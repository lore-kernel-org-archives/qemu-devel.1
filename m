Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FEFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416C12068F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge1S55b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416C12068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKck-0001nA-J1
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnKb3-00008h-VC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:26:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnKb1-0008Be-M6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592825198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9ZqO6ikBo4Otwe2jcgN52Lzlf6F4IVvnJIj0HfLcNNg=;
 b=ge1S55b3Ecjts8jsJfGD7m/xjwcTpfzqal67BS+ZJFMGx6stkQf0HN/c0uxH+t5lYlabG/
 RyTDGovUY4gbCwm7cMerbI1+4hSOk5cGdTAF3Pt56IA6KH0I0ibvCNkSka/MuU4cFiKlv8
 z6m5UbWQoLpUYhEwg7TiBkYFsDFZVjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-rCnYvDd-NWu7uEPYjBSaCA-1; Mon, 22 Jun 2020 07:26:36 -0400
X-MC-Unique: rCnYvDd-NWu7uEPYjBSaCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5090107ACCA
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 11:26:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42DF45D9D5;
 Mon, 22 Jun 2020 11:26:34 +0000 (UTC)
Subject: Re: [PATCH 04/22] tests: Use &error_abort where appropriate
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-5-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <08938756-a547-77c3-03a2-b480b5b06bdc@redhat.com>
Date: Mon, 22 Jun 2020 13:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622104250.1404835-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 12.42, Markus Armbruster wrote:
> Receiving the error in a local variable only to assert there is none
> is less clear than passing &error_abort.  Clean up.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qobject.c              |   5 +-
>  tests/test-logging.c               |  12 +---
>  tests/test-qemu-opts.c             |  22 ++----
>  tests/test-replication.c           | 109 +++++++++--------------------
>  tests/test-string-input-visitor.c  |  33 +++------
>  tests/test-string-output-visitor.c |  16 ++---
>  6 files changed, 57 insertions(+), 140 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



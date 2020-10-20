Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE32C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E832E2225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfckLde+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832E2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUkT4-0004ie-OO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUkRq-0003zy-HJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUkRo-0000AK-SN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603172674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rl6aOWNMJvJ22FeKJKS5msBruGknc3U/DkTAGrtonVc=;
 b=RfckLde+ygNaHOwx1GbUKtkWMZDORdjEeSHMjKxXPKGJepNYK07qLFfG2SU6hjAMRJQibh
 QX8QAcwd7tE3MCaeSaEUba4fMQgNIk4zty+bMzav67qXdm1hfi4mz/3jKuKKFmm6DYHMsi
 dNx8mdCmLaf784K4hjUqGt0nu8GmgXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-ZGE4PCIjOtKrlkYoQHNJqQ-1; Tue, 20 Oct 2020 01:44:30 -0400
X-MC-Unique: ZGE4PCIjOtKrlkYoQHNJqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 226A6186DD21;
 Tue, 20 Oct 2020 05:44:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C91427CD4;
 Tue, 20 Oct 2020 05:44:25 +0000 (UTC)
Subject: Re: [PATCH] scripts/qmp: delete 'qmp' script
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201019210430.1063390-1-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e057e735-1288-0aa3-0333-cc1d8188f704@redhat.com>
Date: Tue, 20 Oct 2020 07:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019210430.1063390-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 23.04, John Snow wrote:
> This script has not seen a patch that was specifically for this script
> since it was moved to this location in 2013, and I doubt it is used. It
> uses "man qmp" for its help message, which does not exist. It also
> presumes there is a manual page for qmp-XXX, for each defined qmp
> command XXX. I don't think that's true.
> 
> The format it expects arguments in is something like:
> 
> block-dirty-bitmap-add --node=foo --name=bar
> 
> and has no capacity to support nested JSON arguments, either.
> 
> Most developers use either qmp-shell or socat (or pasting JSON directly
> into qmp stdio), so this duplication and additional alternate syntax is
> not helpful.
> 
> Remove it. Leave a breadcrumb script just in case, to be removed next
> release cycle.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qmp/qmp | 131 +++---------------------------------------------
>  1 file changed, 7 insertions(+), 124 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



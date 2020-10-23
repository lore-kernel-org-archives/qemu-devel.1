Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EBFC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE86D208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6bZNbSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE86D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwNK-0006rR-2V
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVwL1-0003oz-Eh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVwKz-0003nv-7B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603456708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yq75D0XBaa7K0bxUvguO4kw7EXr5On1KDHoC4/r6r0U=;
 b=R6bZNbSGaqFiWn46eAu2JR26XqtM0+B0G8D9QYXYi/r4KPhKSVon7K4Eb4CiHdY33dJy7k
 tdMQ4b+3HChEt5HSjW3Hx16oUqawA9ABLrj0XdM2oUvUD7Co677shxOjPgS4dXRQX/IxoP
 Z7GxcUga9H58V0LK6pABscpGCmeftNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-qlOT0DtFPia4syIbr3vtww-1; Fri, 23 Oct 2020 08:38:24 -0400
X-MC-Unique: qlOT0DtFPia4syIbr3vtww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FED804B6E;
 Fri, 23 Oct 2020 12:38:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E54AF1002397;
 Fri, 23 Oct 2020 12:38:21 +0000 (UTC)
Subject: Re: [PATCH 9/30] cris tcg cpus: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134248.14146-1-chetan4windows@gmail.com>
 <20201023121649.19123-1-chetan4windows@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <889be068-242b-f3e7-ca23-6fb40323ad4b@redhat.com>
Date: Fri, 23 Oct 2020 14:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023121649.19123-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 14.16, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  target/cris/cpu.h               | 2 +-
>  target/cris/crisv10-decode.h    | 2 +-
>  target/cris/crisv32-decode.h    | 2 +-
>  target/cris/gdbstub.c           | 2 +-
>  target/cris/helper.c            | 2 +-
>  target/cris/machine.c           | 2 +-
>  target/cris/mmu.c               | 2 +-
>  target/cris/op_helper.c         | 2 +-
>  target/cris/translate.c         | 2 +-
>  target/cris/translate_v10.c.inc | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



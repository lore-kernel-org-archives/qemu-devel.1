Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F258620878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtIo1p9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F258620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSgLC-0003YA-OZ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSgJe-0001mz-Ct
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSgJc-0000sv-Hs
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602680135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPAc1ibXx2s5MisfNkhA3tf3lTTujtnyVkFNyZQyoYo=;
 b=XtIo1p9wFCiM6jKCzOg7/AGK9lA/hUPuPvcn0i2+E6gTjC1kBLJMN9uf2hBci1/F8yPKd1
 qQiaS8rvgq3yOpk2r4kfd7FsW0lETDEg4ZOymYKEFwNUukqMk80GIprw1wmu036l7KKeqL
 9NjgqzSD4tFkHTohTm7DRTXkcgMtc5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-oIrfLvoTMeS4Jy8mCyDv6Q-1; Wed, 14 Oct 2020 08:55:31 -0400
X-MC-Unique: oIrfLvoTMeS4Jy8mCyDv6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B8CB18BE168;
 Wed, 14 Oct 2020 12:55:30 +0000 (UTC)
Received: from thuth.remote.csb (reserved-198-128.str.redhat.com
 [10.33.198.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9F319C59;
 Wed, 14 Oct 2020 12:55:28 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes', 
 fix Paul Burton mail
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ae71256-eebb-cba5-78ae-89e571cfdeb4@redhat.com>
Date: Wed, 14 Oct 2020 14:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201013101659.3557154-4-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 12.16, Philippe Mathieu-Daudé wrote:
> Paul's Wavecomp email has been bouncing for months. He told us
> he "no longer has access to modern MIPS CPUs or Boston hardware,
> and wouldn't currently have time to spend on them if he did." [1]
> but "perhaps that might change in the future." [2].
> Be fair and downgrade the status of the Boston board to "Odd Fixes"
> (has a maintainer but they don't have time to do much other).
> Similarly to commit 2b107c2c1c (".mailmap: Update Paul Burton email
> address"), update his email address here too.
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Squashed email address change (Thomas Huth)
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2de5943e388..702f73823fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1161,9 +1161,9 @@ S: Maintained
>  F: hw/intc/loongson_liointc.c
>  
>  Boston
> -M: Paul Burton <pburton@wavecomp.com>
> +M: Paul Burton <paulburton@kernel.org>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
>  F: hw/pci-host/xilinx-pcie.c
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>



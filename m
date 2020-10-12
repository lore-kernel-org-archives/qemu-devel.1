Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ADBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95632080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN15SIs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95632080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsT8-0000e4-Hb
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRsS1-0008Ef-9r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRsRz-0001xe-BY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602488454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opeKW/zWxutObCzHHz2C/UN0tqFEd2SvidaKb4QsBBU=;
 b=RN15SIs7o0Qn9GTh2idAoYBK7IbzEWQ1o99KSTioRRguoy1lIn9lsdso1fPmG5IryhxAn+
 SPJLcmXrQ6BCfdyjms/Ehd+7yt67rTvbemy69wZiYKoUsgi3M2XrCsFouD09Um4xTnd5WD
 eoJyyzSVUh8IaSC+TWqNYRLEXp50VRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-G4rjLdFSOw-YUBPKZ_8MvQ-1; Mon, 12 Oct 2020 03:40:50 -0400
X-MC-Unique: G4rjLdFSOw-YUBPKZ_8MvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2731005504;
 Mon, 12 Oct 2020 07:40:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAC1475131;
 Mon, 12 Oct 2020 07:40:46 +0000 (UTC)
Subject: Re: [PATCH 3/5] MAINTAINERS: Downgrade status of MIPS Boston to "Odd
 Fixes"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201009165208.2905569-1-f4bug@amsat.org>
 <20201009165208.2905569-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <945e6bbe-51a3-6bf6-8387-e2acf0901738@redhat.com>
Date: Mon, 12 Oct 2020 09:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009165208.2905569-4-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 09/10/2020 18.52, Philippe Mathieu-Daudé wrote:
> Paul's Wavecomp email has been bouncing for months. He told us
> he "no longer has access to modern MIPS CPUs or Boston hardware,
> and wouldn't currently have time to spend on them if he did." [1]
> but "perhaps that might change in the future." [2].
> Be fair and downgrade the status of the Boston board to "Odd Fixes"
> (has a maintainer but they don't have time to do much other).

When I read this patch description ("email bouncing"), I wondered why you
did not also update Paul's email address here. Then I saw that you're doing
this in the next patch. So I'd recommend to either scratch the first
sentence of your patch description here, or to merge the two patches.

 Thomas

> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2de5943e388..782743b7ef0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1163,7 +1163,7 @@ F: hw/intc/loongson_liointc.c
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
>  F: hw/pci-host/xilinx-pcie.c
> 



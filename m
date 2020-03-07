Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604BC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F6F2070A
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPjeGiqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F6F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdPa-0003Um-4U
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAdP0-00030M-BN
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAdOy-0003h1-T2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:38:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAdOy-0003dg-MK
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583602695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPMONysU5i67ApYeahZG5wNj2ytX4NLqpcIr2IVegV0=;
 b=VPjeGiqsGUwBjrF6vzhVHr6yBN9FXizaBwe9Msgr6LEf2gZEYO5lrnAzMSNgrZ12VNpNW9
 DNNEVMO2EaawMl0RZLx6BTIhGr2S+CtKz4ovHupWPiZsLmE6t8dqPBmldEUy8VbYSoHhkE
 4lU0Cbb6ciRHgvjFDHk74PwQalfwH0k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-MWoZI9v6N9OlVQ6wgjoYmA-1; Sat, 07 Mar 2020 12:38:11 -0500
X-MC-Unique: MWoZI9v6N9OlVQ6wgjoYmA-1
Received: by mail-wm1-f70.google.com with SMTP id v21so1594476wml.5
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QPMONysU5i67ApYeahZG5wNj2ytX4NLqpcIr2IVegV0=;
 b=UoW2aWX5+TO5/xo/D1Fo4KUSaMO6CrxCs3TIYuBZqGcGIhoZlAITAHtsL10OWHosNN
 ZPRwPDDJenXZmu80+ejd4FB4MX1AlFGnoX11ceCL5WWB0jcBbzM5aXNBAjlwQ5c/acFZ
 eRBF6Ld0kSfaGLXl2sgXLJcB05boZbKHt8S/zPjk84llLfGrjTOmNGwzWmVkXjvc+cya
 tBd/0bs0ha2P/VcYNpQGYReBj5iKCdETgnaGAVSlrYdEXCxvW3ZaP6o2xYvRMK82dXDX
 1xcQzNzFOD5iYgz8/pYzy6vslh2zcfIH65jprttBw56NIwCyMIoTusgE8D9fYtyWJT7o
 qrcQ==
X-Gm-Message-State: ANhLgQ3ISrPEWOe6Uo38VOQpxL6yzLjm9A+XspCBsuiJY3vOcX2ywat1
 Dta9enfLtx9FXAIrD/htX9MItdlBeuVIz6qZrYE/Lpk5DOKro8cBES7SQygPGCbR8aoRp09QYYK
 jPGDIO7hxgOtUVZk=
X-Received: by 2002:a5d:5286:: with SMTP id c6mr10260920wrv.418.1583602690276; 
 Sat, 07 Mar 2020 09:38:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs3uVPfDxbdukcxQyNbqjpEe66/X24fVLoCnHqW+EgWf3TpVg/5ZM9McjOw5XUrXxevVdSymA==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr10260909wrv.418.1583602690055; 
 Sat, 07 Mar 2020 09:38:10 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f9sm1972896wrc.71.2020.03.07.09.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 09:38:09 -0800 (PST)
Subject: Re: [PATCH v32 22/22] qemu-doc.texi: Add RX section.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200224141923.82118-1-ysato@users.sourceforge.jp>
 <20200224141923.82118-23-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b20d7bb-d808-bbf0-621e-c7494beae4bd@redhat.com>
Date: Sat, 7 Mar 2020 18:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224141923.82118-23-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 2/24/20 3:19 PM, Yoshinori Sato wrote:
> Describe emulated target specification. And two examples.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   qemu-doc.texi | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 33b9597b1d..d80a9c64f7 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1719,6 +1719,7 @@ differences are mentioned in the following sections.
>   * Microblaze System emulator::
>   * SH4 System emulator::
>   * Xtensa System emulator::
> +* RX System emulator::
>   @end menu
>   
>   @node PowerPC System emulator
> @@ -2487,6 +2488,49 @@ so should only be used with trusted guest OS.
>   
>   @c man end
>   
> +@node RX System emulator
> +@section RX System emulator
> +@cindex system emulation (RX)
> +
> +Use the executable @file{qemu-system-rx} to simulate a Virtual RX target.
> +This target emulated following devices.
> +
> +@itemize @minus
> +@item
> +R5F562N8 MCU
> +@item
> +On-chip memory (ROM 512KB, RAM 96KB)
> +@item
> +Interrupt Control Unit (ICUa)
> +@item
> +8Bit Timer x 1CH (TMR0,1)
> +@item
> +Compare Match Timer x 2CH (CMT0,1)
> +@item
> +Serial Communication Interface x 1CH (SCI0)
> +@item
> +External memory 16MByte
> +@end itemize
> +
> +Example of @file{qemu-system-rx} usage for rx is shown below:
> +
> +Download @code{u-boot_image} from @url{https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz}
> +
> +Start emulation of rx-virt:
> +@example
> +qemu-system-rx -bios @code{u-boot_image}
> +@end example
> +
> +Download @code{kernel_image} from @url{https://osdn.net/users/ysato/pf/qemu/dl/zImage}
> +
> +Download @code{device_tree_blob} from @url{https://osdn.net/users/ysato/pf/qemu/dl/rx-virt.dtb}
> +
> +Start emulation of rx-virt:
> +@example
> +qemu-system-rx -kernel @code{kernel_image} -dtb @code{device_tree_blob} \
> +  -append "earlycon"
> +@end example
> +
>   @node QEMU User space emulator
>   @chapter QEMU User space emulator
>   
> 

In commit 3a8273b1ab3 the this file has been removed (due to the 
conversion to the rST format).

Can you send a single patch (not the rest) with your documentation in 
rST format please?



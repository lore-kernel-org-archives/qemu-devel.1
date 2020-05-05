Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E947BC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAC320675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EwZ2top9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAC320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuan-0007uq-0u
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1jVuW7-00057R-EN; Tue, 05 May 2020 06:09:35 -0400
Received: from mout.web.de ([212.227.15.3]:42415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1jVuW5-0001f6-A5; Tue, 05 May 2020 06:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588673368;
 bh=7tm2uiWWOBJDWwfvQsO5SvZX/DgVGHJc0wj85CCMSuo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=EwZ2top9cGJJweP7LIfomRMMsIs0r+qLJiLGzye8pAL1jhZPVeDBOppH7xTk3aIvW
 F2bO6+ugWXykf2K9IrrGcVd0+HOoHMDZ2MbLOB6Tdcxj1Fl9ZIFof+cAnsw7mpEJSG
 5quYIUAA4w6zBeFl37Lbst65T/156P0jNKKQgsbo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [167.87.245.84] ([95.157.53.180]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSJH1-1jhCuR0li7-00TTIG; Tue, 05
 May 2020 12:09:28 +0200
Subject: Re: [RFC PATCH] hw/arm/musicpal: Map the UART devices unconditionally
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200505095945.23146-1-f4bug@amsat.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <bc8d1213-5578-52f2-7a86-f45dfa8b33be@web.de>
Date: Tue, 5 May 2020 12:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505095945.23146-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/0PbicFLYknB61oxXHaRRxsD+broSIQwq0iltFjDSI3QVq/orn5
 3vMgVJqwoIFMnNRk2ngSRFTufb9i6vtgTLvCHcuIglrbO1O0WScSgPf74eyOuOI3Z2xtud5
 7JhovJXN4fzfCxDyyoJvJYO5FTSEP6VujL1X81jtEXBMuFFQEu1UcwneLhUcGctRS9nofDz
 ctimd01nny+FRM6k1b3BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ookMrKmGhbU=:aEOY7hfQAy/3l4277ovEi9
 WxATQWVWi3DZvt44OscOxTPU7DVLx/4UlZFicBiUANoMcENA3Fz/AyrohQEOfQfmaIuCsGPEs
 QhMIYlTZ2a3MxAUeKzNritfwCwOtu+0WLTrjtwJV9DEzN932EOAYXntAj3MomYjcOiiofdmsB
 oDCKV8QrKfytW9NTFkhIpjFA/H9vS1lvX8k0iEaH6wSx2i6Bp9AdxC0B4unq4cCxlrKXzWev4
 lbYTop7v84/w9Yl5R+vlkudhA2FLdpdJ6u7cvbCd9D/4lnPx3eqxBtON6EGyam3tyS+9yTFuR
 MB1UcqG4bvf/A0T3mV4k4i4Yohv0ELylnVrOZLlxu0KbmOLlTKCKilMgzdQ5eA1GceZA6bqhg
 xt7YBG83L6MUXa9tbEhg0Fe5NtXYckP0VySpVWEPmf41UWe4GFoMN83KtvuVIGoVF2wRsRGhF
 JBNgeGWB7D5fm+aMzD3Y7Rc9f+ydG8PyF1YE422KZyP0BdKP4xYaDec4yQV51j0w/C/WoFMkS
 CEdYtUqAmdcWDJfZS8q7xMwSZ92TBsJbK+B65cPwrP/z2WYFEnH6R+khDXm1t/T03WCalA7q1
 vQ2XGgp/4Jq2m0oCSctCoY5YcRmdn3TE90GZ+W4Tb4/xSOueHeCcYR9DPAKhZyx9zi8+ofHGU
 rNwROkno+rBtSIOtB1XMprIy53exL9l2P5kz27wLU9cAuBe/qZ9uvvFjmX1NK8lyKCilMcbEt
 nFdrym3fDF/Ac4mgpcpWLLm8VQIcmnFT93JMr+7khSn+TY8Jr+NFeBgW1wRn4RCUvsMS0DzIG
 JZzI3iZZd0vDraRUaKAAtF/PXRlhkPASRfHoN/LcxOf7fhE8Mn5v9VRSnivw36yXK1gdBjoNw
 zvpKSEzY3jgFrnDz2HvhhMQXipW+AnbcZYjnLPrtvd03Pz/cgLSbbRsMdXPSTQ0v60Q9fYDtP
 B0lZ5OTEDHJo2bcZFv4KiRn7DGSabHk3YqkgWPaWh6LhxQnaDbQPPyL/sk1Vr91S8iXF9+FEw
 zoJy11sTXy4WBIFMVab36gtPVuxs7nUVlXuQtqzD1Q0akYUX9JsfjW1lgiiXeggHdxMKPeD7v
 xeg6BEVEP/uE9+BWYGs5Ip6jNZkmFqm9D4qPbmRvOknAvKM9iHHzaMP6VSKM3/jf/vzSIuh5V
 HxABVdLyvaX4w795WkMG9OzN5e7MBZPu5pxhFAIFwl2bKCvdmQ/DsLC/cBJ4Db++Mz3F4coJT
 vauRit2Oh/dZ8p2EM
Received-SPF: pass client-ip=212.227.15.3; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 06:09:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.05.20 11:59, Philippe Mathieu-Daud=C3=A9 wrote:
> I can't find proper documentation or datasheet, but it is likely
> a MMIO mapped serial device mapped in the 0x80000000..0x8000ffff
> range belongs to the SoC address space, thus is always mapped in
> the memory bus.
> Map the devices on the bus regardless a chardev is attached to it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> from 2019... found while doing housekeeping
> ---
>   hw/arm/musicpal.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index b2d0cfdac8..92f33ed87e 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1619,14 +1619,10 @@ static void musicpal_init(MachineState *machine)
>                             pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
>                             pic[MP_TIMER4_IRQ], NULL);
>
> -    if (serial_hd(0)) {
> -        serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART=
1_IRQ],
> -                       1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
> -    }
> -    if (serial_hd(1)) {
> -        serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART=
2_IRQ],
> -                       1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
> -    }
> +    serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IR=
Q],
> +                   1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
> +    serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IR=
Q],
> +                   1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
>
>       /* Register flash */
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>

I don't recall details anymore either (more than 10 year ago now...),
but this looks reasonable.

Reviewed-by: Jan Kiszka <jan.kiszka@web.de>

Jan


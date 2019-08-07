Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8AC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 02:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEF6208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 02:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcLNKe07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEF6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvC5d-0005y6-41
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 22:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvC5G-0005Wh-Hv
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 22:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvC5F-0007zK-Hw
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 22:53:50 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvC5D-0007wt-3y; Tue, 06 Aug 2019 22:53:47 -0400
Received: by mail-ed1-x541.google.com with SMTP id w13so84608839eds.4;
 Tue, 06 Aug 2019 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8KqV7uC+8Lw6l5OAG3seB9TFUQ/kHbDz38n1k0F6c1I=;
 b=WcLNKe07E2ZQEu8YkiPCOEQxU7CP+ZOGN5gz9G5qaUq17udR5qgSxDoMiGtSikS2Q0
 U/UfN+nvsZIZzNjIaGwwVxFSI72gG52DapGsBX/1pCrx5T57Rg0vavS/Y24JYoLCGK3n
 wV195+kENfgI+IS60Ev8o0DO8daEdUXFUUvExxEjpsdorNfjVOsUotXLpWTzrGOcM78A
 MGsI0eBv+EIQ66QAxAvqnHr3RJ2cdlL5CybzjCqtMNk7dvJ7N7GM5rXZK35mfheGMNRd
 +eknST6dv9kgyQPGaeQfHJ/OGxj7y36hNFu3e2idkliZ6WaPcG9x5IlDnZ2GpIKaZLlJ
 /GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8KqV7uC+8Lw6l5OAG3seB9TFUQ/kHbDz38n1k0F6c1I=;
 b=KzOMrS/6FmLCw4zjdavHP0nb5dWtEpaUTByHRLwfiFQf5ncWt93YuYYY1p5fUnIuhN
 057kcEAOdAkY41PaW7kv64n48zo4EDEM/IneJiWjwShpG6S0Rqw4MCkIqygYDceOUTvk
 9xRy3FAV5d3JLDIIscJ6HHeBgH4DKoU1e5m4AAz7/II9pCaA+z7Z/fmP7GPu0Fs0ZuqU
 kNakvPF2Ego9hZOIvUaQ3vlPv8L1jYwT8L35CzxEZGP3K84sKIk17MIl7oi8J3JzDMw9
 H327E5Xg8uCDNPnOsM2jz11i/krHsTvZ096pberCtxLHLmYdbx27BZJ06we/v4T2eU0y
 dWOg==
X-Gm-Message-State: APjAAAWGNWfFWoNdZARCTSqkWFKjU8tIN5O3W9bveM0j03E+dsi7EznE
 jInT7PvddmOtg3TcbGUfebH3Zl/gxhQoWrFO1sM=
X-Google-Smtp-Source: APXvYqz/HLi92AL5Rc7j9L3fwvbcSYltwGNRwurYJltdzI6tTyMNrqdIdEjbF7AFRM2IpJ6Rdu6IO1ICp54rw7J4vEw=
X-Received: by 2002:a17:906:499a:: with SMTP id
 p26mr6333344eju.308.1565146425267; 
 Tue, 06 Aug 2019 19:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
 <CAEUhbmU-TdVocONETkSV-+DtX_66+8J8m3yYeph3P1i_3C9LzQ@mail.gmail.com>
 <11403b54-d41a-3083-7794-2c699a223479@redhat.com>
In-Reply-To: <11403b54-d41a-3083-7794-2c699a223479@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Aug 2019 10:53:34 +0800
Message-ID: <CAEUhbmV7_75mCPE7dOzBt7xWo1Lxj43HL4+Hxz=Zs3Ota03a5w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 5:06 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 8/5/19 8:43 AM, Bin Meng wrote:
> > On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sifive.com> =
wrote:
> >> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>
> >>> Some of the SoC IP block sizes are wrong. Correct them according
> >>> to the FE310 manual.
> >>>
> >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >>> ---
> >>>
> >>>  hw/riscv/sifive_e.c | 6 +++---
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> >>> index 2a499d8..9655847 100644
> >>> --- a/hw/riscv/sifive_e.c
> >>> +++ b/hw/riscv/sifive_e.c
> >>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
> >>>      hwaddr base;
> >>>      hwaddr size;
> >>>  } sifive_e_memmap[] =3D {
> >>> -    [SIFIVE_E_DEBUG] =3D    {        0x0,      0x100 },
> >>> +    [SIFIVE_E_DEBUG] =3D    {        0x0,     0x1000 },
> >>>      [SIFIVE_E_MROM] =3D     {     0x1000,     0x2000 },
> >>>      [SIFIVE_E_OTP] =3D      {    0x20000,     0x2000 },
> >>>      [SIFIVE_E_CLINT] =3D    {  0x2000000,    0x10000 },
> >>>      [SIFIVE_E_PLIC] =3D     {  0xc000000,  0x4000000 },
> >>> -    [SIFIVE_E_AON] =3D      { 0x10000000,     0x8000 },
> >>> -    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x8000 },
> >>> +    [SIFIVE_E_AON] =3D      { 0x10000000,     0x1000 },
> >>> +    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x1000 },
> >>>      [SIFIVE_E_OTP_CTRL] =3D { 0x10010000,     0x1000 },
> >>>      [SIFIVE_E_GPIO0] =3D    { 0x10012000,     0x1000 },
> >>>      [SIFIVE_E_UART0] =3D    { 0x10013000,     0x1000 },
> >>> --
> >>> 2.7.4
> >>>
> >>
> >> It seems the modification follows  E310-G002(Hifive1 Rev B) spec and t=
he origin is for E310-G000(Hifive1) spec.
> >> There should be some way to specify different board version with diffe=
rent memory map or we have policy, always support the latest spec.
>
> I agree with Chao, it would be cleaner to have two different boards
> (machines).
> Since the SoCs are very similar, you could add a 'revision' property and
> use it to select the correct map.
>

I am not sure if adding two different machines will bring us a lot of
benefits, since the only difference is the SoC revision with different
block sizes.

> >>
> >
> > Yes, I checked both specs. The older spec says these bigger sizes,
> > however their register sizes fit well in the smaller range as well. So
> > I think the modification works well for both.
>
> This is OK for the PRCI, since sifive_prci_create() does not use
> memmap[SIFIVE_E_PRCI].size.
>
> However the AON case is borderline, since you shrink it from 32KiB to 4Ki=
B.
>

AON is not implemented anyway currently. And I checked the FE310 old
spec, its register block size is still within the 4KiB range, so
shrinking the size should be fine for both old and new SoC.

> BTW (not related to this patch) it is odd a function named
> sifive_mmio_emulate() creates a RAM region with memory_region_init_ram()
> and does not use the UnimplementedDevice (see make_unimp_dev() in
> hw/arm/musca.c).
>

Regards,
Bin


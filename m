Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EFDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0OzhjBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcvI-0007ZH-4n
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcsH-0001sO-CW; Tue, 26 May 2020 12:56:21 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcsF-0003Rg-TL; Tue, 26 May 2020 12:56:20 -0400
Received: by mail-io1-xd42.google.com with SMTP id q8so21391954iow.7;
 Tue, 26 May 2020 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UaBvgKQcklPNmrmRbw60e70SnGLomqQFDLLUcqlmqwg=;
 b=F0OzhjBeoSAlxYqugpvac9k0zNVfyJZ1+3/CYaJEVtBbSgjsGVRRLvrH8FgshLGCmr
 0oE8uGPMa7FjtyJ8goFoJK/ADORdxT33xC/hGaM1NRWXUe1UojPQ59ntBf1ulh1ussrI
 7kV5PN5BAkuwiBYXbLYbsTslkvfGdxPixpfHnLceOep3+3eYM4UrxAAWFxkhiMjwUP+b
 elaDCe0x3KCuLmXaa+vbtfzcylUez01b+dkDqy4DO8vVJxzkCTxlBRLmZyJsk9gi19pZ
 BSDqxasz/jwly/cUkhyzpixf2hki172FQg9UAXUCuhm4OwAL8An5/K4OUBqS8g5PP87+
 ai2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UaBvgKQcklPNmrmRbw60e70SnGLomqQFDLLUcqlmqwg=;
 b=mm3vSih8hzgV3hkcrw8r8I95hLYjIZastE0Ehyxuh+SvlC1zNTaKsR4C8WMRGZ194L
 an2oDdqk/BxcWzZLuC6wTxARxNVbTes3VMlEeuevzDSvA9RFW9hqYa69F6B6v/HsRRD0
 wMkGwov0dmYFfKaIQ5GESRgERwgPWZiWjAj61FcHErKmAt7EIL9qlh1Ck97MY6Opn2IL
 9YEyzLxwD1gu9FSgzRaIaoZ0nLyVJDsiQdy/9hSSNZm9xuOFTrR+ehTESMjsaIJUBgMy
 RHvKH/bcLU9qa2VF8RqzTE8vJU92kqYfhoWaCSMqZ63J7Xrzl9gIOgruLwGESnmuK0Tn
 VCSw==
X-Gm-Message-State: AOAM533wGrSoeYX4GMyF8o2lT+N969naT8uYUVDbJ/LiAsvdBDfQOsfL
 AATweeA7q+afSp4w2xa8c12OSfr1gyGvgGjkU5U=
X-Google-Smtp-Source: ABdhPJwauc72nYuI1fguaPlvR/qVplpcX5/5/cBD5QvewjmiroqtkB8FWuqfHsW14F5AzmF+sTXJc68jK7EOeRLlXuk=
X-Received: by 2002:a02:6543:: with SMTP id u64mr1986792jab.26.1590512176396; 
 Tue, 26 May 2020 09:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-4-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:47:15 -0700
Message-ID: <CAKmqyKPzfVkCiQTa2a9kaT0a-ZVR6=LSmW-A29e=O2NkMXhwjg@mail.gmail.com>
Subject: Re: [PATCH 03/14] hw/display/cirrus_vga: Convert debug printf() to
 trace event
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:25 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/cirrus_vga.c | 4 +---
>  hw/display/trace-events | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 1f29731ffe..33ccdde000 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -1512,9 +1512,7 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, u=
nsigned reg_index)
>  static void
>  cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_valu=
e)
>  {
> -#if defined(DEBUG_BITBLT) && 0
> -    printf("gr%02x: %02x\n", reg_index, reg_value);
> -#endif
> +    trace_vga_cirrus_write_gr(reg_index, reg_value);
>      switch (reg_index) {
>      case 0x00:                 // Standard VGA, BGCOLOR 0x000000ff
>         s->vga.gr[reg_index] =3D reg_value & gr_mask[reg_index];
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 47b2b168ae..c3043e4ced 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -133,6 +133,7 @@ vga_vbe_write(uint32_t index, uint32_t val) "index 0x=
%x, val 0x%x"
>  vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
>  vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
>  vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x=
%x"
> +vga_cirrus_write_gr(uint8_t index, uint8_t val) "GR addr 0x%02x, val 0x%=
02x"
>
>  # sii9022.c
>  sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
> --
> 2.21.3
>
>


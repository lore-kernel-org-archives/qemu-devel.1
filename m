Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD49CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA57D20882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb5NsXix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA57D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMh7d-0002cF-UX
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMh6R-0001rL-40
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMh6Q-0001vh-1O
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:28:43 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMh6P-0001vR-Qk; Mon, 21 Oct 2019 19:28:41 -0400
Received: by mail-lj1-x242.google.com with SMTP id n14so15122871ljj.10;
 Mon, 21 Oct 2019 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9PC2BHFK1tP4HU0v9/hM4g84Eu1VrZtgfWuJnWRH9XQ=;
 b=Nb5NsXixDurDcuj56Ce0qVeyvvJ/LjInyuA5K2M+S7iMINbcZLpBnzX22AA6z3Xzn7
 4SC9ngC7XBnkVpmNJD7NuCwQcRhfXkHWN9UHE5UqPkGH+XL9n+xYx4dHALdy4Z2LMFQk
 MCPGn7C1WXKfkDknQ9mlfIhfFJCdM1LOfjc6Pmuw5kSwoqU2tdfkvOlC320s0i0mZ/Uc
 /XVlRtM+9vZG6bbSCeTBE3i13DJdMzRBSXp4Idi6utlyQvwriGd89Hr3aNZCP9OTzswg
 Vik/khzc4tt62gmtbVZgQKdCBgLXg2z6bPsCouTY37Ed2iSgkV9SwSbHnNG4hRg2LvMS
 FOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9PC2BHFK1tP4HU0v9/hM4g84Eu1VrZtgfWuJnWRH9XQ=;
 b=ESHtr4ok5nA221NXkrh31Cedwrst8vG4S0+Gy5+3UeTyOWQ0C7t1ETgMt2q0/VVJzu
 aHaaYRSh4xiecaPwu7qy5iqXzCGHPEvNdZyjyBsWVbD2dzEqL7dT0/tgAim13qTtp4He
 f8h9b6cz/cniMhYRD4tCJj6A7ajTRElHlAPi//IoFEGSKb7jB3RF0h2w3QzZpFCTZvt2
 bC3o2nICxK7n9IAcFeExNy2Ft3tHPihE1jpw+TH9a3S1qJqvYmFtIwAqMbL176W0woNe
 M4AM0/ceMNnsgtombtx7HWpRuiKkgn/GkdX76NXrWBhMgqE7AC4nOO5L+hod6IBf6cbi
 44Bg==
X-Gm-Message-State: APjAAAWRoNAR0sQHblH/4PdmUQRZhLGdEy/898EpBZL3fXMCrdxAzJ7k
 RrHZ6vzqluoKkEIVg5DMt0YIIfBX+6JFKeeeG0yGlDWS6qw=
X-Google-Smtp-Source: APXvYqzLfhKMLblK2dh7F/W+v9uuqCDbL50edNBDSF1XcWdokqN2Pczy/fsK+YDQ7ZHvQWwwopsSHzKWTEos78xy7NE=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr16381662ljm.7.1571700520735; 
 Mon, 21 Oct 2019 16:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-15-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:23:25 -0700
Message-ID: <CAKmqyKMX=1eMYgUnzGgXfCeZN6GQBkk+55f1eoTqP2na1tF9hA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] hw/arm/highbank: Use AddressSpace when using
 write_secondary_boot()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:54 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> write_secondary_boot() is used in SMP configurations where the
> CPU address space might not be the main System Bus.
> The rom_add_blob_fixed_as() function allow us to specify an
> address space. Use it to write each boot blob in the corresponding
> CPU address space.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/highbank.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index f1724d6929..518d935fdf 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -78,7 +78,8 @@ static void hb_write_secondary(ARMCPU *cpu, const struc=
t arm_boot_info *info)
>      for (n =3D 0; n < ARRAY_SIZE(smpboot); n++) {
>          smpboot[n] =3D tswap32(smpboot[n]);
>      }
> -    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_ADD=
R);
> +    rom_add_blob_fixed_as("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_=
ADDR,
> +                          arm_boot_address_space(cpu, info));
>  }
>
>  static void hb_reset_secondary(ARMCPU *cpu, const struct arm_boot_info *=
info)
> --
> 2.21.0
>
>


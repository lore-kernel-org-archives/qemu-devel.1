Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA05206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXmGWzZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA05206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4bt-0005Lo-Hh
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kD4ax-0004Z6-75; Tue, 01 Sep 2020 07:36:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kD4av-0000jU-Ds; Tue, 01 Sep 2020 07:36:58 -0400
Received: by mail-lf1-x142.google.com with SMTP id z19so316127lfr.4;
 Tue, 01 Sep 2020 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o2JlYt9+6tex0MC6RXfdEMWMgM7eYzK624p0Sgpz2z4=;
 b=tXmGWzZ9QhqdYs+6Jf7SiZdQ0484pFkix+AdCywb75wBw5WE+eG6RYO4Gbei3KzXgo
 N9sRy3NY8a+HfcUF0f7DNAHIIuwwtzr899y9HuirklPEFdKwgXYdJAtN0ZHDZZrfglA2
 DkbmspzCvrKIGcuzDPB5UIRB+xED4vKLqS/QbbZxPobvTNrYgMU5uCJzinjCLb0y6ayM
 i/mlVKFILY9uR4Ma4cMkkfvpOxyNiPdQg5pOrd9w9++XED3k1iNDo7SEuai7icw3IW8v
 B57uOz3KuZPLGBN0/t6W393F37Rw/CR4cYfmfkqIZPTAw1zmIEeiGJn9RynatYiCoJtv
 4MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o2JlYt9+6tex0MC6RXfdEMWMgM7eYzK624p0Sgpz2z4=;
 b=dlhpTa88G2j3F9Q8+Gg8mf5OjlgU5xA3Of6o7jKKrxHfcbw3PpGb2KmoiAHKkvGbyT
 TSLB1PvEjU4/eEV8m9Mm0yOiVtSEGSJj4kIE0XBiApNRYOHYJHPLpxg+jjVjCLY9s1o9
 L/YVajV9iyeRidz9FTD5MhsNHkZnI2HhLXR6EyF0bArFRFyrSNisTci3lsME5fhQ7GHS
 2HwldO6EMQrOyNmmCapUi6IbrIZsTCnyl0/mEsczS0ZEsGs/XOppYwAomdhBbJEBQnix
 rTOSiI11gjS4EyvVHV5xWAz/1Qt5g8m0WmoD5qYX/NQeQKceMr7NWiqddrTrOXeCek2H
 TYAQ==
X-Gm-Message-State: AOAM5332HTARxKHbcmKypxw9ELd2NqHYer/msIRvcvadDIej4H1Zjm8z
 zxWP39IJGsTeGcLuPJ0FyqWKctQ1LJ7XoCBpq5Y=
X-Google-Smtp-Source: ABdhPJwRHa62/8JGjcpHcEYxLhYPuZRvdTLxC+AUAHqeQJjZCeAwqP3+yEhB29+lzbxMkfB09uhJlYtKaR06rAAagwI=
X-Received: by 2002:ac2:4576:: with SMTP id k22mr383115lfm.55.1598960212793;
 Tue, 01 Sep 2020 04:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-3-f4bug@amsat.org>
In-Reply-To: <20200901104043.91383-3-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 1 Sep 2020 19:36:41 +0800
Message-ID: <CABDp7VpVpyAyQVBadt088qPZirdNDZ6nrSJAVVN8pv2-aAKeZQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/mips/fuloong2e: Convert pointless error message to
 an assert()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Huacai Chen <chenhc@lemote.com>

On Tue, Sep 1, 2020 at 6:41 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Displaying "vt82c686b_init error" doesn't give any hint about why
> this call failed. As this message targets developers and not users,
> replace the pointless error message by a call to assert() which
> will provide more useful information.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/fuloong2e.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 8ca31e5162c..f28609976bf 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -240,10 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_b=
us, int slot, qemu_irq intc,
>      PCIDevice *dev;
>
>      isa_bus =3D vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
> -    if (!isa_bus) {
> -        fprintf(stderr, "vt82c686b_init error\n");
> -        exit(1);
> -    }
> +    assert(isa_bus);
>      *p_isa_bus =3D isa_bus;
>      /* Interrupt controller */
>      /* The 8259 -> IP5  */
> --
> 2.26.2
>
>


--=20
Huacai Chen


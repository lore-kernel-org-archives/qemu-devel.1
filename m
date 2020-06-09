Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5902068D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCN7NbnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5902068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jinXB-0007mA-J6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 19:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jinWA-0007Ik-JR; Tue, 09 Jun 2020 19:18:54 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34454)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jinW9-0006ab-NV; Tue, 09 Jun 2020 19:18:54 -0400
Received: by mail-io1-xd44.google.com with SMTP id m81so117604ioa.1;
 Tue, 09 Jun 2020 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p16Yd9krmK9kB9uJm7XYxV+CRaiKlH1oWNxN9u08tRE=;
 b=OCN7NbnVWskDjOFBXVERPOpWIYAHNONA4ecmOc4kqsTwzzSof3QLkaoVHpNFaH+nm5
 e0pzbgLFr4AHRKYvQ6n7XTD13J74tF5bibCN6pR+83w0yt0Tc/GtXulSKgeXkjHq3zKe
 JBo2+dJr/lL4zNYjVtN9IIFaKu8HBAzsuCTERFIFvO0pZnDhNJRiGorygpJP66JXhwox
 NwpwqHQbw9pCV3G2wfidytA+wAxGDx2EHwUSl+gMrREp5MwbVda+1U8fVjDbJhaZi3dO
 RXMZBTVVLmoqca9askv3SUjI6h32dh4bn8cKnag4Tk0j7anXNgPybL0gPt7kxR5FZx1x
 WLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p16Yd9krmK9kB9uJm7XYxV+CRaiKlH1oWNxN9u08tRE=;
 b=aFuTzBP9xCywvOy5woY1YrvB4FF828xgNj/Ru15N+J66eR3n3z0Y139z0Rhd0R7T1p
 9hMEkUYmJM9p6jk61bYfegNZkM0iinsv/HS5Tpved95IhzTQ5Qnvs9AC88rIwv3uYFk2
 rSrBCdQO5E2flG7HxJvXBih6qIg61v7lM3ej0wBeDUFz/AZlUIHbPvuTzimqRlA+M84b
 xx+e0yF790lPi9dwNRpFv75JrSEMF5QuikMH9o1BntrrFyflBjGEtBOGKLlMM3hYDhDP
 8yDmFaJlzshvloB1SwmUWqLEW3eKHTR0LVOHKtMV5vCmsVNcg6b7OLlqACDEfd9GH1eZ
 9O0g==
X-Gm-Message-State: AOAM530jtk4220kZfLwXDS5bYeI5Znt1cOXTTNbxFwp+Ffh/OU2x9fS8
 RMz1cPIMbLwtwTcpHPBlkMaRsdg+NXzl9io82S4=
X-Google-Smtp-Source: ABdhPJyRLvlfXNcbzZgYptWfyyM360nRosJ3NJ1yYWc6DqAEHOVxL+DP8jmjEZFT3RPntosSjEpVrWKuJxNOD9A5Gb8=
X-Received: by 2002:a5d:9cc2:: with SMTP id w2mr538112iow.42.1591744720860;
 Tue, 09 Jun 2020 16:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
 <c3d7b26b-c55d-8ec5-3ee3-f197693b4378@greensocs.com>
 <7bb1bc10-e986-dcbc-630d-99660517c11b@redhat.com>
In-Reply-To: <7bb1bc10-e986-dcbc-630d-99660517c11b@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jun 2020 16:09:19 -0700
Message-ID: <CAKmqyKPe8dBJOmXXS_sUchFPRiExt9Rqn6yUDRM4HT0cm82Nww@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 7:21 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 6/9/20 3:48 PM, Damien Hedde wrote:
> >
> > Hi Alistair,
> >
> > On 5/29/20 12:14 AM, Alistair Francis wrote:
> >> This adds a barebone OpenTitan machine to QEMU.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> >> ---
> >
> >> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan=
.h
> >> new file mode 100644
> >> index 0000000000..a4b6499444
> >> --- /dev/null
> >> +++ b/include/hw/riscv/opentitan.h
> >> @@ -0,0 +1,68 @@
> >
> > [...]
> >
> >> +
> >> +static const struct MemmapEntry {
> >> +    hwaddr base;
> >> +    hwaddr size;
> >> +} ibex_memmap[] =3D {
> >> +    [IBEX_ROM] =3D            {  0x00008000,   0xc000 },
> >
> > Shouldn't the ROM size be 0x4000 (which make the end of rom at 0xc000) =
?
> >
> > Not sure if that's exactly this platform you are modeling but the
> > following doc says the ROM size is 16kB (0x4000):
> > https://github.com/lowRISC/opentitan/blob/master/hw/top_earlgrey/doc/_i=
ndex.md

Yep you are right, I have fixed this.

>
> Good catch. This is why I prefer the IEC notation:
>
>     [IBEX_ROM] =3D            {  0x00008000,   16 * KiB },
>
> You can then verify the mapping running 'info mtree' in the monitor.

Thanks!

Alistair

>
> >
> > --
> > Damien
> >
> >
>


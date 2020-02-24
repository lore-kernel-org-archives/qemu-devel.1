Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DFC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FB120CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plbot5xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FB120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Lf7-00014y-B5
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6LDr-0005Qn-MQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6LDq-0008WB-J9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:25:03 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6LDq-0008VV-Bw; Mon, 24 Feb 2020 16:25:02 -0500
Received: by mail-lf1-x144.google.com with SMTP id l18so7940475lfc.1;
 Mon, 24 Feb 2020 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f/ifAF9KuPku19Cn2OwygyTt91U6QCUjnSpXcB6RnSA=;
 b=Plbot5xXUC22k6W/VTeAJm1AvN3NYvMbKqo67/KxfYVWbRkmnwPR3mUJskptCA2KIj
 hI6Ny1bkzn8uiujqqRZwEFMMo5siZWfChYcskfACv78pRbJt8xomgP7l35C42JeCpNVJ
 ebztbymX7FWbV3cbH3Y5bs7U6WpvfoA9rcUu3JvuAuBwo4/V/DEewzRBY5uEIvjw/Rg4
 NU30G1iMSh7d+HcrHyYa5ubYUbu5K0WYvg2YQjWClpSFja6YxzBYgxoUCVo05yQWv5LL
 aNHHXy1lNIKhSnStsTw/aeA9Tr3lZ7YUk4A0TlC5dzQ2Hnp3+t2BsIcIrjXflHDNVTcI
 7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f/ifAF9KuPku19Cn2OwygyTt91U6QCUjnSpXcB6RnSA=;
 b=So54aTbND/mXb/mA75FbO0NnmYOTohu/ZaJvXpeZEQW0qMdDTSBIyVAYhn/4tNklB9
 x3dh6kZs9I7ddFvDf9mCsZ9ld7dRO0JD/GYySoHvSBLw1muQhnNCh0Hz/qYrwnCf+/XC
 wf+1e2pvD6SaPRJkNZMoDpCt1Ej+IPRH9mfjlPjbQcRvbAmgBa87bhI/HZK004nAge2w
 oUt23vZIFkHit4RKOZFP2+V6cRuNE74fzg+2GdKGh0nPBHjvzotEuc2VgplHxPiamZ+P
 rHe0S6WVnqLQL+wAVmvs2H1sNMn6AcHmzBbuPtCJmibByZvGnA8bo3zxZW/cdf5ilhPU
 vvww==
X-Gm-Message-State: APjAAAXElYXx9EQsrDEidvjPPK87Mhvi7BLugRZRTIiJ9m60UYJ4AaPv
 jq7NZPWrPbBm1Jgcy2Lua5gcresSRKb/tYNZAeI=
X-Google-Smtp-Source: APXvYqySC87RZ6THrzxQfoiedyAF8Jsw569kdlkpa6OHERHWsgTO6woeWJbTVOAp4d3gl43rg7hmb7kO6pXMlKg12Wo=
X-Received: by 2002:a19:8585:: with SMTP id h127mr7476613lfd.196.1582579499762; 
 Mon, 24 Feb 2020 13:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-3-philmd@redhat.com>
In-Reply-To: <20200224205533.23798-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2020 13:17:22 -0800
Message-ID: <CAKmqyKPYOtVjK0z6JWzDv+HK6oNg0BS2RLSHWzVHreiLAFQrbQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/32] memory: Simplify
 memory_region_init_rom_nomigrate() to ease review
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Qemu-block <qemu-block@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 1:10 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> memory_region_init_rom_nomigrate() has the same content than
> memory_region_init_ram_shared_nomigrate(), with setting the
> readonly mode. The code is easier to review as creating a
> readonly ram/shared/nomigrate region.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  memory.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index ce1179874e..6a327a54ed 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1659,19 +1659,8 @@ void memory_region_init_rom_nomigrate(MemoryRegion=
 *mr,
>                                        uint64_t size,
>                                        Error **errp)
>  {
> -    Error *err =3D NULL;
> -    memory_region_init(mr, owner, name, size);
> -    mr->ram =3D true;
> +    memory_region_init_ram_shared_nomigrate(mr, owner, name, size, false=
, errp);
>      mr->readonly =3D true;
> -    mr->terminates =3D true;
> -    mr->destructor =3D memory_region_destructor_ram;
> -    mr->ram_block =3D qemu_ram_alloc(size, false, mr, &err);
> -    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> -    if (err) {
> -        mr->size =3D int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -    }
>  }
>
>  void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
> --
> 2.21.1
>
>


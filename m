Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F3C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445C92063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445C92063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL1sX-00050f-G2
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 04:43:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hL1rl-0004dS-0B
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hL1rj-0000Pe-CV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:42:24 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:40062
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hL1ri-0000NB-OE; Mon, 29 Apr 2019 04:42:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 7863181380;
	Mon, 29 Apr 2019 10:42:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5aYVgMI3gsU; Mon, 29 Apr 2019 10:42:20 +0200 (CEST)
Received: from localhost.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id C29498137F;
	Mon, 29 Apr 2019 10:42:19 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20190427162922.4207-1-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <50dfb24e-4944-6bae-4591-64a3a2747870@adacore.com>
Date: Mon, 29 Apr 2019 10:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427162922.4207-1-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: Re: [Qemu-devel] [PATCH v2] hw/sparc/leon3: Allow load of uImage
 firmwares
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Fabien Chouteau <chouteau@adacore.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429084217.uvhUE6MptjOqpopRQV_-Oz9KvzJ2oPkzjJq8CaoGkS4@z>

Hi Philippe,

Le 4/27/19 =C3=A0 6:29 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Currently the Leon3 machine doesn't allow to load legacy u-boot images:
>=20
>    $ qemu-system-sparc -M leon3_generic -d in_asm \
>        -kernel HelenOS-0.6.0-sparc32-leon3.bin
>    qemu-system-sparc: could not load kernel 'HelenOS-0.6.0-sparc32-leon=
3.bin'
>=20
>    $ file HelenOS-0.6.0-sparc32-leon3.bin
>    HelenOS-0.6.0-sparc32-leon3.bin: u-boot legacy uImage, HelenOS-0.6.0=
,\
>      Linux/ARM, OS Kernel Image (Not compressed), 2424229 bytes,\
>      Sun Dec 21 19:18:09 2014,\
>      Load Address: 0x40000000, Entry Point: 0x40000000,\
>      Header CRC: 0x8BCFA236, Data CRC: 0x37AD87DF
>=20
> Since QEMU can load uImages, add the necessary code,
> so the Leon3 machine can load these images:
>=20
>    $ qemu-system-sparc -M leon3_generic -d in_asm \
>        -kernel HelenOS-0.6.0-sparc32-leon3.bin
>    ----------------
>    IN:
>    0x40000000:  b  0x400007a8
>    0x40000004:  nop
>    ----------------
>    IN:
>    0x400007a8:  save  %sp, -136, %sp
>    0x400007ac:  call  0x40000020
>    0x400007b0:  sethi  %hi(0x4000b800), %i1
>    ...
>=20
> Tested with the following firmware:
> http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

It doesn't go through the whole boot of this HelenOS but we have the same=
 wrong
behavior with the Linux *SMP* kernel.

qemu: fatal: Trap 0x06 while interrupts disabled, Error state
pc: 400009e4  npc: 40000010
%g0-7: 00000000 00000018 80000000 00000018 4000a548 00000000 00000000 000=
00000
%o0-7: 00000018 00000000 000000e2 4000a0a8 4000a0a0 0000ffff 47ffff78 400=
009e0
%l0-7: 4000a000 00000024 47ffffd8 80a00000 00000000 00000000 00000000 000=
00000
%i0-7: 80a00000 4000ba00 47ffffd4 80a00000 00000000 4000a000 48000000 000=
00000
%f00:  0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
%f08:  0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
%f16:  0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
%f24:  0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
psr: f30000c7 (icc: ---- SPE: SP-) wim: 00000001
fsr: 00000000 y: 00000000

But this has nothing to do with the uImage loading so it seems ok to me.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>

> ---
> v2: Fixed GIT_AUTHOR_EMAIL
> ---
>   hw/sparc/leon3.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639af33..0383b17c29 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -193,6 +193,10 @@ static void leon3_generic_hw_init(MachineState *ma=
chine)
>           kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>                                  &entry, NULL, NULL,
>                                  1 /* big endian */, EM_SPARC, 0, 0);
> +        if (kernel_size < 0) {
> +            kernel_size =3D load_uimage(kernel_filename, NULL, &entry,
> +                                      NULL, NULL, NULL);
> +        }
>           if (kernel_size < 0) {
>               error_report("could not load kernel '%s'", kernel_filenam=
e);
>               exit(1);
>=20


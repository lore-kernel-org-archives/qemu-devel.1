Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72376C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488E0208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 17:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488E0208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoA4C-0005Cm-7L
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hoA3z-0004iJ-8Z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hoA3x-0004al-Vl
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:19:27 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:56428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hoA3x-0004Vd-PB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:19:25 -0400
Received: from player755.ha.ovh.net (unknown [10.109.160.217])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id E1D2613CE59
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 19:19:16 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 0FA3682DA5E6;
 Thu, 18 Jul 2019 17:19:12 +0000 (UTC)
Date: Thu, 18 Jul 2019 19:19:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Ivan Warren <ivan@vmfacility.fr>
Message-ID: <20190718191911.3dcb39cb@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <c3466869-e259-fe38-c974-b3ccd349345f@vmfacility.fr>
References: <c3466869-e259-fe38-c974-b3ccd349345f@vmfacility.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 12255420489552795980
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
Subject: Re: [Qemu-devel] [PATCH] Allow bit 15 to be set to 1 on slbmfee and
 slbmfev
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We usually mention the subsystem name in the subject, ie.

target/ppc: Allow bit 15 to be set to 1 on slbmfee and slbmfev

On Thu, 18 Jul 2019 14:44:49 +0200
Ivan Warren <ivan@vmfacility.fr> wrote:

> Allow bit 15 to be 1 in the slbmfee and slbmfev in TCG
> as per Power ISA 3.0B (Power 9) Book III pages 1029 and 1030.
> Per this specification, bit 15 is implementation specific
> so it may be 1, but can probably ne safely ignored.
>=20
> Power ISA 2.07B (Power 7/Power 8) indicates the bit is
> reserved but some none Linux operating systems do set

s/none Linux/non-Linux

> this bit to 1 when entering the debugger.
> So it is likely it is implemented on those systems
> but wasn't yet documented.
>=20

ISA describes things that are common to several processor types,
but each implementation may do some extra stuff... like giving
a special meaning to an invalid instruction form for example (see
commit fa200c95f7f99ce14b8af25ea0be478c722d3cec). This is supposed
to be documented in the user manual.

Maybe something similar was done with the reserved bit 15, even if I
could fine no trace of that in the Power8 UM... of course. I'll try
to find clues within IBM.

https://openpowerfoundation.org/?resource_lib=3Dpower8-processor-users-manu=
al

but it is indeed mentioned in the Power9 UM:

https://openpowerfoundation.org/?resource_lib=3Dpower-processor-users-manual

4.10.7.2 SLB Management Instructions

The POWER9 core implements the SLB management instructions as defined in the
Power ISA (Version 3.0B). Specifically, the following instruction details a=
re
noteworthy:
=E2=80=A2 The slbmfee and slbmfev instructions can read any SLB entry when =
UPRT =3D =E2=80=981=E2=80=99,
  if the L-bit in the instruction image is set to a =E2=80=981=E2=80=99. Th=
is is an
  implementation-specific feature that will only be used in the future if a=
nd
  when the POWER9 processor core supports UPRT =3D =E2=80=981=E2=80=99 for =
HPT translation.

Not sure if we support that in TCG, but it doesn't hurt to relax the check
if that's enough to make AIX's debugger happy.

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Ivan Warren <ivan@vmfacility.fr>
> ---
>=20
> The original creator of the patch is "Zhuowei Zhang"=20
> (https://twitter.com/zhuowei) but I couldn't find any e-mail address.
>=20

This is the original patch, correct ?

https://github.com/zhuowei/qemu/commit/c5f305c5d0cd336b2bb31cab8a70f90b7290=
5a1e

After speaking with some QEMU folks on irc, it is okay to ignore the lack
of S-o-b because the patch is trivial. But the general rule is to always
require an S-o-b when posting someone else's patch.

>  =C2=A0target/ppc/translate.c | 4 ++--
>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4a5de28036..85f8b147ba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7064,8 +7064,8 @@ GEN_HANDLER2(mtsr_64b, "mtsr", 0x1F, 0x12, 0x06,=20
> 0x0010F801, PPC_SEGMENT_64B),
>  =C2=A0GEN_HANDLER2(mtsrin_64b, "mtsrin", 0x1F, 0x12, 0x07, 0x001F0001,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PPC_SEGMENT_64B),
>  =C2=A0GEN_HANDLER2(slbmte, "slbmte", 0x1F, 0x12, 0x0C, 0x001F0001,=20
> PPC_SEGMENT_64B),
> -GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001F0001,=20
> PPC_SEGMENT_64B),
> -GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001F0001,=20
> PPC_SEGMENT_64B),
> +GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001E0001,=20
> PPC_SEGMENT_64B),
> +GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001E0001,=20
> PPC_SEGMENT_64B),
>  =C2=A0GEN_HANDLER2(slbfee_, "slbfee.", 0x1F, 0x13, 0x1E, 0x001F0000,=20
> PPC_SEGMENT_64B),
>  =C2=A0#endif
>  =C2=A0GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TLBIA),
> --
> 2.20.1
>=20
>=20



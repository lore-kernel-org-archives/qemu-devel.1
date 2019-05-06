Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ECEC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF5B2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XkuDYDmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF5B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNUTV-0001Yl-Lo
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 23:39:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURs-0000hV-B7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURr-0006qq-3V
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:52 -0400
Received: from ozlabs.org ([203.11.71.1]:39723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNURq-0006nt-4E; Sun, 05 May 2019 23:37:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44y7jD23Vcz9s9N; Mon,  6 May 2019 13:37:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557113856;
	bh=9yyuy9iEpVPHDt8YC0W8z/PlQg6S0rJW/YJPqz8TV/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkuDYDmHGbpt96aMhj3pb0gVH+OC/dM52l2Fi59ESu2e92Bu/FdIR6PgYwWQpPz7R
	BqZ1ww+IHVdduAj4om4gA/ZnmpB0LD3u7yU/eL89odq3xi3cr01AanljVIR/f7jaF+
	IdSwvE++jwmCTTrpyHO2DNqeWMj6lg/IL10EVY4A=
Date: Mon, 6 May 2019 13:25:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190506032540.GD6790@umbus.fritz.box>
References: <20190505152839.18650-1-philmd@redhat.com>
	<20190505152839.18650-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20190505152839.18650-2-philmd@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ppc/prep: use TYPE_MC146818_RTC
 instead of a hardcoded string
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2019 at 05:28:37PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Certainly a good fix, but looks like there's places in
hw/timer/mc146818rtc.c itself and in vl.c which could also do with
this.

> ---
>  hw/ppc/prep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index b7f459d4754..ebee3211480 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -601,7 +601,7 @@ static int prep_set_cmos_checksum(DeviceState *dev, v=
oid *opaque)
>      uint16_t checksum =3D *(uint16_t *)opaque;
>      ISADevice *rtc;
> =20
> -    if (object_dynamic_cast(OBJECT(dev), "mc146818rtc")) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
>          rtc =3D ISA_DEVICE(dev);
>          rtc_set_memory(rtc, 0x2e, checksum & 0xff);
>          rtc_set_memory(rtc, 0x3e, checksum & 0xff);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzPqTQACgkQbDjKyiDZ
s5L1iRAAta+CoF1UU1VJAVOIaFFB/SlHMx2nqyB7Sj+2q3NhZLKpQx9Ix4Ym+6Kv
cplJkFRxr4Y5ac3WJGlKukTklQeP+Y9kUICCMHS2Ec4dGtO3kwiQkXpkHRCs93/R
z5r8rYzha27eefhhJXC7Cc8bPams8MAqQhfd0GMSz9/jx+mK4HWAizcPAJj4fkxu
A2bHsQLncJBLi8F44hiixt7NaAgTKF/WvjYyIjCoUUeZ7/PFygV/b/FrovH6r8yU
CebMaFXXM3eGeJ2jKD9vd5YOUEjoZKBdh5FK0coI94gSZTUJCDCwLYNVRIeNxVAv
vbQszik0uiV1w4ZKUIeJX2/PZYI4rIHyf/wh+2uUBPTy+cUJzq9OT/i/2S28FOOc
V7zA3zrd7U5EI6a7BexwdRc9V85J0Vfd1eCC1f94xCumlCcyDxbwTAHTtbeOuzUq
iZF0jg8lRg0K+qRaChxzj2EoH4XYsor5Fo/tplstmI9Jt60r8slVZTK8QYYSw6mQ
LPV2gupeUv+5mauS6viwn8AVO1oMVhrTSH0Ahtcg0d8TRXSk3wABm3/wAXzd2yiQ
ss8KJaqiENoMnB5DDCEcQgGNMcUvM4qVa2HX3bhddRYWcaFTD0Kr4hCTlGGcAly2
nBbIWSnVomPdLPjH+P7zy3+YSLxL91mOuEGl8/ky8ELHTeX4Oa0=
=COer
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


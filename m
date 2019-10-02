Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8532CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA842086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="faRIAiWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA842086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFYKX-0001TS-Bq
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFYJR-0000mq-U9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFYJQ-0005Pc-LT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:40:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41541 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFYJP-0005Mq-Ga; Wed, 02 Oct 2019 02:40:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jmjV5Bbzz9sPc; Wed,  2 Oct 2019 16:40:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569998430;
 bh=UFn1Pgpul1VxIsIDPhtK4WxCu1MqCQz23VvRFSet+dg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=faRIAiWriBu6SQBFeu3q5Y9ih4VZhrZFHSISSr8b40cEjMsAnANjzr+3Rrc+hwIfE
 4XdYUi9U5ojTZ+Cmn95wMhe6Eae2bmlGoWm2vXP/HAK7tQolVWELj6/JDODn7XdoOV
 0AJx1txQEY0ViHqf9EUYyw3gpSydjdLaGLZ+TdRY=
Date: Wed, 2 Oct 2019 16:40:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 22/34] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191002064015.GY11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-23-david@gibson.dropbear.id.au>
 <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
 <3118503c-10a2-507a-46e5-da0847d7135e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I2k41U2G4dq8LTBU"
Content-Disposition: inline
In-Reply-To: <3118503c-10a2-507a-46e5-da0847d7135e@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--I2k41U2G4dq8LTBU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 08:13:55AM +0200, C=E9dric Le Goater wrote:
> >> @@ -527,6 +471,30 @@ static int spapr_irq_check(SpaprMachineState *spa=
pr, Error **errp)
> >>  /*
> >>   * sPAPR IRQ frontend routines for devices
> >>   */
> >> +#define ALL_INTCS(spapr_) \
> >> +    { SPAPR_INTC((spapr_)->ics), SPAPR_INTC((spapr_)->xive), }
> >=20
> > I would have expected this array to be under the machine.
> >=20
> >> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >> +                              PowerPCCPU *cpu, Error **errp)
> >> +{
> >> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> >> +    int i;
> >> +    int rc;
> >> +
> >> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> >=20
> > but it would have been difficult to use ARRAY_SIZE. OK then.
> >=20
> >> +        SpaprInterruptController *intc =3D intcs[i];
> >> +        if (intc) {
> >=20
> > Is that test needed ?=20
>=20
> I understand now : spapr->ics and spapr->xive can be NULL.=20
>=20
> I think using a list would be better.

Uh.. a list in what sense?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I2k41U2G4dq8LTBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2URk0ACgkQbDjKyiDZ
s5K6mhAAknugLJpMGxAHWhMKCrw87BjxKqqnJUlMu9IMUaGWlJo+SABBzhg/udIi
AKj7LGeOdHws1uMWKnNwCLqCzSC+/irVhi0XFaOn62ALmxnNUyHOhOHrtT0j9eQ7
atXZtoYi/ypJBV5S+qTh1rmMVjso1zkL6dvMbxf/kF8LFwArc5DpfbSHP11boJJb
pvKmtX8hKBALIzmnAC3q2IiYZWH0DMelDcTZytB0qjADjFBSYhd34sTXlKBnTLE3
j/sboUBEkD/A1JyceFsIPKbByigCRkCOVKVVp9jSXTgGJgYLTb2TjxqbGWrW4Jmw
YTfiCubernHhrFIS6ZTSkltZwWvPYYiIHqiSx7bCyXPbIa5pc40oXnrLvX6jBVfm
ou8mp9qMcl4LwiTAw5dG8y+/cZdjnVkiNBZLSj+55jTuN9zZKGJDXD/tVbWCp5rl
uuCXPo93DdPT7a30vXG5w8Rn9FRcdhs6bEq4XlJKN11zLI0MOVoSk3VE/vP6jC0W
TjsRdFSA/DdlWv/WnpW+9qsIP87T7oNfzePtGrqTmhOrJFddkbq/08elQhLza7Oq
NG7K0InsFkZalRyqzMWd6D1CBybEM1lvDTH89yJzXg8h1uoLTjOc5s0HB+5uPSNN
HxLb2XLIFwVY/OvznjtcUrrTF13YRobtHGwzpBGq4XztuJ0CtUU=
=OrbP
-----END PGP SIGNATURE-----

--I2k41U2G4dq8LTBU--


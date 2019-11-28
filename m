Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A61A208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CzgPuix4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A61A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaB1Y-0007ra-9Q
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaB02-0006JL-Bh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaAzy-0001Tk-9e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:48 -0500
Received: from ozlabs.org ([203.11.71.1]:39371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaAzs-0001Jn-Fr; Wed, 27 Nov 2019 23:01:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47NkTq5pngz9sPc; Thu, 28 Nov 2019 15:01:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574913695;
 bh=+/8PUNHuEuGsWwy96B4j9Ft2HYXfZfG7gfrvt4XmooU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CzgPuix4WQTNzT7BTWY8iVT+hB1qsMrmagWQ8EVUfvtyAX1bUsKxz8g28fnLwqdx/
 zuNMieSRSfgkPXGtINLH3GVqLGZJjipbuPyIj4eve91x/MwoJOKFj9t2Xw0eKSv6Yr
 CFTJ+h1PuS/QL8kttqkK8mGM/grMNLp2zb0Pb9z8=
Date: Thu, 28 Nov 2019 12:30:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 13/20] ppc/pnv: Clarify how the TIMA is accessed on a
 multichip system
Message-ID: <20191128013024.GA4765@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-14-clg@kaod.org>
 <20191127052353.GR5582@umbus.fritz.box>
 <49a23d16-596f-9345-f734-b06443704dfa@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <49a23d16-596f-9345-f734-b06443704dfa@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 07:57:31AM +0100, C=E9dric Le Goater wrote:
> On 27/11/2019 06:23, David Gibson wrote:
> > On Mon, Nov 25, 2019 at 07:58:13AM +0100, C=E9dric Le Goater wrote:
> >> The TIMA region gives access to the thread interrupt context registers
> >> of a CPU. It is mapped at the same address on all chips and can be
> >> accessed by any CPU of the system. To identify the chip from which the
> >> access is being done, the PowerBUS uses a 'chip' field in the
> >> load/store messages. QEMU does not model these messages, instead, we
> >> extract the chip id from the CPU PIR and do a lookup at the machine
> >> level to fetch the targeted interrupt controller.
> >>
> >> Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
> >> this process in pnv_xive_get_tctx(). The latter will be removed in the
> >> subsequent patches but the same principle will be kept.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/pnv.h |  3 +++
> >>  hw/intc/pnv_xive.c   | 40 +++++++++++++++++++++++-----------------
> >>  hw/ppc/pnv.c         | 14 ++++++++++++++
> >>  3 files changed, 40 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> >> index a58cfea3f2fd..3a7bc3c57e0d 100644
> >> --- a/include/hw/ppc/pnv.h
> >> +++ b/include/hw/ppc/pnv.h
> >> @@ -103,6 +103,7 @@ typedef struct Pnv9Chip {
> >>   * A SMT8 fused core is a pair of SMT4 cores.
> >>   */
> >>  #define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> >> +#define PNV9_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
> >> =20
> >>  typedef struct PnvChipClass {
> >>      /*< private >*/
> >> @@ -197,6 +198,8 @@ static inline bool pnv_is_power9(PnvMachineState *=
pnv)
> >>      return pnv_chip_is_power9(pnv->chips[0]);
> >>  }
> >> =20
> >> +PnvChip *pnv_get_chip(uint32_t chip_id);
> >> +
> >>  #define PNV_FDT_ADDR          0x01000000
> >>  #define PNV_TIMEBASE_FREQ     512000000ULL
> >> =20
> >> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> >> index 95e9de312cd9..db9d9c11a8f4 100644
> >> --- a/hw/intc/pnv_xive.c
> >> +++ b/hw/intc/pnv_xive.c
> >> @@ -439,31 +439,37 @@ static int pnv_xive_match_nvt(XivePresenter *xpt=
r, uint8_t format,
> >>      return count;
> >>  }
> >> =20
> >> +/*
> >> + * The TIMA MMIO space is shared among the chips and to identify the
> >> + * chip from which the access is being done, we extract the chip id
> >> + * from the PIR.
> >> + */
> >> +static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
> >> +{
> >> +    int pir =3D ppc_cpu_pir(cpu);
> >> +    PnvChip *chip;
> >> +    PnvXive *xive;
> >> +
> >> +    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
> >> +    assert(chip);
> >> +    xive =3D &PNV9_CHIP(chip)->xive;
> >> +
> >> +    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> >> +        xive_error(xive, "IC: CPU %x is not enabled", pir);
> >> +    }
> >> +    return xive;
> >> +}
> >> +
> >>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> >>  {
> >>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> -    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> >> -    PnvXive *xive =3D NULL;
> >> -    CPUPPCState *env =3D &cpu->env;
> >> -    int pir =3D env->spr_cb[SPR_PIR].default_value;
> >> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> >> =20
> >> -    /*
> >> -     * Perform an extra check on the HW thread enablement.
> >> -     *
> >> -     * The TIMA is shared among the chips and to identify the chip
> >> -     * from which the access is being done, we extract the chip id
> >> -     * from the PIR.
> >> -     */
> >> -    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
> >>      if (!xive) {
> >>          return NULL;
> >>      }
> >> =20
> >> -    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
> >=20
> > I'm not seeing any code which will replace this check on the thread
> > enabled register.  Is that really what you intend?
>=20
> it is calling pnv_xive_tm_get_xive() which calls pnv_xive_is_cpu_enabled()
> which does the same check in better.

Ah, yes of course, thanks.

Applied to ppc-for-5.0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3fIy0ACgkQbDjKyiDZ
s5KKlA//ZOjecSkoUpaABob54W+f8yP6dZ1wXAlFGHsoXGJ2D10kP2CxHy/AXjIN
oWJ3Z4T+FSRiKeMfvnX8caXE34eJ3I5JbBmqIC2uTyavFm7TK853tT/em5UwVFM0
lJvcbH6OF2uzf8Rixi7mL1+09+44wjkSw6anBMvqShyuPIKvvhE5uNCFTIf5hoSh
iT3NjdFyBCgT2MTZMBKe0/ykHy3ZqYcWogyVDfBmJ3T95prIOxfk6tIwpz/P3kRQ
CDsyvMB++IZm0jxBpaOsJ5INlfPskZ12pCdwITvDGdKupTdwNWKZZ5BPTyMTD5C8
JHSq2m+Durx5pz9n9ZlqXyfD92KQmzMrfmr9ylScduwCQBh15DbbJa6n5d6feiNe
J6nyKwNMaPjjzmo9RvjY3WoKP7kMEPfRjCW2o83aI/4K/S2j1TF41aDKRGPVTSr5
G7GJ4D2fwF9zyGsSG+WCItR5qgYadLPWEVyThdQo+Q20K/KP/PnRjEGPqn+FYQzI
uWqxgSeqrO5TQOLx1OaJouOQd3JcpgCub1m7HdEvGHcV+S0ngvZfVSBIm5ca8pP/
s0xN39OcTEAVom7ttUVbBVPkcs8Fa6Jt4B9ok9JkMMpDZh09ji6yQqjD81pjKTmK
XPMFmpz03LPIbiw3k4xYOZcaoPLvJxMWk3xMII+/au51RE1ZBiQ=
=3uNe
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


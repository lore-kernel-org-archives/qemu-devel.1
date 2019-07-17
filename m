Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B4C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A222182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZuRc/nQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A222182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53511 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZGs-00030T-NM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZGA-00011b-IZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG9-0008Ds-7w
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57375 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnZG8-0008CV-J0; Tue, 16 Jul 2019 22:01:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pL905ZR0z9sNq; Wed, 17 Jul 2019 12:01:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563328884;
 bh=q6UzWaLPvEiEIhiNKkSs5QmIRbeg/sFKGRR6qGcoNjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZuRc/nQ6QvXCd/h+qG+xLpoqjnZN0MVv8fbz9m3m6y8YTWSBtmW0kQ75pulyNHswg
 xbpBHd+3pLnV07aMLGJFN35hgSrMmSzvydPsEK2nKZniW76awJ3sjQq/KSeempzLVL
 mcsNrdyXfJjfNkstp1Z4TK2yuKXEKRdNxr6YBjtk=
Date: Wed, 17 Jul 2019 11:51:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717015153.GB9123@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-4-npiggin@gmail.com>
 <20190716082549.GE7525@umbus.fritz.box>
 <1563270152.eyfvtns0jc.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <1563270152.eyfvtns0jc.astroid@bobo.none>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 3/5] spapr: Implement H_CONFER
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 08:25:28PM +1000, Nicholas Piggin wrote:
> David Gibson's on July 16, 2019 6:25 pm:
> > On Tue, Jul 16, 2019 at 12:47:24PM +1000, Nicholas Piggin wrote:
> >> This does not do directed yielding and is not quite as strict as PAPR
> >> specifies in terms of precise dispatch behaviour. This generally will
> >> mean suboptimal performance, rather than guest misbehaviour. Linux
> >> does not rely on exact dispatch behaviour.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  hw/ppc/spapr_hcall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >>=20
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 8b208ab259..28d58113be 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1069,6 +1069,53 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_long target =3D args[0];
> >> +    uint32_t dispatch =3D args[1];
> >> +    PowerPCCPU *target_cpu =3D spapr_find_cpu(target);
> >> +    CPUState *target_cs =3D CPU(target_cpu);
> >> +    CPUState *cs =3D CPU(cpu);
> >> +    SpaprCpuState *spapr_cpu;
> >> +
> >> +    /*
> >> +     * This does not do a targeted yield or confer, but check the par=
ameter
> >> +     * anyway. -1 means confer to all/any other CPUs.
> >> +     */
> >> +    if (target !=3D -1 && !target_cs) {
> >> +        return H_PARAMETER;
> >> +    }
> >=20
> > Should we return an error if a targeted yield is attempted, rather
> > than pretend we've done it?
>=20
> I don't think so, because we do _some_ kind of yield for the directed
> case which is probably better than nothing, and Linux won't fall back.
>=20
> PAPR is much more strict about dispatching. The H_CONFERing vCPU must=20
> not run until the target(s) has been dispatched (if runnable), for
> example. So we don't really implement it to the letter, we just do
> "some kind of yield, whatever generic tcg code has implemented".
>=20
> For single threaded tcg it seems a signifcant complication to the
> round robin algorithm to add a directed yield, yet simply yielding
> to the next vCPU is a good idea here because useful work will get
> done including by the lock holder before we run again.
>=20
> If multi threaded tcg performance with lot of vCPUs and lock contention
> starts becoming more important I guess directed yielding might be
> something to look at.

Ok, makes sense to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ufzkACgkQbDjKyiDZ
s5IwJQ/5AchWldMf3+8LTgVobwwLpNOFFXqDC6ywOgREmAeQyGWOFaQOHVGnDx4/
/cfzvFehWMuQNoNtBB7a8aHr8Z612XJBU9lNV0tGS/ZyhjhAAVH1exdQSHl/IXWh
J1AbTP2trU5IcPT5DmkE8lazZCIX1y55t7kTT1akf+iwkNU9FWhkblMahEzHEkXx
AlO+KvMM0mvCbc7D6wO/7aBwqfwoOTkap0GXjb9CakbdNv7aBAsYwX6TFao8dh0p
H41q7wo8wsK51EkLE2+MctvJ3GDu169AJ3NLsXQLZu3S1iH0CBQcMrPufNG4LiLm
iHcmYbtBZHM6GNkPpgDKR1M0mVXLDrjpnMFmY9RKHXJClSGw0yO/sT+tEf3/Vyd3
qyLTWVOr2poCHwH5+6j1MeEaRjf0KPihi05Ysml90a1n6USAQtSgQCINNJFgLNeI
h8HPYxpY0QlNslKVsjig+cYT53X4DMPBixWUzRthaAL7Bk1QqJCWLJw+LIMW/rPv
r8FSqf54cfFzOiX55Ux7ZHWCNIM3ugm9E9D5/DsTXHOqrcXEc2+Wu+MX/A1x+nAX
B3PXX0rcWpoRcDPapUg5jGEBDTSVEy/fCHwKk5xLfz5TWPPi3gXxfMxHqK+bFZQG
mVjG6nPHbB12Btmvzhy/RxrLbpnPsCka4DTgBsZatkCaFXqzTWg=
=S7Sd
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


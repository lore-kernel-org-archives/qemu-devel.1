Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C1220658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HD/ZgXLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C1220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3Qy-0006vM-CD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE3PQ-0006Li-1l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE3PO-0008A9-5v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:00:51 -0400
Received: from ozlabs.org ([203.11.71.1]:34543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE3PM-0006m6-Ug; Tue, 17 Mar 2020 00:00:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hKFz0YFlz9sRR; Tue, 17 Mar 2020 15:00:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584417639;
 bh=+hmb4Dxvpb0Ht16ulbnoLoVneUPRFhRj5pJfFqHrQ6I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HD/ZgXLlEgnM2y0LggTHzwkTKAjP/W6EV2Vi7tuWXKkVVLfLgfyicp9lMDG8fDHJ7
 1NA0W9L2+c9BCyhPYLHF+4+w/6+x3Va1jf1sesHW23ULj7AYC7yG7ELq8T90qjHAbG
 peZkELUrDs4MkBR+K5nN4LxdcqFu1lxGNECqrCg0=
Date: Tue, 17 Mar 2020 14:56:50 +1100
From: David? Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 5/8] ppc/spapr: Allow FWNMI on TCG
Message-ID: <20200317035650.GM20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-6-npiggin@gmail.com>
 <20200316190103.00bd1628@bahia.lan>
 <1584400812.98siy81ysk.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline
In-Reply-To: <1584400812.98siy81ysk.astroid@bobo.none>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 09:26:15AM +1000, Nicholas Piggin wrote:
> Greg Kurz's on March 17, 2020 4:01 am:
> > On Tue, 17 Mar 2020 00:26:10 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >=20
> >> There should no longer be a reason to prevent TCG providing FWNMI.
> >> System Reset interrupts are generated to the guest with nmi monitor
> >> command and H_SIGNAL_SYS_RESET. Machine Checks can not be injected
> >> currently, but this could be implemented with the mce monitor cmd
> >> similarly to i386.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  hw/ppc/spapr_caps.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>=20
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index f626d769a0..679ae7959f 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -516,10 +516,7 @@ static void cap_fwnmi_apply(SpaprMachineState *sp=
apr, uint8_t val,
> >>          return; /* Disabled by default */
> >>      }
> >> =20
> >> -    if (tcg_enabled()) {
> >> -        warn_report("Firmware Assisted Non-Maskable Interrupts(FWNMI)=
 not "
> >> -                    "supported in TCG");
> >=20
> > With this warning removed, we can now drop the "cap-fwnmi=3Doff" setting
> > in qtest, but this can be done as a followup.
>=20
> Ah right, thanks. Would you send the patch later or should I?

No need, I already folded the change into your patch.

>=20
> Thanks,
> Nick
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wSoAACgkQbDjKyiDZ
s5Kuug/8DT86ggK0qhkUQMA3IlgrppYfLGJqDO0Cczo8p3Ch8VYAhddRTsfJ3kUh
RT+Hj9xzkD3PzBpeO4RXfAAqKIp01mfvXVLULRWXLqihJ+Grc64hC3vlziUJFZiI
gGtn4QQZM3eaO9UcdWrjYcbO2k3FMGItzmM8qq4SiPxmqfpiL0a5cHsCHr+2bZlh
GNQqMAzHLZzLD4eLOJeoAfiMc7VOH5ZSTmNkXpG5ug6g5w/qJyZBJ5wtra8+K7Uw
X54Th34Be5k2Ehkr7k/T3IXZHVa89pwohoyRiXyx9QcXXzcNpeaPSZtrjvI7rnbO
S8lPuZYgTiA9wGgaHj/vrXOYLWlN5qJbQyz6LLZ80vmxHWJAo/J7slpsj7UO66Pt
TLQU+1WPfqb4Oqhp9VAUFX4AYDndPCuIIMhjGy9Ae6WQgCxbODCx0boFPrlt2xQ1
yYJHW5BR/cp5MWywybFQ15tGqbxSin0Q9EQ396VQaINjFSS69Yq6eD8mzaLeBFGA
lM1zgvSKyWcZTUGvbTb2B6XQ4T1fRNTyT6m//tORcrDGqZRzku15wMxEHsmKMbQK
hgFSD82Idui+qGWs9REJnum4rivEODQ0jn99BEy5JYQ150UyS7HhAd3OLmW8SpWv
Aq+TwrHjVxZc1WpOU0/cFoB3+de1Y0ziKx6fdsUDt5oSGXFxYb0=
=d9eX
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--


Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A5C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676E021855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YRg3DM/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676E021855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEr1a-0007Da-7v
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 04:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEr0Q-0006UX-AR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEr0O-0003dT-GI
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:26:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38649)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEr0N-0003cC-2n; Mon, 30 Sep 2019 04:26:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hb842Hm3z9sDB; Mon, 30 Sep 2019 18:25:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569831956;
 bh=pieiujA26YbvNyFUiNzXCY2SV5f89dLeseMclkucl0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YRg3DM/N77s9iEK6VmsD5SdGxliUsAaXG0AfPzG71IVZtVLACT1GhGWlYVYYVI/AC
 MS0XOkftcY2vhRzaOsbR1RpPTnTGX7ve8O9MM6z4A97nGKiWdlqeCvgHoK8ZcfGn5S
 NRDnJEOAb8gUzG13HRrZxeU2j+LXWy4Fe5F0aqX8=
Date: Mon, 30 Sep 2019 18:25:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 29/33] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
Message-ID: <20190930082543.GH11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-30-david@gibson.dropbear.id.au>
 <f64cc1b3-95b1-08e8-8059-35cdf2e5153b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <f64cc1b3-95b1-08e8-8059-35cdf2e5153b@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 08:11:56AM +0200, C=E9dric Le Goater wrote:
> On 27/09/2019 07:50, David Gibson wrote:
> > It turns out that all the logic in the SpaprIrq::reset hooks (and some =
in
> > the SpaprIrq::post_load hooks) isn't really related to resetting the irq
> > backend (that's handled by the backends' own reset routines).  Rather i=
ts
> > about getting the backend ready to be the active interrupt controller or
> > stopping being the active interrupt controller - reset (and post_load) =
is
> > just the only time that changes at present.
>=20
> This is a 'critical' part which impacts all the migration cases:=20
>=20
> ic-mode=3Dxics,xive,dual + kernel_irqchip=3Don/off + TCG

Yes... and?

> > To make this flow clearer, move the logic into the explicit backend
> > activate and deactivate hooks.
>=20
> I don't see where the hooks are called ?

spapr_irq_reset()
  -> spapr_irq_update_active_intc()
    -> set_active_intc()
      -> activate/deactivate hooks

Similarly via spapr_irq_post_load().

I'm hoping to add one at CAS time to avoid the CAS reboot, too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RvAUACgkQbDjKyiDZ
s5K/nA//bjXYiOeBNCRkEt5NePgK+Brx6PuM+BUbPo83vsUODg/Cv1FNluahOJEm
16oqRT61WJ/WllCSWEk2lcpueBxTTR93zaUk47sHyJ0Ko/YC37bufbZASg6ksSxK
E+ho3Gc0J27UVM/Rvl8jp9J/Kw6MZdR9W51O4PK6EbW+9vE4tb/sRIz6Daq9dKgG
Uo1ADfNCwX9ognwpFK62bUCMZIMn/CeremKbGqOguv/8CJ2xhQPlx4dwxwtynZhy
XW/yhBmP/71nPdliZGt2gPQAa0ki+h3zyqfSXfMJ9NsZVRdkDBY+nTeC/D/naVsL
W1IMioV2FnkyFTi+KS2j2TlE+AOgGmc+PCKa6JZxHFRn6YgxwfNreOenOvNZwc5n
tNxuMgYUJ4heT/dDlgLJpQfyiD8T/p1xubrL/WFDx5veRxQTL0p1cGWCEf+N5fNd
zfuPl/aASxsVEtOKX/sRm6K5KZRO9bcAy/IR1onDliTb2MDxwMtihnpKdVZKq41p
g/chb3nZ8YAqUeHHNlFN/l3nwbpYfbYLjnYjMXW8Uyps2wJEoFmSV3L01qyFhHwe
LW9cgtWk0IkP9YjeepEppobWL37Pe2y+s570RGPHlPEl1T+RTWAGZppIUUQYKbnx
+AZOPl/2Gbuu0yhFKbhEoVlnq1/D9v233OMi61bn6u8WnEUgdDY=
=jaIZ
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--


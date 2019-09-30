Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B28DC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06212086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D6n/Ys1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06212086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEn8e-0004Ak-Ph
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 00:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn61-0002S4-J9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn5z-0001pL-UC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:37 -0400
Received: from ozlabs.org ([203.11.71.1]:36555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEn5y-0001oi-Kp; Mon, 30 Sep 2019 00:15:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hTb62yRPz9sPJ; Mon, 30 Sep 2019 14:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569816930;
 bh=sMoc6US5ubF2oNztIOvoeOvaDxeErLkS0YaZTW/tSXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D6n/Ys1pyV73mjW+waC1QtXOEjVLyUkG2hGXlwurVWCGrRHiIFAgE54ld4C9x8fwN
 2OtUqxm2vGGSRCdQUnwK9Rc92Un2253kAdafeEm+Y+BxjgX4j1M1cI7YMj0L8gDD0Q
 BlJDS6pcuDRHPE/Nzn1GdJRVWakvc0+jt2NxXLrE=
Date: Mon, 30 Sep 2019 12:37:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20190930023740.GC11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20190927121649.5b9f3db7@bahia.lan>
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
> On Fri, 27 Sep 2019 15:50:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This method essentially represents code which belongs to the interrupt
> > controller, but needs to be called on all possible intcs, rather than
> > just the currently active one.  The "dual" version therefore calls
> > into the xics and xive versions confusingly.
> >=20
> > Handle this more directly, by making it instead a method on the intc
> > backend, and always calling it on every backend that exists.
> >=20
> > While we're there, streamline the error reporting a bit.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

[snip]
> > +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> > +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> > +                  void *fdt, uint32_t phandle);
>=20
> These two ^^ seem to belong to later patches.

Oops, yes.  I've moved those to where they belong.

>=20
> > +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> > +                              PowerPCCPU *cpu, Error **errp);
> > +
> > +
> >  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
> >  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> >                          Error **errp);
> > @@ -61,8 +75,6 @@ typedef struct SpaprIrq {
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> >      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> >                          void *fdt, uint32_t phandle);
> > -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> > -                            Error **errp);
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> >      void (*reset)(SpaprMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RanEACgkQbDjKyiDZ
s5KAWg//cQsxP70ykXkop56UQM6zjhSpYo/skHeN48pgOOgkb7/h7tfPKTKDb1a2
OShAo8O4byzBun6oYXQT7XMQRf7A8DKbl9a4ZWbklxjuS+y3qWir00/Fu9ucgtQf
YUQTbHeoZyQZaN6pSoaOIPUxBIYWQ2WXoB2yXYQ+TBb+L+T4OarfBZnLEsBXAHpV
0/1h6GiKc0o8h199In6p9Ktf2FA7QzWYTEKg6ValkvF3Dr02usZmWoAcmfbdpje0
sVgQKyYRG5JgD/leshaqZQcYlW2t3zSqHtdOsS3v80tVOjrzLLKVxCe/eaqeNiVF
IPi/uIAiekgI+NtanWFTrb0O5g7eAFo7cSxcAPYuRlncqY43lMo/AuAY1VQ7jgW9
cPpVEJNqfny8afh6HCrZriTnLZRr7Y1vHfaGzdn9Q5VmG+ze6kGOdHgktnIbQ/HS
mFOuKb1iHu4Va+V7SOnzuPymzXLy3d+VKqm5dfpO18DycaBud+tHecok7e/5IOJ/
tORvhGb06ILJYdfeTFRUvl68FRoW+sNgptHeBIlO7L9j/UNsCAvplnlAPqDM2lbo
ADgRx9K8oNMqfq6X58F7dmy2MPL09XU1EhDPvqd2mq5fGp9njbKmD+sEZMmMRCls
auDTr0O5EVAcwtFMdc8/EoIIVib2L2xvTqQLsaKIN8QrIhKV0yw=
=Hg2p
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--


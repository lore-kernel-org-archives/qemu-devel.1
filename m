Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB8C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAC820775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cWGl65ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAC820775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvtmU-0004N8-AQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvtlo-0003xP-6v; Wed, 15 Jul 2020 22:37:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56671 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvtlk-0001bQ-FU; Wed, 15 Jul 2020 22:37:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6dgc3vj8z9sT6; Thu, 16 Jul 2020 12:37:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594867020;
 bh=FUVFnp+oflaghzrJtqeO2dHMNcLscZo659eJct7q4Zo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cWGl65ahFNnWXhBxTXaiarldsZytzfJfDI5gdVvss0D7oOH3gJkvO0zoGoOttrC56
 5UMEArs92xL2t1ZNgyKim+BJ1qhuhkKQvnBQPqN0e0bsjK4bfqInOLzALRNTv6ca+z
 T34ifrTuSrvPQTqNXTsez+8zufAjhD7CcBsFaGfg=
Date: Thu, 16 Jul 2020 09:26:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200715232610.GK93134@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
 <20200615112031.679512c3@bahia.lan>
 <20200703161924.7131e87f@bahia.lan>
 <20200713045330.GK2666@umbus.fritz.box>
 <20200715131442.2ab70206@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Content-Disposition: inline
In-Reply-To: <20200715131442.2ab70206@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 01:14:42PM +0200, Greg Kurz wrote:
> On Mon, 13 Jul 2020 14:53:30 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jul 03, 2020 at 04:19:24PM +0200, Greg Kurz wrote:
> > > On Mon, 15 Jun 2020 11:20:31 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >=20
> > > > On Sat, 13 Jun 2020 17:18:04 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > > > > > Nested KVM-HV only works on POWER9.
> > > > > >=20
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > > >=20
> > > > > Hrm.  I have mixed feelings about this.  It does bring forward an
> > > > > error that we'd otherwise only discover when we try to load the k=
vm
> > > > > module in the guest.
> > > > >=20
> > > > > On the other hand, it's kind of a layering violation - really it's
> > > > > KVM's business to report what it can and can't do, rather than ha=
ving
> > > > > qemu anticipate it.
> > > > >=20
> > > >=20
> > > > Agreed and it seems that we can probably get KVM to report that
> > > > already. I'll have closer look.
> > > >=20
> > >=20
> > > Checking the KVM_CAP_PPC_NESTED_HV extension only reports what the ho=
st
> > > supports. It can't reasonably take into account that we're going to
> > > switch vCPUs in some compat mode later on. KVM could possibly check
> > > that it has a vCPU in pre-power9 compat mode when we try to enable
> > > the capability and fail... but it would be a layering violation all
> > > the same. The KVM that doesn't like pre-power9 CPUs isn't the one in
> > > the host, it is the one in the guest, and it's not even directly
> > > related to the CPU type but to the MMU mode currently in use:
> > >=20
> > > long kvmhv_nested_init(void)
> > > {
> > > 	long int ptb_order;
> > > 	unsigned long ptcr;
> > > 	long rc;
> > >=20
> > > 	if (!kvmhv_on_pseries())
> > > 		return 0;
> > > =3D=3D>	if (!radix_enabled())
> > > 		return -ENODEV;
> > >=20
> > > We cannot know either for sure the MMU mode the guest will run in
> > > when we enable the nested cap during the initial machine reset.
> > > So it seems we cannot do anything better than denylisting well
> > > known broken setups, in which case QEMU seems a better fit than
> > > KVM.
> > >=20
> > > Makes sense ?
> >=20
> > Yeah, good points.
> >=20
>=20
> So, should I just rebase/repost this or do you think of another
> way ?

Urgh... I've kind of forgotten the context while I've been away.  So,
I guess repost and I'll take another look at them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8PkJIACgkQbDjKyiDZ
s5JmVxAAiQBwSqpy3VSOIAoJ3EivySkqfH2jVN3SNUFphufCbmVWANW7ERCuzU2K
Q047t2FNqFxv/f6HYXrTeEdgLu32UOWBR+6EK0IV/XdXg/US5oRjE/LcAGbPStAq
QqeBYaZdDYyX23CovGdcIq8bjx8SuLuVYujwMSk3iWnQ+j+f508be8KkIvvBRjnt
7vArbXwO4KWBGmUPRYiPQJ3rO6NRjgA0lgzf5aE9vRTvcT+AvbNvvpj6PwT0AxwL
7nXaZp1JSAPxx3FA9hEt6fD1ub2F9l3yItQADgMK+zclnFuJcuPsbISzJ8hUk7Yi
r0pw8dL7He98XlKxBDFiZmuciPNVyg9rWHTKh9I1rVuM35BEa8bzxezHkNoInYCJ
oxF5DPCt8Hf66KOKCRVvHexMoGPes2cEkEky2BmfzL2YObSC/6FftdubBRBdeE3K
yWqA4BugiNlEkzgWkCJxWCjk+iE9hLSaTaX8CKbG8+TCl9fAuPp4rZfG9W5jHgTm
XlW9VC80ZvODT/hOcprfrGJDovpKOEEu0+jF1haKR9kmiyRRKZLcjUXVwtXG0n2n
iB+OoP+nc+ruqMoWm8FRfz4TG4bkRANUQgsr2MEHvp5Z8mW2Y1GOFk0yC6LdZ9Qu
jquCwYCD8EtpDA6Y0fM5xJpxgRsq9SEMoX8Hj0biM9sNoNuYfmc=
=o5bS
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--


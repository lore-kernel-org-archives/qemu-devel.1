Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A13C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6D52073A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kbEhojsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6D52073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juqpS-0000sL-T3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 01:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqnz-0007u8-4A; Mon, 13 Jul 2020 01:15:07 -0400
Received: from ozlabs.org ([203.11.71.1]:55825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqnw-0008R4-DU; Mon, 13 Jul 2020 01:15:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B4sK83kpDz9sQt; Mon, 13 Jul 2020 15:14:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594617292;
 bh=Cmq0Wioc83FgaqZSiKWmUqPb4Mh8jfPSL28gqUB7D1c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kbEhojsJjcIpa+Ve7El1E56II2zblc06KGnu4jCeULJJpMXN4UCLsxykKmyOMJF2Z
 87AzrpmBM6aMHmsXPrXPx349W4moVV+yftqeYWGFAzbFt+cMrkJcNN7QQBnWwbi4C7
 TEhnyqggX0JmIK14+56Tv0lgBwjvsdvC3zJwgtks=
Date: Mon, 13 Jul 2020 14:53:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200713045330.GK2666@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
 <20200615112031.679512c3@bahia.lan>
 <20200703161924.7131e87f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <20200703161924.7131e87f@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 04:19:24PM +0200, Greg Kurz wrote:
> On Mon, 15 Jun 2020 11:20:31 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Sat, 13 Jun 2020 17:18:04 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > > > Nested KVM-HV only works on POWER9.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > >=20
> > > Hrm.  I have mixed feelings about this.  It does bring forward an
> > > error that we'd otherwise only discover when we try to load the kvm
> > > module in the guest.
> > >=20
> > > On the other hand, it's kind of a layering violation - really it's
> > > KVM's business to report what it can and can't do, rather than having
> > > qemu anticipate it.
> > >=20
> >=20
> > Agreed and it seems that we can probably get KVM to report that
> > already. I'll have closer look.
> >=20
>=20
> Checking the KVM_CAP_PPC_NESTED_HV extension only reports what the host
> supports. It can't reasonably take into account that we're going to
> switch vCPUs in some compat mode later on. KVM could possibly check
> that it has a vCPU in pre-power9 compat mode when we try to enable
> the capability and fail... but it would be a layering violation all
> the same. The KVM that doesn't like pre-power9 CPUs isn't the one in
> the host, it is the one in the guest, and it's not even directly
> related to the CPU type but to the MMU mode currently in use:
>=20
> long kvmhv_nested_init(void)
> {
> 	long int ptb_order;
> 	unsigned long ptcr;
> 	long rc;
>=20
> 	if (!kvmhv_on_pseries())
> 		return 0;
> =3D=3D>	if (!radix_enabled())
> 		return -ENODEV;
>=20
> We cannot know either for sure the MMU mode the guest will run in
> when we enable the nested cap during the initial machine reset.
> So it seems we cannot do anything better than denylisting well
> known broken setups, in which case QEMU seems a better fit than
> KVM.
>=20
> Makes sense ?

Yeah, good points.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8L6MgACgkQbDjKyiDZ
s5KOrw/+ISJIK+8Q0SwAQS1tt3Vh08oUk+ymyRkAzWs0Te+JCWnO1mYkmmdtPmdQ
IeOL07KKqecYXee+uQa+E5C22hMPr3bkMJ6honVneb1+wJwkKcZRnsldeiKV+iTB
OfmHy9IOfJ1YaD5s3Yq38NLo9HhsdXWfYoHMyDS8eEj7A+jPidnaBQ5G0L9IwZPg
NkBhY/4L/1EuMcKnWHygiDsLVGthqq7NAq7jEoo/I5MeRP2F+XJmV7MoFpPRnR1q
GqsKz3wxUaj5/L3yqTteVETQDIDv94hKsmLY5ur0Fab2lg+s2UmuKekxwhlzRcps
wl80bs4JiYFyjjM/M2jIpVfVN4JZk2phpnnqhLk3/rEjHZSt+q5CiIYcxWSbiyF6
9/MT0rJUHlvQdMrLCmw+Jo8mzjd/Pih67tInWO3xMWSrURLr3AjDGwzHSuQZ0kJ4
Mk7L3JkhIVDscmN/Xr5BNX4QAidnlHaljMa1Ah+gXqpMVZMfiteovnY/i4ZgORqE
/hTX9dI/gzNnUiLqyqjOhLoLet+whEgB1yIhcAQswOffiwbE55jgQ0JLgck6QuhW
lfKTd3nHFXt8Tkx3ovUoP8a1EJn89qbIZ3750sXnPqeXvw/tXJELLv1XpqG6o3MD
p+hNRP4ZHvKvXUzYEpLS9fDLPLxWKr6oSe2dRXJU9M6Ou8yQAZY=
=ow3Q
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--


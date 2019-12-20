Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3025C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8302924679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="WplczBaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8302924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLuo-0000CQ-JG
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1iiLtm-0007v5-5D
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1iiLtj-0000p6-GH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:17:08 -0500
Received: from mail.online.net ([62.210.16.11]:46008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1iiLti-0000lZ-T4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:17:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id C0CFDF2B8D49;
 Fri, 20 Dec 2019 18:17:04 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id CrzPPqzoe8AR; Fri, 20 Dec 2019 18:17:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 9A4D0F2B8E53;
 Fri, 20 Dec 2019 18:17:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net 9A4D0F2B8E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1576862224;
 bh=zF2MAAx0O3svkEJw/YRXxOrkJrjWtsJISKf1mWOx3DA=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=WplczBaH3vqxLVaUYRZG30Hj4jCX1HDS1bp52schnr2k5z/naax6enl2Lnkr70x0W
 G5foS09Nq768LnHpTqSQZ7y5d/co66KZ1RSN9YFPp9c6HXjLWP41CfWOojnhARF/b/
 4oHgs6R8ECp1e6ZgZDA4pLdRNJxZuk6sj8zm4QZAKv5+cVK/ljW0TofLf51xmJLp2O
 lLuCKXRpIE+G/yef0mjdqJFpNRY3Fl008Cfj1pqLe9Db0Llt4CUkborarjJ/zmU7WK
 s+I8JqpZGeICbp0S/BUs1XOY14nVGWhm7BqDFUpIS/pUI101gb1ianyTjnl5HVFWwg
 YPpGQied+21HA==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yxWJ6v_7i0_U; Fri, 20 Dec 2019 18:17:04 +0100 (CET)
Received: from localhost (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id 6EEC1F2B8D49;
 Fri, 20 Dec 2019 18:17:04 +0100 (CET)
Date: Fri, 20 Dec 2019 18:17:04 +0100
From: Florian Florensa <fflorensa@online.net>
To: dillaman@redhat.com
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
Message-ID: <20191220171704.7qlh6gmulsvj45db@flash.localdomain>
References: <20191219133416.671431-1-fflorensa@online.net>
 <20191219145125.iwhxhzmt5mow5pea@steredhat>
 <20191220141125.wxlm4eizbwie6522@flash.localdomain>
 <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j5dba3slve6pqkyu"
Content-Disposition: inline
In-Reply-To: <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 62.210.16.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--j5dba3slve6pqkyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 09:56:51AM -0500, Jason Dillaman wrote:
> On Fri, Dec 20, 2019 at 9:11 AM Florian Florensa <fflorensa@online.net> w=
rote:
> >
> > Hello Stefano and Jason,
> >
> > First of all thanks for the quick reply,
> > Response inline belowe
> > > Hi Florian,
> > >
> > > I think we need to add (Since: 5.0).
> >
> > Are you implying by that (Since: 5.0) that we need to specify its
> > availability target is qemu 5.0 ?
>=20
> FWIW, I took this as just a comment to add some documentation that the
> field is only valid starting w/ qemu v5.
>=20
Works for me, will add this in v2.
> > I guess that maybe a version check would be better ? Like try to do
> > namespaces stuff only if we have a recent enough librbd in the system ?
> > Using something like :
> >
> > int rbd_major;
> >
> > rbd_version(&rbd_major, NULL, NULL);
> > /*
> >  * Target only nautilus+ librbd for namespace support
> > */
> > if (rbd_major >=3D 14) // tar
> >  <process namespace>
>=20
> Unfortunately, those versions weren't updated in the Mimic nor
> Nautilus release so it would still return 1/12 (whoops). I think that
> means you would need to add a probe in "configure" to test for librbd
> namespace support (e.g. test for the existence of the `rbd_list2`
> function or the `rbd_linked_image_spec_t` structure). I'll fix this
> before the forthcoming Octopus release.
Will see to do this, I originally wanted to do this at runtime so a Qemu
built against an older librbd would work if the library was updated.
Else some dlopen + dlsym trickery would work by checking for the
existence of rbd_list2 in librbd.so, but I guess this might be a bad
idea, as it would add code that would be useless in sometime
>=20
> > > The patch LGTM, but I'd like to use 'namespace' instead of cryptic
> > > 'nspace'. (as BlockdevOptionsNVMe did)
> > > What do you think?
> > >
> > Yes no worries, I can rename it to 'rbd_namespace' to avoid any possible
> > confusion, is this Ok for you ?
>=20
> We use "pool_namespace" in the rbd CLI if you are trying to avoid the
> word "namespace".
>=20
Yes I wanted to avoid namespace because it looks like the qapi generated
code changes the name to something like q_namespace, will use
pool_namespace in the v2.
> > > With those fixed:
> > >
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > Thanks,
> > > Stefano
> >
> > Regards,
> > Florian
>=20
> --=20
> Jason
>=20

Regards,
Florian

--j5dba3slve6pqkyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEENMOcO22p59MYDr5mpFTgAOO+N4gFAl39AgsACgkQpFTgAOO+
N4jjXhAAgSVYWGfpQBWX/pUFLhpiQHBC+PfW9lJQqjy7ka1P7JIEAUdLh6uPg0s3
XX6dAU4TgYbaxt/zQlqn1grNk1MZP2HD/20mFTAftXEwHedf4dYrDW8RIsrYKKJ5
Lk3SWwMeyNtFhDcKc+5sZA6ldN9vDhlpve8gUUf/QEe95cq9ubFjm1k7WuS/mWtP
YRo+EYSiPc6+r6Iyzo+QSzgqrhJWuAdxOha4AzyivI3GUxyT6o+MdHSfCPKxLcOa
Pt21B72eOT7NYubNzsqNWM+c0fPLYKGxKMRE/Zbq6MSYp6bMXMbEWG4+c/x+6v91
sEEclLmpXMO1cN7Xy6Fb20AXm6zr2VS3Z6DW0cU/K78+w+oaRiFi8JjKPL5kOmpc
n0Ni0wxatNTKPwCK5+L5nMFQNfPz+Yp+y0EiaUYKTksa9tkXdHTfZ6D4xVYHx32p
sDzpCXqy6pKKl1w2xrnF/HfyzZoukRldUuW0MidIu+xJuZyzs1JsK2uutpUQrHQ5
AEMudrX5+pqUUgG/e+AMssV0Un6IDlnYpSolymxTZ1BoMHDzPMlJavmQ00+eUvGo
x9mB0DOZpkpvYiY1kMHsr4+Ge7QM133TtHDHYn9/gUFfy4B6zxHa6nJ5+L2MUKZM
OR1V6+WXyrDz3mhaJa/Wv8jXA3cjEZNZgBeKi4LQFJkasP6hgxQ=
=/dox
-----END PGP SIGNATURE-----

--j5dba3slve6pqkyu--


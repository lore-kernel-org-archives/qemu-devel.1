Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827EF223B0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827EF223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLUw-0003hE-LC
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXLUG-0002zu-1P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXLUA-0006vF-R8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:37:19 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:33251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXLUA-0006qz-IM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:37:14 -0500
Received: from player699.ha.ovh.net (unknown [10.109.146.19])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1D96F21366B
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:37:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 46EF4C4E17C1;
 Wed, 20 Nov 2019 08:37:00 +0000 (UTC)
Date: Wed, 20 Nov 2019 09:36:58 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191120093658.6ee97336@bahia.lan>
In-Reply-To: <20191120053837.GK5582@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
 <20191011081333.7e483b95@bahia.lan>
 <20191012000041.GE4080@umbus.fritz.box>
 <20191014111516.15ca65a0@bahia.lan>
 <20191120053837.GK5582@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EzkV/YA_QR2Io7EEqlDIgfX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 18101937229636606438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.176
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
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/EzkV/YA_QR2Io7EEqlDIgfX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2019 16:38:37 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

[...]
> >=20
> > Hmmm... I had the impression that capability numbers would stay
> > forever, even if at some point we may decide to not support some
> > of them for newer machine types... Can you elaborate on a
> > deprecating scenario that would break ?
>=20
> Uhh... good point, I don't think that could break it.  Even if we
> deprecated a capability we could still retain enough awareness of the
> old number to sanity check this.
>=20
> > > and it also might be problematic for downstream
> > > where we've sometimes selectively backported caps.
> >=20
> > Do you mean that capability numbers defined in spapr.h differ
> > from the ones in upstream QEMU ?
>=20
> No, they don't but that's actually the problem.  The point is that we
> might backport some later caps without necessarily backporting all the
> earlier ones - that means that the "max cap index" no longer implies
> that all the lower indexed caps are present.
>=20

The idea with "max cap index" isn't that all the lower indexed caps are
present but rather higher indexed caps are absent. Maybe rename it to
something like "ignore higher cap index" or any better naming you can
think of ?

> >=20
> > > > > I think what we need here is a custom migrate_needed function, li=
ke we
> > > > > already have for cap_hpt_maxpagesize, to exclude it from the migr=
ation
> > > > > stream for machine versions before 4.2.
> > > > >=20
> > > >=20
> > > > No, VMState needed() hooks are for outgoing migration only.
> > >=20
> > > Ah, yeah, right.  Essentially the problem is that in the absence of
> > > caps, the new qemu assumes they're in the default state, but if an old
> > > source had ic-mode set, then they effectively aren't.  Or looked at
> > > another way, it's now trying to check that the ends match w.r.t. intc
> > > selection, but doesn't have enough information supplied by old sources
> > > to do so correctly.
> >=20
> > Yes, but do we really need to perform strict checks on ic-mode in the f=
irst
> > place ? I mean that migrating the state of XICS and/or XIVE entities _o=
nly_
> > requires the destination to have instantiated them, ie:
> >=20
> > SOURCE/DEST | xics | xive | dual
> > ------------+------+------+-------
> > xics        | ok   | fail | ok (*)
> > xive        | fail | ok   | ok (*)
> > dual        | fail | fail | ok
> >=20
> > (*) missing migrated state for xics/xive means that the corresponding
> >     objects will have reset state, like after CAS.
>=20
> Yes... I don't really see where you're goig with that thought.
>=20

I mean that if we didn't check the XICS and XIVE capabilities, we
would still fail migration when it is really needed, ie. migrating
from ic-mode=3Dxics to ic-mode=3Dxive or the other way round. This
would it make it possible to migrate anything to ic-mode=3Ddual though
but I don't think this is a problem since it doesn't break anything.

> > > Ugh, that's a bit trickier to work around.
> > >=20
> >=20
> > Maybe have a migrate_needed() hook like this:
> >=20
> > static bool cap_xics_xive_migrate_needed(void *opaque)
> > {
> >     return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_2_migration;
> > }
> >=20
> > and also use it in spapr_caps_post_migration() ?
>=20
> Yeah, maybe.  I think we have a hack like this for one of the other
> caps already.
>=20


--Sig_/EzkV/YA_QR2Io7EEqlDIgfX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl3U+yoACgkQcdTV5YIv
c9aVCg/9Ec/lduu1mSQSOgdj/2uxwG6/wx96a8hoQjgr/skwzU3NoPLhic1EX2cK
8tE/0/Gkyn2QNZ5bTkFeREq4LHN0/p/47tiCurDjvrHbmHUO6BQ3nS8j/s/aXCSf
DMiBMXOyycyqIB3ybEqC4SXrP/YtTFbpyltfEK9odgRorCh5RtgRFoBFG4Vx2QDQ
nRZzBZhah1o/GVYiSNn7X+DdBdG6Yo3WbUreB5C0INmke4tf5XBejIiTwOMXouQ7
fDYocOSSRjaMwc+n5YhX1CtxCJZV4na581J5Xi/HyNuJVv06au4SHf8XhipsVt1T
b3OiicuzG0TXFthupE02rXYTpHFRBmKZpStLQctWclnwT5XNJ+nzHcFAIhrj0Ov1
8yNL7NIsCHWVv7rRqn3NACuq4r+h5+1R5OERiCMIZVP1taHxZ7Pb3k3sbysSFhmI
DA5g+k09qemAgaX8KHihVtWy+QcJsJ6STP5qHUvUzOq4kwanHJ3Re7AAqnYfkStU
2gtKCQ5WXYEO3LBhAp/kvslcWaZ0pzCJ/zKOY/heImYHqkrK1cjvi7izJUnMuWjy
/OjkoCevu0+l6Ruiutw8xtKTVcpCVU7yKx9cs0ze58mphHokXOBHjA4yIdXedLCy
XBXDgXvknrejjPSk2+MDznL8r9TU8GqgltIWqTxN74Ozt/boiVE=
=B848
-----END PGP SIGNATURE-----

--Sig_/EzkV/YA_QR2Io7EEqlDIgfX--


Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F62BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6FB20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CHCpKllz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6FB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3hS-0000so-7q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jw3fj-00081i-Pu; Thu, 16 Jul 2020 09:11:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59489 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jw3fg-0000D7-Dm; Thu, 16 Jul 2020 09:11:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6vlV4Cp7z9sTF; Thu, 16 Jul 2020 23:11:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594905078;
 bh=UOM825bzkhbd2ynG/1QwxZsOPolwIeQqE+rqK9vLoTY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CHCpKllzGa/422nfxwVO2Ct1K2ar7XanqM9uJtcTpYZ+zx7/Xpbhk1SrXpB5zqRDv
 KrKVf2I0r8aH3Vub6XTd4wHaxjMlhu1Bq9Skeh6MWfWVnnqH8wEu5dfK/9+SErPA+B
 xXuJrxBXTKwQji8RTrKHpdYdue7kJ5nZ+R30Iyws=
Date: Thu, 16 Jul 2020 23:11:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716131109.GA5607@umbus.fritz.box>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <20200716123244.1f854c63@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200716123244.1f854c63@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:11:19
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 12:32:44PM +0200, Greg Kurz wrote:
> On Thu, 16 Jul 2020 14:45:40 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> > > Some recent error handling cleanups unveiled issues with our support =
of
> > > PCI bridges:
> > >=20
> > > 1) QEMU aborts when using non-standard PCI bridge types,
> > >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error han=
dling"
> > >=20
> > > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> > > Unexpected error in object_property_find() at qom/object.c:1240:
> > > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' no=
t found
> > > Aborted (core dumped)
> >=20
> > Oops, I thought we had a check that we actually had a "pci-bridge"
> > device before continuing with the hotplug, but I guess not.
>=20
> Ah... are you suggesting we should explicitly check the actual type
> of the bridge rather than looking for the "chassis_nr" property ?

Uh.. I thought about it, but I don't think it matters much which way
we do it.

> > > This happens because we assume all PCI bridge types to have a "chassi=
s_nr"
> > > property. This property only exists with the standard PCI bridge type
> > > "pci-bridge" actually. We could possibly revert 7ef1553dac but it see=
ms
> > > much simpler to check the presence of "chassis_nr" earlier.
> >=20
> > Hrm, right, 7ef1553dac was not really correct since add_drcs() really
> > can fail.
>=20
> Yes.
>=20
> > > 2) QEMU abort if same "chassis_nr" value is used several times,
> > >    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
> > >    object_property_add() & friends"
> > >=20
> > > $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=3D1 \
> > >                         -device pci-bridge,chassis_nr=3D1
> > > Unexpected error in object_property_try_add() at qom/object.c:1167:
> > > qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add =
duplicate property '40000100' to object (type 'container')
> > > Aborted (core dumped)
> > >=20
> > > This happens because we assume that "chassis_nr" values are unique, b=
ut
> > > nobody enforces that and we end up generating duplicate DRC ids. The =
PCI
> > > code doesn't really care for duplicate "chassis_nr" properties since =
it
> > > is only used to initialize the "Chassis Number Register" of the bridg=
e,
> > > with no functional impact on QEMU. So, even if passing the same value
> > > several times might look weird, it never broke anything before, so
> > > I guess we don't necessarily want to enforce strict checking in the P=
CI
> > > code now.
> >=20
> > Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
> > supposed to be system-unique (well, unique within the PCI domain at
> > least, I guess) as part of the hardware spec.  So specifying multiple
> > chassis ids the same is a user error, but we need a better failure
> > mode.
>=20
> According to section 3.2.6.4 of "PCI-to-PCI Bridge Architecture
> Specification", the chassis number is exposed to the OS as a=20
> non-volatile r/w register.

Argh.  Dammit.  I could have sworn I checked that chassis numbers were
supposed to be unique (and not guest alterable).  That's the whole
reason I chose it.

> It seems to be expected that chassis
> numbers might collide, in which case the system software can
> overwrite the register with a new number. So I'm not sure that
> specifying the same number multiple times is an actual user error.
>=20
> > > Workaround both issues in the PAPR code: check that the bridge has a
> > > unique and non null "chassis_nr" when plugging it into its parent bus.
> > >
> > > Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC id=
s")
> >=20
> > Arguably, it's really fixing 7ef1553dac.
>=20
> True for issue 1 but not for issue 2, which is the result of
> 05929a6c5dfe (switch to "chassis_nr" introduces a condition
> to end up with duplicate DRC ids)

Well, technically.  But the method we had before was *way* more broken
than chassis numbers.  It was using bus number which is not stable
across the VM's lifetime, which is a non-starter.  Plus, the bus
number too won't be unique, until the guest has enumerated the bus,
which is too late for DRC creation.

The only reason we got away with it, was that it was basically dead
code - at that stage we didn't support hotplug under bridges, so we
never actually created DRCs except for the root bus.

> and d2623129a7de (assert
> when trying to add a duplicated DRC).

Well, again, only on a technicality.  It might not have immediatley
assert()ed, but adding a duplicated DRC was still completely broken
before that.

> I'm starting to think I should maybe split this in
> two patches. One for each issue.

At this stage, I'd kind of prefer to merge this fix now, with the
intention of doing a pull request tomorrow.  AFAICT none of the
suggested improvements can't be done as followups.

> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > I had a few misgivings about the details of this, but I think I've
> > convinced myself they're fine.  There's a couple of things I'd like to
> > polish, but I'll do that as a follow up.
>=20
> Some fixes for d2623129a7de just got merged. Let me have a look
> again.

In fact the main part of the polish I was thinking of didn't really
work out.  The only change I made was a tiny move to the check (it's
not really relevant until *after* we've checked if hotplug is enabled
at all).  So I just folded that in and put it into the ppc-for-5.1
tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8QUesACgkQbDjKyiDZ
s5LNHg//bKavU8Yk0NGgq/dAcx3ub2F9vlxdm9gk0zNoS1Blo4rFCb3cxrRUFA71
0qSHzB4fLKXfrvlPfDRaeWRiukklAsMR4UqRX4kygyXXfgQBG76qcgAKvUbrEDzC
IQA0JLBrTv8FNmFgi8gzcovwWPILCAg3VKKkCQhlsdKL1QTPkFr9+4iANvSTDZbC
f6yys1visqx3o7cnLAHwcwCOERRTUkuiBc2ha3kw7giUw3ZB1at89P1eGHVdVF9n
D7fsmZEnZ8pAXnyxx4L4yYyq5VwubiljlncSAtb6sUqX+DlWxWLhaqJ2/TmWQFtF
JROnPwb9Y0VWPn3A6AoI4SNEaMvllX4srodB/bdhisBOWkkLfYXp/a7YCtpcUzE3
qo7L0kl79g/sDbmVHfcDuJLOivSV+kBNhnR2S6oKTL6MFNRVE1ke1PBxAuoRMWnJ
oFYbAfbvOukED9lzNHxAXvOWGzFNJQVQJgazEL52C8irsTgqjICyFAo3exTmodBY
Z0QWpt4WP9DgrK/BK9AtFuQi3pMB/doF0oF9Dm3SuHu/ZNdMpRv08irift+dAmGf
hLIhKT4JKZDhTpDI7Jq4bgxPkCbqUssgAERQsmv2YGq5OFM72RxBwyw4Uf5ffr1h
Sl1QY3KFno82XSLX1PQvteMiaDEAGP167ccsQp+hU3fFs943c8g=
=CxVA
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


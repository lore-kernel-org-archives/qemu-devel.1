Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B93C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14E6205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WVWyScfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14E6205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icdKa-0001CK-Ry
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 17:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1icdI9-0008JV-A0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1icdI2-0006Uh-SE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:38:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52575 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1icdHv-00065v-94
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:38:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Stzc2CPsz9sPT; Thu,  5 Dec 2019 09:38:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575499100;
 bh=7hTBqZOx08H0yrMnM9m+YHvro5CWamEeLlC14X99i/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WVWyScfbCqmo2/pjj3DMj9tn3Qlg2uGVYHO1oJpJPnbFeQfO8gD2LKC9UFT2MhpRW
 +0kXC5rBeDSeEHiIu9mHqkZqz96psbANf1W14vTzcQcqL6fblgDZhCLU3pN5WYlXLn
 Y7pC+EJveICZa6QpLe9RJISH3np5/zIC8fRHmWDA=
Date: Thu, 5 Dec 2019 09:28:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191204222827.GE5031@umbus.fritz.box>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <20191019101223.GD1960@umbus.fritz.box>
 <20191021081444.GA2934@work-vm>
 <20191120214827.iui5rtwyls3r62ns@rascal.austin.ibm.com>
 <20191204164915.GM3325@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20191204164915.GM3325@work-vm>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2019 at 04:49:15PM +0000, Dr. David Alan Gilbert wrote:
> * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > On Mon, Oct 21, 2019 at 09:14:44AM +0100, Dr. David Alan Gilbert wrote:
> > > * David Gibson (david@gibson.dropbear.id.au) wrote:
> > > > On Fri, Oct 18, 2019 at 10:43:52AM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > > > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > > > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Pr=
iority
> > > > > > >> sorting is maintained by searching from head to tail for a s=
uitable
> > > > > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > > > > >>
> > > > > > >> If we instead keep track of the head of each priority's subq=
ueue
> > > > > > >> within that larger queue we can reduce this operation to O(1=
) time.
> > > > > > >>
> > > > > > >> savevm_state_handler_remove() becomes slightly more complex =
to
> > > > > > >> accomodate these gains: we need to replace the head of a pri=
ority's
> > > > > > >> subqueue when removing it.
> > > > > > >>
> > > > > > >> With O(1) insertion, booting VMs with many SaveStateEntry ob=
jects is
> > > > > > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T ha=
s 40000 such
> > > > > > >> objects to insert.
> > > > > > >=20
> > > > > > > Separate from reviewing this patch, I'd like to understand wh=
y you've
> > > > > > > got 40000 objects.  This feels very very wrong and is likely =
to cause
> > > > > > > problems to random other bits of qemu as well.
> > > > > >=20
> > > > > > I think the 40000 objects are the "dr-connectors" that are used=
 to plug
> > > > > > peripherals (memory, pci card, cpus, ...).
> > > > >=20
> > > > > Yes, Scott confirmed that in the reply to the previous version.
> > > > > IMHO nothing in qemu is designed to deal with that many devices/o=
bjects
> > > > > - I'm sure that something other than the migration code is going =
to
> > > > > get upset.
> > > >=20
> > > > It kind of did.  Particularly when there was n^2 and n^3 cubed
> > > > behaviour in the property stuff we had some ludicrously long startup
> > > > times (hours) with large maxmem values.
> > > >=20
> > > > Fwiw, the DRCs for PCI slots, DRCs and PHBs aren't really a problem.
> > > > The problem is the memory DRCs, there's one for each LMB - each 256=
MiB
> > > > chunk of memory (or possible memory).
> > > >=20
> > > > > Is perhaps the structure wrong somewhere - should there be a sing=
le DRC
> > > > > device that knows about all DRCs?
> > > >=20
> > > > Maybe.  The tricky bit is how to get there from here without breaki=
ng
> > > > migration or something else along the way.
> > >=20
> > > Switch on the next machine type version - it doesn't matter if migrat=
ion
> > > is incompatible then.
> >=20
> > 1mo bump.
> >=20
> > Is there anything I need to do with this patch in particular to make it=
 suitable
> > for merging?
>=20
> Apologies for the delay;  hopefully this will go in one of the pulls
> just after the tree opens again.
>=20
> Please please try and work on reducing the number of objects somehow -
> while this migration fix is a useful short term fix, and not too
> invasive; having that many objects around qemu is a really really bad
> idea so needs fixing properly.

I'm hoping to have a crack at this tomorrow.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3oMwsACgkQbDjKyiDZ
s5Lk6hAAlZqM55cUTLc2elRP7Y9aq2Jfpr808RDHqa2gvks+fBwQVCSVWmYFL2Rk
GBcFKnbG6JHV19oIcmhB64GI+jmiGPVNkrIhO3WOFBo00cyDF3Q88oEjygWNW2Xq
O2+KTdSjk3wps6VqRFFObgbSyryYc8WVec6IrVMT7wI2vk3ueWGPZUyaWKKVkRLk
kT2uAtIe4oR01zi8c2M9zu+VPJMFpQ1jXnMhXEJdCflW13qRmmCiiD9IPXyRR+Mc
cdQT0cMWXBXKJc0TxvPGgMndSGg0cP2/PXxdr5WvbDhFz5luyl0NjeoLdTyZbwrN
gr7xnDAOO1DThi7CvWjOATd0/XVceglopkCHBa73t9Vx8b/GtKYt3ZZR2TkTn5Qo
NwHtJ+KaKdXYqRTrZZ5zLXfcoBSA+Cuo79KHNC4GsHs3KM++53tm7RFKa2z2Lery
JxUKptrmy09Cy+aGHCsbA596NNpNcmHQaodbl4ea7yBnEn9hKRW4NtAM+C/c3Xjv
K5GhFyRaYULXxnIyfoB0X5Qi4f63lxlCJK+KFA6086AP4bPE7H9NEd5D0m5Mdh5J
i0OexpxeeQ7GzCHMxC9eQCbvChuNzf99ZONPt+63AE3Svwv9mwfbe6Jt4vW24vPE
28+DA1v1+D3p9KJvG5EAiBWUGq2zjbVFxVgKQX9C30jXQweB2xE=
=0ssA
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--


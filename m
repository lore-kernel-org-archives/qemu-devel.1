Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566CCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90D521D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oZO5hQPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90D521D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLmGu-00005V-12
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 06:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iLmFh-0007uI-15
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iLmFe-0001gh-Mu
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:46:28 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59067 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iLmFd-0001bO-M0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:46:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wKMD3cM3z9sPW; Sat, 19 Oct 2019 21:46:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571481976;
 bh=aHBKOQppKPMT+GKlL3+rQ+PfjiSJs5ACH1nYwCEeEts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oZO5hQPxoL+s8ffkUTry653Em9EAq4ZtqWQQ3K2lnb45NZeuz//h6UBdoTkur09fJ
 IxINYWF1j4MjpILffmpOFBQEgDCAblu5S4MRL4XSu+hrMvJE4t5zVMfpQv8cLR6vEg
 Es7JCwvrDef4RxWZ8W+8JAWe085mchN9sQAyhzW0=
Date: Sat, 19 Oct 2019 21:12:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191019101223.GD1960@umbus.fritz.box>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20191018094352.GC2990@work-vm>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 10:43:52AM +0100, Dr. David Alan Gilbert wrote:
> * Laurent Vivier (lvivier@redhat.com) wrote:
> > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > >> sorting is maintained by searching from head to tail for a suitable
> > >> insertion spot.  Insertion is thus an O(n) operation.
> > >>
> > >> If we instead keep track of the head of each priority's subqueue
> > >> within that larger queue we can reduce this operation to O(1) time.
> > >>
> > >> savevm_state_handler_remove() becomes slightly more complex to
> > >> accomodate these gains: we need to replace the head of a priority's
> > >> subqueue when removing it.
> > >>
> > >> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T has 40000 =
such
> > >> objects to insert.
> > >=20
> > > Separate from reviewing this patch, I'd like to understand why you've
> > > got 40000 objects.  This feels very very wrong and is likely to cause
> > > problems to random other bits of qemu as well.
> >=20
> > I think the 40000 objects are the "dr-connectors" that are used to plug
> > peripherals (memory, pci card, cpus, ...).
>=20
> Yes, Scott confirmed that in the reply to the previous version.
> IMHO nothing in qemu is designed to deal with that many devices/objects
> - I'm sure that something other than the migration code is going to
> get upset.

It kind of did.  Particularly when there was n^2 and n^3 cubed
behaviour in the property stuff we had some ludicrously long startup
times (hours) with large maxmem values.

Fwiw, the DRCs for PCI slots, DRCs and PHBs aren't really a problem.
The problem is the memory DRCs, there's one for each LMB - each 256MiB
chunk of memory (or possible memory).

> Is perhaps the structure wrong somewhere - should there be a single DRC
> device that knows about all DRCs?

Maybe.  The tricky bit is how to get there from here without breaking
migration or something else along the way.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2q4YUACgkQbDjKyiDZ
s5KP7A//Tboy3KjmlC25gZc4ZZsbS+xNaXLWS5eH+ZBk57pA9iDkYlBxUrfFBVm+
I08/Yur8Ap1DACUNFbDvDI6M9ifiqo9yN6rBMJle8Ey8Yqhq+IUQBaDycjM2AY/Z
8tpNiOOtf0WukDUhk/su0o2+LwoVGhoZR4xC0dnxu8jwGEo+fvtJssSM947O1P7K
AfFhMro+rpRztyRSWl+IdORWJLn4Ougz3LSsu2yqmnq3XgA3TVBuNjF3UQ2IPIgA
qEcQbc4vv5q0226rSSfWmwATugLglSAlO+dp35HnA8c1W8OJemIX/4mIOs2dQi/l
N7YCSw2b/qX/1TjGqKx3nEkb/pfS+xVnQDC8bw48RBsXLqC1bR6kGDg8S4vz6pk8
DNR3aqJgS1elyAaPGov00gHx/9m9AkO4Sn/8Okxo5gXfI8EBqPwt/ozbpts+0WxW
Y7kfXcWALtu+u7gXbpU1ZTIeYGSnus/xAJgnVDcm5zh+OM1utYjwryvx9yqFrt9h
xcSP6UV582BqAIScrKhpTgb6pzkss6+qrrzEGX6WvsKuRj8hjJ3w7Ciow/eYKQk4
VPcx0MiCYsn+jSD8MWjdnnc57drSQVqLskapGJUEtK/UrC8KV7bunbauXf6WnP9z
V6ea9phH0mIcwA692EvV7+NCfsLx9d4GPL8avJNLl14Vqq7fNg8=
=Jmin
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--


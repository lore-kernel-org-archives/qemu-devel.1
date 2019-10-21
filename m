Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B9CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3BB2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xbk/0FFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3BB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSEL-0004YG-2Q
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 03:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iMSCU-0003rc-Ma
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iMSCS-0002j7-NA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:33:58 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iMSCR-0002gy-Jc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:33:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46xT0G48L6z9sP3; Mon, 21 Oct 2019 18:33:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571643230;
 bh=C+rKBUAUF0JM5jiIFzaTr3wC3Ip8hsexJY0BFhNGdE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xbk/0FFIyiaa4B2OTawUAnvIjBY03M0YPlA6xgNPgVQjUw7UL9sc0bqsCh6UHBHfi
 jrzWiDs4a5qnogzHFJtqA0KK76Z1ZQJi6x6EmMCk6BHeUR9t/iShONfRjssWRjWD2P
 ty9axe1IQ2UOLQ0kYufypQRzViiV6LIxG+nNyQZw=
Date: Mon, 21 Oct 2019 18:33:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191021073344.GF6439@umbus.fritz.box>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <157141671749.15348.15966144834012002565@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <157141671749.15348.15966144834012002565@sif>
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 11:38:37AM -0500, Michael Roth wrote:
> Quoting Dr. David Alan Gilbert (2019-10-18 04:43:52)
> > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > > >> sorting is maintained by searching from head to tail for a suitable
> > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > >>
> > > >> If we instead keep track of the head of each priority's subqueue
> > > >> within that larger queue we can reduce this operation to O(1) time.
> > > >>
> > > >> savevm_state_handler_remove() becomes slightly more complex to
> > > >> accomodate these gains: we need to replace the head of a priority's
> > > >> subqueue when removing it.
> > > >>
> > > >> With O(1) insertion, booting VMs with many SaveStateEntry objects =
is
> > > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T has 4000=
0 such
> > > >> objects to insert.
> > > >=20
> > > > Separate from reviewing this patch, I'd like to understand why you'=
ve
> > > > got 40000 objects.  This feels very very wrong and is likely to cau=
se
> > > > problems to random other bits of qemu as well.
> > >=20
> > > I think the 40000 objects are the "dr-connectors" that are used to pl=
ug
> > > peripherals (memory, pci card, cpus, ...).
> >=20
> > Yes, Scott confirmed that in the reply to the previous version.
> > IMHO nothing in qemu is designed to deal with that many devices/objects
> > - I'm sure that something other than the migration code is going to get=
 upset.
>=20
> The device/object management aspect seems to handle things *mostly* okay,=
 at
> least ever since QOM child properties started being tracked by a hash tab=
le
> instead of a linked list. It's worth noting that that change (b604a854) w=
as
> done to better handle IRQ pins for ARM guests with lots of CPUs. I think =
it is
> inevitable that certain machine types/configurations will call for large
> numbers of objects and I think it is fair to improve things to allow for =
this
> sort of scalability.
>=20
> But I agree it shouldn't be abused, and you're right that there are some
> problem areas that arise. Trying to outline them:
>=20
>  a) introspection commands like 'info qom-tree' become pretty unwieldly,
>     and with large enough numbers of objects might even break things (QMP
>     response size limits maybe?)
>  b) various related lists like reset handlers, vmstate/savevm handlers mi=
ght
>     grow quite large
>=20
> I think we could work around a) with maybe flagging certain
> "internally-only" objects as 'hidden'. Introspection routines could then
> filter these out, and routines like qom-set/qom-get could return report
> something similar to EACCESS so they are never used/useful to management
> tools.
>=20
> In cases like b) we can optimize things where it makes sense like with
> Scott's patch here. In most cases these lists need to be walked one way
> or another, whether it's done internally by the object or through common
> interfaces provided by QEMU. It's really just the O(n^2) type handling
> where relying on common interfaces becomes drastically less efficient,
> but I think we should avoid implementing things in that way anyway, or
> improve them as needed.
>=20
> >=20
> > Is perhaps the structure wrong somewhere - should there be a single DRC
> > device that knows about all DRCs?
>=20
> That's an interesting proposition, I think it's worth exploring further,
> but from a high level:
>=20
>  - each SpaprDrc has migration state, and some sub-classes SpaprDrc (e.g.
>    SpaprDrcPhysical) have additional migration state. These are sent
>    as-needed as separate VMState entries in the migration stream.
>    Moving to a single DRC means we're either sending them as an flat
>    array or a sparse list, which would put just as much load on the
>    migration code (at least, with Scott's changes in place). It would
>    also be difficult to do all this in a way which maintains migration
>    compatibility with older machine types.
>  - other aspects of modeling these as QOM objects, such as look-ups,
>    reset-handling, and memory allocations, wouldn't be dramatically
>    improved upon by handling it all internally within the object
>=20
> AFAICT the biggest issue with modeling the DRCs as individual objects
> is actually how we deal with introspection, and we should try to
> improve. What do you think of the alternative suggestion above of
> marking certain objects as 'hidden' from various introspection
> interfaces?

So, that's not something I'd considered particularly in this context,
but it has bothered me in other contexts.  The fact that all the QOM
interfaces are freely user-inspectable, but are also used for a bunch
of interaction between qemu components means that we (arguably)
routinely make a bunch of stuff into user-visible API which we
probably don't really need or want to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2tX1cACgkQbDjKyiDZ
s5JK7A/+OtvPrLjjpv65pV7U+h9D/atQh/+OtIobhdZ4oZx0Ak5jPytDgwA7ii0+
hGkTChbZMIlBX/7A3HmEryFpwkE631QPeJ+VxxuTyVmekG7m6bvkCeAI5pRSj8Th
6YRK7k8hQg2b9137boTdFuKm5krtIsFiLIkHMYRD1Y1UqTR+5i1uFtOLi1S4K+2G
cgGqrcX2OKahzvSOwdXfsoa92/hO28VkoNXLPQkM+mJa3uOn9yYGq+v5ZuOW1NYV
xJIn0AJQY9xpg/YVVoRlm5a72l9Jc6WWIAHTYxzpZvAO+ep6k5mXIcBKswASd2sz
YdP6HMKhwpbvVOLHR9JAYjy6OyeK2JGh9KQPmIB0cJw5PoBfnHYVMsmdGX9f1iNx
jmdBAVbh2lhkcgIDgANcvtGwppO5xnXL6P3IfM5XPI6/uarkO68tayFf82R0Xg42
hkES5iZ0SK/Bj804HG57EhcpAir6IeI3fesJzE45+TK3Ye94kraBhDwK7670YncH
YiNj4jpzUtOx/vNyOBvekc35t8l+6aPKSNEI4UAOhXnS9l9Mc2WG/bl1Iwvf8VGM
n5Efg6MYgXYF43zNasfag+pkHF6Op1jAYEJxg4bXkZ2w87j//YJV9Ul3/eQIuC1t
jegArkbf2HDKTuLO4b5QJxLwdvSxv2saJ324yqDSnv51QGHqucc=
=hL4M
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--


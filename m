Received: from eggs.gnu.org ([2001:4830:134:3::10]:44086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzY17-00021h-Og
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXrP-0007dd-4J
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:53:02 -0400
Date: Tue, 11 Sep 2018 11:42:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911014220.GD7978@umbus.fritz.box>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
	<20180907073155.26200-2-david@gibson.dropbear.id.au>
	<2ae5af64-c452-9d7d-ea81-6d9035a30697@redhat.com>
	<20180910042551.GB24181@umbus.fritz.box>
	<a556cf98-7902-869a-fa5b-5b7c7fedbb71@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <a556cf98-7902-869a-fa5b-5b7c7fedbb71@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/14] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, lvivier@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 08:32:40AM +0200, Thomas Huth wrote:
> On 2018-09-10 06:25, David Gibson wrote:
> > On Fri, Sep 07, 2018 at 08:39:52AM -0500, Eric Blake wrote:
> >> On 09/07/2018 02:31 AM, David Gibson wrote:
> >>> From: Thomas Huth <thuth@redhat.com>
> >>>
> >>> There is no known available OS for ppc around anymore that uses page
> >>> sizes below 4k, so it does not make much sense that we keep wasting
> >>> our time on building and testing the ppcemb-softmmu target. It has
> >>> been deprecated since two releases, and nobody complained, so let's
> >>> remove this now.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>
> >>> +++ b/qapi/common.json
> >>> @@ -146,6 +146,6 @@
> >>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm=
32',
> >>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >>> -             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
> >>> +             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> >>>                'x86_64', 'xtensa', 'xtensaeb' ] }
> >>
> >> Can we also get documentation that this was deleted (probably as a fol=
lowup,
> >> since I'm only now noticing this in the pull request)?  See QKeyCode in
> >> qapi/ui.json for an example of documenting 'altgr: dropped in 2.10'
> >=20
> > So, it turns out Peter isn't able to process pull requests until late
> > september, so I guess we can fix it inline after all.  I've now done
> > so.
> >=20
> > Since I won't be resending the pull request for a while, you can
> > review the new version at:
> >=20
> > https://github.com/dgibson/qemu/commit/9de3048e22f73824cc1920db17f7a166=
ef815090
>=20
> Thanks, fine for me. Maybe just swap the order of the "Since: 3.0" and
> the "ppcemb: dropped in 3.1" so that these entries are listed
> chronologically?

I wasn't seeing it as chronilogically listed - rather the "Since: 3.0"
applies to the overall command, whereas the "ppcemb: dropped in.." is
related to a specific entry/value.  That seems to be the pattern in
the ui.json example Eric pointed at.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXHXoACgkQbDjKyiDZ
s5JMKBAArlz23PorqTzLzOnRLiNe/W6T09vvuJZ+pASQt3ZzRGynaT5sG1+Rfkpp
cxU4NdrUOIZto2lQkajSwpx5xU3wBs/s+tMiRinvjAyqa1xL8VGT/S6SU7PtZiqK
jeKYdUJgvabjfDRbPSTreDQ0GNeVo51B4rku6hKuj0pCvsoy11+ICOjSoxJBj66t
X/CW0R+WFsAwEGyZSQp2VzMIEUvH8P89sOOs6prDyTjWjfyBXRVGYhcqNueF/pFj
YxRHNiae51Omy+k4mWlI07/LoJ7kmewBG28WL199G+qHkVxAcCWy43MQaqIz6Nkf
HF0btgTaqsdnzDSCYDPUipOyF0X1S5KKCLo7iz4BJRr/tU0hqI1SjmGtfGobdaNn
8LmOEiNUJuSKpMU5Go6l2DvNXPn8j5o/7QfACdhSoZUVBxWYkRVNgrzVA4l85PdI
ROF2p41NX6fGQhRiFucxhF+8Uvs++DbaV/WeQftlw+8UoCT4nQH2hvOQU76tIWAy
vgeIfxEmwAJtYUwatC63MJam4KdNPFAQKBzy+0gq0OYJTLggLGxSAg+OsawEA0xH
bE3n5WYDsI+8YV/Eas0bw/sjAVmhSYfGE+/2H9684KYL0jOTs3v/R+3b/zcAib0a
h/RUAmBkhUXObk4RilR9N1mekd4dEy2PrAv0virb8b/r4LxJ0qc=
=QrGf
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--

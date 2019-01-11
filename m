Received: from eggs.gnu.org ([209.51.188.92]:45280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghvhU-0000VI-Ln
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghvhT-0005Vq-VZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:14:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghvhT-0005Uw-NI
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:14:11 -0500
Date: Fri, 11 Jan 2019 13:14:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111121407.GE5010@dhcp-200-186.str.redhat.com>
References: <20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box>
	<20190110114113.GC2589@work-vm>
	<20190110151101.GB6361@linux.fritz.box>
	<20190110170626.GH2589@work-vm>
	<6ebd4d4b-c515-fbcb-0af4-a085d5f735bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <6ebd4d4b-c515-fbcb-0af4-a085d5f735bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.01.2019 um 19:22 hat Eric Blake geschrieben:
> On 1/10/19 11:06 AM, Dr. David Alan Gilbert wrote:
>=20
> >>> savevm [-t] [-i] [tag|id]
> >>>
> >>> then:
> >>>   a) with neither -t or -i  it would behave in the same roulette way
> >>>      as it does in the moment, and it might be a tag or id
> >>>
> >>>   b) with -t we'd explicitly treat the parameter as a tag and it
> >>>      would error if it wasn't found
> >>>
> >>>   c) With -i we'd explicitly treat the parameter as an id and
> >>>      it would error if it wasn't found
> >>>
> >>> Since we still allow (a) it doesn't break any existing code.
> >>
> >> If you can explain why we need both tag and id?
> >>
> >> And by keeping the current behaviour, we might not break hypothetically
> >> existing correct code, but we leave currently actually existing broken
> >> code like libvirt broken.
> >=20
> > My only reason for leaving both tag & id was for the hypothetical
> > existing current code; my assumption adding the above would be that we
> > would then fix libvirt never to use (a),  probably always (b).
>=20
> How? HMP is not introspectible, so libvirt can't know if 'savevm -t'
> works without trying it.

It is introspectible in a way, 'help savevm'. Just that the result of
that isn't machine readable and not meant to be parsed by programs. But
that's just what happens when you use HMP.

I'm still against the proposal because it makes the interface more
complicated rather than simpler.

Kevin

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcOIiPAAoJEH8JsnLIjy/WBZkP/3zNHYnL25n9FB5E4Z+VrTux
fKVVnuJRTB+d7bnTAA7y5RH2X7B/K45N0/2OY7UA95pbGdrYQerJ0Pf5yQeQpXDL
G8tWss95fcHEleEQfss+QC1wPzarXnwq3ijwkNVK6qwYxAVr7spguHQqfm78sE4B
mKr3QFTqNaIDapK8RHJvTwOSh/gPp7ZCNupjAmmhAb10CQdSDkQHils3mQDQ6dJS
sPNwJb+BuQt4/TBCyy/63az8FEqMX+rT47z2dB3o4Agu0tRIaSziD69ndmRGuf+B
rI4snH3m80HFV++zkdup20qmixLsQS5x1obzdAygibvQIu9vGLkGDBSzPgbG4i0g
cY1Yi2kV6+O0BLv9Udk1TjUs4hDitgIJT7TWpyDsHGclD9E31SwW38VZSqdfnWdI
5gpveoDbAzALTgHdqj0YgHog9x23PZiezKLhKVLGiNz0kMVUETqApQCsfCJSdGMD
JdR6ocCfHR7Qbvkn6bkXtPLOfBdo/l9mXClcb+A3Ptsi4BKlDUnCost7xnaQEhh4
0/luR6WdehHQlntZRtx5wE02Oh0fd1QLduTERjMu68j37nAehz6LcwLg93uPtA0z
g43Gqyi49I04qqWcWiMxy0lgDwol/Dr+PuPE04d7OvEjcGb8wKcPMNOw4n0BBMBm
fc+UH7j1eMOC2cU8Tn58
=RBQC
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

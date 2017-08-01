Received: from eggs.gnu.org ([2001:4830:134:3::10]:37973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dcMo6-0007h4-9O
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dcMo2-00049T-6l
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:21:14 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dcMo1-00047J-Rx
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:21:10 -0400
Received: by mail-pg0-x241.google.com with SMTP id 125so432265pgi.5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 19:21:05 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
	<20170728040257.GI3098@umbus.fritz.box>
	<c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
	<20170731045821.GE2652@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a9d88270-94ec-84a1-a664-4e6df3f2af31@ozlabs.ru>
Date: Tue, 1 Aug 2017 12:20:56 +1000
MIME-Version: 1.0
In-Reply-To: <20170731045821.GE2652@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="APfH549nHCt5i51XajV5am0w21RGouMJL"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to
 update the XICS phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--APfH549nHCt5i51XajV5am0w21RGouMJL
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Message-ID: <a9d88270-94ec-84a1-a664-4e6df3f2af31@ozlabs.ru>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to update
 the XICS phandle
References: <150100547373.27487.3154210751350595400.stgit@bahia>
 <150100578691.27487.8944448515009831240.stgit@bahia>
 <20170728040257.GI3098@umbus.fritz.box>
 <c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
 <20170731045821.GE2652@umbus.fritz.box>
In-Reply-To: <20170731045821.GE2652@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31/07/17 14:58, David Gibson wrote:
> On Fri, Jul 28, 2017 at 08:20:57AM +0200, Thomas Huth wrote:
>> On 28.07.2017 06:02, David Gibson wrote:
>>> On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote:
>>>> The "phandle" property of the XICS node is referenced by the "interr=
upt-map"
>>>> property of each PHB node. This is used by the guest OS to setup IRQ=
s for
>>>> all PCI devices.
>>>>
>>>> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF con=
verts
>>>> this value to a SLOF specific one, which is then presented to the gu=
est OS.
>>>>
>>>> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which=
 is used
>>>> by SLOF to communicate the patched phandle value back to QEMU. This =
value
>>>> is then cached and preserved accross migration until machine reset.
>>>>
>>>> This is required to be able to support PHB hotplug.
>>>>
>>>> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, =
so we
>>>> have to introduce its number even if QEMU currently doesn't implemen=
t it.
>>>>
>>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>
>>> Ugh.  I really, really hope we can avoid this, though I don't
>>> immediately see how.  Having to have two way communication between
>>> qemu and SLOF about the device tree contents just seems like opening
>>> the door to endless complexities.
>>>
>>> This is basically a consequence of the fact that both qemu and partly=

>>> responsible for constructing the device tree for the guest, and that'=
s
>>> not easy to avoid.
>>>
>>> Hrm.. Thomas, I know it's not really the OF way, but would it be
>>> feasible to change SLOF to use the phandles as supplied by qemu rathe=
r
>>> than creating its own?
>>
>> I don't see a way to do this in an easy, clean, reasonable way. SLOF
>> uses pointers to internal structures as phandles all over the place. Y=
ou
>> likely can't replace that so easily without rewriting half of the whol=
e
>> device tree related code in SLOF, I guess...
>=20
> Dang, that's what I suspected.
>=20
> Just to be clear the phandles are used directly as raw pointers?
> There's not even some lookup macro we could change?
>=20

We would need to rewrite
https://github.com/aik/SLOF/blob/master/slof/fs/node.fs

Since SLOF does not seem to use phandles as pointers directly anywhere bu=
t
in nofe.fs, this should be doable. Easier said than done though.


--=20
Alexey


--APfH549nHCt5i51XajV5am0w21RGouMJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZf+WJDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5UJAQALmU
/Wi1rvpFRxoE8CK1wP2WoXt42FK0xDnf8/NoCQiUKcvtyVaFD98EIpsSD3dSACPZ
IBYPkT7gAy4NOzpoL6iTcc3BUuT/H+DCge9UEiHT4eII8GZlTgTmP/4SXGrhCvH1
/g/0OeO6ZWz3CQRbwYy+t676kO1nPnpEl2yqCsMvhFj4jt0dCKm73Wbhwvh8O4uB
lQaQlc/PD361ezF9p7/O4DME0Ezmf4Kb4YbrKC+YZ1KAgPTMyG0GDPQ0XDtSClHH
AiV1IMEaspMOJ+SpBZxvDI1ESgjVyTivs50Wzm+m/DuyeTgsuL7XAnrgh6C9TGAq
qSuwhaGqimiSGN6xBjYyYWR3yp5STq8ITsPV2T7DPXNCnMfEcZRa//IrAaRmoDog
mVr7bdF9Ihnn7zAkqoeghFBmDX2NkgvcdH2ubbZkc13IpWx2b9eh5rh9pPLf1xJi
M3VRo1rij2/9LmyouP3HTTAFfTCFXCdyFZE+fQVHM2aAePg8AKJbuqn9d0FXxkBn
hNaWa/5VQM/cz1zrflx8pnkaFtrdnSGjdOclp3worC2/fSBFkr6MzPYrfVjaTuPv
wu8W4YirWBYhYN9eVlon/kuaCSr7K6lBorzYKDrX9jyfk3yPX3f854PQOAi+74k5
nqzX97DHmfy34BOWFnTABkqViAf8Rdztr1+j3VoA
=3Vm8
-----END PGP SIGNATURE-----

--APfH549nHCt5i51XajV5am0w21RGouMJL--

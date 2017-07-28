Received: from eggs.gnu.org ([2001:4830:134:3::10]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1davvp-0003MJ-Lq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1davvm-0004qy-Dd
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:27:17 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1davvm-0004pg-27
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:27:14 -0400
Received: by mail-pg0-x242.google.com with SMTP id v190so22311286pgv.1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 20:27:14 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
	<20170727183926.246b5beb@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
Date: Fri, 28 Jul 2017 13:27:05 +1000
MIME-Version: 1.0
In-Reply-To: <20170727183926.246b5beb@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BE9FegwKRWxciW2cN5b4NCXirQbBcmp3I"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BE9FegwKRWxciW2cN5b4NCXirQbBcmp3I
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add support
 for PHB hotplug
References: <150100547373.27487.3154210751350595400.stgit@bahia>
 <07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
 <20170727183926.246b5beb@bahia.lan>
In-Reply-To: <20170727183926.246b5beb@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/07/17 02:39, Greg Kurz wrote:
> On Wed, 26 Jul 2017 17:31:17 -0300
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>=20
>> I've tested the patch set using Greg's Github branch. It worked fine i=
n=20
>> my tests
>> using a Fedora 26 and an Ubuntu 17.04 guests. I have two observations
>> though:
>>
>> 1 - This is not related to this patch set per se because it is=20
>> reproducible on master, but
>> I think it is interfering with this new feature.  There is a=20
>> warning/error message in
>> the kernel right after SLOF that goes:
>>
>> (...)
>>   -> smp_release_cpus() =20
>> spinning_secondaries =3D 0
>>   <- smp_release_cpus()
>> Linux ppc64le
>> #1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci:=20
>> failed with rc=3D-22
>> [    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=3D-2=
2
>> [  OK  ] Started Security Auditing Service.
>> (...)
>>
>=20
> This is a regression in QEMU master introduced by this commit:
>=20
> commit b87680427e8a3ff682f66514e99a8344e7437247
> Author: C=C3=A9dric Le Goater <clg@kaod.org>
> Date:   Wed Jul 5 19:13:15 2017 +0200
>=20
>     spapr: populate device tree depending on XIVE_EXPLOIT option
>    =20
>     When XIVE is supported, the device tree should be populated
>     accordingly and the XIVE memory regions mapped to activate MMIOs.
>    =20
>     Depending on the design we choose, we could also allocate different=

>     ICS and ICP objects, or switch between objects. This needs to be
>     discussed.
>    =20
>     Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> It is very similar to the issue that motivated the new KVMPPC_H_UPDATE_=
PHANDLE
> hcall (see patch 24 and 26 in this series):
>=20
> - QEMU creates an "interrupt-controller" node with a phandle property
>   with the value 0x1111
> - QEMU passes the FDT to SLOF
> - SLOF converts all references to the phandle to an SLOF internal value=

>=20
> =3D> from now on (ie, until the next machine reset), the guest only kno=
ws
>    the OF phandle.
>=20
> - during CAS, if we go XICS, we send back an updated FDT with the
>   phandle of the "interrupt-controller" node reverted to 0x1111
>=20
> =3D> the guest complains because all cold-plugged devices nodes refer
>    to the OF phandle, not 0x1111
>=20
> A solution is to use the value set by KVMPPC_H_UPDATE_PHANDLE during CA=
S
> instead of 0x1111. I could verify it makes the guest warning disappear.=

>=20
> I'll send a dedicated patchset to fix this in 2.10.


The SLOF I pushed for 2.10 does not have it though. And the rest of XIVE =
is
not targeted for 2.10 anyway. So imho the solution is reverting "spapr:
populate device tree depending on XIVE_EXPLOIT option" for 2.10.


--=20
Alexey


--BE9FegwKRWxciW2cN5b4NCXirQbBcmp3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZeq8JDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5c1wP/1+p
V8CZhimanXAGm4/mH3mOOnyovbaX5wb3NHHRDVM/ODcJsfmyOIHwTNK/Fdc//KV9
+tqDW32S9/3G9ZVLA06+zcEBjDt8X+Wkk0qJHOlXj/ope4ddN5gVgMjcqoVucACs
/wm0rJd58KilDz7hsK1xB20N3mrPJdbkzBzCtlJwFXfTZsJFGMeCL5daIeDAUOfe
KKn0LoqxEt7WskVdRjxE5lUGSxrI/wlbLBWHSUbTUsDV+lCe9ObaRzXs3gbgXPDW
pvoWYNoQ05NL+XBrZWWoaTAu6d5nov3v8DAF2274OvxsGQCXa8foIZLjvNg10NA5
wR1cFk5iqmrUVNpfdxoyqWtHFTltgoSzNR/l2jyEcHqNnV6Q/U2hMJFWi6wGHHoL
IVjqhKdcEcmaO87yYEXNN/U7tKazObwGG3RMZ6D/lt46C2loXm70YiDv6F4gSIyP
vhH//JoQ7k6zMMNbF8Wm6kqcAJVUgwLmdmLtmaOXszhhe2aZzMdvp+PuRs5KTleU
DslkKJrDic9RYOp+myBJGd8i+ZEBWMnS52NVBxOjeNI0PxrLp+9lQ7YT3Ls8b2bi
aambVSkeJ5RU6Cv5BkzCQ9jwU4UhEHsZ5Y/MBi3k/mQuPreQJIKysVvkK0uUWtao
9YU5uIPwBtutl8Eonf8x/DIY9lBnVDnQoQybHBjF
=NPAq
-----END PGP SIGNATURE-----

--BE9FegwKRWxciW2cN5b4NCXirQbBcmp3I--

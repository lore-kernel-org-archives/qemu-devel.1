Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dayeB-0007uW-G8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daye8-00029b-1i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:21:15 -0400
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
	<20170728040257.GI3098@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
Date: Fri, 28 Jul 2017 08:20:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170728040257.GI3098@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OSSVwh8nTSbhd8I7x8K9emKvFC5Kmjh48"
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
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OSSVwh8nTSbhd8I7x8K9emKvFC5Kmjh48
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.07.2017 06:02, David Gibson wrote:
> On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote:
>> The "phandle" property of the XICS node is referenced by the "interrup=
t-map"
>> property of each PHB node. This is used by the guest OS to setup IRQs =
for
>> all PCI devices.
>>
>> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF conve=
rts
>> this value to a SLOF specific one, which is then presented to the gues=
t OS.
>>
>> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which i=
s used
>> by SLOF to communicate the patched phandle value back to QEMU. This va=
lue
>> is then cached and preserved accross migration until machine reset.
>>
>> This is required to be able to support PHB hotplug.
>>
>> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, so=
 we
>> have to introduce its number even if QEMU currently doesn't implement =
it.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Ugh.  I really, really hope we can avoid this, though I don't
> immediately see how.  Having to have two way communication between
> qemu and SLOF about the device tree contents just seems like opening
> the door to endless complexities.
>=20
> This is basically a consequence of the fact that both qemu and partly
> responsible for constructing the device tree for the guest, and that's
> not easy to avoid.
>=20
> Hrm.. Thomas, I know it's not really the OF way, but would it be
> feasible to change SLOF to use the phandles as supplied by qemu rather
> than creating its own?

I don't see a way to do this in an easy, clean, reasonable way. SLOF
uses pointers to internal structures as phandles all over the place. You
likely can't replace that so easily without rewriting half of the whole
device tree related code in SLOF, I guess...

 Thomas


--OSSVwh8nTSbhd8I7x8K9emKvFC5Kmjh48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZetfOAAoJEC7Z13T+cC21ZFAQAKLTlGf+zmlBDpSvrJ62T4ua
Og5L02Umxg72f/A89qNKVOzQsMFTd5AxE+qwyiPNg2Gne4SLwQTVQvnkJt2j6dxj
4Uk/J9X0557QwiKR3Hc4JzUrPms2czF1mCiiic/QUs/U9mnJHzMNvSUX1m9Py4fN
0KCBri+pO3irsg8NrxwklItVEJ6kQnhi59OX4sj6OiU2gWd1dKEiFwsiSQNdFCmO
E11/NGNpRCCdI80WyJJveUud/ku48+DYuTVkLq9hV95NLXkVK7GGzx1zeLz9Db67
BG1Cl7lj4VrI/T54BbeRMlW+gE+4im72dJibxwmIUOOUW/RqUwvgLz0yVose6W2+
KcgW/6feoJyY380j/FMiL7LlYuGpWw5ODvYyvMLnYMe8eWFFrHKyz0xm8MCDR4I3
doaW9/AdgMgod85a4KnGqDYCpFMqb900YQTMfwIW8Hvofy4nnu63cqmxDhHRGsLK
8HupQ3aHS3fcJdNQGbkZEymK6Knub7lASALFBcjCQf5sFB9GuwvjOCYH3u7r+9AS
LaAszPMZgVnI64qCPuovONrTBZ1SoBLXCdMDKAVQFI064+qHjaLQ7m0M9dCMYGMf
anhMozMKjbMtre0ARDR5w+6ny4lsZzAVtcUByZUunUQscPoJheYek9eDfCeUeHOz
+txpFnfztHnqBzUESkI8
=fG03
-----END PGP SIGNATURE-----

--OSSVwh8nTSbhd8I7x8K9emKvFC5Kmjh48--

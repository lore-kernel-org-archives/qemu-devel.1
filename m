Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dOR5z-000089-Dc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dOR5w-0000LB-5x
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:06:07 -0400
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ccd9fbf-cf3f-cd98-540c-e7bbae36ff88@redhat.com>
Date: Fri, 23 Jun 2017 18:05:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170623092124.GG12089@umbus>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="k8vS3OjLFsq4KulBq5sfhPWrp4GUgd6nn"
Subject: Re: [Qemu-devel] [PATCH] target/ppc/cpu-models: set POWER9_v1.0 as
 POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k8vS3OjLFsq4KulBq5sfhPWrp4GUgd6nn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.06.2017 11:21, David Gibson wrote:
> On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
>> On 22.06.2017 13:26, Laurent Vivier wrote:
>>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
>>>
>>> When we run qemu on a POWER9 DD1 host, we must use either
>>> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
>>>
>>>     Unable to find sPAPR CPU Core definition
>>>
>>> because POWER9 DD1 doesn't appear in the list of known CPUs.
>>>
>>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
>>> PVR instead of CPU_POWERPC_POWER9_BASE.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  target/ppc/cpu-models.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>> index 4d3e635..a22363c 100644
>>> --- a/target/ppc/cpu-models.c
>>> +++ b/target/ppc/cpu-models.c
>>> @@ -1144,7 +1144,7 @@
>>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,               =
 970,
>>>                  "PowerPC 970 v2.2")
>>> =20
>>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,           =
 POWER9,
>>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,            =
 POWER9,
>>>                  "POWER9 v1.0")
>>> =20
>>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,             =
 970,
>>>
>>
>> I think this also makes sense for running in TCG mode to get a valid
>> real PVR there.
>=20
> I'm not so convinced.
>=20
> IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's a)
> probably not what anyone wants - who'd select a buggy prototype and b)
> not accurate - TCG does not implement DD1's bugs.

But DD1 =3D v1.0. There is no real chip which is using
CPU_POWERPC_POWER9_BASE as PVR ... so using that is also not accurate,
and also likely not what users expect when the select "POWER9_v1.0", and
it just does not work as soon as KVM is enabled. So I think Laurent's
patch is the right way to go. Or do you have a better suggestion?

 Thomas


--k8vS3OjLFsq4KulBq5sfhPWrp4GUgd6nn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZTTxmAAoJEC7Z13T+cC218n4P/ROgfieG2Wznbx/TTap/mKVp
+4aZ3pAjSAVbURuLB0CbE+KnT9sqTRis0w5KYosuYZbZh9iZvtaAAvuCW68ARN0q
YEWWuqhG5ME9I8MNi38Glg36ltkPi4kr0n2hBN7MzwmilJvat+osWwRKfM1SHL6h
0vLFyTwX93dNZ2Kn6d6E8AgwYmtm7PSi9RVAzfDWF49pTl7Gc+AoyDmxApEqpbBZ
qZLUGLJxzNIfl9RkIg8SpFr+EE1aVaLQhKbEE70yQ6jGTu5cWvAnkCjpxDQJtBxN
G2MdqZ2qCv/YAYiuPwkQBXLLk8tpjKCmbkdm71J46yfLKIxE0bCFcGLLDkh+lLaN
cqhOM9c3QJB9/1BxpYtGe+MLKcJnSK3crvKHMPLpKPuUwgYev3ych6Hrnw3gZCO/
n+yr1sGVZqpoo7dID4Ndw2FmTkxicwGniKNOmaPeF2lCdpFFRlBXZQClYw3ZIXrx
TTJ7q1ItpNkn+lWDdbCd5z0ARRdDrDRrBENrY1e2eSH+BXM4MlyJ2wv3RTU9qEix
r36C4CBkZv2qblKNnX/8WRDnB5gONyqnKjTkdwgDcW/PZn1EpVqztIf2+b4rK+er
Acpd3Q1iehxqyT/Z5D9PSMfhaxP8zOYyfIGCT0bbsoo59IqIzKLBNoZvKYE349dU
lMZRBhQjDqNnx63KVe/7
=HuI2
-----END PGP SIGNATURE-----

--k8vS3OjLFsq4KulBq5sfhPWrp4GUgd6nn--

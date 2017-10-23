Received: from eggs.gnu.org ([2001:4830:134:3::10]:48368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e6Uaf-000685-IU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 00:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e6Uab-0001cy-Gz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 00:43:53 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:51229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e6Uab-0001cY-9H
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 00:43:49 -0400
Received: by mail-pg0-x244.google.com with SMTP id p9so10818225pgc.8
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 21:43:47 -0700 (PDT)
References: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
	<1507823408-270386-1-git-send-email-imammedo@redhat.com>
	<20171012222409.GE28032@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5743323b-0a81-3675-90df-ab88eb84660a@ozlabs.ru>
Date: Mon, 23 Oct 2017 15:43:41 +1100
MIME-Version: 1.0
In-Reply-To: <20171012222409.GE28032@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p5bfVDiXSNFg2sTU125UxqJIIqnUcBnuD"
Subject: Re: [Qemu-devel] [PATCH v2 18/24] fixup! ppc: spapr: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5bfVDiXSNFg2sTU125UxqJIIqnUcBnuD
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de
Message-ID: <5743323b-0a81-3675-90df-ab88eb84660a@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v2 18/24] fixup! ppc: spapr: use generic
 cpu_model parsing
References: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
 <1507823408-270386-1-git-send-email-imammedo@redhat.com>
 <20171012222409.GE28032@umbus.fritz.box>
In-Reply-To: <20171012222409.GE28032@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/10/17 09:24, David Gibson wrote:
> On Thu, Oct 12, 2017 at 05:50:08PM +0200, Igor Mammedov wrote:
>> inot sure how it managed to compile locally and on travis
>=20
> Because target/ppc/kvm.c is only compiled on a ppc _host_.


that or in cross environment, to be precise.


>=20
>> but build fails with type mismatch on PPC host, fixup it
>> by casting to expected type
>=20
> I already hit this one and fixed it up in place.
>=20
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  target/ppc/kvm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 48dc3f7..9d57deb 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2505,7 +2505,7 @@ static int kvm_ppc_register_host_cpu_type(Machin=
eState *ms)
>>      }
>>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc))=
;
>>      type_register(&type_info);
>> -    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
>> +    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
>>          /* override TCG default cpu type with 'host' cpu model */
>>          mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
>>      }
>=20


--=20
Alexey


--p5bfVDiXSNFg2sTU125UxqJIIqnUcBnuD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlntc30OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILnTkQ/+NgVWVvD03WEfndX7g9FRBtMybntBYw280hh4
LL5e3JgV7Jcj04e2sjGnoYw8G+mTSf2pQRrvRCIQKWbiKUDFNs4ZMmDWWayykDFh
HveHRENK5loju4OW7UUNILiOVswP82fnL2Q6QS7ZhIIxI6v6UohL6gobeMpRdnxS
nwJdYsu5taqL94+is2yJQLM6DIm8plNktiA5bcG/p3TtyFR61i4Zd6vCjQc8cNt4
TxFxltN+oGPzRWKaEmCQK/vO/MS4h8W7X/6+7/JwCM2F8vAI/TiJDD+mLIDki0hr
EsBblVCJQrNUJ3wjhJ4v5e7UQsCTsQFWdK9qVKxj9vWAhixgIp5+kl1KURHYbNM+
HwY5aFMU363om5k0fIvLcgaxBNccF2lrmEVnCB8OjFn3kaj4XjabUGm8i7BIRZUz
lC1i+DbKYpEJ58rCOGwXxeIzWP9MzyLtPBkzxIKr7Ex7BLNJvb19x4AisnEteGdY
HGdWPyRc/oVFA+fL/S4urLiTqtp1YqsL6nelLGuDaNRxDTbpK9c5g4zvB4trm+KW
MB1MR21zUtA5rRMOjJKViVRHbswvZanEVO+cJgafgShIZ3sTrCdCnIo9QVsAcmkZ
s3HtLQf8ZRUcj9wKTwTsx+4VwOwKZgVjmRfdZfJbONKfgYuOU8ROGDi1d004HjOK
aDWWyc4=
=J/Nu
-----END PGP SIGNATURE-----

--p5bfVDiXSNFg2sTU125UxqJIIqnUcBnuD--

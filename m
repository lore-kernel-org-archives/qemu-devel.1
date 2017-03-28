Received: from eggs.gnu.org ([2001:4830:134:3::10]:54471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cspNi-0005zm-VX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cspNi-0003M6-82
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:33:47 -0400
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
	<20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
	<e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
	<20170328063925.GB22108@bjsdjshi@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8ff6f913-9903-daac-1099-65b5c4fc6dc5@redhat.com>
Date: Tue, 28 Mar 2017 13:33:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170328063925.GB22108@bjsdjshi@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rFNuufwkXOht8xLhhgBwawL9ab9Ne8d0P"
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/1] block: pass the right options
 for BlockDriver.bdrv_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rFNuufwkXOht8xLhhgBwawL9ab9Ne8d0P
From: Max Reitz <mreitz@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 kwolf@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com,
 borntraeger@de.ibm.com
Message-ID: <8ff6f913-9903-daac-1099-65b5c4fc6dc5@redhat.com>
Subject: Re: [PATCH RFC v2 1/1] block: pass the right options for
 BlockDriver.bdrv_open
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
 <20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
 <e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
 <20170328063925.GB22108@bjsdjshi@linux.vnet.ibm.com>
In-Reply-To: <20170328063925.GB22108@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28.03.2017 08:39, Dong Jia Shi wrote:
> * Max Reitz <mreitz@redhat.com> [2017-03-27 17:27:16 +0200]:

[...]

>> (1) Remove every option in "options" that has a "file." prefix before
>> the qdict_put() call.
>>
>> (2) Use bdrv_unref_child(bs->file) instead of bdrv_unref(bs->file->bs)=
=2E
> :> You must mean:
> bdrv_unref_child(bs, bs->file);

Yes, right. :-)

>> I guess it should work with those changes. At least I hope it will.
> Yes, with my test results, it works!
>=20
>>
>> By the way, the easiest way to do (1) is probably:
>>
>> QDict *file_options;
>>
>> qdict_extract_subqdict(options, &file_options, "file.");
>> QDECREF(file_options);
> Cool. I adopted your code and it works well.
>=20
> Thanks for these very detailed analysis and the code example.

No problem.

> Mind if I add a:
> Suggested-by: Max Reitz <mreitz@redhat.com>
> in the following version?

Feel free to, but it's not necessary. That was just normal reviewing work=
=2E

Max


--rFNuufwkXOht8xLhhgBwawL9ab9Ne8d0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljaShESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiCsH/R6qCTKSbX62psQy+s5lt7Qy8DH4KXUy
oDtRzzQbpr7B0xIQ977kW02PdWYUTFYgiDKExTkMRINybOgCYuODpZFkxr4Jn+Mn
+SAzzQKYv6tIGxF9vpdhK7RjPylsjySTn+v0ZbrPuSzakarLIbJRFiGj0QyUX0n1
N6GfXvzgpUfbh5kyme6hMcPtspczE8T/ME9RkCXHXtKLb+awnSdoxi0HSrcNG+CE
41OQZdEGiLgkPT47NVYhf5OkOKlxxjNoG51dwtWaSdv3UmIEebHtqqqdPTy2Gqm0
RBMdsKVO99NmivUY4+XwdM/Vt7W3OpF7cqmCfKQwxt1YmWKDf43osZ0=
=rE2T
-----END PGP SIGNATURE-----

--rFNuufwkXOht8xLhhgBwawL9ab9Ne8d0P--

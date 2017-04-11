Received: from eggs.gnu.org ([2001:4830:134:3::10]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwKe-0007mQ-18
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwKd-0008S2-18
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:59:44 -0400
References: <20170411131327.10734-1-mreitz@redhat.com>
	<874lxvujut.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ab9d54e6-fedf-030b-9258-609a3e1549b2@redhat.com>
Date: Tue, 11 Apr 2017 15:59:26 +0200
MIME-Version: 1.0
In-Reply-To: <874lxvujut.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KKFiPhKcrQm0p0n7bxfgdu4ImHfbkWQLD"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KKFiPhKcrQm0p0n7bxfgdu4ImHfbkWQLD
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org
Message-ID: <ab9d54e6-fedf-030b-9258-609a3e1549b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
References: <20170411131327.10734-1-mreitz@redhat.com>
 <874lxvujut.fsf@dusky.pond.sub.org>
In-Reply-To: <874lxvujut.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 15:58, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Parsing the URI is not required to give us a scheme; uri->scheme may b=
e
>> NULL.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/nfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 0816678307..0c7d5619fe 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -83,7 +83,7 @@ static int nfs_parse_uri(const char *filename, QDict=
 *options, Error **errp)
>>          error_setg(errp, "Invalid URI specified");
>>          goto out;
>>      }
>> -    if (strcmp(uri->scheme, "nfs") !=3D 0) {
>> +    if (!uri->scheme || strcmp(uri->scheme, "nfs") !=3D 0) {
>>          error_setg(errp, "URI scheme must be 'nfs'");
>>          goto out;
>>      }
>=20
> Consider g_strcmp0().

Nice, thanks!

Max


--KKFiPhKcrQm0p0n7bxfgdu4ImHfbkWQLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs4T4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWTAH/j9Gk3yD7XFcP2z/1gMBkjovwn6zWB6S
zNpI83GESqIrK9zvc+RtrqfhicQJNhwXgFdfE0s9s2Sy3qxwdAqOW/znHhJgIUA3
QkB/fZAYx2r4LC7xTytdVV5FnH3yuf0xkiTAG4PRpQt16G1NDFwgkw+FnSu2zDJO
HA4hITgZ/0POHPxfEVDD/W3RtAE0Bv/4S+q5xGF+2tQ/gQokgSpiOw18gr7guJOU
R+nGqhVJJ6VJ2YKzgIOXWInaxpsFhHAMdiwYDz3YkSGcgGRRkgYY80UsdTBJVkDa
anIoy4G0JMIORJjbb3b7+/827ZFmvtYtYn/TbsJ1sDgLYL/UqcaEYHg=
=u3iP
-----END PGP SIGNATURE-----

--KKFiPhKcrQm0p0n7bxfgdu4ImHfbkWQLD--

Received: from eggs.gnu.org ([208.118.235.92]:56190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehdsx-0007Dy-9Z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehdss-0000rD-Vl
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:08:19 -0500
From: Max Reitz <mreitz@redhat.com>
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
	<be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
Message-ID: <77301f3f-5ce2-dfe5-1529-6b03fbe245e7@redhat.com>
Date: Fri, 2 Feb 2018 16:36:12 +0100
MIME-Version: 1.0
In-Reply-To: <be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H0EHMSOSrEcIUxHv4HPUz6wM7X2VHdmZf"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H0EHMSOSrEcIUxHv4HPUz6wM7X2VHdmZf
From: Max Reitz <mreitz@redhat.com>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <77301f3f-5ce2-dfe5-1529-6b03fbe245e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
 <be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
In-Reply-To: <be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-02 14:37, Max Reitz wrote:
> On 2017-12-02 23:37, Shravan Rajinikanth wrote:
>> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
>> ---
>>  qemu-img.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 68b375f..bea9268 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *che=
ck, bool quiet)
>>          if (check->leaks) {
>>              qprintf(quiet,
>>                      "\n%" PRId64 " leaked clusters were found on the =
image.\n"
>> -                    "This means waste of disk space, but no harm to d=
ata.\n",
>> +                    "This means disk space is wasted, but data is saf=
e.\n",
>>                      check->leaks);
>>          }
>=20
> Sorry, somehow I never applied this.  (Maybe I thought it would go
> through trivial...)
>=20
> Applied to my block tree:
>=20
> https://github.com/XanClic/qemu/commits/block

I'll have to unstage it again because it breaks some iotests (026, 060,
and 112), sorry.

Max


--H0EHMSOSrEcIUxHv4HPUz6wM7X2VHdmZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0hWwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAo0IAJpg70rbFBalfkIjkOvvqt/EyZatDOkP
kIB9q95oxj4DC8vmmteNm129c09fAme1RQmzS5WfB14oRe0kXLhBudwFR8dVZyn9
H5Bn3wJcqoOLeyTPSRrii+pF2ORVKqc96Xa5WbB+EdtK49leQFbYF5NH2d/7sB58
4gy4Xxg0ytNHLQHFgQDc5b34+wRuyLXDyuSsn6AgogjBgvnBtXZJgylZ9Qx/7A0d
7rZPolAOSqVEN5g7T+9LPlAtYXehuPU2rGP+xyafNyzGTgDgyPS1FjswpBd5Wtms
Dud3pF0mXt0Y66OdLDGgfRH6exiwkgaVk4582UKZbpcAdkrFMpO+YMU=
=pKNj
-----END PGP SIGNATURE-----

--H0EHMSOSrEcIUxHv4HPUz6wM7X2VHdmZf--

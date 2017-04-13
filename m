Received: from eggs.gnu.org ([2001:4830:134:3::10]:42334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyj5z-0004ng-Bh
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyj5y-00070u-EL
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:03:51 -0400
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-2-git-send-email-kwolf@redhat.com>
	<a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
	<20170413175444.GG5095@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35c0f944-0303-5d86-7bf3-93940bd886e5@redhat.com>
Date: Thu, 13 Apr 2017 13:03:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170413175444.GG5095@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ABcvgglWxxtKjpjurevNjsnKVR1S3KuBg"
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ABcvgglWxxtKjpjurevNjsnKVR1S3KuBg
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com,
 dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <35c0f944-0303-5d86-7bf3-93940bd886e5@redhat.com>
Subject: Re: [PATCH 1/3] migration: Call blk_resume_after_migration() for
 postcopy
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
 <1492104214-29994-2-git-send-email-kwolf@redhat.com>
 <a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
 <20170413175444.GG5095@noname.redhat.com>
In-Reply-To: <20170413175444.GG5095@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 12:54 PM, Kevin Wolf wrote:
> Am 13.04.2017 um 19:39 hat Eric Blake geschrieben:
>> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
>>> Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming=

>>> migration') added blk_resume_after_migration() to the precopy migrati=
on
>>> path, but neglected to add it to the duplicated code that is used for=

>>> postcopy migration. This means that the guest device doesn't request =
the
>>> necessary permissions, which ultimately led to failing assertions.
>>>
>>> Add the missing blk_resume_after_migration() to the postcopy path.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  migration/savevm.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Are we targetting this for 2.9-rc5, or is it 2.10 material?
>=20
> At this point, I think it's clearly 2.10.

Okay.  Restating, to make sure I got your reasoning: the removed
assertions of commit e3e0003 imply that 2.9 is not regressing in
behavior, and at this point the worst the code can do without this patch
applied is behave like it's done previously; therefore this patch is not
fixing an observable 2.9 behavior and therefore not worth holding up the
release.

But for 2.10, it's absolutely essential, as we have another patch
pending to revert e3e0003 at which point we have a behavior break
without this patch.

Works for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ABcvgglWxxtKjpjurevNjsnKVR1S3KuBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7713AAoJEKeha0olJ0NqBzQH/Rx4KOeQAjXEiKyG9DJrNmea
NnPf/3+QdDQaB2C9LVAC4XQI551YOzJYt/rIx6wZt6y9evM5O+11BD2pem2wfXgR
90/Ej3xsWdg+r8/vSh89tIlPGBPKJ0WQ5CGtbtqAgQJuxWbTqADYgJDC6tuUHP6g
7rG3aOrJjAmecSCMAfd5K1TeXeWP8A+IVfQzHB2jk4u3+vo7h8xPm+GIxRwMz+2C
s5/EsNm8a/GK5N/S7+bWwjeL4G+Mtz6K/aoEZDaOYtDsdCAStMYKKW/8MNm/P7fE
m1vF1e/Z3F9N08eG3xJWlGoCL0bugG4LHn9Mrhn9rzpFRCHyHYDT9CNJJmu8ZqE=
=GcR+
-----END PGP SIGNATURE-----

--ABcvgglWxxtKjpjurevNjsnKVR1S3KuBg--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDrm-0008T4-US
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDri-0003GZ-HO
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:06 -0500
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
Date: Thu, 19 Jan 2017 08:38:44 -0600
MIME-Version: 1.0
In-Reply-To: <87lgu7flkc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hd5Q7DSQCUvDaalKuHxxqcQDq2Wbj8oe6"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hd5Q7DSQCUvDaalKuHxxqcQDq2Wbj8oe6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alberto Garcia <berto@igalia.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:X86" <xen-devel@lists.xensource.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-3-eblake@redhat.com>
 <87lgu7flkc.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgu7flkc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:25 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Quite a few users of qdict_put() were manually wrapping a
>> non-QObject. We can make such call-sites shorter, by providing
>> common macros to do the tedious work.  Also shorten nearby
>> qdict_put_obj(,,QOBJECT()) sequences.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>
>> ---
>>
>> v2: rebase to current master
>>
>> I'm okay if you want me to break this patch into smaller pieces.
>=20
> I guess I'm okay with a single piece, but I'd like to know how you did
> the conversion.  Coccinelle?  Manually?

Manual, via grepping for put_obj.*QOBJECT. I'll see if I can do the same
under Coccinelle (at which point, committing the script will make it
easier to rerun cleanups if later code reintroduces poor usage
patterns), so maybe I have a v3 coming up.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hd5Q7DSQCUvDaalKuHxxqcQDq2Wbj8oe6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgM90AAoJEKeha0olJ0Nqtf4H/2XqUE1mZXeWEOPkUvvUvcAE
oII7oXLCR+vwen9uxFWvu1czlz4D/IpCPLpYAJ07W5AUPGCUSGdwqnuG5zw7UpY2
KiEa7CUnMpbT5m5C3tQiMVz3kxFxtidV3UqZBj46dhz7cSv6KgqdaEz+vjF6vo8F
i/D499hPlDAuyn4UlZ5HOO928BYPDO5PEz77wMgKTdFfld+lbIJ2bcckNDw59due
YzpMDLKG8wQAZ3vQZPuV+feRLHvLAW1O1Grrhdsjg1N2bCuRbS9hPkaa3EE7N9Cw
1GABVRk9IE3c3vIc/GmScGFw30QSXQ045qrYVv/OSaaYhEEGFtiwgXdRf6RjQSA=
=hK+R
-----END PGP SIGNATURE-----

--hd5Q7DSQCUvDaalKuHxxqcQDq2Wbj8oe6--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvX8h-0004Yv-EE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvX8g-0003HZ-D5
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:41:27 -0400
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
	<9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
Date: Tue, 4 Apr 2017 17:41:08 -0500
MIME-Version: 1.0
In-Reply-To: <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CC8q7utnXC2rDTsL2oMBJU1QCquFOrQGv"
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CC8q7utnXC2rDTsL2oMBJU1QCquFOrQGv
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alberto Garcia <berto@igalia.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>,
 Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:X86" <xen-devel@lists.xensource.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-3-eblake@redhat.com>
 <87lgu7flkc.fsf@dusky.pond.sub.org>
 <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
In-Reply-To: <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 08:38 AM, Eric Blake wrote:
> On 01/19/2017 03:25 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> Quite a few users of qdict_put() were manually wrapping a
>>> non-QObject. We can make such call-sites shorter, by providing
>>> common macros to do the tedious work.  Also shorten nearby
>>> qdict_put_obj(,,QOBJECT()) sequences.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>
>>> ---
>>>
>>> v2: rebase to current master
>>>
>>> I'm okay if you want me to break this patch into smaller pieces.
>>
>> I guess I'm okay with a single piece, but I'd like to know how you did=

>> the conversion.  Coccinelle?  Manually?
>=20
> Manual, via grepping for put_obj.*QOBJECT. I'll see if I can do the sam=
e
> under Coccinelle (at which point, committing the script will make it
> easier to rerun cleanups if later code reintroduces poor usage
> patterns), so maybe I have a v3 coming up.

I've got a Coccinelle patch (mostly) working now - but it has one
shortfall - I found places in tests/check-qdict.c that coccinelle
didn't, and traced it to the fact that our use of g_assert_cmpint(expr,
=3D=3D, expr) throws off the coccinelle parser so badly that it silently
ignores the entire function body containing the use of that macro.  v3
will be posted soon, with the best of both worlds (coccinelle caught
spots that I missed, not to mention recent code base changes; and my
manual search found the spots in tests/ that coccinelle missed).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CC8q7utnXC2rDTsL2oMBJU1QCquFOrQGv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5CEEAAoJEKeha0olJ0Nq3EkH/0Oq+K4IoD5nqLL4pz2vb4k0
X8G+asQgxxSI0B8QNRDZa3zyZmUPSNCO1ADwELy+GtrJVnlm/eAirrs+3idFvu8a
Z4ijZZ2gnnagXq3vaOSLVYNg0TLddjvJv/Mud3kZO7JdTTTie+RukgCOSp/1M81v
EjssWuSsKOFw40vxFIQM5JvxIeYrdJxEpl57z/WmemQRd/V61dYiDMwd3nixMUr3
sFcxwdJeAOBHtIHaZGIHBo/TRQomJL8lz84BXNFJ9RnBOVNvH4TgCtcF0c1ax0xk
t09WOGiPCvifeLKTJ+yNNA2FW9ons3rhCUoYFBEYUIEJ6yl2LKGFndXHAg4fSeA=
=Ewpr
-----END PGP SIGNATURE-----

--CC8q7utnXC2rDTsL2oMBJU1QCquFOrQGv--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcXE-00053G-5k
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcXA-0004OR-9I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVcX9-0004OG-W8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:43:52 -0400
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<87vamxzjln.fsf@dusky.pond.sub.org>
	<CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
	<69e2fa77-5311-9874-34fc-297a062929d4@redhat.com>
	<878tjsr38n.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e73b3f52-c950-4fa3-cddd-0fd579a11108@redhat.com>
Date: Thu, 13 Jul 2017 06:43:48 -0500
MIME-Version: 1.0
In-Reply-To: <878tjsr38n.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k5O5VRXBJjWmwAChWihgBjcm236vlIXXX"
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, philippe@mathieu-daude.net, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k5O5VRXBJjWmwAChWihgBjcm236vlIXXX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 philippe@mathieu-daude.net, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Message-ID: <e73b3f52-c950-4fa3-cddd-0fd579a11108@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
References: <cover.1499866456.git.alistair.francis@xilinx.com>
 <87vamxzjln.fsf@dusky.pond.sub.org>
 <CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
 <69e2fa77-5311-9874-34fc-297a062929d4@redhat.com>
 <878tjsr38n.fsf@dusky.pond.sub.org>
In-Reply-To: <878tjsr38n.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 06:22 AM, Markus Armbruster wrote:
>>>> I can take this through my tree once PATCH 4 got some R-by from PC
>>>> paintainers.  Whom you again neglected to cc; I just did that for yo=
u.
>>>> I'll be happy to touch up minor issues like the ones I pointed out f=
or
>>>> v4.
>>>
>>> Thanks for CCing them. I keep assuming git send-email will CC from th=
e
>>> suggested-by line, but apparently not.
>>
>> It will, if you add 'git config sendemail.cccmd
>> "/path/to/scripts/get_maintainer.pl --nogit-fallback --noroles"'
>=20
> Misunderstanding?  Your bit of configuration automates cc'ing
> maintainers.  Alistair was wondering about Suggested-by lines.

Indeed. Unless someone submits a patch to upstream git, right now there
is only a finite set of 'Tag: <email@example.com>' that git will
automatically cc (including Signed-off-by: and CC:, but excluding
Suggested-by:).  It might be nice if git could add a knob to select
which Tag:s are important (or just relax its regular expression to send
CC:s to everything that looks like a Tag:).  But for now, adding ccs to
suggested-by requires manual effort.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k5O5VRXBJjWmwAChWihgBjcm236vlIXXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1z1AAoJEKeha0olJ0NqQXcH/1TQ3ysxQZCc9zFlcN+bmcBO
VGjU1Yn8Dqm4AReP/RiraROJqD6ifx3Wyh+nki0VYj4hy0bPejKDRwjG75im6M4U
XRDVcCW0Lj58Z4IFk0aucWhsD9fr0K6uE1MNdwBMOzK1oHYy3flC0/PDM8sWizH+
/bDqCIxqxdmgKLFrz1WuZVFpc5f0TdHEvYLfBLqgOKmmiTa64BKhBxWNVH1hxB9m
sxih99fj7LE5gWW4X3g9gGetY9k8t4X56LE7s/WZgcqzuKHTOl523YGKyLku1ZnE
bn0cVDDksoinC0mDsdoeMpfG6IyAejeLrNIbZY+Ug+M8xzwkMP0vOGnW9AwyOEE=
=mI86
-----END PGP SIGNATURE-----

--k5O5VRXBJjWmwAChWihgBjcm236vlIXXX--

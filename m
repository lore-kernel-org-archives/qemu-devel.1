Received: from eggs.gnu.org ([2001:4830:134:3::10]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUEBo-00019X-18
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUEBn-00070M-7P
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:59:48 -0500
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
	<20161031172022.GD12558@noname.redhat.com>
	<50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
	<20170118095952.GA5258@noname.str.redhat.com>
	<566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
Date: Thu, 19 Jan 2017 08:59:38 -0600
MIME-Version: 1.0
In-Reply-To: <566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UBVoRtaW3dBv1ivxw6oHOG39kQ05JI611"
Subject: Re: [Qemu-devel] [PATCH v6 0/2] allow blockdev-add for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UBVoRtaW3dBv1ivxw6oHOG39kQ05JI611
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, jcody@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
Subject: Re: [PATCH v6 0/2] allow blockdev-add for NFS
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
 <20161031172022.GD12558@noname.redhat.com>
 <50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
 <20170118095952.GA5258@noname.str.redhat.com>
 <566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
In-Reply-To: <566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 08:30 AM, Peter Lieven wrote:
>>> qemu-img: Could not open
>>> 'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qc=
ow2,linux?readahead=3D131072':
>>> Block protocol 'nfs' doesn't support the option 'readahead-size'
>>>
>>> Please let me know if the below fix would be correct:
>> No, this needs to be fixed the other way round: runtime_opts must use
>> the names as specified in the schema, and nfs_client_open() must acces=
s
>> them as such. Without that, blockdev-add can't work (and the command
>> line only with the "wrong" old option names from the URL, whereas it
>> should be using the same names as the QAPI schema).
>=20
> Shouldn't we support both for backwards compatiblity.?

blockdev-add only needs to support the modern naming.  But yes,
preserving back-compat spelling of the command-line spellings, as well
as matching blockdev-add spellings, is desirable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UBVoRtaW3dBv1ivxw6oHOG39kQ05JI611
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgNRaAAoJEKeha0olJ0NqQigH/jKQN8NvLirjLTD8wPtkU5WU
Zd/EMLl5SDTe3+gpIO+RzhM95y1UvT3yFYgSj0TZ2mdBlWd2IROiUmNAHUjUzrz0
nIceusdZk/M7mL+9g0Ya+xWJnAaDjdOKgaOY9LMDI0VnyxSfoK5RHhSQXFNNmve4
hU4uXf1QJAQfD8473qh7hAdDmwA3ExwTmLxnwpvqfyWoSy+x0ED1Ss5RB1dBfk/2
+3EMBvOY/md7vBSA+fYXwdjkodfe5RXpR2G5Ud4XHIUpHFtLgsK2+PM6SdclOQeP
PisYJvduI5IMduo6jllhSkrx5LzCynR4o57HKdU3ZPSgs/rdLAkiPdCR8uEikEM=
=PdBe
-----END PGP SIGNATURE-----

--UBVoRtaW3dBv1ivxw6oHOG39kQ05JI611--

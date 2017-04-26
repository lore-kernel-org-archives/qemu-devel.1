Received: from eggs.gnu.org ([2001:4830:134:3::10]:37099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3O8y-0002WR-Om
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3O8u-0000dd-6O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3O8t-0000cy-St
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:42:08 -0400
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
Date: Wed, 26 Apr 2017 09:42:02 -0500
MIME-Version: 1.0
In-Reply-To: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="82EmSnGl1l5r4Xo8h7NUFaptweujAsUtL"
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/char: remove console_exit function
 in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <tgnyang@gmail.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--82EmSnGl1l5r4Xo8h7NUFaptweujAsUtL
From: Eric Blake <eblake@redhat.com>
To: Zihan Yang <tgnyang@gmail.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/char: remove console_exit function in
 sclp
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 07:53 AM, Zihan Yang wrote:
> Currently, the console_exit function in sclpconsole-lm.c and sclpconsol=
e.c
> does nothing, so remove them and convert the callback in SCLPEventClass=
 to
> void. Since there is a NULL check on the DeviceClass exit callback as
> suggested by Frederic Konrad, it should be safe to remove them.

When sending a patch series, please be sure to include a 0/5 cover
letter, to make it easier on automated tooling that processes the list.
You can use 'git config format.coverletter auto' to make it easier to
remember this for patches created by 'git format-patch'/'git send-email'.=


More submission hints at: http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--82EmSnGl1l5r4Xo8h7NUFaptweujAsUtL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALG6AAoJEKeha0olJ0Nq8xcH/2LZMifg64mYHCY8+BaTPr38
QKARlc19+P35NMxQgoUusXmRtFa3rMpfO4GpO8Im7R1OM9OnbfB5HLzEmpWNvLWi
Xyi5wR+mWL8BgjT8K0sHl5rBNIJdTC8/Mf+Up79Iu2aRCZbPx55GPniPCXWAQDAt
QORncsfrq4A4oZpEKuwAZ3MxGpJEirrFEF9wjp64PZrMAodjx4nTrnnof3YRKDpT
1zVG9P6oBScQpQ60ejgybRSK0lw49pjaiVbB4LlieSR3ABfAF+tvqKaA8jxOD+wS
BqYgdzM1BkYH7KPDg6u3HttHc/Fm/kZo5Tk7VPZPubIGTR7aTv7kYTEuX9rbS18=
=vxE0
-----END PGP SIGNATURE-----

--82EmSnGl1l5r4Xo8h7NUFaptweujAsUtL--

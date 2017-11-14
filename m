Received: from eggs.gnu.org ([2001:4830:134:3::10]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEgD0-0005GQ-Tv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEgCz-0005w9-P7
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:45:18 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
Date: Tue, 14 Nov 2017 19:45:00 +0100
MIME-Version: 1.0
In-Reply-To: <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="N8DdtDwkkjI01qddNxRN0bjIikLFOOKhS"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N8DdtDwkkjI01qddNxRN0bjIikLFOOKhS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.2017 14:32, Max Reitz wrote:
[...]
> Well, do you want to document it?  I'd rather deprecate it altogether.

Maybe a first step could be to change qemu-img so that it refuses to
create new qcow1 images (but still can convert them into other formats).
So basically make qcow1 read-only?

 Thomas


--N8DdtDwkkjI01qddNxRN0bjIikLFOOKhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJaCzm0AAoJEC7Z13T+cC217PcP/2i0P9X9ZwyY7T5xFK1LFWJ4
uImuDQ+xyxX3wzoGCfqJtyd3rzFASKAoAKoZg/yZblVoZ39LmdFJMb10wUHbxZ/2
svUydVxoGegqnVmZ0q4WBipfM8HocOCN54vLbglf/jNH1fz6nxJ+dbeVhHI1sSaL
DnwGFWk0b+aagO4S3PblqAxvoGgt9Dq5pc8TdqAfHmuxDRtTxcp22T33Ul7jbjPN
snhCxc5Fjp2i5hf3UzC+/HzzOhSEnDBCWT9BSGKFw1r3nFhhJpAclqaZPu6O2VBH
U23PpulF6ZHacvsBJhNAGw2IvQ6jQCvsT6kjDSzhRhXHwJZWnTtdbXoHD2Q+p2Gl
xVjKRj/NmEVw+3WJW+4QPbCq4Vmyg134AkZLTVS6F3UTS2XSrxYlJQD7TZbGvSeA
IQ5hsq4UrOixhUPXncdRMsuiddKS+AzJyA+2ZkEHjX9wrJhahE2Jb6vFFakS/hrp
Jcqu9ayTr1zh+BH3jsLrTnkoFnh7G7I/2AbOZdrBo1lqxNEQGivj3CYUcjSdxIPW
eQWt0BAPmekKKb6ht8Tw7BbeXXYO1Fi/FrJ7zx66PIEZe2/6tN4S8lI8QmL1oRhe
I1q9TPiwvtMn4FGrpkRG1QKi3B3rYiVuuNwmd7+N6+D4l5V8mOlpQ87J7ePpLHk5
0C8lcvCoLYBT6KPWvTop
=tOCe
-----END PGP SIGNATURE-----

--N8DdtDwkkjI01qddNxRN0bjIikLFOOKhS--

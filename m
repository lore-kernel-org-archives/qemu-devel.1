Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin@schrodt.org>) id 1e1zKH-0003YJ-Fq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin@schrodt.org>) id 1e1zKD-0003PR-Fu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:32:21 -0400
Received: from hermes.schrodt.org ([178.77.73.245]:50938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <martin@schrodt.org>) id 1e1zKD-0003Oz-94
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:32:17 -0400
References: <20171010174403.24660-1-martin@schrodt.org>
	<d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
From: Martin Schrodt <martin@schrodt.org>
Message-ID: <d853c85d-d59a-a65c-d672-f6dc6cdd15be@schrodt.org>
Date: Tue, 10 Oct 2017 20:32:13 +0200
MIME-Version: 1.0
In-Reply-To: <d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sKcMjV0iva56gBPPv0hfl7QvtO9XKERNQ"
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sKcMjV0iva56gBPPv0hfl7QvtO9XKERNQ
From: Martin Schrodt <martin@schrodt.org>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d853c85d-d59a-a65c-d672-f6dc6cdd15be@schrodt.org>
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
References: <20171010174403.24660-1-martin@schrodt.org>
 <d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
In-Reply-To: <d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 08:18 PM, Eric Blake wrote:

> That's a lot of changes to be slamming in one patch.  Any chance you ca=
n
> split it into a series of smaller patches that are easier to review
> individually?  Perhaps one patch per item in your bulleted list is a
> good start for subdividing this into something that is not so massive.

I could make a separate request with all my commits separated.

The patch is all these squashed:

https://github.com/qemu/qemu/compare/master...spheenik:master

Problem is, and that's why I decided to hand it over like this, is that
the commits are kind of a log of my learning experience, getting to
this, and so not really separated better.

These 3 here are only paaudio.c

- Remove PA reader/writer threads from paaudio.c, and do IO from the
audio timer directly.
- Expose new configurable settings, such as TLENGTH and FRAGSIZE, plus
settings to
  enable PA_STREAM_ADJUST_LATENCY for input and output device separately.=

- Fix the input delay when first using the input device.

and cannot really be separated, unfortunately.
The third one is really only a consequence of the removal of the
additional audio thread.

And this one:

- Add 1 millisecond timers which interface with the HDA device, pulling
and pushing data
  to and from it, to enable the guest driver to measure DMA timing by
just looking the LPIB registers.

is hda-codec.c.

Hope that helps,

Martin



--sKcMjV0iva56gBPPv0hfl7QvtO9XKERNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEM4fotX71J08TGk1UJzY/2/PwAbQFAlndEi0ACgkQJzY/2/Pw
AbRx2Af/aMBFvkDWGT3iS0ASVdIEnfsAvL41KPMe/ii8moU2MORb4yI3sf8wZzel
K1DOe8p3b1W4YkHgxTemMhE3RJKxAgbixreARQdf1BBwzQqDynL0pg/SPFapi9LH
lwKN/zssNUrN/LqJmjzG5bNSE+QvArKwOuUuwRDT0g/PIP12vLrQfqlG7Ebn9PJk
0+XmbbzfpEArH4NC/9Zm4plixXLPtR39LNdMW7o09s5yLeHzOr2bc8DiirDE0wY0
ZHsWcwU0e3bbxFd/zhhW7iLpkAIAU6TIkXkeGOERpCevtIIDEuwxyamjsaUZvc5C
dW6vXl/GwTXeQkPXCWPqizCILl508Q==
=Sq2N
-----END PGP SIGNATURE-----

--sKcMjV0iva56gBPPv0hfl7QvtO9XKERNQ--

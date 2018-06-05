Received: from eggs.gnu.org ([2001:4830:134:3::10]:57169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAIT-0002S1-Um
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAIQ-0006BA-TQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:38:42 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQAIQ-0006Am-Kq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:38:38 -0400
Received: by mail-wm0-x241.google.com with SMTP id n5-v6so4419592wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:38:38 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:38:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605113834.GB11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-2-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-2-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 1/7] memory,
 exec: Expose all memory block related flags.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:23PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> We need to use these flags in other files rather than just in exec.c,
> For example, RAM_SHARED should be used when create a ram block from file.
> We expose them the exec/memory.h
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> ---
>  exec.c                | 17 -----------------
>  include/exec/memory.h | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)

To other reviewers:
All of include/exec/memory.h is inside #ifndef CONFIG_USER_ONLY so the
ifdef situation hasn't changed (it's hard to tell from the patch
itself).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFnY6AAoJEJykq7OBq3PImAEIAI9nsQ8xnC6KouEm9TavyPvv
7KY685VlRNmpt1ZjLKkzkr0bM5aANA1+QoJLJXvVOCY071F4MRSeSEJdaSUV4vbG
BAGTMtkOBcFRrYCUXqv/sm5PCZ/rCExxo/3EMkwi3qW/I8cRj9LArb08WZbIzMQS
U6s9wLRgg59ZwlIzZpGjHGyUyS5cQzOY8+LnUFu7mA2FgACqlSHhzZI/VIdL65ZH
te2hcAL/XDL4+nsC81S3A3Z5LYnuyHgnFyced/l2X5ipxwbERls1hxk575clJ2yo
9NqjzGvKBwTuEJ0yWr+t/l8rXQeAOHdFim+2rOjB5u0sOBPH3zhs0xTr9ugBDno=
=EnFb
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

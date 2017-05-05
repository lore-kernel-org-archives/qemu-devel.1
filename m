Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6eXG-0005j7-1m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6eXB-00024f-1j
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:48:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6eXA-00022v-SF
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:48:41 -0400
Received: by mail-wm0-x243.google.com with SMTP id u65so1789347wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 07:48:40 -0700 (PDT)
Date: Fri, 5 May 2017 15:48:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505144837.GB14316@stefanha-x1.localdomain>
References: <1493726062-31743-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <1493726062-31743-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Mark legacy option '-no-kvm' as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 01:54:22PM +0200, Thomas Huth wrote:
> '-no-kvm' was just a legacy convenience option for the users of
> qemu-kvm, it never made sense in the normal QEMU tree since TCG is
> the default here anyway. The option has also never been specified
> in the QEMU docs and in the '--help' list, so likely hardly anybody
> knows about this option at all. I think we could get rid of this
> without bothering anybody nowadays, but just in case, let's print
> out a warning for a couple of releases first.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index d5ec87e..2d44621 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3709,7 +3709,9 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>                  break;
> -             case QEMU_OPTION_no_kvm:
> +            case QEMU_OPTION_no_kvm:
> +                error_report("'-no-kvm' is depreacted, please use "

s/depreacted/deprecated/

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJDFAAoJEJykq7OBq3PIToMH/3P9ilUuXGhb7e5fwQz4EMWd
0GJbIJBKIvgzBhz7tF8l34eOXJUIUkW6b2epCPpZCWptznS8s0JHTs+aOQwiankG
SRCgU4LRZCjnAVY9oVe211CfcRTZdQ7WyJWv74JmyFCvYeFBPaxLT/zquIT9QNLK
n72raSpnzmw3CjVEoOmgWVXqNFJhel/PFZfWFtmo21ettTqd1525G93NL+aT4Ix2
ylZc5mfSHuyOgAK+HtD03F63r0ZHcInIZFbw7X29gU2Z3bVpSewlmEgGRpJuRkM8
SMxyt4Cf2e/fPtOvpTERFHTsLY6W+6yIBuhfbfx5hZnzjXq9fOagky3bBJh9Cas=
=nALo
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

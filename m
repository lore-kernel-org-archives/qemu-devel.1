Received: from eggs.gnu.org ([2001:4830:134:3::10]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fctSU-0001xN-IN
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fctST-0004no-Ix
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:17:38 -0400
Date: Tue, 10 Jul 2018 15:17:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180710141728.GD30635@stefanha-x1.localdomain>
References: <1530674247-31200-1-git-send-email-baiyaowei@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <1530674247-31200-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH v2] tracing: Use double-dash spelling for
 trace option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, stefanha@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, cota@braap.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 11:17:27AM +0800, Yaowei Bai wrote:
> The '-trace' and '--trace' spellings are only both supported in qemu
> binary, while for qemu-nbd or qemu-img only '--trace' spelling is
> supported. So for the consistency of trace option invocation, we
> should use double-dash spelling in our documentation.
>=20
> This's also mentioned in
> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documenta=
tion
> .
>=20
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/devel/tracing.txt | 6 +++---
>  trace/control.c        | 4 ++--
>  trace/control.h        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRL/4AAoJEJykq7OBq3PImI0H/i3az246Z4UI/B4yb8K+AknT
kgNqehTmczemTqjxMVGQkVe/IuWhyGuin2PSe+8zKqHHnMYbtBJw0LMuiSN4qNDA
clgoH7twVodIYmBsd+vlX0vwE4LWKfR50JKz6LpP4IcPnSLdIap7bffKcwQYmx8m
fTmGTKalS8o8IfkGAqQktwVtCKD6inQjSiYZVyf4GgEkMOn9FbtPzfBczbLLF/mE
HaQCP7wICdhXhphehF/EwNU63Cg1T3TzziIn7e/l6G7PiRuN0Bw4qpbNDqOeOHk2
EinpjihNbwOryWnVpTbHUphvd28qiaUcVxvYkAiGNio4Z3FIyj+xf2gE0fxlF08=
=Gs67
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

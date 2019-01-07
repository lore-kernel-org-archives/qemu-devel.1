Received: from eggs.gnu.org ([209.51.188.92]:57711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfR-00071H-1W
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfO-0003D5-Vg
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:32 -0500
Date: Mon, 7 Jan 2019 11:40:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107004033.GB13339@umbus.fritz.box>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20190104181208.7809-3-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] util/cutils: Move ctype macros to
 "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 07:12:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Introduced in cd390083ad1, these macros don't need to be in
> a generic header.
> Add documentation to justify their use.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2: Fixed checkpatch warnings (tabs)
> ---
>  hw/core/bus.c              |  2 +-
>  hw/core/qdev-properties.c  |  1 +
>  hw/s390x/s390-virtio-ccw.c |  1 +
>  hw/scsi/scsi-generic.c     |  2 +-
>  include/qemu-common.h      | 16 ----------------
>  include/qemu/cutils.h      | 25 +++++++++++++++++++++++++
>  qapi/qapi-util.c           |  2 +-
>  qobject/json-parser.c      |  1 -
>  target/ppc/monitor.c       |  1 +
>  ui/keymaps.c               |  1 +
>  util/id.c                  |  2 +-
>  util/readline.c            |  1 -
>  12 files changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 4651f24486..dceb144075 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -18,7 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
> +#include "qemu/cutils.h"
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
> =20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 943dc2654b..3bdebac361 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "net/net.h"
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fd9d0b0542..ed23bb7b3a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/boards.h"
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 7237b4162e..86f65fd474 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -12,8 +12,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "hw/scsi/scsi.h"
>  #include "hw/scsi/emulation.h"
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 760527294f..ed43ae286d 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -33,22 +33,6 @@ int qemu_main(int argc, char **argv, char **envp);
>  void qemu_get_timedate(struct tm *tm, int offset);
>  int qemu_timedate_diff(struct tm *tm);
> =20
> -#define qemu_isalnum(c)		isalnum((unsigned char)(c))
> -#define qemu_isalpha(c)		isalpha((unsigned char)(c))
> -#define qemu_iscntrl(c)		iscntrl((unsigned char)(c))
> -#define qemu_isdigit(c)		isdigit((unsigned char)(c))
> -#define qemu_isgraph(c)		isgraph((unsigned char)(c))
> -#define qemu_islower(c)		islower((unsigned char)(c))
> -#define qemu_isprint(c)		isprint((unsigned char)(c))
> -#define qemu_ispunct(c)		ispunct((unsigned char)(c))
> -#define qemu_isspace(c)		isspace((unsigned char)(c))
> -#define qemu_isupper(c)		isupper((unsigned char)(c))
> -#define qemu_isxdigit(c)	isxdigit((unsigned char)(c))
> -#define qemu_tolower(c)		tolower((unsigned char)(c))
> -#define qemu_toupper(c)		toupper((unsigned char)(c))
> -#define qemu_isascii(c)		isascii((unsigned char)(c))
> -#define qemu_toascii(c)		toascii((unsigned char)(c))
> -
>  void *qemu_oom_check(void *ptr);
> =20
>  ssize_t qemu_write_full(int fd, const void *buf, size_t count)
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 9ee40470e3..644f2d75bd 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -3,6 +3,31 @@
> =20
>  #include "qemu/fprintf-fn.h"
> =20
> +/**
> + * unsigned ctype macros:
> + *
> + * The standards require that the argument for these functions
> + * is either EOF or a value that is representable in the type
> + * unsigned char. If the argument is of type char, it must be
> + * cast to unsigned char. This is what these macros do,
> + * avoiding 'signed to unsigned' conversion warnings.
> + */
> +#define qemu_isalnum(c)     isalnum((unsigned char)(c))
> +#define qemu_isalpha(c)     isalpha((unsigned char)(c))
> +#define qemu_iscntrl(c)     iscntrl((unsigned char)(c))
> +#define qemu_isdigit(c)     isdigit((unsigned char)(c))
> +#define qemu_isgraph(c)     isgraph((unsigned char)(c))
> +#define qemu_islower(c)     islower((unsigned char)(c))
> +#define qemu_isprint(c)     isprint((unsigned char)(c))
> +#define qemu_ispunct(c)     ispunct((unsigned char)(c))
> +#define qemu_isspace(c)     isspace((unsigned char)(c))
> +#define qemu_isupper(c)     isupper((unsigned char)(c))
> +#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
> +#define qemu_tolower(c)     tolower((unsigned char)(c))
> +#define qemu_toupper(c)     toupper((unsigned char)(c))
> +#define qemu_isascii(c)     isascii((unsigned char)(c))
> +#define qemu_toascii(c)     toascii((unsigned char)(c))
> +
>  /**
>   * pstrcpy:
>   * @buf: buffer to copy string into
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index e9b266bb70..ea93ae05d9 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -11,8 +11,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
> =20
>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>  {
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7a7ae9e8d1..06316f3a53 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -15,7 +15,6 @@
>  #include "qemu/cutils.h"
>  #include "qemu/unicode.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 14915119fc..dbcb921231 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 085889b555..00b52a6db3 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "keymaps.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> diff --git a/util/id.c b/util/id.c
> index 6141352955..ca21a77522 100644
> --- a/util/id.c
> +++ b/util/id.c
> @@ -11,7 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
> +#include "qemu/cutils.h"
>  #include "qemu/id.h"
> =20
>  bool id_wellformed(const char *id)
> diff --git a/util/readline.c b/util/readline.c
> index ec91ee0fea..f3d8b0698a 100644
> --- a/util/readline.c
> +++ b/util/readline.c
> @@ -23,7 +23,6 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
>  #include "qemu/readline.h"
>  #include "qemu/cutils.h"
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwyoAEACgkQbDjKyiDZ
s5JD2hAAq5gXdQ32rftSeQiKRxvqTNcWp/uu6ZUOsI/bwKz4DOvb+lp+qCFOL+hv
naIaM44X7KtlsmHpjaxfg8kzXX0E/IuZFEF7q2IY98Pw6B0pf4PXDTs/v8k/Dx9v
+cZdvAA+3ThaBqKWBzeHueUKiK0XfQJqxZ+UQbxZIjwK1sMdFg1YEcOYbcdJiHD3
7tNagdhvbIXFgngj/Zz9psp7s4BD/GGVdKpkKw+rJKpvf4OOFudr06RFfyF7J674
9ztAqx11Yq+cC7TxHmeMa4pFQ4Tot2mTszXR3mLH1xK/Ehb6FWK/qRfJfzn6qIRK
QChTZ9FUsXF3QTWD3TxhIgi+XD2JYErOzYNkoT3+5VHVU5v0iaSiIrfwgMDxJky1
fV/wDzQELrBU+Y5wZYxhyPWLI31UIqGJr6RIQ/rU6B4h446Mn5A2Wbf/PAblkvQG
DDt8/QdR6MQG9TY4xYYLWBHA9RQuWuo88Rp/9u9ORLm3LuKtAAzqahGPlY255IaS
oDVY4o5o2PyAdnfMfE1z818MkJ+XmwBtvwuprLxLAwN3FX5Wvc9+rS3vKYn6BZHl
Ufh2mtw9HuPLwnserrEyux2P3mawMWMmjjGSAHQsTovlUfv89TBRd6NeOTXivPLG
N0DlidiM2FMg+sNfBHxbecLU3boHxzjJYiIWn2qNjRvSof0V/ak=
=jZIl
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

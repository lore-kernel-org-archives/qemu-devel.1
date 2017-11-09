Received: from eggs.gnu.org ([2001:4830:134:3::10]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnyl-0002wB-0D
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnyj-0001B4-1m
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:38:51 -0500
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cce9ff0-1c9f-548f-77af-d0c2f5ab4d94@redhat.com>
Date: Thu, 9 Nov 2017 08:38:23 -0600
MIME-Version: 1.0
In-Reply-To: <da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TXI8vm20tSJkk6pA7inasMsMNKtCiM38i"
Subject: Re: [Qemu-devel] [PATCH v4 04/45] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, alistair23@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TXI8vm20tSJkk6pA7inasMsMNKtCiM38i
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 alistair23@gmail.com
Message-ID: <8cce9ff0-1c9f-548f-77af-d0c2f5ab4d94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/45] tests: Replace fprintf(stderr,
 "*\n" with error_report()
References: <cover.1510181732.git.alistair.francis@xilinx.com>
 <da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 04:56 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then=

> compiler issues where manually fixed.

s/where/were/


>=20
> Some of the error_report()'s were manually kept as fprintf(stderr, ) to=

> maintain standalone test cases.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
> V2:
>  - Keep some of the fprintf() calls
>  - Remove a file I accidently checked in
>=20

> +++ b/tests/ahci-test.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include <getopt.h>
> =20
>  #include "libqtest.h"
> @@ -1859,7 +1860,7 @@ int main(int argc, char **argv)
>              ahci_pedantic =3D 1;
>              break;
>          default:
> -            fprintf(stderr, "Unrecognized ahci_test option.\n");
> +            error_report("Unrecognized ahci_test option.");

Most of our error_report() calls do not include trailing dot.

> +++ b/tests/bios-tables-test.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include <glib/gstdio.h>
>  #include "qemu-common.h"
>  #include "hw/smbios/smbios.h"
> @@ -396,7 +397,7 @@ try_again:
>          aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->m=
achine,
>                                     (gchar *)&signature, ext);
>          if (getenv("V")) {
> -            fprintf(stderr, "\nLooking for expected file '%s'\n", aml_=
file);
> +            error_report("Looking for expected file '%s'", aml_file);

Here, it looks like this is a debug statement, gated by whether $V is
set in the environment; it's not really an error.

>          }
>          if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
>              exp_sdt.aml_file =3D aml_file;
> @@ -408,7 +409,7 @@ try_again:
>          }
>          g_assert(exp_sdt.aml_file);
>          if (getenv("V")) {
> -            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);=

> +            error_report("Using expected file '%s'", aml_file);
>          }

Ditto.

> +++ b/tests/i440fx-test.c
> @@ -13,7 +13,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>  #include "libqtest.h"
>  #include "libqos/pci.h"
>  #include "libqos/pci-pc.h"
> @@ -295,18 +295,18 @@ static char *create_blob_file(void)
>      ret =3D -1;
>      fd =3D g_file_open_tmp("blob_XXXXXX", &pathname, &error);
>      if (fd =3D=3D -1) {
> -        fprintf(stderr, "unable to create blob file: %s\n", error->mes=
sage);
> +        error_report("unable to create blob file: %s", error->message)=
;
>          g_error_free(error);

A candidate for
 error_reportf_err(error, "unable to create blob file: ");

> +++ b/tests/libqos/ahci.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>  #include "libqtest.h"
>  #include "libqos/ahci.h"
>  #include "libqos/pci-pc.h"
> @@ -985,9 +985,9 @@ static void ahci_atapi_command_set_offset(AHCIComma=
nd *cmd, uint64_t lba)
>      default:
>          /* SCSI doesn't have uniform packet formats,
>           * so you have to add support for it manually. Sorry! */
> -        fprintf(stderr, "The Libqos AHCI driver does not support the "=

> +        error_report("The Libqos AHCI driver does not support the "
>                  "set_offset operation for ATAPI command 0x%02x, "
> -                "please add support.\n",
> +                "please add support.",

Trailing dot is unusual.

>                  cbd[0]);
>          g_assert_not_reached();
>      }
> @@ -1060,8 +1060,8 @@ static void ahci_atapi_set_size(AHCICommand *cmd,=
 uint64_t xbytes)
>      default:
>          /* SCSI doesn't have uniform packet formats,
>           * so you have to add support for it manually. Sorry! */
> -        fprintf(stderr, "The Libqos AHCI driver does not support the s=
et_size "
> -                "operation for ATAPI command 0x%02x, please add suppor=
t.\n",
> +        error_report("The Libqos AHCI driver does not support the set_=
size "
> +                "operation for ATAPI command 0x%02x, please add suppor=
t.",

Again

> +++ b/tests/libqos/libqos.c

> @@ -199,7 +200,7 @@ void mkimg(const char *file, const char *fmt, unsig=
ned size_mb)
>                            fmt, file, size_mb);
>      ret =3D g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
>      if (err) {
> -        fprintf(stderr, "%s\n", err->message);
> +        error_report("%s", err->message);
>          g_error_free(err);

Candidate for error_report_err()

> +++ b/tests/libqos/malloc.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "libqos/malloc.h"
>  #include "qemu-common.h"
>  #include "qemu/host-utils.h"
> @@ -193,7 +194,7 @@ static uint64_t mlist_alloc(QGuestAllocator *s, uin=
t64_t size)
> =20
>      node =3D mlist_find_space(s->free, size);
>      if (!node) {
> -        fprintf(stderr, "Out of guest memory.\n");
> +        error_report("Out of guest memory.");

trailing dot

>          g_assert_not_reached();
>      }
>      return mlist_fulfill(s, node, size);
> @@ -209,8 +210,8 @@ static void mlist_free(QGuestAllocator *s, uint64_t=
 addr)
> =20
>      node =3D mlist_find_key(s->used, addr);
>      if (!node) {
> -        fprintf(stderr, "Error: no record found for an allocation at "=

> -                "0x%016" PRIx64 ".\n",
> +        error_report("Error: no record found for an allocation at "
> +                "0x%016" PRIx64 ".",

Again. I'll quit pointing these out.

> +++ b/tests/migration-test.c

> @@ -334,9 +334,9 @@ static void check_guests_ram(QTestState *who)
>                   */
>                  hit_edge =3D true;
>              } else {
> -                fprintf(stderr, "Memory content inconsistency at %x"
> +                error_report("Memory content inconsistency at %x"
>                                  " first_byte =3D %x last_byte =3D %x c=
urrent =3D %x"
> -                                " hit_edge =3D %x\n",
> +                                " hit_edge =3D %x",

Indentation is now off.

>                                  address, first_byte, last_byte, b, hit=
_edge);
>                  bad =3D true;
>              }
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index cf8ce8b16d..49e1ff4555 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -47,7 +47,7 @@ static __attribute__((noreturn)) void exit_failure(vo=
id)
>      if (getpid() =3D=3D 1) {
>          sync();
>          reboot(RB_POWER_OFF);
> -        fprintf(stderr, "%s (%05d): ERROR: cannot reboot: %s\n",
> +        error_report("%s (%05d): cannot reboot: %s",
>                  argv0, gettid(), strerror(errno));

Indentation is now off.

>          abort();
>      } else {
> @@ -60,7 +60,7 @@ static __attribute__((noreturn)) void exit_success(vo=
id)
>      if (getpid() =3D=3D 1) {
>          sync();
>          reboot(RB_POWER_OFF);
> -        fprintf(stderr, "%s (%05d): ERROR: cannot reboot: %s\n",
> +        error_report("%s (%05d): cannot reboot: %s",
>                  argv0, gettid(), strerror(errno));

And again. I'll quit pointing it out.

> +++ b/tests/rcutorture.c
> @@ -61,6 +61,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu/atomic.h"
>  #include "qemu/rcu.h"
>  #include "qemu/thread.h"
> @@ -86,7 +87,7 @@ static int n_threads;
>  static void create_thread(void *(*func)(void *))
>  {
>      if (n_threads >=3D NR_THREADS) {
> -        fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);=

> +        error_report("Thread limit of %d exceeded!", NR_THREADS);

Trailing ! is shouting at the user; it's even less appropriate than
trailing dot.

>          exit(-1);
>      }
>      qemu_thread_create(&threads[n_threads], "test", func, &data[n_thre=
ads],
> @@ -417,7 +418,7 @@ static void gtest_stress_10_5(void)
> =20
>  static void usage(int argc, char *argv[])
>  {
> -    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[=
0]);
> +    error_report("Usage: %s [nreaders [ perf | stress ] ]", argv[0]);
>      exit(-1);

Separate patch - but 'exit(-1)' is almost always wrong (it gives status
255 through wait()/waitpid(); meanwhile waitid() is required by POSIX to
get at the full 32-bit value except that Linux doesn't obey that
requirement).  A process where wait() returns 255 makes xargs behave
differently.  We really want exit(1).

> +++ b/tests/tcg/linux-test.c
> @@ -51,7 +51,7 @@ void error1(const char *filename, int line, const cha=
r *fmt, ...)
>      va_start(ap, fmt);
>      fprintf(stderr, "%s:%d: ", filename, line);
>      vfprintf(stderr, fmt, ap);
> -    fprintf(stderr, "\n");
> +    error_report("");

Umm, a blank line is not a useful error.  This hunk is bogus; we
probably want to stick with fprintf() for the entire message.

> +++ b/tests/tcg/test_path.c
> @@ -150,8 +150,8 @@ int main(int argc, char *argv[])
>      ret =3D do_test();
>      cleanup();
>      if (ret) {
> -	fprintf(stderr, "test_path: failed on line %i\n", ret);
> -	return 1;
> +        error_report("test_path: failed on line %i", ret);
> +        return 1;

Yay for fixing TAB damage along the way.

> +++ b/tests/test-hmp.c
> @@ -15,6 +15,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "libqtest.h"
> =20
>  static int verbose;
> @@ -79,7 +80,7 @@ static void test_commands(void)
> =20
>      for (i =3D 0; hmp_cmds[i] !=3D NULL; i++) {
>          if (verbose) {
> -            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
> +            error_report("\t%s", hmp_cmds[i]);

Verbose messages aren't really errors.  I don't think you want this hunk.=


>          }
>          response =3D hmp("%s", hmp_cmds[i]);
>          g_free(response);
> @@ -102,7 +103,7 @@ static void test_info_commands(void)
>          *endp =3D '\0';
>          /* Now run the info command */
>          if (verbose) {
> -            fprintf(stderr, "\t%s\n", info);
> +            error_report("\t%s", info);

Likewise.

> +++ b/tests/test-rcu-list.c
> @@ -21,6 +21,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu/atomic.h"
>  #include "qemu/rcu.h"
>  #include "qemu/thread.h"
> @@ -64,7 +65,7 @@ static int select_random_el(int max)
>  static void create_thread(void *(*func)(void *))
>  {
>      if (n_threads >=3D NR_THREADS) {
> -        fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);=

> +        error_report("Thread limit of %d exceeded!", NR_THREADS);
>          exit(-1);

Another !, another exit(-1)

> +++ b/tests/usb-hcd-ehci-test.c
> @@ -42,7 +42,7 @@ static void ehci_port_test(struct qhc *hc, int port, =
uint32_t expect)
>      uint16_t mask =3D ~(PORTSC_CSC | PORTSC_PEDC | PORTSC_OCC);
> =20
>  #if 0
> -    fprintf(stderr, "%s: %d, have 0x%08x, want 0x%08x\n",
> +    error_report("%s: %d, have 0x%08x, want 0x%08x",
>              __func__, port, value & mask, expect & mask);
>  #endif

I'd just nuke the #if 0 block entirely, as it is likely to bit-rot
(separate patch, though).

> +++ b/tests/vhost-user-bridge.c

> @@ -714,15 +714,15 @@ main(int argc, char *argv[])
>      return 0;
> =20
>  out:
> -    fprintf(stderr, "Usage: %s ", argv[0]);
> -    fprintf(stderr, "[-c] [-u ud_socket_path] [-l lhost:lport] [-r rho=
st:rport]\n");
> -    fprintf(stderr, "\t-u path to unix doman socket. default: %s\n",
> +    error_report("Usage: %s ", argv[0]);
> +    error_report("[-c] [-u ud_socket_path] [-l lhost:lport] [-r rhost:=
rport]");
> +    error_report("\t-u path to unix doman socket. default: %s",
>              DEFAULT_UD_SOCKET);
> -    fprintf(stderr, "\t-l local host and port. default: %s:%s\n",
> +    fprintf(stderr, "\t-l local host and port. default: %s:%s",
>              DEFAULT_LHOST, DEFAULT_LPORT);
> -    fprintf(stderr, "\t-r remote host and port. default: %s:%s\n",
> +    error_report("\t-r remote host and port. default: %s:%s",
>              DEFAULT_RHOST, DEFAULT_RPORT);
> -    fprintf(stderr, "\t-c client mode\n");
> +    error_report("\t-c client mode");

Is usage text really an error?

> =20
>      return 1;
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TXI8vm20tSJkk6pA7inasMsMNKtCiM38i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEaF8ACgkQp6FrSiUn
Q2rL6Qf/TYyi17Yrj+XRdGaTVUc2/QXlvzbwD7mg7k70zR+KfxqVfc7jOJZ1bar1
sQ3A7nsb8nDBzQoSq+AMGh0VG3dOskp/Uy3n7QLy1UEaBq8K9G774Rg31SX0L+Po
VluEy6AYeImazZRINxyasfbnj+XNdDjpns6qGtkJgxmm9t5CCBbAEbgW/2LqNtHz
ziLZt8ZRkxvOPj9+Mb3mDE+shMM/OP5+77GaD9OZADywbhzQxjFbw92PXisyDX4u
vfXmTnsib65SEnL0UhSt6Y7LlsOhsXQEcGsl3NN4XglIRldEpkykZ8qUVpDEjcFd
jH0oUsHmoVFwtwUjhL+ujeiAhLLqNg==
=Ugj1
-----END PGP SIGNATURE-----

--TXI8vm20tSJkk6pA7inasMsMNKtCiM38i--

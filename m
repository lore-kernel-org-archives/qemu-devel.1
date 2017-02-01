Received: from eggs.gnu.org ([2001:4830:134:3::10]:44206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBN-0003xP-3v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBK-0007Uc-2H
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:57 -0500
Date: Wed, 1 Feb 2017 11:08:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201000817.GO14879@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keoAwTxaagou87Dg"
Content-Disposition: inline
In-Reply-To: <1485868319-16151-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--keoAwTxaagou87Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> When running with KVM on POWER, we register some CPU types during
> the initialization function of the ppc64 KVM code (which unfortunately
> also can not be done via a type_init() like it is done on x86). So to
> be able to see these updates in the CPU help text, the code that calls
> list_cpus() has to be run after configure_accelerator(). This move should
> be fine since the "cpu_model" variable is also never used before the call
> to configure_accelerator(), and thus there should not be any unwanted
> side effects in the code before configure_accelerator() if the user
> started QEMU with "-cpu ?" or "-cpu help".
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This looks fine to me, but it's not within my area to apply.  Paolo,
if you want to ack I'm happy to take it through my tree if that's
convenient for you.

> ---
>  vl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 0b72b12..315c5c3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
>          qemu_set_hw_version(machine_class->hw_version);
>      }
> =20
> -    if (cpu_model && is_help_option(cpu_model)) {
> -        list_cpus(stdout, &fprintf, cpu_model);
> -        exit(0);
> -    }
> -
>      if (!trace_init_backends()) {
>          exit(1);
>      }
> @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
> =20
>      configure_accelerator(current_machine);
> =20
> +    if (cpu_model && is_help_option(cpu_model)) {
> +        list_cpus(stdout, &fprintf, cpu_model);
> +        exit(0);
> +    }
> +
>      if (qtest_chrdev) {
>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--keoAwTxaagou87Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkSbvAAoJEGw4ysog2bOSA9EQALa3RD6dMc3mxRXzpHdYYLAr
4eFVvvnSrP4sQN2x80qyHZQAb9xF7xpWdQ3nMxjagSyNAq6woqBhUFnG89dYsTc7
A2P4XvSTgHd6UpJTAzcaj5g9qHlwhfuAAFuvwcDlo3eo3oIXjp1mjXstVzqSDCVE
wLI7Ow7zPlXA7Pkik83XAs3FUKbt4Kq6nNqrYGc+dfWo2Z665p8vVK+70WIElbj6
wrOlENQqogBJIDf8axYGvHwguN6S+C2RwYuXl74VSkJPHvUFO3w8O9BvFWdeHYXk
h+ZBrs4I6OgngqURfcRrFWMo97x3Dusd3gVocZQcUC56lgokQtLZyU3yJSfETbu7
VAf2qcOBDGT+VmxJU4aNC2TNEIgVO757e5wV7zVnlC9HccniSLGJ1BNH4lfD3MJb
/CStHLFT6pIP+NX0GG146n+CMek8731HFjo3K+OGd60CPY3QKF8grE0HkIZ/qtDA
xNgrmPez/j8bBXxJ/KRzYiLYcGKwNRMgWL4/F+Wsu6XyXHCcIXD/FNvm2g/c4SpS
PBRk2ubONM76WHI61WmYHqCAw0VESRTg0ZCeR6JryEi2kYjVcXRRRK+IiZMouvfD
vJRCJP4qkn4Y2Z5yebISZbIqo2uwzUnxruJ6iBdx5adquCwEhiKqWu+emrNmt+PI
6WSVed/lBuk1de30s179
=unOD
-----END PGP SIGNATURE-----

--keoAwTxaagou87Dg--

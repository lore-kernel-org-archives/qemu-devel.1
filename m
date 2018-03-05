Received: from eggs.gnu.org ([2001:4830:134:3::10]:54955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1espFD-0006Oj-4M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1espFA-0006eH-17
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:29:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1espF9-0006du-TM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:29:27 -0500
Date: Mon, 5 Mar 2018 13:29:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180305132915.4dacc461@redhat.com>
In-Reply-To: <20180215042900.16078-9-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-9-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/30] hw/i386: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Thu, 15 Feb 2018 01:28:38 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It ease code review, unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
[...]

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index deb440f286..9ccc6192b5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2320,8 +2320,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
>  }
> =20
> -#define HOLE_640K_START  (640 * 1024)
> -#define HOLE_640K_END   (1024 * 1024)
> +#define HOLE_640K_START  (640 * K_BYTE)
> +#define HOLE_640K_END   (1024 * K_BYTE)
nit:
could be 1 * M_BYTE

[...]

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ6r2-0005q9-0g
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ6qx-0007fZ-CH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gQ6qx-0007eQ-5H
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:30:19 -0500
Date: Fri, 23 Nov 2018 09:30:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181123093002.589a7391@redhat.com>
In-Reply-To: <20181123055831.28003-1-philmd@redhat.com>
References: <20181123055831.28003-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix ACPI tests data files path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Fri, 23 Nov 2018 06:58:31 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Missed while moving those files in 438c78dab75.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..6c4f25fb05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1216,8 +1216,7 @@ F: hw/i386/acpi-build.[hc]
>  F: hw/arm/virt-acpi-build.c
>  F: tests/bios-tables-test.c
>  F: tests/acpi-utils.[hc]
> -F: tests/acpi-test-data/*
> -F: tests/acpi-test-data/*/*
> +F: tests/data/acpi/
> =20
>  ppc4xx
>  M: David Gibson <david@gibson.dropbear.id.au>

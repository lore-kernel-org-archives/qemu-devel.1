Received: from eggs.gnu.org ([209.51.188.92]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1z2h-000145-W5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1z2h-0002Kt-7u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:50:59 -0500
References: <20190307145839.13128-1-philmd@redhat.com>
	<20190307145839.13128-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27fba8af-670c-e425-54f4-620019466f58@redhat.com>
Date: Thu, 7 Mar 2019 20:50:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190307145839.13128-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] tests/bios-tables: Improve
 portability by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>

On 07/03/2019 15.58, Philippe Mathieu-Daud=C3=A9 wrote:
> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
>=20
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/=
rebuild-expected-aml.sh
> index bf9ba242ad..abdff70a0d 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -1,4 +1,4 @@
> -#! /bin/bash
> +#!/usr/bin/env bash
> =20
>  #
>  # Rebuild expected AML files for acpi unit-test
>=20

In case Kevin wants to pick this up, too:

Acked-by: Thomas Huth <thuth@redhat.com>

Otherwise, I can take this one also through the qtest tree.

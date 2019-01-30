Received: from eggs.gnu.org ([209.51.188.92]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1golGz-0000rv-Ub
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1golGy-00053W-8z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:31:05 -0500
Date: Wed, 30 Jan 2019 09:30:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190130093038.60b10743@Igors-MacBook-Pro.local>
In-Reply-To: <20190129175403.18017-9-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/18] tests/bios-tables: Improve
 portability by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex =?UTF-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 29 Jan 2019 18:53:53 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/re=
build-expected-aml.sh
> index bf9ba242ad..ff77a751c8 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -1,4 +1,4 @@
> -#! /bin/bash
> +#! /usr/bin/env bash
> =20
>  #
>  # Rebuild expected AML files for acpi unit-test

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIE7Z-00058A-8I
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIDvb-0007Ks-QM
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:26:35 -0400
References: <20181030001841.1658-1-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcf1457b-8f0c-3d02-cb40-529eddb19316@redhat.com>
Date: Thu, 1 Nov 2018 09:26:00 -0500
MIME-Version: 1.0
In-Reply-To: <20181030001841.1658-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/bios-tables-test: Sanitize test
 verbose output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/29/18 7:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix the extraneous extra blank lines in the test output when running wi=
th V=3D1.
>=20

> +++ b/tests/bios-tables-test.c
> @@ -371,6 +371,9 @@ static GArray *load_expected_aml(test_data *data)
>       gboolean ret;
>  =20
>       GArray *exp_tables =3D g_array_new(false, true, sizeof(AcpiSdtTab=
le));
> +    if (getenv("V")) {
> +        fputc('\n', stderr);
> +    }

Umm, this prints a blank line even if I run 'make check V=3D0' - do we=20
support V=3D0 as a way to disable verbosity, in which case you need to=20
actually inspect the contents of $V rather than just assuming that if it=20
is in the environment things are verbose?

> @@ -397,7 +400,7 @@ try_again:
>           }
>           g_assert(exp_sdt.aml_file);
>           if (getenv("V")) {
> -            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
> +            fprintf(stderr, "Using expected file '%s'\n", aml_file);

But that's a pre-existing question, so it doesn't affect this particular=20
patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

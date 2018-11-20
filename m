Received: from eggs.gnu.org ([2001:4830:134:3::10]:38439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP82V-0008J9-Lx
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP82U-0002Rd-5V
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:34:11 -0500
Date: Tue, 20 Nov 2018 16:33:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181120163329.6c960628@redhat.com>
In-Reply-To: <20181107123652.23417-2-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 01/14] tests:
 qdev_prop_check_globals() doesn't return "all_used"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed,  7 Nov 2018 16:36:39 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Instead, it returns 1 if an error was detected, which is the case for:
>=20
> /qdev/properties/dynamic/global/subprocess:
> warning: global dynamic-prop-type-bad.prop3 has invalid class name
> warning: global nohotplug-type.prop5=3D105 not used
> warning: global nondevice-type.prop6 has invalid class name
>=20
> Clarify the function return value.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/test-qdev-global-props.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
> index d81b0862d5..ccdf6c57c1 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c
> @@ -214,7 +214,7 @@ static void test_dynamic_globalprop_subprocess(void)
>          { TYPE_NONDEVICE, "prop6", "106", true },
>          {}
>      };
> -    int all_used;
> +    int global_error;
> =20
>      qdev_prop_register_global_list(props);
> =20
> @@ -223,8 +223,8 @@ static void test_dynamic_globalprop_subprocess(void)
> =20
>      g_assert_cmpuint(mt->prop1, =3D=3D, 101);
>      g_assert_cmpuint(mt->prop2, =3D=3D, 102);
> -    all_used =3D qdev_prop_check_globals();
> -    g_assert_cmpuint(all_used, =3D=3D, 1);
> +    global_error =3D qdev_prop_check_globals();
> +    g_assert_cmpuint(global_error, =3D=3D, 1);
>      g_assert(props[0].used);
>      g_assert(props[1].used);
>      g_assert(!props[2].used);
> @@ -259,7 +259,7 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
>          { TYPE_NONDEVICE, "prop6", "106" },
>          {}
>      };
> -    int all_used;
> +    int global_error;
> =20
>      qdev_prop_register_global_list(props);
> =20
> @@ -268,8 +268,8 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
> =20
>      g_assert_cmpuint(mt->prop1, =3D=3D, 101);
>      g_assert_cmpuint(mt->prop2, =3D=3D, 102);
> -    all_used =3D qdev_prop_check_globals();
> -    g_assert_cmpuint(all_used, =3D=3D, 0);
> +    global_error =3D qdev_prop_check_globals();
> +    g_assert_cmpuint(global_error, =3D=3D, 0);
>      g_assert(props[0].used);
>      g_assert(props[1].used);
>      g_assert(!props[2].used);

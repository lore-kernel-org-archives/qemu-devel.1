Received: from eggs.gnu.org ([2001:4830:134:3::10]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRcvr-0003DU-Cw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRcvm-0008TZ-IU
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:48:35 -0500
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
	<20161212173151.18092-3-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1f3b7ccb-19fd-c3df-0a67-fc554c55e05a@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:48:28 +0300
MIME-Version: 1.0
In-Reply-To: <20161212173151.18092-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] object: make some funcs static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

12.12.2016 20:31, Marc-Andr=C3=A9 Lureau wrote:
> There is no need to have those functions as public API.

Were "some" being object_initialize_with_type() and
object_new_with_type().

I'm applying this to -trivial, and Cc'ing Andreas, maybe
he will say more.

Thanks,

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object.c         |  4 ++--
>  include/qom/object.h | 24 ------------------------
>  2 files changed, 2 insertions(+), 26 deletions(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 7a05e35ed9..eb3d0f64e4 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -351,7 +351,7 @@ static void object_post_init_with_type(Object *obj,=
 TypeImpl *ti)
>      }
>  }
> =20
> -void object_initialize_with_type(void *data, size_t size, TypeImpl *ty=
pe)
> +static void object_initialize_with_type(void *data, size_t size, TypeI=
mpl *type)
>  {
>      Object *obj =3D data;
> =20
> @@ -467,7 +467,7 @@ static void object_finalize(void *data)
>      }
>  }
> =20
> -Object *object_new_with_type(Type type)
> +static Object *object_new_with_type(Type type)
>  {
>      Object *obj;
> =20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index c5456db05d..e9791a210e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -586,18 +586,6 @@ struct InterfaceClass
>   */
>  Object *object_new(const char *typename);
> =20
> -/**
> - * object_new_with_type:
> - * @type: The type of the object to instantiate.
> - *
> - * This function will initialize a new object using heap allocated mem=
ory.
> - * The returned object has a reference count of 1, and will be freed w=
hen
> - * the last reference is dropped.
> - *
> - * Returns: The newly allocated and instantiated object.
> - */
> -Object *object_new_with_type(Type type);
> -
>  /**
>   * object_new_with_props:
>   * @typename:  The name of the type of the object to instantiate.
> @@ -726,18 +714,6 @@ int object_set_propv(Object *obj,
>                       Error **errp,
>                       va_list vargs);
> =20
> -/**
> - * object_initialize_with_type:
> - * @data: A pointer to the memory to be used for the object.
> - * @size: The maximum size available at @data for the object.
> - * @type: The type of the object to instantiate.
> - *
> - * This function will initialize an object.  The memory for the object=
 should
> - * have already been allocated.  The returned object has a reference c=
ount of 1,
> - * and will be finalized when the last reference is dropped.
> - */
> -void object_initialize_with_type(void *data, size_t size, Type type);
> -
>  /**
>   * object_initialize:
>   * @obj: A pointer to the memory to be used for the object.
>=20

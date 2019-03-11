Received: from eggs.gnu.org ([209.51.188.92]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3OTe-00041O-Ik
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3OPb-0004OU-Bg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:08:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h3OPb-0004Lo-3P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:08:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id g20so5053746wmh.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190311083234.20841-1-richardw.yang@linux.intel.com>
In-Reply-To: <20190311083234.20841-1-richardw.yang@linux.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Mar 2019 18:08:10 +0100
Message-ID: <CAJ+F1CJrUawSKzcCg4yOh8A+Fn0gQXqDtq1Tw14g7jEBBLOZHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom: use object_new_with_type in
 object_new_with_propv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi

On Mon, Mar 11, 2019 at 9:34 AM Wei Yang <richardw.yang@linux.intel.com> wr=
ote:
>
> Function object_new_with_propv already get the Type of the object, so we
> could leverage object_new_with_type here.
>
> [make check test pass]
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 05a8567041..76d2f1eb2f 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -640,7 +640,7 @@ Object *object_new_with_propv(const char *typename,
>          error_setg(errp, "object type '%s' is abstract", typename);
>          return NULL;
>      }
> -    obj =3D object_new(typename);
> +    obj =3D object_new_with_type(klass->type);
>
>      if (object_set_propv(obj, &local_err, vargs) < 0) {
>          goto error;
> --
> 2.19.1
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

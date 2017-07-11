Received: from eggs.gnu.org ([2001:4830:134:3::10]:57971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUyIr-0007tL-5a
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUyIq-0005hB-B4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:46:25 -0400
Date: Tue, 11 Jul 2017 12:46:16 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1803793100.49591678.1499791576069.JavaMail.zimbra@redhat.com>
In-Reply-To: <1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev-properties.h: Explicitly set the
 default value for arraylen properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Markus Armbruster <armbru@redhat.com>



----- Original Message -----
> In DEFINE_PROP_ARRAY, because we use a PropertyInfo (qdev_prop_arraylen)
> which has a .set_default_value member we will set the field to a default
> value. That default value will be zero, by the C rule that struct
> initialization sets unmentioned members to zero if at least one member
> is initialized. However it's clearer to state it explicitly.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> If my eyeball of the sources is correct, this is the only case we
> have of a Property struct that uses a PropertyInfo with a non-NULL
> .set_default_value but which doesn't explicitly set .defval.u.
> ---
>  include/hw/qdev-properties.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 0604c33..36d040c 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -110,6 +110,7 @@ extern PropertyInfo qdev_prop_arraylen;
>                            _arrayfield, _arrayprop, _arraytype) {        =
\
>          .name =3D (PROP_ARRAY_LEN_PREFIX _name),                        =
  \
>          .info =3D &(qdev_prop_arraylen),                                =
  \
> +        .defval.u =3D 0,                                                =
  \
>          .offset =3D offsetof(_state, _field)                            =
  \
>              + type_check(uint32_t, typeof_field(_state, _field)),       =
\
>          .arrayinfo =3D &(_arrayprop),                                   =
  \
> --
> 2.7.4
>=20
>=20

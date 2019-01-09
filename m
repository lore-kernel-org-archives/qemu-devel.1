Received: from eggs.gnu.org ([209.51.188.92]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1ghHvw-0006xp-Tf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1ghHvv-0004tk-07
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:46:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjongsma@redhat.com>) id 1ghHvr-0004oK-Bt
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:46:24 -0500
Message-ID: <5109a83384d59675df22842ca7b2a4b81339fb8e.camel@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
Date: Wed, 09 Jan 2019 11:37:19 -0600
In-Reply-To: <20190108152648.32537-3-lhrazky@redhat.com>
References: <20190108152648.32537-1-lhrazky@redhat.com>
	<20190108152648.32537-3-lhrazky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH spice 2/3] QXL interface:
 deprecate spice_qxl_set_max_monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

Acked-by: Jonathon Jongsma <jjongsma@redhat.com>


On Tue, 2019-01-08 at 16:26 +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD wrote=
:
> Replace it by spice_qxl_set_device_info. Note we can't use
> monitors_count for what's stored in max_monitors, because
> monitors_count
> denotes the length of the device_display_ids array, which
> spice_qxl_set_max_monitors doesn't touch.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
> ---
>  server/red-qxl.c   | 1 +
>  server/spice-qxl.h | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/server/red-qxl.c b/server/red-qxl.c
> index 0ea424cd..6ffd8286 100644
> --- a/server/red-qxl.c
> +++ b/server/red-qxl.c
> @@ -888,6 +888,7 @@ void spice_qxl_set_device_info(QXLInstance
> *instance,
>      }
> =20
>      instance->st->monitors_count =3D device_display_id_count;
> +    instance->st->max_monitors =3D device_display_id_count;
>  }
> =20
>  void red_qxl_init(RedsState *reds, QXLInstance *qxl)
> diff --git a/server/spice-qxl.h b/server/spice-qxl.h
> index 547d3d93..e7af5e5e 100644
> --- a/server/spice-qxl.h
> +++ b/server/spice-qxl.h
> @@ -101,9 +101,9 @@ void spice_qxl_monitors_config_async(QXLInstance
> *instance, QXLPHYSICAL monitors
>                                       int group_id, uint64_t cookie);
>  /* since spice 0.12.3 */
>  void spice_qxl_driver_unload(QXLInstance *instance);
> -/* since spice 0.12.6 */
> +/* since spice 0.12.6, deprecated since 0.14.2,
> spice_qxl_set_device_info replaces it */
>  void spice_qxl_set_max_monitors(QXLInstance *instance,
> -                                unsigned int max_monitors);
> +                                unsigned int max_monitors)
> SPICE_GNUC_DEPRECATED;
>  /* since spice 0.13.1 */
>  void spice_qxl_gl_scanout(QXLInstance *instance,
>                            int fd,

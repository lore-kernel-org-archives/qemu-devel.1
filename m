Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSSl-0001st-Sx
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSIe-0007mT-BA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:11:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKSIa-0007jH-I9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:11:30 -0500
Received: by mail-wr1-x443.google.com with SMTP id u9-v6so8084801wrr.0
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 10:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-5-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-5-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Nov 2018 22:11:13 +0400
Message-ID: <CAJ+F1CJXg2rMc0sEQpYhzqFjTb1FLMyKoh65849TWGGsesbsPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/11] hw/usb: fix const-ness for string
 params in MTP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Fri, Oct 19, 2018 at 5:43 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> Various functions accepting 'char *' string parameters were missing
> 'const' qualifiers.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index f026419e47..ccbe25820b 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -372,7 +372,7 @@ static const USBDesc desc =3D {
>  /* ---------------------------------------------------------------------=
-- */
>
>  static MTPObject *usb_mtp_object_alloc(MTPState *s, uint32_t handle,
> -                                       MTPObject *parent, char *name)
> +                                       MTPObject *parent, const char *na=
me)
>  {
>      MTPObject *o =3D g_new0(MTPObject, 1);
>
> @@ -454,7 +454,7 @@ static MTPObject *usb_mtp_object_lookup(MTPState *s, =
uint32_t handle)
>  }
>
>  static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
> -                                    char *name)
> +                                    const char *name)
>  {
>      MTPObject *child =3D
>          usb_mtp_object_alloc(s, s->next_handle++, o, name);
> @@ -473,7 +473,7 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MTPO=
bject *o,
>  }
>
>  static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
> -                                             char *name, int len)
> +                                             const char *name, int len)
>  {
>      MTPObject *iter;
>
> @@ -640,7 +640,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
>      }
>  }
>
> -static int usb_mtp_add_watch(int inotifyfd, char *path)
> +static int usb_mtp_add_watch(int inotifyfd, const char *path)
>  {
>      uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
>
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

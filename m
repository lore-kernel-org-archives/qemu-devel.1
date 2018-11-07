Received: from eggs.gnu.org ([2001:4830:134:3::10]:36815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSSp-0001tA-Du
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSHj-000725-Mu
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:10:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKSHe-0006wp-Oh
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:10:30 -0500
Received: by mail-wr1-x442.google.com with SMTP id o15-v6so14797591wrv.4
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 10:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-4-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Nov 2018 22:10:13 +0400
Message-ID: <CAJ+F1CJ+t3V-DZ=6ENfpwVKMJhnN2m5ywC2Mt-GHHmuLBGPNMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/11] hw/usb: don't set IN_ISDIR for
 inotify watch in MTP driver
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

On Fri, Oct 19, 2018 at 5:40 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> IN_ISDIR is not a bit that one can request when registering a
> watch with inotify_add_watch. Rather it is a bit that is set
> automatically when reading events from the kernel.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 00a3691bae..f026419e47 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -642,8 +642,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
>
>  static int usb_mtp_add_watch(int inotifyfd, char *path)
>  {
> -    uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY |
> -        IN_ISDIR;
> +    uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
>
>      return inotify_add_watch(inotifyfd, path, mask);
>  }
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

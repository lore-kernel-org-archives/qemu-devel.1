Received: from eggs.gnu.org ([2001:4830:134:3::10]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gNGHN-0004VW-Ry
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gNGHL-0003fP-Pj
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:57:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gNGHK-0003bK-PU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:57:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id j17-v6so20895783wrq.11
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 03:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20180830163831.18586-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180830163831.18586-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Nov 2018 15:57:29 +0400
Message-ID: <CAJ+F1CLprQF4guKvsVEuH-WpbEG=s=ukJLpHu2E=FXZ8FsMzFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: fix clang enum-conversion
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Aug 30, 2018 at 8:50 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Now that the VhostUserMsg.request field is used for both master &
> slave requests, since commit d84599f56c820d8c1ac9928a76500dcdfbbf194d:
>
> contrib/libvhost-user/libvhost-user.c:953:20: error: implicit conversion =
from enumeration type 'enum VhostUserSlaveRequest' to different enumeration=
 type 'VhostUserRequest' (aka 'enum VhostUserRequest') [-Werror,-Wenum-conv=
ersion]
>         .request =3D VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping,
thanks

> ---
>  contrib/libvhost-user/libvhost-user.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 4aa55b4d2d..c0133b7f3f 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -145,7 +145,7 @@ typedef struct VhostUserVringArea {
>  #endif
>
>  typedef struct VhostUserMsg {
> -    VhostUserRequest request;
> +    int request;
>
>  #define VHOST_USER_VERSION_MASK     (0x3)
>  #define VHOST_USER_REPLY_MASK       (0x1 << 2)
> --
> 2.19.0.rc0.48.gb9dfa238d5
>
>


--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9L1-0006dh-Ra
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9L0-0007vQ-Ss
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:37:23 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dz9L0-0007v5-O8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:37:22 -0400
Received: by mail-oi0-x241.google.com with SMTP id h9so4009212oia.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 15:37:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002191521.15748-4-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
	<20171002191521.15748-4-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2017 00:37:21 +0200
Message-ID: <CAJ+F1CJWMm41ZR8810nboSy7hRphfgkAywePws5mK-Emw2Yfsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] libvhost-user: Update and fix feature
 and request lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On Mon, Oct 2, 2017 at 9:15 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Update the ProtocolFeature and UserRequest lists to
> match hw/virtio/vhost-user.c.
> Fix the text labelling in libvhost-user.c to match the list.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 10 +++++-----
>  contrib/libvhost-user/libvhost-user.h |  9 ++++++++-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 5ee8483a32..1901311a70 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -35,16 +35,13 @@
>      } while (0)
>
>  static const char *
> -vu_request_to_string(int req)
> +vu_request_to_string(unsigned int req)
>  {
>  #define REQ(req) [req] =3D #req
>      static const char *vu_request_str[] =3D {
>          REQ(VHOST_USER_NONE),
>          REQ(VHOST_USER_GET_FEATURES),
>          REQ(VHOST_USER_SET_FEATURES),
> -        REQ(VHOST_USER_NONE),
> -        REQ(VHOST_USER_GET_FEATURES),
> -        REQ(VHOST_USER_SET_FEATURES),
>          REQ(VHOST_USER_SET_OWNER),
>          REQ(VHOST_USER_RESET_OWNER),
>          REQ(VHOST_USER_SET_MEM_TABLE),
> @@ -62,7 +59,10 @@ vu_request_to_string(int req)
>          REQ(VHOST_USER_GET_QUEUE_NUM),
>          REQ(VHOST_USER_SET_VRING_ENABLE),
>          REQ(VHOST_USER_SEND_RARP),
> -        REQ(VHOST_USER_INPUT_GET_CONFIG),
> +        REQ(VHOST_USER_NET_SET_MTU),
> +        REQ(VHOST_USER_SET_SLAVE_REQ_FD),
> +        REQ(VHOST_USER_IOTLB_MSG),
> +        REQ(VHOST_USER_SET_VRING_ENDIAN),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 94d7cc8fbd..c2fc6da720 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -34,6 +34,10 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ =3D 0,
>      VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
>      VHOST_USER_PROTOCOL_F_RARP =3D 2,
> +    VHOST_USER_PROTOCOL_F_REPLY_ACK =3D 3,
> +    VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
> +    VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
> +    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
>
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> @@ -61,7 +65,10 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_QUEUE_NUM =3D 17,
>      VHOST_USER_SET_VRING_ENABLE =3D 18,
>      VHOST_USER_SEND_RARP =3D 19,
> -    VHOST_USER_INPUT_GET_CONFIG =3D 20,
> +    VHOST_USER_NET_SET_MTU =3D 20,
> +    VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
> +    VHOST_USER_IOTLB_MSG =3D 22,
> +    VHOST_USER_SET_VRING_ENDIAN =3D 23,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau

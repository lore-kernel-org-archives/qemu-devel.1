Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dDW6k-0004Ff-8K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dDW6f-0007b0-SP
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dDW6f-0007Zv-Lm
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B73C2C04B948
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:13:39 +0000 (UTC)
Date: Wed, 24 May 2017 09:13:36 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <389383564.20749240.1495631616794.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170510132906.23481-1-dgilbert@redhat.com>
References: <20170510132906.23481-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Fix VHOST_USER_NET_SET_MTU
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com



----- Original Message -----
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> VHOST_USER_'s 20th entry is defined as VHOST_USER_INPUT_GET_CONFIG but
> should be VHOST_USER_NET_SET_MTU.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 2 +-
>  contrib/libvhost-user/libvhost-user.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index af4faad60b..645cb36c4c 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -62,7 +62,7 @@ vu_request_to_string(int req)
>          REQ(VHOST_USER_GET_QUEUE_NUM),
>          REQ(VHOST_USER_SET_VRING_ENABLE),
>          REQ(VHOST_USER_SEND_RARP),
> -        REQ(VHOST_USER_INPUT_GET_CONFIG),
> +        REQ(VHOST_USER_NET_SET_MTU),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index 156b50e989..ecf9539ffa 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -60,7 +60,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_QUEUE_NUM =3D 17,
>      VHOST_USER_SET_VRING_ENABLE =3D 18,
>      VHOST_USER_SEND_RARP =3D 19,
> -    VHOST_USER_INPUT_GET_CONFIG =3D 20,
> +    VHOST_USER_NET_SET_MTU =3D 20,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> --
> 2.12.2
>=20
>=20

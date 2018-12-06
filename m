Received: from eggs.gnu.org ([2001:4830:134:3::10]:44479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUtpR-0003QM-Gt
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUtpO-0007YQ-CB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUtpO-0007YD-45
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:36:30 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-4-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4e19a724-d3bc-705d-fb7f-6fe93da6508a@redhat.com>
Date: Thu, 6 Dec 2018 14:36:26 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/71] vhost: restrict Linux dependency to
 kernel vhost
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> vhost-user does not depend on Linux; it can run on any POSIX system.  R=
estrict
> vhost-kernel to Linux in hw/virtio/vhost-backend.c, everything else can=
 be
> compiled on all POSIX systems.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  backends/Makefile.objs     |  5 ++---
>  default-configs/virtio.mak |  4 ++--
>  hw/net/vhost_net.c         |  2 +-
>  hw/virtio/Makefile.objs    |  5 +++--
>  hw/virtio/vhost-backend.c  | 11 +++++++++--
>  5 files changed, 17 insertions(+), 10 deletions(-)
[...]
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index fe6202a..2a300ee 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -193,7 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>      }
> =20
>      /* Set sane init value. Override when guest acks. */
> -#ifdef CONFIG_VHOST_USER
> +#ifdef CONFIG_VHOST_NET_USER

Merge this hunk with the previous patch?

Apart from that nit:

Reviewed-by: Thomas Huth <thuth@redhat.com>

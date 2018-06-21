Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fVymG-0001f4-5h
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fVymB-0004hM-Ae
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:33:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:46055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fVymB-0004g6-22
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:33:23 -0400
Date: Thu, 21 Jun 2018 20:33:20 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180621123320.GA19274@debian>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618161729.334-5-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/26] vhost-user: simplify
 vhost_user_init/vhost_user_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Mon, Jun 18, 2018 at 06:17:07PM +0200, Marc-André Lureau wrote:
[...]
> diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
> index 049089b5e2..323dfcc46a 100644
> --- a/hw/virtio/vhost-stub.c
> +++ b/hw/virtio/vhost-stub.c
> @@ -7,7 +7,7 @@ bool vhost_has_free_slot(void)
>      return true;
>  }
>  
> -VhostUserState *vhost_user_init(void)
> +bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
>  {
>      return NULL;

It would be better to return false.

Best regards,
Tiwei Bie

>  }
[...]

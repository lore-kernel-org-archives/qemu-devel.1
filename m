Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAXV-0003Ds-VM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAXS-0002ny-VG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:54:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVAXS-0002ns-Pq
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:54:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA7C07DAC3
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:54:49 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:54:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619065448.kf3sguslhbqnczvv@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-27-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618161729.334-27-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 26/26] hw/display: add vhost-user-vga &
 gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

  Hi,

> +    VHOST_USER_GPU_SCANOUT,
> +    VHOST_USER_GPU_UPDATE,
> +    VHOST_USER_GPU_DMABUF_SCANOUT,
> +    VHOST_USER_GPU_DMABUF_UPDATE,

Hmm, still two command versions.

I still think there should be no separate 2d code path.  Just
put the 2d display updates into a texture, or into a drm buffer,
then use VHOST_USER_GPU_DMABUF_* for both 2d and 3d updates (see
also ui/console-gl.c, which does basically the same).

cheers,
  Gerd

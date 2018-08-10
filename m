Received: from eggs.gnu.org ([2001:4830:134:3::10]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4AI-0007Zt-W3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4AE-0004Kx-4p
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:57:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo4AE-0004KU-00
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:56:58 -0400
Date: Fri, 10 Aug 2018 11:56:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810095654.drs4fwswdakktqbw@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-27-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-27-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 26/29] vmsvga: Add basic support for
 display topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>

  Hi,

> +    case SVGA_REG_DISPLAY_WIDTH:
> +        if ((s->display_id == 0) || (s->display_id == SVGA_ID_INVALID))
> +            ret = s->new_width ? s->new_width : surface_width(surface);
> +        else
> +            ret = 0;
> +        break;
> +    case SVGA_REG_DISPLAY_HEIGHT:
> +        if ((s->display_id == 0) || (s->display_id == SVGA_ID_INVALID))
> +            ret = s->new_height ? s->new_height : surface_height(surface);
> +        else
> +            ret = 0;
> +        break;

What is the purpose of these registers?  Hint for the guest about the
host display size?  If so you probably want wire up a callback for
GraphicHwOps->ui_info.  This will be called on display changes (i.e.
user resizes qemu gtk window).  See virtio_gpu_ui_info() for an example.

cheers,
  Gerd

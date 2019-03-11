Received: from eggs.gnu.org ([209.51.188.92]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3EPw-000773-6U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3EPv-0006er-61
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3EPu-0006ck-Uz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:28:07 -0400
Date: Mon, 11 Mar 2019 07:28:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190311062800.ofl7svfek37z4k3c@sirius.home.kraxel.org>
References: <20190222054939.19739-1-kraxel@redhat.com>
	<20190222054939.19739-2-kraxel@redhat.com>
	<e49ae948-5856-e9e2-7c87-76810a44da91@oracle.com>
	<20190308141451.55976c7e@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308141451.55976c7e@x1.home>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

  Hi,

> Liam and I both found some difficulty with the cleverness of the
> macros, so for the sake of better maintainability, I'd like to propose
> rolling in the following patch, including Liam's trace format fix.  It's
> not as compact as your version, but I think it's equivalent, it's easier
> to follow, and doesn't covertly introduce a non-curly braced block ;)
> If you agree, I'll roll this into your v3. Thanks,

>  #define pwrite_field(_fd, _reg, _ptr, _fld)                             \
> -    if (sizeof(_ptr->_fld) !=                                           \
> -        pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                  \
> -               _reg->offset + offsetof(typeof(*_ptr), _fld)))           \
> -        goto err;
> +    (sizeof(_ptr->_fld) !=                                              \
> +     pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                     \
> +            _reg->offset + offsetof(typeof(*_ptr), _fld)))

>      dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
> -    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> +    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
> +        goto err;
> +    }

Fine with me.

thanks,
  Gerd

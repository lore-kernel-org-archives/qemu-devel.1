Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f7zWH-0006wN-U4
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f7zWD-0003UL-Qi
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:29:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f7zWD-0003Tv-Md
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:29:45 -0400
Date: Mon, 16 Apr 2018 10:29:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180416082944.fkgqs5htp2rr3yi5@sirius.home.kraxel.org>
References: <1523698174-22832-1-git-send-email-agk@godking.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523698174-22832-1-git-send-email-agk@godking.net>
Subject: Re: [Qemu-devel] qapi: [PATCH v2] Implement query-usbhost QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kappner <agk@godking.net>
Cc: eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On Sat, Apr 14, 2018 at 02:29:34AM -0700, Alexander Kappner wrote:
> Implement a QMP command similar to the HMP's "info usbhost" command.

The hmp version of the command should be switched over to call the
qmp_query_usbhost() and pretty-print the qapi struct then, to make
sure hmp and qmp versions of the command deliver consistent results.

> This allows a QMP client to query which USB devices may be available
> for redirection.

I'm wondering what the use case is?

At least libvirt sandboxes qemu, for security reasons, and you wouldn't
get any useful results because qemu hasn't the permissions needed to
scan the usb bus.

>  ##
> +# @query-usbhost:
> +#
> +# Returns information about USB devices available on the host
> +#
> +# Returns: a [UsbDeviceInfo]. Returns an error if compiled without
> +# CONFIG_USB_LIBUSB
> +#
> +# Since: TODO (maintainer insert version number if mainlined)

Will not make it into 2.12, so 2.13.

> +# @UsbDeviceInfo:
> +#
> +# @speed: the speed

Use an enum for this?

> +# @id_vendor: idVendor field from device descriptor
> +#
> +# @id_product: idProduct field from device descriptor
> +#
> +# @str_product: string descriptor referenced by iProduct index, if any
> +#
> +# @str_manufacturer: string descriptor referenced by iManufacturer index, if any
> +#
> +# @dev_addr: address on bus that device is connected to
> +#
> +# @bus_num: bus number device is connected to

No port?

cheers,
  Gerd

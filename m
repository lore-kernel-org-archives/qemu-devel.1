Received: from eggs.gnu.org ([209.51.188.92]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gomA3-0006nU-Br
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gom9x-0004Ux-13
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:27:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gom9w-0004T6-Kn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:27:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so25202674wrp.3
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 01:27:51 -0800 (PST)
Date: Wed, 30 Jan 2019 10:27:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190130092747.ft6q5hl7mcggimri@steredhat>
References: <20190129221928.11522-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129221928.11522-1-huth@tuxfamily.org>
Subject: Re: [Qemu-devel] [PATCH] hw/m68k/mcf5208: Support loading of bios
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On Tue, Jan 29, 2019 at 11:19:28PM +0100, Thomas Huth wrote:
> The MCF5208EVB supports 2 MiB of flash at address 0. Add support
> for this memory region and some code to load the file that can
> be specified with the "-bios" command line option.
> This can be used for example to load U-Boot images for the
> MCF5208EVB (we still lack some features in the CPU emulation for
> this firmware, though, so it can not be run successfully yet).
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  hw/m68k/mcf5208.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

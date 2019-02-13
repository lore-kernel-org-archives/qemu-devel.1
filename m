Received: from eggs.gnu.org ([209.51.188.92]:36439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtr94-0007OV-Rk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtr93-0007Km-Cn
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:58 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtr93-0007KQ-5c
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:57 -0500
Received: by mail-wr1-f41.google.com with SMTP id r2so1679284wrv.10
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 01:47:57 -0800 (PST)
Date: Wed, 13 Feb 2019 10:47:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190213094752.5jz2m3xrv5zonfvw@steredhat>
References: <20190212145322.30974-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212145322.30974-1-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/dma/i8257: Use qemu_log_mask(UNIMP)
 instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Feb 12, 2019 at 03:53:22PM +0100, Philippe Mathieu-Daudé wrote:
> Avoid to clutter stdout until explicitly requested (with -d unimp):
> 
>   $ qemu-system-mips64el -M fulong2e -bios pmon_2e.bin
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/dma/i8257.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

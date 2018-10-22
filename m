Received: from eggs.gnu.org ([2001:4830:134:3::10]:52107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjvx-0008CE-PR
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjsw-0006Xm-NF
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:45:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEjsv-0006Wy-TR
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:45:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18-v6so4994036wrw.6
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:45:21 -0700 (PDT)
References: <20181022080053.9379-1-yuchenlin@synology.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <adce4765-3ff4-0898-168d-7d55606720f4@redhat.com>
Date: Tue, 23 Oct 2018 01:45:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181022080053.9379-1-yuchenlin@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org

On 22/10/18 10:00, yuchenlin--- via Qemu-devel wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/display/vga_int.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 6e4fa48a79..55c418eab5 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>                             const MemoryRegionPortio **vbe_ports);
>   void vga_common_reset(VGACommonState *s);
>   
> -void vga_sync_dirty_bitmap(VGACommonState *s);
>   void vga_dirty_log_start(VGACommonState *s);
>   void vga_dirty_log_stop(VGACommonState *s);
>   
> 

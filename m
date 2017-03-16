Received: from eggs.gnu.org ([2001:4830:134:3::10]:58881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWQV-0000Se-QL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWQS-0004OY-LS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:30:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coWQS-0004OT-Fg
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:30:48 -0400
References: <20170316092030.1685-1-iwona260909@gmail.com>
	<20170316092030.1685-2-iwona260909@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd6b25aa-1661-9ac2-8c94-6c64a7658354@redhat.com>
Date: Thu, 16 Mar 2017 15:30:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170316092030.1685-2-iwona260909@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Dead Code Removal: removing support for
 DEPTH != 32.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: iwona260909@gmail.com
Cc: qemu-devel@nongnu.org



On 16/03/2017 10:20, iwona260909@gmail.com wrote:
>  static draw_line_func * draw_line8_funcs[] = {
> -    draw_line8_8,
> -    draw_line8_15,
> -    draw_line8_16,
>      draw_line8_32,
>      draw_line8_32bgr,
> -    draw_line8_15bgr,
> -    draw_line8_16bgr,
>  };
>  
>  static draw_line_func * draw_line16_funcs[] = {
> -    draw_line16_8,
> -    draw_line16_15,
> -    draw_line16_16,
>      draw_line16_32,
>      draw_line16_32bgr,
> -    draw_line16_15bgr,
> -    draw_line16_16bgr,
>  };
>  
>  static draw_line_func * draw_line32_funcs[] = {
> -    draw_line32_8,
> -    draw_line32_15,
> -    draw_line32_16,
>      draw_line32_32,
>      draw_line32_32bgr,
> -    draw_line32_15bgr,
> -    draw_line32_16bgr,
>  };
>  
>  static draw_hwc_line_func * draw_hwc_line_funcs[] = {
> -    draw_hwc_line_8,
> -    draw_hwc_line_15,
> -    draw_hwc_line_16,
>      draw_hwc_line_32,
>      draw_hwc_line_32bgr,
> -    draw_hwc_line_15bgr,
> -    draw_hwc_line_16bgr,
>  };
>  
>  static inline int get_depth_index(DisplaySurface *surface)

In fact, as in your cirrus-vga patch, here you adjusted the arrays but
not its users.  This would never work, because get_depth_index will
return 3.  The value is out of bounds for these 2-element arrays.

Paolo

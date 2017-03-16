Received: from eggs.gnu.org ([2001:4830:134:3::10]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWLw-0006iU-KI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWLt-0002UC-DJ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coWLs-0002Ty-Vu
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:26:05 -0400
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
	<1489673540.15659.93.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd567818-a266-5a09-554e-567c5aca6b8e@redhat.com>
Date: Thu, 16 Mar 2017 15:26:01 +0100
MIME-Version: 1.0
In-Reply-To: <1489673540.15659.93.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, iwona260909@gmail.com



On 16/03/2017 15:12, Gerd Hoffmann wrote:
>   Hi,
> 
>>> -#define DEPTH 8
>>> -#include "cirrus_vga_rop2.h"
>>> -
>>> -#define DEPTH 16
>>> -#include "cirrus_vga_rop2.h"
>>> -
>>> -#define DEPTH 24
>>> -#include "cirrus_vga_rop2.h"
>>> -
>>>  #define DEPTH 32
>>>  #include "cirrus_vga_rop2.h"
> 
> No.  It isn't *that* simple.  The cirrus blitter operates on the guest
> framebuffer, which can have any format the guest wishes it to have.
> This is *not* about rendering into a 32bpp DisplaySurface.

Besides that the patch is incomplete, since it doesn't adjust the users
of the ROP2 macro---this will probably apply to other display adapters
where you can do this kind of dead code removal.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ctY2r-0006up-3u
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ctY2l-0004kg-3B
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:15:13 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52801
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ctY2k-0004hU-Sf
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:15:07 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
Date: Thu, 30 Mar 2017 12:14:35 +0100
MIME-Version: 1.0
In-Reply-To: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 30/03/17 07:55, Gerd Hoffmann wrote:

>   Hi,
> 
> First attempt on making display updates thread-save for real.  Most
> interesting patches at this point are #2 (adds helper functions to
> create and use a dirty bitmap copy) and #3 (updates vga code to use
> them).
> 
> Patch #1 fixes a bug I've noticed while wading through the vga code,
> and #4 removes the temporary workaround for testing purposes.  Which
> will of course break some or all non-vga display adapters as those
> are not ported over yet.
> 
> git branch is available here:
>   git://git.kraxel.org/qemu work/vga-fixes
> 
> Gerd Hoffmann (4):
>   vga: add vga_scanline_invalidated helper
>   memory: add support getting and using a dirty bitmap copy.
>   vga: make display updates thread safe.
>   [testing] console: remove do_safe_dpy_refresh
> 
>  exec.c                  | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/display/vga.c        | 50 +++++++++++++++++--------------
>  include/exec/memory.h   | 13 ++++++++
>  include/exec/ram_addr.h |  8 +++++
>  include/qemu/typedefs.h |  1 +
>  memory.c                | 15 ++++++++++
>  ui/console.c            | 25 +---------------
>  7 files changed, 145 insertions(+), 46 deletions(-)

Excellent! I can help out with converting and/or testing the SPARC
devices (cg3/tcx) if required.

Out of interest, from your work do you have a rough estimate as to how
this affects guest performance? For example benchmarks with Jan's
original commit to reduce the locking vs. Alex's current workaround vs.
with this patchset applied?


ATB,

Mark.

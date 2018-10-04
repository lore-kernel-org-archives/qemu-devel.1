Received: from eggs.gnu.org ([2001:4830:134:3::10]:34233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86zb-00034J-6z
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86zX-0007PF-RK
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:00:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g86zX-0007OS-GS
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:00:47 -0400
References: <20180925071228.32040-1-cst@tolva.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <34b290b2-2507-98c0-09f0-ca58ec434b9c@vivier.eu>
Date: Thu, 4 Oct 2018 19:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180925071228.32040-1-cst@tolva.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Linux usermode emulation user mode
 USB driver support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Cortland_T=c3=b6lva?= <cst@tolva.net>, qemu-devel@nongnu.org

Le 25/09/2018 à 09:12, Cortland Tölva a écrit :
> This patch series aims to let programs running under QEMU Linux user mode
> emulation implement user-space USB drivers via the USBFS ioctl()s.  First
> I check for the necessary header files, then I define some types, and
> last I implement the submit, discard, and reap functions, which involve
> USB request buffers which live beyond a single ioctl() call.
> 
> Each patch in this series compiles for i386, ppc64, ppc64le, mips, mipsel,
> xtensa, and xtensaeb with an armv7l host and an x86_64 host.  The
> i386-linux-user target is tested working with a USB scanner driver on an
> armv7l host.  Additionally, a patched copy of strace was used to verify
> the conversion for reaping.  Additionally, a MIPS binary of lsusb was run
> on armv7l host to check reaping and other functionality across endianness.
> 
> Not tested on 64-bit hosts.
> 
> Changes from v1:
>   use check_include in configure
>   move struct definitions to later patch where possible
>   improve pointer cast to int compatibility
>   remove unimplemented types for usb streams
> 
> Cortland Tölva (3):
>   linux-user: Check for Linux USBFS in configure
>   linux-user: Define ordinary usbfs ioctls.
>   linux-user: implement special usbfs ioctls.
> 
>  configure                  |  12 +++-
>  linux-user/ioctls.h        |  46 ++++++++++++
>  linux-user/syscall.c       | 171 +++++++++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  30 ++++++++
>  linux-user/syscall_types.h |  68 ++++++++++++++++++
>  5 files changed, 326 insertions(+), 1 deletion(-)
> 

I've applied patches 1 and 2 to my linux-user branch.

Thanks,
Laurent

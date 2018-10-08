Received: from eggs.gnu.org ([2001:4830:134:3::10]:37869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9PWK-0008UU-FQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9PWF-0004G5-GF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:00:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g9PWF-0004Fg-72
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:59:55 -0400
References: <20181008042747.10130-1-cst@tolva.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b1b48975-36e3-baf6-c2b2-8cc1b7fa4986@vivier.eu>
Date: Mon, 8 Oct 2018 08:59:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181008042747.10130-1-cst@tolva.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: usbfs improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Cortland_T=c3=b6lva?= <cst@tolva.net>, qemu-devel@nongnu.org

Le 08/10/2018 à 06:27, Cortland Tölva a écrit :
> From: Cortland Setlow Tölva <cst@tolva.net>
> 
> This patch series enables programs running under QEMU Linux user mode
> emulation to implement user-space USB drivers via the USBFS ioctl()s.
> Support is limited to control, bulk, and possibly interrupt transfers.
> 
> Usbfs ioctl codes were incorrect whenever host and target disagreed on
> struct size.  The submit, discard, and reap usbfs ioctls require special
> memory buffer handling and the second commit implements this but not for
> USB3 streams or isochronous transfers.
> 
> Cortland Tölva (2):
>   linux-user: Use calculated sizes for usbfs ioctls.
>   linux-user: Implement special usbfs ioctls.
> 
>  linux-user/ioctls.h        |   8 ++
>  linux-user/syscall.c       | 177 +++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  42 ++++-----
>  linux-user/syscall_types.h |  20 +++++
>  4 files changed, 227 insertions(+), 20 deletions(-)
> 

As I didn't push the previous series, could you merge the both in one on
top of master?

I think it would be clearer.

Thanks,
Laurent

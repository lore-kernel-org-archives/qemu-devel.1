Received: from eggs.gnu.org ([2001:4830:134:3::10]:36484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2mB-0004VO-3i
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2m8-0004Tn-0G
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:07:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gB2m7-0004TY-MG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:07:03 -0400
References: <20181008163521.17341-1-cst@tolva.net>
	<20181008163521.17341-3-cst@tolva.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <26543aa4-3aa2-17a8-c728-e971604a2ec8@vivier.eu>
Date: Fri, 12 Oct 2018 21:07:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181008163521.17341-3-cst@tolva.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] linux-user: Define ordinary usbfs
 ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Cortland_T=c3=b6lva?= <cst@tolva.net>, qemu-devel@nongnu.org

On 08/10/2018 18:35, Cortland Tölva wrote:
> Provide ioctl definitions for the generic thunk mechanism to
> convert most usbfs calls.  Calculate arg size at runtime.
> 
> Signed-off-by: Cortland Tölva <cst@tolva.net>
> ---
> Changes from v1:
>   move some type definitions to patch 3/3
> Changes from v2:
>   calculate ioctl arg size at runtime
> 
>  linux-user/ioctls.h        | 38 ++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c       |  3 +++
>  linux-user/syscall_defs.h  | 24 +++++++++++++++++++++++
>  linux-user/syscall_types.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

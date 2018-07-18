Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffo8z-0005bO-AG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffo8w-000506-5V
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:13:33 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffo8v-0004yi-Ty
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:13:30 -0400
Received: by mail-pl0-x242.google.com with SMTP id m16-v6so2177553pls.11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:13:29 -0700 (PDT)
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
	<1531900083-18167-3-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df03e948-d5c8-f250-9f51-b2b5b8823fad@linaro.org>
Date: Wed, 18 Jul 2018 08:13:25 -0700
MIME-Version: 1.0
In-Reply-To: <1531900083-18167-3-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7 V11] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On 07/18/2018 12:47 AM, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> As more flag parameters besides the existing 'share' are going to be
> added to following functions
> memory_region_init_ram_from_file
> qemu_ram_alloc_from_fd
> qemu_ram_alloc_from_file
> let's switch them to use the 'flags' parameters so as to ease future
> flag additions.
> 
> The existing 'share' flag is converted to the RAM_SHARED bit in ram_flags,
> and other flag bits are ignored by above functions right now.
> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  backends/hostmem-file.c |  3 ++-
>  exec.c                  | 10 +++++-----
>  include/exec/memory.h   |  7 +++++--
>  include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
>  memory.c                |  8 +++++---
>  numa.c                  |  2 +-
>  6 files changed, 41 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

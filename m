Received: from eggs.gnu.org ([2001:4830:134:3::10]:53641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHmuU-00037u-Bk
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHmuJ-0003YT-6K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:35:27 -0400
References: <20181030151637.37207-1-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ef0a5153-10b4-0991-9d59-7a14dba06cc4@vivier.eu>
Date: Wed, 31 Oct 2018 10:28:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181030151637.37207-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw: qdev: fix error in
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, f4bug@amsat.org, armbru@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 30/10/2018 16:16, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  include/hw/qdev-core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd566..92851e55df 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -197,7 +197,7 @@ typedef struct BusChild {
>  
>  /**
>   * BusState:
> - * @hotplug_device: link to a hotplug device associated with bus.
> + * @hotplug_handler: link to a hotplug handler associated with bus.
>   */
>  struct BusState {
>      Object obj;
> 

Applied to trivial-patches branch

Thanks,
Laurent

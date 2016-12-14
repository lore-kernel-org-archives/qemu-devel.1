Received: from eggs.gnu.org ([2001:4830:134:3::10]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cGxwR-0002Tc-2O
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 20:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cGxwO-0008Rh-0b
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 20:01:07 -0500
Received: from mail.kernel.org ([198.145.29.136]:53990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cGxwN-0008RZ-R9
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 20:01:03 -0500
Date: Tue, 13 Dec 2016 17:00:58 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1481263496-8004-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1612131700110.2777@sstabellini-ThinkPad-X260>
References: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481263496-8004-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH for-2.9 V3 1/3] Migration: Don't load
 vmdesc when xen is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Fri, 9 Dec 2016, Zhang Chen wrote:
> Xen doesn't need this.

Could you please elaborate a bit more on what is the problem exactly,
and why we don't have any issues with migration with Xen today (COLO
use-case aside)?


> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  migration/savevm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0363372..bec6c7e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1973,6 +1973,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          ret = qemu_file_get_error(f);
>      }
>  
> +    if (xen_enabled()) {
> +        return ret;
> +    }
> +
>      /*
>       * Try to read in the VMDESC section as well, so that dumping tools that
>       * intercept our migration stream have the chance to see it.
> -- 
> 2.7.4
> 
> 
> 
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eGn3t-0004AO-FN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eGn3q-0003lS-D2
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eGn3q-0003l8-6X
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:34 -0500
Date: Mon, 20 Nov 2017 22:28:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171120142828.GB6828@lemon.lan>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, anthony.xu@intel.com, stefanha@redhat.com, zhang.zhanghailiang@huawei.com

On Fri, 11/17 14:23, Yang Zhong wrote:
> diff --git a/util/rcu.c b/util/rcu.c
> index ca5a63e..8d491a6 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -26,6 +26,7 @@
>   * IBM's contributions to this file may be relicensed under LGPLv2 or later.
>   */
>  
> +#include <malloc.h>

BTW, if you respin, the "qemu/osdep.h" header should always be included first as
per HACKING file.

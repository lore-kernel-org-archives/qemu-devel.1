Received: from eggs.gnu.org ([209.51.188.92]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyaFR-00028h-9X
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyaFQ-0001sn-KG
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyaFQ-0001nH-Cx
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:46:04 -0500
Date: Tue, 26 Feb 2019 10:36:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226103646.GB2721@work-vm>
References: <20190226053434.6252-1-chen.zhang@intel.com>
	<20190226053434.6252-2-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226053434.6252-2-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] Migration/colo.c: Fix double close bug
 when occur COLO failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> In migration_incoming_state_destroy(void) will check the mis->to_src_file
> to double close the mis->to_src_file when occur COLO failover.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 398b239d1c..a916dc178c 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -872,6 +872,7 @@ out:
>      /* Must be called after failover BH is completed */
>      if (mis->to_src_file) {
>          qemu_fclose(mis->to_src_file);
> +        mis->to_src_file = NULL;
>      }
>      migration_incoming_disable_colo();
>  
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

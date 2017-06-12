Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKORJ-0002jG-LT
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKORI-000490-GX
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dKORI-00047m-Ac
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:27:24 -0400
Date: Mon, 12 Jun 2017 13:27:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170612122716.GF3146@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496828798-27548-2-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/11] userfault: add pid into uffd_msg
 & update UFFD_FEATURE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, aarcange@redhat.com
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This commit duplicates header of "userfaultfd: provide pid in userfault msg"
> into linux kernel.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

OK, so this isn't yet merged into Linus' tree from what I can tell;
we need to wait until it gets merged, and then run the
scripts/update-linux-headers.sh

Dave

> ---
>  linux-headers/linux/userfaultfd.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> index 9701772..eda028c 100644
> --- a/linux-headers/linux/userfaultfd.h
> +++ b/linux-headers/linux/userfaultfd.h
> @@ -78,6 +78,9 @@ struct uffd_msg {
>  		struct {
>  			__u64	flags;
>  			__u64	address;
> +			union {
> +				__u32   ptid;
> +			} feat;
>  		} pagefault;
>  
>  		struct {
> @@ -161,6 +164,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
>  #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
>  #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
> +#define UFFD_FEATURE_THREAD_ID			(1<<7)
>  	__u64 features;
>  
>  	__u64 ioctls;
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

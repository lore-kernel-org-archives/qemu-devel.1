Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvSiB-0004H2-Db
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvSi6-000709-PN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvSi6-0006yP-K1
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:57:42 -0400
Date: Tue, 4 Apr 2017 18:57:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404175737.GL2147@work-vm>
References: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170318151330eucas1p102b9378cc23a399528fa7f2440846650@eucas1p1.samsung.com>
	<1489850003-5652-2-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489850003-5652-2-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] userfault: add pid into uffd_msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  linux-headers/linux/userfaultfd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> index 2ed5dc3..7b299a2 100644
> --- a/linux-headers/linux/userfaultfd.h
> +++ b/linux-headers/linux/userfaultfd.h
> @@ -77,6 +77,7 @@ struct uffd_msg {
>  		struct {
>  			__u64	flags;
>  			__u64	address;
> +			pid_t   pid;
>  		} pagefault;

Yes, but we'll just rerun the sync of the headers once your change
lands in the kernel.

Dave

>  		struct {
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

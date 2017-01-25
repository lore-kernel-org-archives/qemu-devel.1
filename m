Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWOov-00068K-2i
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWOou-0006p5-90
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWOou-0006o3-3d
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:45:08 -0500
Date: Wed, 25 Jan 2017 14:45:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125144502.GF2096@work-vm>
References: <20170125121710.13561-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125121710.13561-1-cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/flic: fix compilation of kvm flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, duanj@linux.vnet.ibm.com

* Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> 2c21ee7 ("migration: extend VMStateInfo") missed a void -> int
> return conversion for kvm_flic_save().
> 
> Fixes: 2c21ee7 ("migration: extend VMStateInfo")
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/intc/s390_flic_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index da8e4dfab6..e86a84e49a 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -303,7 +303,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
>           * migration state */
>          error_report("flic: couldn't allocate memory");
>          qemu_put_be64(f, FLIC_FAILED);
> -        return;
> +        return 0;
>      }
>  
>      count = __get_all_irqs(flic, &buf, len);
> -- 
> 2.11.0

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

as discussed, sort out an error return value later.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

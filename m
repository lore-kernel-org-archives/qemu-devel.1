Received: from eggs.gnu.org ([2001:4830:134:3::10]:53527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWhjR-0001Jd-Pe
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWhjO-0001EH-MR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:56:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42189
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cWhjO-0001Dm-Ha
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:56:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QArw63070174
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 05:56:41 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 287camyppf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 05:56:41 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 26 Jan 2017 10:56:39 -0000
Date: Thu, 26 Jan 2017 11:56:34 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170125121710.13561-1-cornelia.huck@de.ibm.com>
References: <20170125121710.13561-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170126115634.2a8c379d.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/flic: fix compilation of kvm flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, duanj@linux.vnet.ibm.com, dgilbert@redhat.com

On Wed, 25 Jan 2017 13:17:10 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

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

Added to my s390-next branch.

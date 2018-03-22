Received: from eggs.gnu.org ([2001:4830:134:3::10]:36372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mapfelba@redhat.com>) id 1eyuy6-0007Tm-3W
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mapfelba@redhat.com>) id 1eyuy2-0000YC-24
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:49:02 -0400
Date: Thu, 22 Mar 2018 03:48:56 -0400 (EDT)
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1232053152.12730389.1521704936150.JavaMail.zimbra@redhat.com>
In-Reply-To: <152169525471.222.10982135661238361362@71c20359a636>
References: <152169525471.222.10982135661238361362@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, eblake@redhat.com, qemu-trivial@nongnu.org


Hi Yuval,

----- Original Message -----
> From: no-reply@patchew.org
> To: "yuval shaia" <yuval.shaia@oracle.com>
> Cc: famz@redhat.com, "yuval shaia" <yuval.shaia@oracle.com>, marcel@redhat.com, eblake@redhat.com,
> qemu-devel@nongnu.org, qemu-trivial@nongnu.org
> Sent: Thursday, March 22, 2018 7:07:35 AM
> Subject: Re: [Qemu-devel] [PATCH 0/3] hw/rdma: Fix 32-bit compilation
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 

[...]

> === OUTPUT BEGIN ===
> Checking PATCH 1/3: hw/rdma: Change host_virt to void *...
> Checking PATCH 2/3: hw/rdma: Use correct print format in CHK_ATTR macro...
> Checking PATCH 3/3: hw/rdma: Fix 32-bit compilation...
> WARNING: line over 80 characters
> #40: FILE: hw/rdma/rdma_backend.c:180:
> +            pr_dbg("ibv_create_ah failed for gid <0x%" PRIx64 ", 0x%" PRIx64
> ">\n",
> 
> ERROR: space prohibited before that close parenthesis ')'
> #78: FILE: hw/rdma/rdma_backend.c:673:
> +    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64 );
> 
> WARNING: line over 80 characters
> #244: FILE: hw/rdma/vmw/pvrdma_main.c:345:
> +        pr_err("Error trying to set REG value, addr=0x%" PRIx64 ", val=0x%"
> PRIx64 "\n",
> 
> total: 1 errors, 2 warnings, 248 lines checked
> 

Can you please fix and resend?

Thanks,
Marcel

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

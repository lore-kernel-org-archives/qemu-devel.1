Received: from eggs.gnu.org ([2001:4830:134:3::10]:36012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eymAV-0006sZ-PP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eymAQ-0006Jp-OH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:25:15 -0400
References: <20180321211056.3339-1-yuval.shaia@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <159b2ec9-a8a4-ec03-51c1-5bbc097c0de9@redhat.com>
Date: Wed, 21 Mar 2018 17:24:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180321211056.3339-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 03/21/2018 04:10 PM, Yuval Shaia wrote:
> Hi all,
> Following are three patches which fixes various compilation warnings and
> errors detected when compiling rdma device in 32bit host.
> 
> All three patches are based on Eric Blake patch for rdma device.
> Thanks!
> 
> Patch #1: Change host_virt to void *
> Low level IB verbs library accept void * argument so let's make sure this
> is what we supply. This issue reported by Eric Blake.
> 
> Patch #2: Use correct print format in CHK_ATTR macro
> This macro can utilize the given 'format' argument and not need to cast all
> members to u64. This patch is an alternative to suggested patch by Eric
> Blake.
> 
> Patch #3: Fix 32-bit compilation
> Based on Eric Blake patch this patch replaces all %ld/%lx with the platform
> independent PRIx64/PRId64 format.
> 
> Again, thanks Eric Blake for the report.
> 
> Yuval Shaia (3):
>    hw/rdma: Change host_virt to void *
>    hw/rdma: Use correct print format in CHK_ATTR macro

Your fix was nicer than my proposal.

>    hw/rdma: Fix 32-bit compilation

Reviewed-by: Eric Blake <eblake@redhat.com>

and it fixes the build on my 32-bit rawhide VM, so

Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

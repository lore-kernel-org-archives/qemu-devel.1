Received: from eggs.gnu.org ([2001:4830:134:3::10]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clyp5-0007eL-Nu
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clyp0-0002nx-JG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:13:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1clyp0-0002no-8c
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:13:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29E8m0A043670
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 09:13:36 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2937kkugp7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 09:13:36 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 14:13:32 -0000
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-2-dgilbert@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 9 Mar 2017 15:13:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170309132216.23482-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <b808873d-5d80-ccdc-6121-3f8d63bea08c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com



On 03/09/2017 02:22 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Provide a helper to say whether a RAMBlock was created as a
> shared mapping.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

> ---
>  exec.c                    | 5 +++++
>  include/exec/cpu-common.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index aabb035..1f25a12 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2593,6 +2593,11 @@ MemoryRegion *get_system_io(void)
>      return system_io;
>  }
> 
> +bool qemu_ram_is_shared(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_SHARED;
> +}
> +
>  #endif /* !defined(CONFIG_USER_ONLY) */
> 
>  /* physical memory access (slow version, mainly for debug) */
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b62f0d8..4d45a72 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -69,6 +69,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
> +bool qemu_ram_is_shared(RAMBlock *rb);
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
> 

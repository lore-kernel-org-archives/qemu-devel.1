Received: from eggs.gnu.org ([2001:4830:134:3::10]:37096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clfVc-0001iB-SM
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clfVZ-0001oV-LK
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:36:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42138
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1clfVZ-0001oJ-D5
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:36:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v28HSWpR083105
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 12:36:16 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292fxp4khk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 12:36:15 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Mar 2017 17:36:14 -0000
References: <20170307183637.21245-1-dgilbert@redhat.com>
	<20170307183637.21245-2-dgilbert@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 8 Mar 2017 18:36:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170307183637.21245-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <af15f78f-774f-f657-1554-a086488cc1a9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] RAMBlocks: qemu_ram_is_shared
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



On 03/07/2017 07:36 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Provide a helper to say whether a RAMBlock was created as a
> shared mapping.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c                    | 5 +++++
>  include/exec/cpu-common.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index aabb035..c2cc455 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1560,6 +1560,11 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
>      return rb->idstr;
>  }
> 
> +bool qemu_ram_is_shared(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_SHARED;

Hm, it appears to me RAM_SHARED is defined conditionally, that's within 
#if !defined(CONFIG_USER_ONLY)
#endif

The function however seems to be defined and using RAM_SHARED
unconditionally. Either one or the other seems inappropriate to me.

Regards,
Halil

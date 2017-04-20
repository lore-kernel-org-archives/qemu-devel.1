Received: from eggs.gnu.org ([2001:4830:134:3::10]:48948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d16NH-0007Bj-Rx
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d16NE-0005NP-MN
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:19:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d16NE-0005NG-FQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:19:28 -0400
Received: by mail-wm0-x241.google.com with SMTP id z129so8996468wmb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 00:19:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a8eb495d-7c03-2d6f-c8df-3970f08bc05d@twiddle.net>
Date: Thu, 20 Apr 2017 00:19:23 -0700
MIME-Version: 1.0
In-Reply-To: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] VFIO: Make 8-byte accesses atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, alex.williamson@redhat.com, mdroth@linux.vnet.ibm.com

On 04/19/2017 12:44 PM, Jose Ricardo Ziviani wrote:
> This patchset has two patches:
> [1] 8-byte writes to non-mapped MMIO are broken into pairs of 4-byte writes, this patch makes such pairs atomic.
>
> [2] Enable 8-byte accesses in vfio_region_write and vfio_region_read.
>
> Patches based on master.
>
> Jose Ricardo Ziviani (2):
>   vfio: Set MemoryRegionOps:max_access_size and min_access_size
>   vfio: enable 8-byte reads/writes to vfio
>
>  hw/vfio/common.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

I think these patches need to be squashed to be bisectable.


r~

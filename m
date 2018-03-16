Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewkMh-0007lZ-N9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewkMe-0006mh-IV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:27 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:39522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ewkMe-0006lg-CT
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:24 -0400
Received: by mail-io0-x22f.google.com with SMTP id d11so5367252iop.6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 01:05:24 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<20180315102501.GA3062@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
Date: Fri, 16 Mar 2018 16:05:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180315102501.GA3062@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, quintela@redhat.com, liang.z.li@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org


Hi David,

Thanks for your review.

On 03/15/2018 06:25 PM, Dr. David Alan Gilbert wrote:

>>   migration/ram.c | 32 ++++++++++++++++----------------
> 
> Hi,
>    Do you have some performance numbers to show this helps?  Were those
> taken on a normal system or were they taken with one of the compression
> accelerators (which I think the compression migration was designed for)?

Yes, i have tested it on my desktop, i7-4790 + 16G, by locally live migrate
the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limited to 350.

During the migration, a workload which has 8 threads repeatedly written total
6G memory in the VM. Before this patchset, its bandwidth is ~25 mbps, after
applying, the bandwidth is ~50 mbps.

BTW, Compression will use almost all valid bandwidth after all of our work
which i will post it out part by part.

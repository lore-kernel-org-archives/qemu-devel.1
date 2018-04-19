Received: from eggs.gnu.org ([2001:4830:134:3::10]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9DBv-0004Yn-L0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9DBu-0005zp-Lx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:17:51 -0400
References: <CAMxP3BTEzHjfxr=nnYDCL2v1djYJt5t5_hZ8rWo_S=qcbhQYVQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3d41de05-4bbd-3843-a0b7-fd71fc187022@redhat.com>
Date: Thu, 19 Apr 2018 13:17:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxP3BTEzHjfxr=nnYDCL2v1djYJt5t5_hZ8rWo_S=qcbhQYVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SPDK] qemu process hung at boot-up,
 no explicit errors or warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Forwarding to qemu-block.

On 04/19/2018 06:13 AM, Bob Chen wrote:
> Hi,
> 
> I was trying to run qemu with spdk, referring to
> http://www.spdk.io/doc/vhost.html#vhost_qemu_config
> 
> Everything went well since I had already set up hugepages, vfio, vhost
> targets, vhost-scsi device(vhost-block was also tested), etc, without
> errors or warnings reported.
> 
> But at the last step to run qemu, the process would somehow hang. And its
> cpu busy remained 100%.
> 
> I used `perf top -p` to monitor the process activity,
>   18.28%  [kernel]                      [k] vmx_vcpu_run
>    3.06%  [kernel]                      [k] vcpu_enter_guest
>    3.05%  [kernel]                      [k] system_call_after_swapgs
> 
> Do you have any ideas about what happened here?
> 
> Test environment: latest CentOS 7 kernel, nvme ssd, spdk v18.01.x,
> dpdk 17.11.1, qemu 2.12.0-rc2. Detail log is attached within this mail.
> 

Have you tried any other versions? (2.11.1, or 2.12-rc4?)

> 
> 
> Thanks,
> Bob
> 

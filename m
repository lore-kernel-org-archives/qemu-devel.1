Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dmfAe-0003YF-6h
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dmfAb-0003cX-11
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:59:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:10756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dmfAa-0003a4-Mb
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:59:00 -0400
Message-ID: <59A557B1.7080704@intel.com>
Date: Tue, 29 Aug 2017 20:01:53 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20170827233033.7afa49b9@fiorina>
	<20170829095726.GL25960@stefanha-x1.localdomain>
In-Reply-To: <20170829095726.GL25960@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpbw==?= =?UTF-8?B?dnNrw70=?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>

On 08/29/2017 05:57 PM, Stefan Hajnoczi wrote:
> On Sun, Aug 27, 2017 at 11:30:33PM +0200, Tomáš Golembiovský wrote:
>> Hi,
> I have CCed the relevant mailing lists and people most recently involved
> in virtio-balloon discussions.  Hopefully this will help get the right
> people to see your questions.
>
>> We'd like to include information about reclaimable memory into the
>> statistics in VirtiO Balloon driver. Namely, we'd like to include
>> counters for bufferes and caches of Linux kernel. The patch itself is
>> pretty trivial -- no problem there. But before we do that I'd like to
>> get some input from the QEMU community.
>>
>> 1) Is there any reason not to have the stats there?

Could you please share the usages of reclaimable memory via the stats?


>>
>> 2) Considering the balloon device is multiplatform (Linux, BSD,
>> Windows), is there a problem with including buffers/caches? These seem
>> to be specific to the Linux virtual memory subsystem. Of course, other
>> OSes could just report zeros. Are there some internal stats on those
>> OSes that could be filled in? I don't now if such or similar statistic
>> are available on BSD. On Windows only SystemCache stat looks like
>> something relevant. Anyone familiar with those OSes has any suggestions?
>>
>>     

One of the solutions that I'm thinking about is to make virtio 
platform-ware.

That is, the device by default supports
VIRTIO_F_LINUX,
VIRTIO_F_WINDOWS,
VIRTIO_F_BSD.

For the Linux driver, only VIRTIO_F_LINUX is supported, then we can
have Linux specific driver implementations under that feature.


Best,
Wei

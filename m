Received: from eggs.gnu.org ([2001:4830:134:3::10]:56939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJueg-0005uf-Ks
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJueb-0001dw-N8
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:16:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gJueb-0001dc-F2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:15:57 -0500
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<bd913c1b-fcbe-b198-3955-4b4b2e33757a@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <fef3b167-0d69-d61d-418b-535fb6d36dfc@oracle.com>
Date: Tue, 6 Nov 2018 14:17:46 +0800
MIME-Version: 1.0
In-Reply-To: <bd913c1b-fcbe-b198-3955-4b4b2e33757a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to emulate block I/O timeout on qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, jsnow@redhat.com
Cc: qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>



On 11/06/2018 01:49 AM, Eric Blake wrote:
> On 11/2/18 3:11 AM, Dongli Zhang wrote:
>> Hi,
>>
>> Is there any way to emulate I/O timeout on qemu side (not fault injection in VM
>> kernel) without modifying qemu source code?
> 
> You may be interested in Rich's work on nbdkit.  If you don't mind the overhead
> of the host connecting through NBD, then you can use nbdkit's delay and
> fault-injection filters for inserting delays or even run-time-controllable
> failures to investigate how the guest reacts to those situations

Thank you all very much for the suggestions. I will take a look on nbdkit.

So far I am reproducing the issue with NFS (by shutdown the link to NFS where
the image is placed on purpose) but it did not work well.

> 
>>
>> For instance, I would like to observe/study/debug the I/O timeout handling of
>> nvme, scsi, virtio-blk (not supported) of VM kernel.
>>
>> Is there a way to trigger this on purpose on qemu side?
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>
> 

Dongli Zhang

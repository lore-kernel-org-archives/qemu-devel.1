Received: from eggs.gnu.org ([2001:4830:134:3::10]:52260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJj0t-00051N-4d
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJj0m-0005Gy-Um
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:50:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJj0k-0005Bm-SC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:50:04 -0500
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd913c1b-fcbe-b198-3955-4b4b2e33757a@redhat.com>
Date: Mon, 5 Nov 2018 11:49:55 -0600
MIME-Version: 1.0
In-Reply-To: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

On 11/2/18 3:11 AM, Dongli Zhang wrote:
> Hi,
> 
> Is there any way to emulate I/O timeout on qemu side (not fault injection in VM
> kernel) without modifying qemu source code?

You may be interested in Rich's work on nbdkit.  If you don't mind the 
overhead of the host connecting through NBD, then you can use nbdkit's 
delay and fault-injection filters for inserting delays or even 
run-time-controllable failures to investigate how the guest reacts to 
those situations

> 
> For instance, I would like to observe/study/debug the I/O timeout handling of
> nvme, scsi, virtio-blk (not supported) of VM kernel.
> 
> Is there a way to trigger this on purpose on qemu side?
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

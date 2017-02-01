Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1Sh-0002oW-IM
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1Sc-0001Hy-L7
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:25:03 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cZ1Sc-0001Hd-Fo
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:24:58 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so32471265pfg.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 12:24:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
	<20170201110320.GD3232@redhat.com>
	<CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
	<15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5554a4fb-c7e7-aa36-ea82-32931233f56f@redhat.com>
Date: Wed, 1 Feb 2017 12:24:53 -0800
MIME-Version: 1.0
In-Reply-To: <15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ladi Prosek <lprosek@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com



On 01/02/2017 06:43, Eric Blake wrote:
>>> It would be possible to design a ioctl API that is more usable if you
>>> didn't try to do generic passthrough of arbitrary ioctl commands. Instead
>>> provide a QAPI schema that uses a union to provide strongly typed arguments
>>> for the ioctl commands you care about using. Or completely separate QAPI
>>> commands instead of multiplexing everything into an ioctl command.
>>
>> I can add a QAPI command for my specific use case if it's acceptable,
> 
> Certainly more palatable, and more likely to gain my acceptance.
> 
>> that's not a problem. Although at that point I would probably just go
>> back to my plan b and use regular file I/O and guest-file-read. I just
>> wanted to be as generic as possible to benefit other use cases as well
>> and I ended up with what's basically my stab at RPC ioctl.
> 
> The problem is that RPC ioctl is not sanely possible.

Windows ioctl (DeviceIoControl) is a little different from POSIX ioctl,
more RPC and less one-size-fits-all bucket for syscallish stuff.  It is
still a leaky abstraction though.

Paolo

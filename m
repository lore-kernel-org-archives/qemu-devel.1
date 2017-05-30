Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFi93-0003r7-Nv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFi90-0008OC-Ge
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFi90-0008O5-AO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:29:10 -0400
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
	<20170530131140.GA11356@stefanha-x1.localdomain>
	<086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
	<e5ed37e3-832a-8336-ea9e-3e7fd3974596@redhat.com>
	<F2D36A68-D126-4851-8385-E4456CE12121@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dee9cce8-9cf3-373e-0522-6fc93922bac5@redhat.com>
Date: Tue, 30 May 2017 16:29:05 +0200
MIME-Version: 1.0
In-Reply-To: <F2D36A68-D126-4851-8385-E4456CE12121@nutanix.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/21] vhost-scsi: create a
 vhost-scsi-common abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 30/05/2017 16:21, Felipe Franciosi wrote:
>> default-configs/pci.mak:CONFIG_VHOST_USER_SCSI=$(CONFIG_POSIX)
>> default-configs/s390x-softmmu.mak:CONFIG_VHOST_USER_SCSI=y
>>
>> Unfortunately, the mingw docker test doesn't build all targets, so I
>> missed it.
>>
>> I would like vhost-user to be available on non-Linux POSIX, but this is
>> not immediately possible because vhost-backend.c includes the kernel
>> backend.  So we'll have to change CONFIG_POSIX to CONFIG_LINUX too.
> Sounds good to me. Do you need anything from my end or are you happy to take care of this?

If you'd like to take a look at breaking vhost-backend.c, that would be
nice.

Thanks,

Paolo

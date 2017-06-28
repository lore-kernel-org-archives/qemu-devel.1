Received: from eggs.gnu.org ([2001:4830:134:3::10]:52286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQ7UQ-0005FD-Q2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQ7UM-0006WD-Rw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQ7UM-0006W2-LX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:14 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<cd6a24ee-ddfd-f6f1-a20d-2ec1323ffd3e@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c847fa9f-c6d5-cf44-ebeb-427443a1aa1b@redhat.com>
Date: Wed, 28 Jun 2017 09:34:00 +0200
MIME-Version: 1.0
In-Reply-To: <cd6a24ee-ddfd-f6f1-a20d-2ec1323ffd3e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

On 27.06.2017 18:50, Farhan Ali wrote:
[...]
>> The patches are still in a rough shape, but before I continue here,
>> I though I'd get some feedback first. Specifically:
>>
>> - This adds a lot of additional code to the s390-ccw firmware (and
>>   the binary is afterwards three times as big as before, 75k instead
>>   of 25k) ... is that still acceptable?
> 
> IMHO 75k is not that huge compared to the Linux based netboot image.

True. I was just surprised that the size was now three times as big as
before, but when you compare it to the huge size of a Linux kernel +
initrd, 75k are of course close to nothing.

>> - Is it OK to require loading an .INS file first? Or does anybody
>>   have a better idea how to load multiple files (kernel, initrd,
>>   etc. ...)?
>>
>> - The code from SLOF uses a different coding style (TABs instead
>>   of space) ... is it OK to keep that coding style here so we
>>   can share patches between SLOF and s390-ccw more easily?
>>
>> - The code only supports TFTP (via UDP) ... I think that is OK for
>>   most use-cases, but if we ever want to support network booting
>>   via HTTP or something else that is based on TCP, we would need to
>>   use something else instead... Should we maybe rather head towards
>>   grub2, petitboot or something different instead?
> 
> Can't it be extended to support HTTP boot?

Not so easily, since you need TCP support for this first. And TCP is way
more complex to implement when compared with UDP.

 Thomas

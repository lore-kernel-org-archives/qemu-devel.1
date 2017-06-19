Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dMvrv-0003IR-VQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dMvrs-0002bM-Q6
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:33:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dMvrs-0002Ys-Gg
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:33:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5JCT4vp132303
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 08:33:17 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b69tufnt1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 08:33:17 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 19 Jun 2017 06:33:16 -0600
References: <20170615203735.19649-1-rth@twiddle.net>
	<7998cb6b-018e-8069-9d11-a3e1e4e70380@redhat.com>
	<429793f7-a3c1-91ec-9a83-908ee779e703@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 19 Jun 2017 14:33:10 +0200
MIME-Version: 1.0
In-Reply-To: <429793f7-a3c1-91ec-9a83-908ee779e703@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <9362010b-5c05-c29f-6e67-c182d2ae57ec@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 06/19/2017 02:05 PM, David Hildenbrand wrote:
> On 19.06.2017 12:03, David Hildenbrand wrote:
>> On 15.06.2017 22:37, Richard Henderson wrote:
>>> There are no uses in a Linux system with which to test,
>>> but it Looks Right by my reading of the PoO.
>>
>> I am using next.git/master with this patch applied:
>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=8aa8680aa383bf6e2ac
>>
>> I am using QEMU with the mvcos patch and your patch applied (and a patch
>> that allows enabling csst/csst2).
>>
>> I am using the following qemu command line:
>>
>> #!/bin/bash
>> /home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x \
>> 	-nographic -nodefaults -machine s390-ccw-virtio,accel=tcg \
>> 	-cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>>           eimm=on,stckf=on,csst=on,csst2=on,ginste=on,exrl=on\
>> 	-m 256M -smp 1 -chardev stdio,id=con0 \
>> 	-device sclpconsole,chardev=con0 \
>> 	-kernel vmlinux -initrd /home/dhildenb/initrd.debian
>>
>> Right now, I can start a z9 compiled kernel.
>>
>> When trying to start a z10 compiled kernel (which generates many csst),


I would be very surprised if the kernel would contain any csst. gcc does not
emit csst and the kernel source also does not contain it.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1esv6u-0003A8-EN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1esv6n-0000oH-Pq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:45:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1esv6n-0000mr-ES
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:45:13 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25IiZ6d027951
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 13:45:11 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh97uy0v7-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:45:10 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Mon, 5 Mar 2018 13:45:08 -0500
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
	<20180305110356.GF7910@stefanha-x1.localdomain>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 13:45:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180305110356.GF7910@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <12e1269c-6eae-a400-cc00-2c5c8e4bb8f9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>



On 03/05/2018 06:03 AM, Stefan Hajnoczi wrote:
> Please include the following gdb output:
> 
>    (gdb) disas swapcontext
>    (gdb) i r
> 
> That way it's possible to see which instruction faulted and which
> registers were being accessed.


here is the disas out for swapcontext, this is on a coredump with 
debugging symbols enabled for qemu. So the addresses from the previous 
dump is a little different.


(gdb) disas swapcontext
Dump of assembler code for function swapcontext:
    0x000003ff90751fb8 <+0>:	lgr	%r1,%r2
    0x000003ff90751fbc <+4>:	lgr	%r0,%r3
    0x000003ff90751fc0 <+8>:	stfpc	248(%r1)
    0x000003ff90751fc4 <+12>:	std	%f0,256(%r1)
    0x000003ff90751fc8 <+16>:	std	%f1,264(%r1)
    0x000003ff90751fcc <+20>:	std	%f2,272(%r1)
    0x000003ff90751fd0 <+24>:	std	%f3,280(%r1)
    0x000003ff90751fd4 <+28>:	std	%f4,288(%r1)
    0x000003ff90751fd8 <+32>:	std	%f5,296(%r1)
    0x000003ff90751fdc <+36>:	std	%f6,304(%r1)
    0x000003ff90751fe0 <+40>:	std	%f7,312(%r1)
    0x000003ff90751fe4 <+44>:	std	%f8,320(%r1)
    0x000003ff90751fe8 <+48>:	std	%f9,328(%r1)
    0x000003ff90751fec <+52>:	std	%f10,336(%r1)
    0x000003ff90751ff0 <+56>:	std	%f11,344(%r1)
    0x000003ff90751ff4 <+60>:	std	%f12,352(%r1)
    0x000003ff90751ff8 <+64>:	std	%f13,360(%r1)
    0x000003ff90751ffc <+68>:	std	%f14,368(%r1)
    0x000003ff90752000 <+72>:	std	%f15,376(%r1)
    0x000003ff90752004 <+76>:	slgr	%r2,%r2
    0x000003ff90752008 <+80>:	stam	%a0,%a15,184(%r1)
    0x000003ff9075200c <+84>:	stmg	%r0,%r15,56(%r1)
    0x000003ff90752012 <+90>:	la	%r2,2
    0x000003ff90752016 <+94>:	lgr	%r5,%r0
    0x000003ff9075201a <+98>:	la	%r3,384(%r5)
    0x000003ff9075201e <+102>:	la	%r4,384(%r1)
    0x000003ff90752022 <+106>:	lghi	%r5,8
    0x000003ff90752026 <+110>:	svc	175
    0x000003ff90752028 <+112>:	lgr	%r5,%r0
=> 0x000003ff9075202c <+116>:	lfpc	248(%r5)
    0x000003ff90752030 <+120>:	ld	%f0,256(%r5)
    0x000003ff90752034 <+124>:	ld	%f1,264(%r5)
    0x000003ff90752038 <+128>:	ld	%f2,272(%r5)
    0x000003ff9075203c <+132>:	ld	%f3,280(%r5)
    0x000003ff90752040 <+136>:	ld	%f4,288(%r5)
    0x000003ff90752044 <+140>:	ld	%f5,296(%r5)
    0x000003ff90752048 <+144>:	ld	%f6,304(%r5)
    0x000003ff9075204c <+148>:	ld	%f7,312(%r5)
    0x000003ff90752050 <+152>:	ld	%f8,320(%r5)
    0x000003ff90752054 <+156>:	ld	%f9,328(%r5)
    0x000003ff90752058 <+160>:	ld	%f10,336(%r5)
    0x000003ff9075205c <+164>:	ld	%f11,344(%r5)
    0x000003ff90752060 <+168>:	ld	%f12,352(%r5)
    0x000003ff90752064 <+172>:	ld	%f13,360(%r5)
    0x000003ff90752068 <+176>:	ld	%f14,368(%r5)
    0x000003ff9075206c <+180>:	ld	%f15,376(%r5)
    0x000003ff90752070 <+184>:	lam	%a2,%a15,192(%r5)
    0x000003ff90752074 <+188>:	lmg	%r0,%r15,56(%r5)
    0x000003ff9075207a <+194>:	br	%r14
End of assembler dump.

(gdb) i r
r0             0x0	0
r1             0x3ff8fe7de40	4396165881408
r2             0x0	0
r3             0x3ff8fe7e1c0	4396165882304
r4             0x3ff8fe7dfc0	4396165881792
r5             0x0	0
r6             0xffffffff88004880	18446744071696304256
r7             0x3ff880009e0	4396033247712
r8             0x27ff89000	10736930816
r9             0x3ff88001460	4396033250400
r10            0x1000	4096
r11            0x1261be0	19274720
r12            0x3ff88001e00	4396033252864
r13            0x14d0bc0	21826496
r14            0x1312ac8	19999432
r15            0x3ff8fe7dc80	4396165880960
pc             0x3ff9075202c	0x3ff9075202c <swapcontext+116>
cc             0x2	2

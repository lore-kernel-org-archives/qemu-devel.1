Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiN6-0002Qc-QE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiN3-0000VA-2W
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:28:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59066
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGiN2-0000Ur-T7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:28:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAK9OSZp119584
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:28:00 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebux9ht7w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:27:59 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 09:27:58 -0000
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
	<5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 10:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>



On 11/20/2017 10:19 AM, Alexander Graf wrote:
> On 11/20/2017 10:15 AM, Christian Borntraeger wrote:
>> The QEMU ELF loader does not initialize the bss segment. This has
>> triggered several bugs in the past, e.g. see commit 5d739a4787a5
>> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
>> css").
>>
>> Instead of fixing these things one-by-one we can build the BIOS
>> with -fno-zero-initialized-in-bss. This will move the zero variables
>> also into the data segment, which is then part of a LOAD section.
> 
> Doesn't this bloat the firmware? Why don't we just manually clear bss in the firmware itself? It's what all other firmwares do :)

Yes the proper fix is to initialize bss in the bios itself.
I was trying to come up with something for 2.11, but since the patch does not solve the original issues, lets drop it.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXQyJ-00088J-6b
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXQyG-0002Wl-4H
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:51:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fXQyF-0002WO-Rx
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:51:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PCnwSC123487
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:51:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jtwc6j2a2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:51:04 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Jun 2018 13:50:56 +0100
References: <1529056145-6404-1-git-send-email-thuth@redhat.com>
	<93f1dae5-e071-41f2-a1b7-1fbfdbe7917a@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Jun 2018 14:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <93f1dae5-e071-41f2-a1b7-1fbfdbe7917a@redhat.com>
Content-Language: en-US
Message-Id: <f70f99ec-e415-1bbb-b7c2-2a916e2f3f66@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 06/25/2018 10:31 AM, Thomas Huth wrote:
> On 15.06.2018 11:49, Thomas Huth wrote:
>> The rom_ptr() function allows direct access to the ROM blobs that we
>> load during startup. However, there are currently no checks for the
>> size of the accesses, so it's currently possible to crash QEMU for
>> example with:
>>
>> $ echo "Insane in the mainframe" > /tmp/test.txt
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
>> Segmentation fault (core dumped)
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
>> Segmentation fault (core dumped)
>> $ echo -n HdrS > /tmp/hdr.txt
>> $ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
>> Segmentation fault (core dumped)
>>
>> We need a possibility to check the size of the ROM area that we want
>> to access, thus let's add a size parameter to the rom_ptr() function
>> to avoid these problems.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Ping!
> 
> Could anybody please pick this patch up? Qemu-trivial seems to be pretty
> dormant these days (?), so maybe Paolo via misc? Or either the s390x or
> Sparc tree, since it fixes a crash on these machines?

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

if this will go via the s390x tree.

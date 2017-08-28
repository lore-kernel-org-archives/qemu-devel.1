Received: from eggs.gnu.org ([2001:4830:134:3::10]:51393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmLaL-0007VI-1N
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmLaF-0003BM-Uz
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:17 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:38356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmLaF-0003Ap-Pa
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:11 -0400
Received: by mail-qk0-x22a.google.com with SMTP id m4so3364564qke.5
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 08:04:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
	<c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
	<b5a9ab05-4e3c-66bc-33ce-d953d7f911e2@linux.vnet.ibm.com>
	<20170828160554.45855dfa.cohuck@redhat.com>
	<e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0154068e-9f8c-bbb4-cd75-2e175fd5ebc7@amsat.org>
Date: Mon, 28 Aug 2017 12:04:05 -0300
MIME-Version: 1.0
In-Reply-To: <e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: farman@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, pasic@linux.vnet.ibm.com, walling@linux.vnet.ibm.com, qemu-devel@nongnu.org

Hi Farhan,

On 08/28/2017 11:15 AM, Farhan Ali wrote:
> On 08/28/2017 10:05 AM, Cornelia Huck wrote:
>>>>> It's the alignment of the CCW which causes the problem.
>>>>>
>>>>> The exact error message when starting the guest was:
>>>>>
>>>>> ! No virtio device found !
>>>>>
>>>>> Since it worked for SCSI and CDL, and failed for LDL disks on that 
>>>>> particular system, we are not really sure what caused the failure.
>>>>> Debugging it further showed the CCW for LDL disks were not aligned 
>>>>> at double word boundary.
>> This is really, really odd, as the low-level ccw code is the same for
>> any disk type...
>>
> Exactly!
> 
>>>>> Trying the test on a different system with LDL disks worked fine, 
>>>>> with the aligned(8) fix.
>>>> Do you happen to have an old s390-ccw.img laying around in the test 
>>>> folder? QEMU might pick up
>>>> this one (e.g. when calling it without libvirt from the command line).
>>>>
>>> I explicitly mention the bios to use with '-bios' option and pick up the
>>> latest bios. Without the aligned fix I see the error and with the fix it
>>> works fine.
>> Wait, so the fix fixes it? Or am I confused now?
>>
> 
> It fixes in my system and one other system we tried on. But fails on a 
> system where this issue was first noticed.

Can you provide the link script used in both systems?

See on the previous thread:
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05134.html

Regards,

Phil.

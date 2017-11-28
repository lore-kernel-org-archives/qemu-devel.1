Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJi2I-00037X-Jx
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJi2D-0005Ej-NU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:43:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJi2D-0005ED-Ed
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:42:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASFgg2P116322
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 10:42:53 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eh8fg8g0g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 10:42:53 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 08:42:33 -0700
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-3-git-send-email-walling@linux.vnet.ibm.com>
	<20171128114814.55ccfbf3.cornelia.huck@mailbox.org>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 10:42:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171128114814.55ccfbf3.cornelia.huck@mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <2a2ee45b-c199-2763-a151-938bbed49ca3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/5] s390-ccw: ipl structs
 for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On 11/28/2017 05:48 AM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 15:55:33 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
>> ECKD DASDs have different IPL structures for CDL and LDL
>> formats. The current Ipl1 and Ipl2 structs follow the CDL
>> format, so we prepend "EckdCdl" to them. A new struct,
>> EckdLdlIpl1 is introduced and contains boot info for LDL.
> So does this add support for LDL DASD, or does it simply enhance the
> code? It's unclear from the desription alone.

Enhances. I'll reword it. Perhaps something along the lines of "Boot info
for LDL has been *moved* to a new struct, EckdLdlIpl1"

>
>> Also introduce structs for IPL stages 1 and 1b and for
>> disk geometry.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
>>   pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
>>   2 files changed, 53 insertions(+), 26 deletions(-)


-- 
- Collin L Walling

Received: from eggs.gnu.org ([209.51.188.92]:37944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1bV8-0003IO-9Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1bV6-0007Eu-A1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:42:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43106
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1bV4-0006yn-Ig
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:42:43 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x26IXtMt110301
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 13:42:24 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r2hn8puej-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 13:42:23 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 6 Mar 2019 18:42:23 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
	<e3f0d9ab-c98b-d500-12e6-cfcc1a2b2a1b@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 6 Mar 2019 13:42:17 -0500
MIME-Version: 1.0
In-Reply-To: <e3f0d9ab-c98b-d500-12e6-cfcc1a2b2a1b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <96d70258-6ed8-136c-d824-a0403ace036f@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 06/16] s390-bios: Clean up
 cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/5/19 12:51 AM, Thomas Huth wrote:
> On 01/03/2019 19.59, Jason J. Herne wrote:
>> Add proper typedefs to all structs and modify all bit fields to use consistent
>> formatting.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/cio.h      | 152 ++++++++++++++++++++++----------------------
>>   pc-bios/s390-ccw/s390-ccw.h |   8 ---
>>   2 files changed, 76 insertions(+), 84 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>> index 1a0795f..2f58256 100644
>> --- a/pc-bios/s390-ccw/cio.h
>> +++ b/pc-bios/s390-ccw/cio.h
> [...]
>> -struct subchannel_id {
>> -        __u32 cssid  : 8;
>> -        __u32        : 4;
>> -        __u32 m      : 1;
>> -        __u32 ssid   : 2;
>> -        __u32 one    : 1;
>> -        __u32 sch_no : 16;
>> -} __attribute__ ((packed, aligned(4)));
>> +} __attribute__ ((packed, aligned(4))) Schib;
>> +
>> +typedef struct subchannel_id {
>> +        __u32 cssid:8;
>> +        __u32:4;
> 
> __u32:4 looks a little bit funny. Not sure, but maybe this should be
> given a name like "reserved" or so?
> 

Perhaps, but this is not my code. I was just cleaning up the style. If you feel strongly 
that this patch is the place to give this a name, I can do that.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

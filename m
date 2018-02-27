Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqkwH-0001j2-BC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqkwD-0002Mc-Da
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eqkwD-0002M5-7K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RJOdxJ004054
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:29:20 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gdbcu5fjx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:29:20 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 12:29:19 -0700
References: <1519744760-12337-1-git-send-email-walling@linux.vnet.ibm.com>
	<20180227201819.7818a548.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 14:29:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180227201819.7818a548.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ed55c0f9-4552-9041-b886-0a43dfc3ee19@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: only print boot menu error if
 -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, mihajlov@linux.vnet.ibm.com

On 02/27/2018 02:18 PM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 10:19:20 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
> Nit: make the prefix s390x/ipl:, as this is not directly in the bios.
>
>> It is possible that certain QEMU configurations may not
>> create an IPLB (such as when -kernel is provided). In
>> this case, a misleading error message will be printed
>> stating that the "boot menu is not supported for this
>> device type".
>>
>> To amend this, only print this message iff boot menu=on
>> was provided on the commandline. Otherwise, return silently.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/ipl.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 798e99a..c4addb5 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>>       case S390_IPL_TYPE_QEMU_SCSI:
>>           break;
>>       default:
>> -        error_report("boot menu is not supported for this device type.");
>> +        if (boot_menu) {
>> +            error_report("boot menu is not supported for this device type.");
>> +        }
>>           return;
>>       }
>>   
> This change makes sense and works as I'd expect (although the message
> is still slightly odd in the -kernel case, but I can't think of
> anything better.)
>
> Will you also do a followup removing the trailing punctuation? :)
>
You got it!

-- 
- Collin L Walling

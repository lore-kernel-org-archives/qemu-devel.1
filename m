Received: from eggs.gnu.org ([2001:4830:134:3::10]:52790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emhhq-0005AO-Jw
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emhhl-0005EW-F8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:13:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52198
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emhhl-0005EM-9K
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:13:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GFAs2q189580
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 10:13:40 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g6072vbra-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 10:13:40 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 08:13:39 -0700
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-11-git-send-email-walling@linux.vnet.ibm.com>
	<407113fb-5758-5cb6-5383-2075c2768c22@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 10:13:36 -0500
MIME-Version: 1.0
In-Reply-To: <407113fb-5758-5cb6-5383-2075c2768c22@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <4c1490a9-34cc-b073-1158-72c9741510f0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/12] s390-ccw: read user input for
 boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 02/16/2018 10:03 AM, David Hildenbrand wrote:
> On 15.02.2018 23:54, Collin L. Walling wrote:
>> [...]
>> +
>>   static int get_boot_index(int entries)
>>   {
>> -    return 0; /* Implemented next patch */
>> +    int boot_index;
>> +    bool retry = false;
>> +    char tmp[5];
>> +
>> +    do {
>> +        boot_menu_prompt(retry);
>> +        boot_index = get_index();
>> +        retry = true;
>> +    } while (boot_index < 0 || boot_index >= entries);
>> +
> Can you add a comment like
>
> /*
>   * We might still have pending SERVICE interrupts. Print something to
>   * definitely clear it.
>   */

I handle clearing the pending int in the next patch.

[...]

-- 
- Collin L Walling

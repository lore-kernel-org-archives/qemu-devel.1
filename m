Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eCRRc-0000Wz-Ve
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eCRRY-0004kr-OP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:35:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42370
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eCRRY-0004jj-IQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:35:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8EXvZk024451
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 09:34:57 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e42a6nn3c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 09:34:57 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 09:34:56 -0500
References: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<7426dac9-67bf-a70a-bb5b-307de4602263@ozlabs.ru>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 20:04:48 +0530
MIME-Version: 1.0
In-Reply-To: <7426dac9-67bf-a70a-bb5b-307de4602263@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <89ec1e6e-3f08-78bd-2bd5-0057055738b3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] spapr_pci: fix the path
 while fetching loc-code from host DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Apologize for the confusion. I thought devspec is not having leading '/'.

I checked devspec in my system and it works as expected.

On 11/08/2017 08:00 AM, Alexey Kardashevskiy wrote:
> On 08/11/17 00:18, Seeteena Thoufeek wrote:
>> The function spapr_phb_vfio_get_loc_code uses wrong path for
>> fetching loc-code from host DT
>>
>> this is the call that needs to be fixed:
>> /* Construct and read from host device tree the loc-code */
>> path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
>
> I do not see why would extra '/' hurt but where does it really fail?
>
> My machines have leading '/' in devspec, do not yours?
>
> aik@garrison2:~$ cat /sys/bus/pci/devices/0009:03:00.0/devspec && echo -e '\n'
> /pciex@3fffe40500000/pci@0/pci@0/pci@1/usb-xhci@0
>
>
>
>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> ---
>>   hw/ppc/spapr_pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 5a3122a..ae86322 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -762,7 +762,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
>>       g_free(path);
>>   
>>       /* Construct and read from host device tree the loc-code */
>> -    path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
>> +    path = g_strdup_printf("/proc/device-tree/%s/ibm,loc-code", buf);
>>       g_free(buf);
>>       if (!g_file_get_contents(path, &buf, NULL, NULL)) {
>>           goto err_out;
>>
>

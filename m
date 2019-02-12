Received: from eggs.gnu.org ([209.51.188.92]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbdU-00026Q-9h
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbdQ-0007OR-K2
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gtbdO-0007LM-JO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CH5gCM124615
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:14:12 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm0gnntgd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:14:12 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 12 Feb 2019 17:03:55 -0000
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<20190212011657.18324-2-walling@linux.ibm.com>
	<d9b74b0d-83f3-f7f1-3912-25739a931f41@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 12 Feb 2019 12:03:49 -0500
MIME-Version: 1.0
In-Reply-To: <d9b74b0d-83f3-f7f1-3912-25739a931f41@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bc051eaa-69de-f3a7-fa53-a978c2430290@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/3] s390x/cpumodel:
 default enable mepoch for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net

On 2/12/19 4:04 AM, David Hildenbrand wrote:
> On 12.02.19 02:16, Collin Walling wrote:
>> Latest systems and host kernels support mepoch, which is a
>> feature that was meant to be supported for z14 GA1 from the
>> get-go. Let's copy it to the z14 GA1 default CPU model.
>>
>> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
>> models and will not provide this bit nor the extended PTFF
>> functions in the default model.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>> @Christian, @David: I elected to not add your r-b's to this
>> patch since I've added some code to disable feature groups.
>> I'd like to know what you both think :)
> 
> Looks good to me!
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

-- 
Respectfully,
- Collin Walling

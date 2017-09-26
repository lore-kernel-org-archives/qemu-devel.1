Received: from eggs.gnu.org ([2001:4830:134:3::10]:44416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwmtI-0002oI-Gf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwmtF-0000SJ-5L
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:15:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dwmtE-0000R1-Sr
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:14:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QAETIs086204
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:14:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7jajacma-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:14:52 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 11:14:50 +0100
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170921180841.24490-4-pasic@linux.vnet.ibm.com>
	<7e694ed6-7b40-c895-9542-e445489cda18@linux.vnet.ibm.com>
	<20170926121027.735e5126.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 12:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170926121027.735e5126.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d38de14e-c126-131a-f6d5-a9b0122149a2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/26/2017 12:10 PM, Cornelia Huck wrote:
> On Fri, 22 Sep 2017 17:39:35 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> 
>> On 21/09/2017 20:08, Halil Pasic wrote:
>>> Replace direct access which implicitly assumes no IDA
>>> or MIDA with the new ccw data stream interface which should
>>> cope with these transparently in the future.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> ---
>>>   hw/s390x/virtio-ccw.c | 155 +++++++++++++++-----------------------------------
>>>   1 file changed, 46 insertions(+), 109 deletions(-)
> 
>> LGTM.
>> Not testing the return value for ccw_dstream_read/write_buf() bother me 
>> but I can understand that you will modify this later.
>> May be a comment?
>> Not a strong opinion.
> 
> I can add "Note that checking the return code for ccw_dstream_* will be
> done in a follow-on patch."
> 

I'm fine with that.

>>
>> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>
>>
> 
> 

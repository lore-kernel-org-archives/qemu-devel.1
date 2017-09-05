Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpDFd-0001wN-7j
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpDFV-00053z-KX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:46:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dpDFV-00053X-Az
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:46:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85CieIc026025
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 08:46:36 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csq84s5h2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:46:35 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Sep 2017 13:46:33 +0100
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-9-david@redhat.com>
	<20170905143801.1dc39cb1.cohuck@redhat.com>
	<e4ed534e-6eef-30ea-6359-0b535f483cc3@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Sep 2017 14:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <e4ed534e-6eef-30ea-6359-0b535f483cc3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a1db14fd-1bd6-e6b3-2af9-a33f2816e932@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/19] s390x: move sclp_service_call()
 to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>



On 09/05/2017 02:42 PM, David Hildenbrand wrote:
> On 05.09.2017 14:38, Cornelia Huck wrote:
>> On Mon,  4 Sep 2017 17:43:05 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> Fix up includes and rename it to s390x_*.
>>
>> I'm not quite sure whether that is the right direction: servc is just an
>> instruction that does something and then happens to also generate an
>> interrupt on conclusion. I'll think a bit more about it.
>>
> 
> Having CPU related stuff in sclp looks also wrong. Feel free to skip
> this patch, should be unrelated to the following patches.

I think having the sclp instruction handler in sclp (as today) is
the best compromise.

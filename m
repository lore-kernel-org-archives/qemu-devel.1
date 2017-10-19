Received: from eggs.gnu.org ([2001:4830:134:3::10]:57204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e56qc-00087I-2s
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e56qW-0007S0-1A
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:10:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e56qV-0007RJ-Nt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:10:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J99D0d033961
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 05:10:27 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpgdh8413-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 05:10:26 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 10:10:24 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-5-pasic@linux.vnet.ibm.com>
	<20171019061125.GC4612@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 11:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171019061125.GC4612@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4ad90651-e572-345d-d0bc-615e5fef3deb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] s390x: refactor error handling for
 XSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/19/2017 08:11 AM, Dong Jia Shi wrote:
>> +    if (!sch || !css_subch_visible(sch)) {
>> +        setcc(cpu, 3);
> ?:
> s/3/IOINST_CC_NOT_OPERATIONAL/
> 
> This also applies to other alike cases.
> 

I do not know. My first reaction was that I'm against because
were IOInstEnding strongly typed, it would not work as set
cc takes an int and works not just for IO instructions.

OTOH the same goes for setcc(cpu, css_do_xsch(sch)) so that
ain't really an argument, and it would improve grepability.

So I think I'm in favor now.

Halil

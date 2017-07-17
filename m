Received: from eggs.gnu.org ([2001:4830:134:3::10]:52806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAXE-0003tp-4U
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAXA-0004Vu-Qb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXAXA-0004UU-H0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6HIE3qm109521
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:14:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brr4am5h6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:14:15 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 17 Jul 2017 12:14:14 -0600
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-35-git-send-email-borntraeger@de.ibm.com>
	<a0ad09dd-62aa-88f1-68b0-418199a1ae81@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Jul 2017 20:14:06 +0200
MIME-Version: 1.0
In-Reply-To: <a0ad09dd-62aa-88f1-68b0-418199a1ae81@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <58bdd968-0c2e-fbb7-1727-c2c894ca3af3@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 34/40] s390x/cpumodel: wire up new hardware
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 07/17/2017 07:30 PM, David Hildenbrand wrote:
> On 14.07.2017 12:41, Christian Borntraeger wrote:
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> Some new guest features have been introduced recently. Let's wire
>> them up in the CPU model.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [split patch]
>> ---
> 
> Would it make sense to add further checks to check_consistency?
> 
> I think e.g. vx extensions should rely on vx. I can't see a new PoP out
> there, so I can't check.

Yes, the vx extensions depend on vx and it makes sense to have a dependeny for
both extension.

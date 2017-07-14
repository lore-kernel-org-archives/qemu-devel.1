Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVvUJ-0000ZR-4I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVvUF-0008Gw-VN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39285
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVvUF-0008Gb-QN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6E7rsjc127808
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:58:07 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bph7xseeu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:58:06 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 03:58:06 -0400
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<1499961789-127874-4-git-send-email-borntraeger@de.ibm.com>
	<20170714095549.1c6e709e@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 09:58:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170714095549.1c6e709e@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <7e73a8c3-7426-0a28-b963-64ae9b4dcae4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x/cpumodel: add esop/esop2 to z12
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 07/14/2017 09:55 AM, Cornelia Huck wrote:
> On Thu, 13 Jul 2017 18:03:05 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> Add esop and esop2 features to z12 model where esop2 was originally introduced.
>> Provide a mechanism to disable features in compatibility machines and use this
>> method to disable esop and esop2 when using compatibility machine v2.9 or
>> earlier.
> 
> The patch description does not quite fit anymore due to patch

Right, I have splitted out the compat handling to be used for the PCI stuff.

> reordering. What about:
> 
> "Add esop and esop2 features to z12 model where esop2 was originally introduced.
> Disable esop and esop2 when using compatibility machine v2.9 or earlier."

Will use that, thanks.

> 
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  | 3 +++
>>  target/s390x/gen-features.c | 3 +++
>>  2 files changed, 6 insertions(+)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

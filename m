Received: from eggs.gnu.org ([2001:4830:134:3::10]:43828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKTmw-0004NA-UK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKTmu-000863-NX
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:46:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gKTmu-00085b-Ee
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:46:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7JdJku002588
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 14:46:48 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nm5xrs96e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 14:46:48 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 7 Nov 2018 19:46:47 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-4-david@redhat.com>
	<228ec0b2-cd30-b33b-8120-bb28e3f83e66@redhat.com>
	<723f6454-8cac-08ed-bdb6-afddc4ed7ad1@linux.ibm.com>
	<c6623c2e-415b-0951-cfa6-4d83a42b81d4@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 7 Nov 2018 14:46:42 -0500
MIME-Version: 1.0
In-Reply-To: <c6623c2e-415b-0951-cfa6-4d83a42b81d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4e550b15-0f2b-c8ec-5589-4ff834af4131@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/4] s390x/zpci: move some
 hotplug checks to the pre_plug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/7/18 2:36 PM, David Hildenbrand wrote:
>>
>> When did these function names drop the *_hot_plug postfix? Latest master does not reflect this change for me.
>> Just figured I'd mention it now in case merging becomes a pain later ;)
>>
> 
> Mentioned it in the cover letter, part of another series
> (also CC'ed to qemu-s390x@nongnu.org, so maybe easier to find for you).

Ah, I see that now. Thanks for pointing that out (again).

-- 
Respectfully,
- Collin Walling

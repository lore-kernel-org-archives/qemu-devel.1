Received: from eggs.gnu.org ([2001:4830:134:3::10]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1cTtjw-0006k7-NX
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1cTtjt-0005h3-F0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:09:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33309
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1cTtjt-0005gr-8T
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:09:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0IH8keZ027978
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:09:36 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 282b4mce29-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:09:35 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Wed, 18 Jan 2017 10:09:35 -0700
Reply-To: jjherne@linux.vnet.ibm.com
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
	<20170118170049.GB3491@thinpad.lan.raisama.net>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Wed, 18 Jan 2017 12:09:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170118170049.GB3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/9] i386:
 query-cpu-model-expansion test script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On 01/18/2017 12:00 PM, Eduardo Habkost wrote:
> On Tue, Jan 17, 2017 at 10:22:10AM -0500, Jason J. Herne wrote:
>> On 01/16/2017 08:01 PM, Eduardo Habkost wrote:
>>> This is a follow-up to the series that implements
>>> query-cpu-model-expansion. Before including the test script, the
>>> series has some fixes to allow the results of
>>> query-cpu-model-expansion to be used in the QEMU command-line.
>>>
>>> The script probably will work on s390x too, but I couldn't test
>>> it yet.
>>>
>>
>> Eduardo,
>>
>> This test seems to mostly work on s390. The only issue I ran into is
>> querying host model using tcg only. s390 requires kvm to query the host
>> model. Perhaps we could just skip the tcg host test case on s390?
>
> We could still try to test "host", but add it to a greylist where
> errors returned by query-cpu-model-expansion can be non-fatal.
> query-cpu-model-expansion model="host" can also fail with KVM if
> the host doesn't support CPU models.
>

David had the idea to just support -cpu host for tcg. We could do that.
In the meantime, I'm ok with your greylist idea too. This would allow the
script to work properly on s390 right from the start, and we can remove the
greylist when s390 supports specifying -cpu host for tcg.

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)

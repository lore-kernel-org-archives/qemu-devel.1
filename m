Received: from eggs.gnu.org ([2001:4830:134:3::10]:50484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dZar9-0005jZ-Hy
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dZar6-0008IF-GF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36416
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dZar6-0008Gu-Aq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:44:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6OAhrfZ081559
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 06:44:50 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bwegfa9yr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 06:44:50 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 24 Jul 2017 04:44:49 -0600
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170719150313.6acdb087@gondolin>
	<bcdcdd89-4a1d-aa7c-ac2d-f994a0613183@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 24 Jul 2017 12:44:43 +0200
MIME-Version: 1.0
In-Reply-To: <bcdcdd89-4a1d-aa7c-ac2d-f994a0613183@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <870ba6c0-e285-d75a-098e-0a2d1e02e02b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/19/2017 03:31 PM, Thomas Huth wrote:
> On 19.07.2017 15:03, Cornelia Huck wrote:
>> On Tue, 18 Jul 2017 16:24:46 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> Next try of the zPCI detangling, taking cpu models into account.
>>>
>>> The goal of this is twofold:
>>> - Being able to disable PCI support in a build completely, as for v1.
>>> - Properly fencing off PCI if the relevant facility bit is not provided.
>>>
>>> The second one leads to an interesting usability problem: -device help
>>> still shows the various pci devices, but you cannot add them if the
>>> cpu model does not include zpci, due to the phb not being instantiated.
>>> The user is presented with
>>>
>>> qemu-system-s390x: -device virtio-rng-pci: No 'PCI' bus found for device 'virtio-rng-pci'
>>>
>>> ...which is not very helpful, as it does not point to the root cause (no
>>> zpci in the cpu model, and therefore no pci at all). Not sure how one can
>>> communicate this root cause, ideas welcome.
>>
>> An idea on how to improve this would still be welcome :)
> 
> IMHO it's ok to keep that error message ... but we should add a section
> to http://wiki.qemu.org/Documentation/Platforms/S390X about PCI devices,
> including a sample error message as above and a note what has to be done
> to get a machine with PCI support, so that people can find that page via
> Google in case they run into this problem.

I agree, the message is actually not that bad for an error message. With
an wiki entry we should be fine.

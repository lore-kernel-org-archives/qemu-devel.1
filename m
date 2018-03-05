Received: from eggs.gnu.org ([2001:4830:134:3::10]:41727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ess4m-0003UM-S1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ess4l-0000wg-V6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:30:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ess4l-0000p3-MB
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:30:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25FUduU113093
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 10:30:44 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh620r89y-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 10:30:41 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Mar 2018 08:30:12 -0700
References: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
	<083d2e7c-5ada-88c9-bf50-0c68e7c19136@de.ibm.com>
	<c0d0caa1-992a-7df6-67bb-e7d639f18049@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 10:30:08 -0500
MIME-Version: 1.0
In-Reply-To: <c0d0caa1-992a-7df6-67bb-e7d639f18049@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0d19a911-765c-ac44-fab5-a90f23c9e968@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [Bug 1753437] [NEW]
 qemu/pc-bios/s390-ccw/libc.c:82: bad test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Bug 1753437 <1753437@bugs.launchpad.net>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>

On 03/05/2018 09:53 AM, Thomas Huth wrote:
> On 05.03.2018 12:22, Christian Borntraeger wrote:
>> Adding qemu-s390x.
>>
>> On 03/05/2018 11:31 AM, dcb wrote:
>>> Public bug reported:
>>>
>>> qemu/pc-bios/s390-ccw/libc.c:82]: (style) Unsigned variable 'num_idx'
>>> can't be negative so it is unnecessary to test it.
>>>
>>> Source code is
>>>
>>>
>>>      while (num_idx >= 0) {
>>>
>>> but
>>>
>>>      size_t num_idx = 1; /* account for NUL */
>>>
>>> So there is no escape from the while loop.
> Actually we're defining size_t like this in the s390-ccw bios:
>
> typedef long               size_t;
>
> So the while loop is not endless.
>
> But yes, this is ugly, we should fix the function and re-define size_t
> to be unsigned instead...
>
>   Thomas
>
Agreed.

-- 
- Collin L Walling

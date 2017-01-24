Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cW02j-0003u0-Lb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cW02g-00055O-H3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:17:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cW02g-00053z-Be
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:17:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OBrfPD043398
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 07:17:41 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28636dhgax-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 07:17:40 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Tue, 24 Jan 2017 05:17:40 -0700
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170122142959.GA12419@lemon.Home>
	<ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
	<20170124120957.GC13714@lemon.Home>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 07:17:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170124120957.GC13714@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <cea8c740-d220-409f-51b0-d00c6554b479@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 01/24/2017 07:09 AM, Fam Zheng wrote:
> On Tue, 01/24 12:23, Paolo Bonzini wrote:
>>
>>
>> On 22/01/2017 15:29, Fam Zheng wrote:
>>> On Fri, 01/20 17:25, Eric Farman wrote:
>>>> Changes:
>>>>  v2->v3:
>>>>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>>>>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>>>>  v1->v2:
>>>>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]
>>>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>
>> Looks good, who's merging this? :)
>
> All I know is not me :) Adding Kevin and Max who maintain block/file-posix.c.

Also not me :) But thank you for the review and consideration of this!

  - Eric

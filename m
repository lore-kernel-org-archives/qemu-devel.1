Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUXTE-0005PM-Hr
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUXT9-0005EG-L7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:35:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50347
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUXT9-0005DV-Ec
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:34:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KBXiwC060853
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:34:57 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283fpgn200-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:34:57 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 04:34:56 -0700
References: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
	<20170119205134.50112-4-farman@linux.vnet.ibm.com>
	<20170120093151.GD29561@lemon> <20170120095359.GE29561@lemon>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 06:34:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170120095359.GE29561@lemon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <c512cea6-e105-4034-e5d3-50eae3840bfc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: get max_transfer limit for
 char (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 01/20/2017 04:53 AM, Fam Zheng wrote:
> On Fri, 01/20 17:31, Fam Zheng wrote:
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index 2115155..94068ca 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -657,9 +657,11 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
>>>      int max_sectors = 0;
>>>      short max_sectors_short = 0;
>>>      if (bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
>>> +        /* sg returns a value in bytes */
>>>          return max_sectors;
>>
>> The variable name is now misleading, maybe use "bytes" instead?
>
> BTW patch 2 should already make the function return bytes consistently.  Doing
> it here is meaningless code churn.

Excellent points.  Spinning v3 now.

  - Eric

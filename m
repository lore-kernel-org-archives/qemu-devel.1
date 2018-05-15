Received: from eggs.gnu.org ([2001:4830:134:3::10]:49060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbAb-0000N0-F3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbAa-0003Xx-Pr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:43:17 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180515141518.GF4442@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7da70cbb-b92e-c029-1ed6-9e0676a48c6a@redhat.com>
Date: Tue, 15 May 2018 09:43:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180515141518.GF4442@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/42] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/15/2018 09:15 AM, Kevin Wolf wrote:
> Am 09.05.2018 um 18:25 hat Kevin Wolf geschrieben:
>> Before we can make x-blockdev-create a background job, we need to
>> generalise the job infrastructure so that it can be used without any
>> associated block node.
>>
>> This series extracts a Job object from the block job infrastructure,
>> which should contain everything related to jobs that doesn't require the
>> block layer to be involved.
>>
>> Job creation with a centralised job-create command (if we even want
>> this) as well as the actual conversion of x-blockdev-create to Job is
>> left for another series. With 42 patches, the series must be perfect and
>> I can't add any more patches.
> 
> Thanks for the review, applied patches 1-6 in the hope of making v2 at
> least a little bit shorter. :-)

Or now you can split/add patches until you're back up to 42 patches in v2 ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

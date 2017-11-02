Received: from eggs.gnu.org ([2001:4830:134:3::10]:43146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMcJ-0003P1-60
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMcI-00037D-Hg
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:01:35 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171020164515.GC31112@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f961b41-e75b-5517-63fa-0c1ecd58605e@redhat.com>
Date: Thu, 2 Nov 2017 17:01:25 -0400
MIME-Version: 1.0
In-Reply-To: <20171020164515.GC31112@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/24] make bdrv_get_block_status
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 10/20/2017 12:45 PM, Kevin Wolf wrote:
> Am 12.10.2017 um 05:46 hat Eric Blake geschrieben:
>> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
>> but NBD wants to report status on byte granularity (even if the
>> reporting will probably be naturally aligned to sectors or even
>> much higher levels).  I've therefore started the task of
>> converting our block status code to report at a byte granularity
>> rather than sectors.
>>
>> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
>>
>> The overall conversion currently looks like:
>> part 1: bdrv_is_allocated (merged, commit 51b0a488)
>> part 2: dirty-bitmap (merged, commit ca759622)
>> part 3: bdrv_get_block_status (this series, v5 at [1])
>> part 4: .bdrv_co_block_status (v3 is posted [2], mostly reviewed, but needs rebase)
> 
> Thanks, applied to the block branch.
> 
> Kevin
> 

Thanks;

Eric: does this just leave part four?

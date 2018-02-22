Received: from eggs.gnu.org ([2001:4830:134:3::10]:52012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eouKp-0007pV-3n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eouKo-00004q-7u
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:07:07 -0500
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <c374c10a-a46c-1870-8f2c-47a2841b8a44@redhat.com>
Date: Thu, 22 Feb 2018 12:06:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180222105755.GB4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 02/22/2018 05:57 AM, Kevin Wolf wrote:
> Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
>> On 20/02/2018 18:04, Peter Lieven wrote:
>>> Hi,
>>>
>>> I remember we discussed a long time ago to limit the stack usage of all
>>> functions that are executed in a coroutine
>>> context to a very low value to be able to safely limit the coroutine
>>> stack size as well.
>>
>> IIRC the only issue was that hw/ide/atapi.c has mutual recursion between
>> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_transfer ->
>> ide_atapi_cmd_reply_end.
>>
>> But perhaps it's not an issue, somebody needs to audit the code.
> 
> I think John intended to get rid of the recursion sometime, but I doubt
> he has had the time so far.
> 

It hasn't been a priority for me.

Paolo tried to fix ATAPI by adding a BH callback, but that added the
possibility of a migration halfway through a data transfer IIRC.

If anyone wants to tackle it, I'll dig up Paolo's patches.

--js

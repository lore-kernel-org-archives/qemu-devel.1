Received: from eggs.gnu.org ([2001:4830:134:3::10]:59187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNO5u-0003SE-7M
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNO5t-0004Fr-Dr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:13:58 -0500
References: <20171207170834.15843-1-berto@igalia.com>
	<83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
	<w51609ijpsb.fsf@maestria.local.igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8312ac9e-207b-87a8-3b4b-c7c3f70c0ead@redhat.com>
Date: Fri, 8 Dec 2017 14:13:48 -0500
MIME-Version: 1.0
In-Reply-To: <w51609ijpsb.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Tweak 030 in order
 to trigger a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 12/07/2017 02:34 PM, Alberto Garcia wrote:
> On Thu 07 Dec 2017 08:16:41 PM CET, Eric Blake wrote:
>>>              qemu_io('-f', iotests.imgfmt,
>>> -                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_kb * 1024),
>>> +                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
>>
>> I guess changing from a variable to a fixed 0xff pattern doesn't make
>> a difference?
> 
> I noticed that with the previous code we would write zeroes to the first
> image (i == 0), and with that I can't reproduce the bug. I assume that
> block-stream doesn't copy the data in that case. Changing it to anything
> != 0 solves the problem.
> 

I think I ran into a similar problem with an AHCI test once.

Reviewed-by: John Snow <jsnow@redhat.com>

> And answering your question, it doesn't really matter if we write the
> same value in all places, we only check the output of 'qemu-io -c map'.
> Plus the areas don't even overlap.
> 
> Berto
> 

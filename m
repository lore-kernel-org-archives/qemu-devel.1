Received: from eggs.gnu.org ([209.51.188.92]:48186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmMco-0008Bw-T6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmMcn-000724-Ky
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:47:42 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
	<04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
	<8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <57f12e0d-0fef-43f6-ab18-86624ed4d152@redhat.com>
Date: Wed, 23 Jan 2019 12:47:06 -0500
MIME-Version: 1.0
In-Reply-To: <8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be
 run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 12:34 PM, Max Reitz wrote:
> On 23.01.19 14:05, Max Reitz wrote:
>> On 21.01.19 21:50, John Snow wrote:
> 
> [...]
> 
>>> I guess my only other observation is that we have a lot of "while True"
>>> loops now, is it worth creating some kind of helper that does the dirty
>>> work of finding a serviceable port or nah?
>>
>> Seems reasonable, I'll see how it looks.
> 
> If I do that, the diff stat looks to be 40+, 33-.  Is that worth it?
> 
> Max
> 

Instead of:
 1 file changed, 68 insertions(+), 30 deletions(-)

Or in addition to?

Use your own judg[e?]ment on it, I guess it's local to this one iotest
for now anyway, so if it's not an obvious win just skip it.

--js

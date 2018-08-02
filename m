Received: from eggs.gnu.org ([2001:4830:134:3::10]:53252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1flIzl-0005Td-IO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1flIzk-0006pY-Oe
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:10:45 -0400
References: <20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<20180801185515.GE2691@work-vm>
	<6bfdc952-fb17-feae-f367-be710853d829@openvz.org>
	<20180802092907.GA2523@work-vm>
	<202065a2-f9d1-ce31-b12b-437d57095ac1@openvz.org>
	<20180802095056.GB2523@work-vm>
	<86304a35-efd8-a605-f684-2bd3fb3b9815@openvz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <1e41d103-6d56-71e8-ef60-fc4c9343a06e@redhat.com>
Date: Thu, 2 Aug 2018 15:10:36 -0400
MIME-Version: 1.0
In-Reply-To: <86304a35-efd8-a605-f684-2bd3fb3b9815@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, Eric Blake <eblake@redhat.com>



On 08/02/2018 03:05 PM, Denis V. Lunev wrote:
> On 08/02/2018 12:50 PM, Dr. David Alan Gilbert wrote:
>> * Denis V. Lunev (den@openvz.org) wrote:
>>
>>
>>>> I don't quite understand the last two paragraphs.
>>> we are thinking right now to eliminate delay on regular IO
>>> for migration. There is some thoughts and internal work in
>>> progress. That is why I am worrying.
>> What downtime are you typicaly seeing and what are you aiming for?
>>
>> It would be good if you could explain what you're planning to
>> fix there so we can get a feel for it nearer the start of it
>> rather than at the end of the reviewing!
>>
>> Dave
> The ultimate goal is to reliable reach 100 ms with ongoing IO and
> you are perfectly correct about reviewing :)
> 
> Though the problem is that right now we are just trying to
> invent something suitable :(
> 
> Den
> 

Yeah, I gotcha -- please give me just a little time. I'm not against
using Vlad's series, it just surprised me. David and I have talked about
what you're trying to do and we are in agreement that it is the right
thing to do for now.

I have some more questions about Vlad's series, but I want to test it a
bit myself before I waste time asking them. I'll stage a working version
as soon as I can.

--js

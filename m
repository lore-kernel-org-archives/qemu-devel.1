Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gLGVR-0001EF-JM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 18:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gLGIc-0008NR-RO
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 18:34:51 -0500
References: <20180927031131.102494-1-eblake@redhat.com>
	<9f5147c4-5728-c377-2129-7c1095bdbb04@redhat.com>
	<406c2f73-9793-6e65-370f-3eb13996075c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <084fbc5b-b0ba-f164-e83e-aeb17e3e37c1@redhat.com>
Date: Fri, 9 Nov 2018 18:34:40 -0500
MIME-Version: 1.0
In-Reply-To: <406c2f73-9793-6e65-370f-3eb13996075c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, "open list:Dirty Bitmaps" <qemu-block@nongnu.org>



On 11/09/2018 12:57 PM, Eric Blake wrote:
> On 9/27/18 12:23 PM, John Snow wrote:
>>
>>
>> On 09/26/2018 11:11 PM, Eric Blake wrote:
>>> We need an accurate count of the number of bits set in a bitmap
>>> after a merge. In particular, since the merge operation short-circuits
>>> a merge from an empty source, if you have bitmaps A, B, and C where
>>> B started empty, then merge C into B, and B into A, an inaccurate
>>> count meant that A did not get the contents of C.
>>>
> 
>>
>> OK, tests coming up. Thanks for the CC to stable.
> 
> Did we ever add tests for this yet?
> 

Running behind. Not yet. On my list.

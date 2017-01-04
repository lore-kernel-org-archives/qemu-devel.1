Received: from eggs.gnu.org ([2001:4830:134:3::10]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOjy8-0000rl-Ux
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOjy8-0001eJ-Aw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:43:01 -0500
References: <20161129113245.32724-1-pbonzini@redhat.com>
	<3f948687-3169-c304-3ef8-31347f08857f@redhat.com>
	<20170104040728.GA30425@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4ad8370-cbcb-e4fd-b89d-5d7cb63569e6@redhat.com>
Date: Wed, 4 Jan 2017 12:42:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170104040728.GA30425@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/5] Sheepdog cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, qemu-block@nongnu.org



On 04/01/2017 05:07, Jeff Cody wrote:
> On Wed, Dec 21, 2016 at 03:07:07PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 29/11/2016 12:32, Paolo Bonzini wrote:
>>> Cleaning up the code and removing duplication makes it simpler to
>>> later adapt it for the multiqueue work.
>>>
>>> Tested against sheepdog 1.0.  I also tested taking snapshots and reverting
>>> to older snapshots, but the latter only worked with "dog vdi rollback".
>>> Neither loadvm nor qemu-img worked for me.
>>>
>>> Paolo
>>>
>>>         v1->v2: placate patchew
>>>         v2->v3: rebase
>>>
>>> Paolo Bonzini (5):
>>>   sheepdog: remove unused cancellation support
>>>   sheepdog: reorganize coroutine flow
>>>   sheepdog: do not use BlockAIOCB
>>>   sheepdog: simplify inflight_aio_head management
>>>   sheepdog: reorganize check for overlapping requests
>>>
>>>  block/sheepdog.c | 289 ++++++++++++++++---------------------------------------
>>>  1 file changed, 83 insertions(+), 206 deletions(-)
>>>
>>
>> 2.8 is now out, so ping.
>>
> 
> I don't have a functional sheepdog setup at the moment; have you tested
> these patches, or should I set up a test rig for them? (I am guessing I
> should do the latter; either way, I'll pull the patches in once I or someone
> else has tested them).

Yes, I have tested them.  Fedora's sheepdog package is fubar right now.
I've built an updated one and asked for ownership but haven't had any
answer yet.

Paolo

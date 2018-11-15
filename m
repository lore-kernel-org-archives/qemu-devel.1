Received: from eggs.gnu.org ([2001:4830:134:3::10]:42507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNKj2-000502-VO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNKj0-0006Xi-Kr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:42:40 -0500
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
	<CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <93846394-729c-c616-0b31-348943b001e5@redhat.com>
Date: Thu, 15 Nov 2018 11:42:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration/block-dirty-bitmap:
 fix Coverity CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>



On 11/15/18 6:48 AM, Peter Maydell wrote:
> On 17 October 2018 at 10:51, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Theoretically possible that we finish the skipping loop with bs = NULL
>>> and the following code will crash trying to dereference it. Fix that.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  migration/block-dirty-bitmap.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 477826330c..6de808f95f 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>>>              bs = backing_bs(bs);
>>>          }
>>>
>>> +        if (!bs || bs->implicit) {
>>> +            continue;
>>> +        }
>>> +
>>>          for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>>               bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>>>          {
>>
>> Previous discussion:
>> http://qemu.11.n7.nabble.com/PATCH-migration-Appease-coverity-skip-empty-block-trees-td582504.html
>>
>> I've CCed John so he can take a look.
> 
> So have you block-layer folks figured out how you want to address
> this Coverity issue yet?
> 
> thanks
> -- PMM
> 

I'm sorry, Peter.

I've let this one slip through the cracks many times and I thought it
had been handled.

I'll look now.

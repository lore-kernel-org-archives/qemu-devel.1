Received: from eggs.gnu.org ([2001:4830:134:3::10]:34242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fclCq-0007rz-ON
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 01:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fclCn-00079E-Fe
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 01:28:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fclCn-000795-AT
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 01:28:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1530879678-20487-1-git-send-email-ari@tuxera.com>
	<87lgakopio.fsf@dusky.pond.sub.org>
	<fcebd6aa-6346-35d8-cedf-71f5677033e7@tuxera.com>
Date: Tue, 10 Jul 2018 07:28:51 +0200
In-Reply-To: <fcebd6aa-6346-35d8-cedf-71f5677033e7@tuxera.com> (Ari Sundholm's
	message of "Mon, 9 Jul 2018 14:17:27 +0300")
Message-ID: <87o9fflkvg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org

Ari Sundholm <ari@tuxera.com> writes:

> On 07/09/2018 10:07 AM, Markus Armbruster wrote:
>> Ari Sundholm <ari@tuxera.com> writes:
>>
>>> This was accidentally omitted. Thanks to Eric Blake for spotting this.
>>>
>>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>>> ---
>>>   qapi/block-core.json | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 38b3125..62a92fa 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3057,6 +3057,8 @@
>>>   # @log-sector-size: sector size used in logging writes to @file, determines
>>>   #                   granularity of offsets and sizes of writes (default: 512)
>>>   #
>>> +# @log-append:      append to an existing log (default: false)
>>> +#
>>>   # @log-super-update-interval: interval of write requests after which the log
>>>   #                             super block is updated to disk (default: 4096)
>>>   #
>>
>> Applied to qapi-next.  Thanks!
>>
>
> Thanks. Does this mean that the patch be queued for 3.0 or should I
> take some additional steps to ensure this?

When a maintainer (like me) accepts your patch, he also accepts
resposibility to get it merged into master.  The patch submitter (you)
should not have to do anything to get that done.

"Should" only because maintainers aren't infallible :) I keep tracking
my own patches until they reach master.  Pretty much always they just
do.  Only once in a great while I have to ask a maintainer what's up.

In this case, your patch should be in my next QAPI pull request, and you
should receive a copy.

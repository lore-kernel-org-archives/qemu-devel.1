Received: from eggs.gnu.org ([2001:4830:134:3::10]:40108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eospF-0002zL-Ae
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eospE-0007JJ-D7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:30:25 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f2885948-d6b3-90a3-9960-6f8fd53e0177@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
	<w51po5icfbh.fsf@maestria.local.igalia.com>
	<f2885948-d6b3-90a3-9960-6f8fd53e0177@redhat.com>
Date: Thu, 22 Feb 2018 16:30:15 +0100
Message-ID: <w51606p59fc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Thu 22 Feb 2018 04:19:45 PM CET, Max Reitz wrote:
> On 2018-02-06 16:23, Alberto Garcia wrote:
>> On Mon 05 Feb 2018 04:18:27 PM CET, Max Reitz wrote:
>>> --- a/block/blkdebug.c
>>> +++ b/block/blkdebug.c
>>> @@ -886,6 +886,21 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
>>>      return 0;
>>>  }
>>>  
>>> +static const char *const blkdebug_sgfnt_runtime_opts[] = {
>>> +    "config",
>>> +    "inject-error.",
>>> +    "set-state.",
>>> +    "suspend.",
>> 
>> Where did this "suspend." come from?
>
> Er, well, er.
>
> After having looked at it a couple of times now, I can't see anything.
> I guess I'll remove it and hope for the best...?

My interpretation is that you saw

enum {
    ACTION_INJECT_ERROR,
    ACTION_SET_STATE,
    ACTION_SUSPEND,
};

and assumed that "suspend" was an option (the other two are). I haven't
seen any string with the "suspend" text anywhere else in the code.

Berto

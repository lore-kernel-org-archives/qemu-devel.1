Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUxl0-0000mm-1S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUxky-0006dK-Vi
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:26 -0400
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-2-git-send-email-kchamart@redhat.com>
	<251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8cddb03d-3e98-b01e-f543-4335c10ec9e8@redhat.com>
Date: Tue, 11 Jul 2017 12:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/2] bitmaps.md: Convert to rST;
 move it into 'interop' dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, berto@igalia.com



On 07/10/2017 10:36 PM, Eric Blake wrote:
> On 07/10/2017 03:15 AM, Kashyap Chamarthy wrote:
>> This is part of the on-going effort to convert QEMU upstream
>> documentation syntax to reStructuredText (rST).
>>
>> The conversion to rST was done using:
>>
>>      $ pandoc -f markdown -t rst bitmaps.md -o bitmaps.rst
>>
>> Then, make a couple of small syntactical adjustments.  While at it,
>> reword a statement to avoid ambiguity.  Addressing the feedback from
>> this thread:
>>
>>      https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05428.html
>>
>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
> 
>> ---
>>   docs/devel/bitmaps.md    | 505 ------------------------------------------
>>   docs/interop/bitmaps.rst | 555 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> A shame that git rename detection doesn't see these as the same rough
> contents, but not too bad. I'll just review the new text; if I point out
> something that was pre-existing in the old text, it may be nicer to
> split the cleanups into a separate followup patch, but I'm also okay if
> they go in as part of this patch.
> 
> My review is less focused on the choices used in representing things in
> rST and on the final display outcome, and more on the text itself
> (grammar and such).
> 
>> +++ b/docs/interop/bitmaps.rst
>> +
>> +-  Dirty bitmaps can be created at any time and attached to any node
>> +   (not just complete drives.)
> 
> Looks a bit nicer with '.' outside the sub-sentence '()'.
> 

I suppose if I am to be consistent and eschew the double-space following 
a full stop in the name of "It is semantically invalid and serves only 
typesetting purposes," then I should probably also learn to forego my 
typesetter's quotes...

That one is definitely my quirk and not Kashyap's.

>> +
>> +.. contents::
>> +
>> +Dirty Bitmap Names
>> +------------------
>> +
>> +-  A dirty bitmap's name is unique to the node, but bitmaps attached to
>> +   different nodes can share the same name.
>> +
>> +-  Dirty bitmaps created for internal use by QEMU may be anonymous and
>> +   have no name, but any user-created bitmaps may not be. There can be
> 
> s/may not be/must have a name/
> 
> 
>> +
>> +-  This bitmap will have a default granularity that matches the cluster
>> +   size of its associated drive, if available, clamped to between [4KiB,
> 
> s/clamped to/clamped/
> 
>> +   64KiB]. The current default for qcow2 is 64KiB.
>> +
>> +
> 
> 
>> +-  QMP example response, highlighting one success and one failure:
>> +
>> +   -  Acknowledgement that the Transaction was accepted and jobs were
>> +      launched:
> 
> US spelling prefers Acknowledgment, but I think you are okay because of
> UK spelling.
> 

My judgement again. I've never cared for "acknowledgment" and their ilk. 
I've asked before, but do we officially prefer US or UK spellings?

> Again, since these are probably pre-existing and just code motion, and
> if you've gotten positive review of your use of rST, I'm fine with adding:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

This might be the funniest mail I send all day.

--js

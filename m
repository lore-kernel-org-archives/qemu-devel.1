Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEVeJ-0003IW-Sj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEVeI-00008j-V3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:28:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171113152424.25381-1-eblake@redhat.com>
	<87h8tyyuch.fsf@dusky.pond.sub.org>
	<e9e7bf10-bc24-0524-bb02-5328718d124a@redhat.com>
Date: Tue, 14 Nov 2017 08:28:37 +0100
In-Reply-To: <e9e7bf10-bc24-0524-bb02-5328718d124a@redhat.com> (Eric Blake's
	message of "Mon, 13 Nov 2017 12:19:59 -0600")
Message-ID: <87a7zpwc7u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 11/13/2017 11:14 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> When using error prepend(), it is necessary to end with a space
>>> in the format string; otherwise, messages come out incorrectly,
>>> such as when connecting to a socket that hangs up immediately:
>>>
>>> can't open device nbd://localhost:10809/: Failed to read dataUnexpected end-of-file before all bytes were read
>>>
>
>> Preexisting: inconsistent capitalization (Failed vs. failed).
>> 
>> In general, prepend chains looks slightly less ugly when each link
>> starts with a lower case letter.  Compare:
>> 
>>     can't open device nbd://localhost:10809/: failed to read data: unexpected end-of-file before all bytes were read
>>     Can't open device nbd://localhost:10809/: Failed to read data: Unexpected end-of-file before all bytes were read
>> 
>> Neither message is really good, but the second one is ugly to boot.
>
> A tree-wide search shows that we have no strong preference for
> capitalization or not; but I can do a followup patch for at least NBD
> code to prefer lower-case, and enforce that style in future NBD-related
> patches.  Not sure if that followup would be 2.11 material, though.

Tree-wide consistency would take consensus on the new rule, a tree-wide
patch (always a bother) to fix up the code, and a checkpatch patch to
catch regressions.  We got bigger fish to fry.

Local consistency is much easier.  Maintainer's discretion (here:
yours).

>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> 
>
> Thanks

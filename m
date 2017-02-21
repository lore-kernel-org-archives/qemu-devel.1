Received: from eggs.gnu.org ([2001:4830:134:3::10]:57049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6W8-0005YK-9c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6W7-0007JD-Gt
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:13:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-22-git-send-email-armbru@redhat.com>
	<20170220193429.GJ2372@work-vm>
Date: Tue, 21 Feb 2017 10:13:46 +0100
In-Reply-To: <20170220193429.GJ2372@work-vm> (David Alan Gilbert's message of
	"Mon, 20 Feb 2017 19:34:33 +0000")
Message-ID: <87a89fnbxx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Change the qemu_strtosz() & friends to return -EINVAL when @endptr is
>> null and the conversion doesn't consume the string completely.
>> Matches how qemu_strtol() & friends work.
>> 
>> Only test_qemu_strtosz_simple() passes a null @endptr.  No functional
>> change there, because its conversion consumes the string.
>> 
>> Simplify callers that use @endptr only to fail when it doesn't point
>> to '\0' to pass a null @endptr instead.
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
>> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
>> Cc: qemu-block@nongnu.org (open list:Block layer core)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> (end and endptr are horribly confusing names in do_strtosz)

Could rename for consistency with qemu_strtol() & friends:

* Parameter @end to @endptr

* Local variable @endptr to @ep

Would that be useful?

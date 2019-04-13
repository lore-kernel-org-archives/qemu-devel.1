Received: from eggs.gnu.org ([209.51.188.92]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFAl3-00033a-FD
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFAl2-00036c-IL
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hFAl2-00035d-9Y
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A47E8666A
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 04:59:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-18-armbru@redhat.com>
	<20190412183946.GS2906@work-vm>
Date: Sat, 13 Apr 2019 06:59:13 +0200
In-Reply-To: <20190412183946.GS2906@work-vm> (David Alan Gilbert's message of
	"Fri, 12 Apr 2019 19:39:47 +0100")
Message-ID: <87wojyh55q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/17] include: Move fprintf_function to
 disas/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The previous commits have eliminated fprintf_function outside
>> disassemblers, simplifying code and cleaning up the ugly type-punning
>> fprintf_function seems to attract.  Move fprintf_function to
>> include/disas/dis-asm.h to reduce the temptation to abuse it.
>> 
>> I considered renaming it to fprintf_ftype (reverting that part of
>> commit 6e2d864edf5, v0.14.0) to get us closer to binutils, but I
>> figure the fork is too distant to make this worthwhile.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I'm OKish with this - although it's the only place we currently
> use it, it's a fairly common concept, so I'm not sure it's worth
> banishing.

I found 15 uses, ranging from questionable to outright bad.  I
eliminated 14, and cleaned up one.  I guess that has made me skeptical
on the chances of this type getting used sanely.

Banishing the type to where it came from reduces the temptation.

Perhaps that's not actually necessary now we've gotten rid of the bad
examples.

Should a sane use come up, we can simply revert this patch.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

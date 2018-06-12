Received: from eggs.gnu.org ([2001:4830:134:3::10]:34171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSoaO-0005mq-Px
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSoaN-0000bl-Us
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:04:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180607062559.16127-1-armbru@redhat.com>
	<20180607213303.GJ6435@localhost.localdomain>
	<20180612125548.GA19946@localhost.localdomain>
Date: Tue, 12 Jun 2018 21:04:01 +0200
In-Reply-To: <20180612125548.GA19946@localhost.localdomain> (Jeff Cody's
	message of "Tue, 12 Jun 2018 08:55:48 -0400")
Message-ID: <87y3fjn7xa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 00/19] block: Configuration fixes and
 rbd authentication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Jeff Cody <jcody@redhat.com> writes:

> On Thu, Jun 07, 2018 at 05:33:03PM -0400, Jeff Cody wrote:
>> Here are some results from auth testing of various combinations; I haven't
>> completed all the combinations in my matrix yet, but what I have completed
>> looks like what I would expect.
>> 
>> These were all tested with blockdev-add QAPI commands against this patch
>> series.
>> 
>> I'll be away on PTO tomorrow (Friday), so I'll conclude testing on Monday.
>> 
>> Warning, long lines below, so don't read it on a vt220 (apologies in
>> advance if you do...):
>> 
>
> Below is the rest of the matrix filled out.  Everything looks OK to me, the
> ones that were a bit different than I expected were when the server was
> 'none', and we passed an bad key-secret.  But that isn't a qemu/qapi issue,
> and not really an issue at all (just different from what I expected).
>
> Completed tests:
[...]

Looks good to me.  Thanks for your help!

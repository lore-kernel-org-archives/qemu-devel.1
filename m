Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSzBr-0004eG-Kc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSzBn-0006gF-MR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:23:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSzBn-0006fr-HR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19D5C87A7C
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:23:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525843212-31922-1-git-send-email-thuth@redhat.com>
	<87bmch48w6.fsf@dusky.pond.sub.org>
	<a16c729a-8856-1141-5a6f-e647624bab44@redhat.com>
	<dcd08712-9dbd-eeda-7040-40b1afb14429@redhat.com>
Date: Wed, 13 Jun 2018 08:23:25 +0200
In-Reply-To: <dcd08712-9dbd-eeda-7040-40b1afb14429@redhat.com> (Paolo
	Bonzini's message of "Tue, 12 Jun 2018 17:04:07 +0200")
Message-ID: <87d0wvkxwi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/06/2018 12:46, Thomas Huth wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>> CLI is like QMP in that there's infrastructure, interface and
>>> implementation.
>>>=20
>>> QMP infrastructure is MAINTAINERS sections QMP and QAPI.  These are
>>> proper subsystems, with clear boundaries.  Its maintainers get copied on
>>> relatively few patches.
>>>=20
>>> QMP infrastructure doesn't own the actual commands[1], subsystems do.
>>> For instance, the block subsystem owns commands dealing with block
>>> devices.
>>>=20
>>> The QMP interface is specified in the QAPI schema.  Again, QMP
>>> infrastructure doesn't own it, subsystems do.  However, to maintain some
>>> measure of cohesion, we co-maintain the interface: MAINTAINERS section
>>> QAPI schema covers the complete schema, and subsystems cover individual
>>> modules of the schema[2].
>>>=20
>>> I think a similar arrangement make sense for CLI.  We'll get it for free
>>> with CLI QAPIfication, but that'll take time.
>>>
>>> Your patch does what is possible with a monolithic interface definition:
>>> it dumps it all on one maintainer: me.  I'm struggling to keep up with
>>> the QAPI schema, I'm not sure I can take more.
>>>
>>> Note that "Command line option argument parsing" is phrased carefully:
>>> it's not "CLI", not even "CLI parsing".  qemu-options* does not fit
>>> there.  Two solutions: widen the section so it fits better, create a new
>>> section.  The latter would be closer to how we do QMP.
>>>
>>> What do you think?
>> Both ideas sound fine to me. What about adding a new section called
>> "Generic command line options"? I hope that the word "generic" then
>> makes it clear that this entry is primarily thought for generic options
>> - subsystem specific options can and should still go through the
>> subsystem trees instead.

How well would that work in practice?  get_maintainers.pl can't tell
apart "generic" from "specific to subsystem S"...

For QMP, get_maintainers.pl identifies the parts.  Subsystem-specific
parts are co-maintained by subsystem and QAPI schema maintainers, and
expected to go through the subsystem tree.  The "whatever remains" part
is maintained just by QAPI schema maintainers, and goes through various
trees in practice.  Note "whatever remains" > "generic"; it's a bit of a
dumping ground right now.

>> Do you think you could still be available as (co-)maintainer of that new
>> section? If not, who are going to be the maintainers of that new
>> section? Paolo? Eric? Daniel? ...?
>
> Well, currently it's going through me.  I'd add vl.c too, by the way.

vl.c has much more than just CLI parsing.  It's pushing 4kSLOC...
Splitting it up would be nice.  As long as it's not, I guess the
pragmatic solution is to have multiple MAINTAINERS sections claim it:
existing "Main loop", proposed "CLI", ...

Me helping to maintain CLI in addition to some of its infrastructure
would make plenty of sense if my day had 32 hours or so.  Ask Marc-Andr=C3=
=A9
what he thinks of me taking on *more* maintenance %-}

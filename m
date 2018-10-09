Received: from eggs.gnu.org ([2001:4830:134:3::10]:45983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9oCw-0004TY-RY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9oCt-0000TQ-QR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9oCt-0000Sk-IN
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6706307D910
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 09:21:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1538650419-7995-1-git-send-email-thuth@redhat.com>
	<548e06b9-dac6-812d-9347-fc600ac4f559@redhat.com>
Date: Tue, 09 Oct 2018 11:21:32 +0200
In-Reply-To: <548e06b9-dac6-812d-9347-fc600ac4f559@redhat.com> (Paolo
	Bonzini's message of "Thu, 4 Oct 2018 13:43:29 +0200")
Message-ID: <871s8zzd9f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Add an entry for
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

> On 04/10/2018 12:53, Thomas Huth wrote:
>> The file "qemu-options.h", "qemu-options.hx" and "qemu-options-wrapper.h"
>> in the main directory are currently without maintainer according to our
>> get_maintainers.pl script. Considering that the command line options are
>> a public interface and thus quite important, this is quite a bad state.
>> Add an entry for these files which is maintained by Paolo, since the
>> option handling is tightly coupled with the code in vl.c (that Paolo
>> already handles via the "Main loop" entry).
>> 
>> And since I'm interested in the command line interface of QEMU, add
>> myself (and also Markus) as reviewer here.
>
> Sometimes, a file is really only touched as part of changes to other
> files.  Command line options can be changed by block device patches,
> vl.c patches, or something else.  I think changes to qemu-options* alone

Yes.  But when the file in question is an important interface, having
someone in charge of interface design aspects makes sense all the same.
Without that, consistency is left to chance.

Of course, you might say that command line consistency is FUBAR anyway.
You'd have a point.

> are quite rare, and I'd rather not have more stuff added to my misc tree
> (and my inbox)...

Same here.

I serve in such a role for the QAPI schema, together with Eric.  I feel
like I'm pretty consistently failing at keeping up (pardon the pun).  I
haven't thrown in the towel only because I also feel the guidance I
manage to provide there is better than nothing.  But I'd rather not take
on more.

Note that once my project to QAPIfy the CLI (on hold due to other
obligations) is complete, the CLI will be specified in the QAPI schema,
effectively dumping it on the QAPI schema maintainers.  I guess I'm a
sucker for punishment.  Just not right now, please.

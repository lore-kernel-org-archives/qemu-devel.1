Received: from eggs.gnu.org ([2001:4830:134:3::10]:33849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRTkG-0001kc-VY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 20:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRTkD-0000Ie-VO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 20:00:01 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:57865 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRTkD-0000IN-L4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 19:59:57 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
	<20170111174045.GT12072@redhat.com>
Date: Thu, 12 Jan 2017 01:59:52 +0100
In-Reply-To: <20170111174045.GT12072@redhat.com> (Daniel P. Berrange's message
	of "Wed, 11 Jan 2017 17:40:45 +0000")
Message-ID: <87mvexf5yv.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Daniel P Berrange writes:

> On Wed, Jan 11, 2017 at 06:34:40PM +0100, Paolo Bonzini wrote:
[...]
>> > and we can't
>> > use relative includes for that, since the relative include gets
>> > resolved wrt the source file doing the #include, but the trace.h
>> > file is in $BUILD_DIR.
>> 
>> Why would #include "../foo/trace.h" be resolved against the source
>> file's path only, and not against all -I directories?

> If we have a plain "../trace.h", then it can end up hitting the
> wrong file, because there are many -I dirs listed and most of
> them contain a trace.h file, so if it matches on the 2nd -I
> dir and you need the one from the 3rd -I dir it gets "fun".

> Having all the trace.h files included with path from the root
> is alot simpler to understand IMHO than just plain "trace.h"
> and hoping the -I order is going to ensure the right one is
> found

I'm with Daniel and and Eric on this one, for whatever it matters. It's clearer
to *me* to have includes starting on the project's root.


Cheers,
  Lluis

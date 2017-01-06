Received: from eggs.gnu.org ([2001:4830:134:3::10]:54215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPbO0-0004uQ-9e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPbNx-0000To-5l
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:45:16 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:34435 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPbNw-0000R0-QC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:45:13 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-41-berrange@redhat.com>
	<87r34g2k03.fsf@ac.upc.edu> <20170106171813.GV31112@redhat.com>
Date: Fri, 06 Jan 2017 21:45:08 +0100
In-Reply-To: <20170106171813.GV31112@redhat.com> (Daniel P. Berrange's message
	of "Fri, 6 Jan 2017 17:18:13 +0000")
Message-ID: <87bmvj2a0b.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 40/47] trace: switch target/s390x/
 directory to modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Daniel P Berrange writes:

> On Fri, Jan 06, 2017 at 06:09:16PM +0100, Llu=C3=ADs Vilanova wrote:
>> Daniel P Berrange writes:
>>=20
>> > Switch files in the target/s390x/ directory to include the
>> > target/s390x/trace.h file instead of the global trace.h
>> > file.
>>=20
>> > The make rules for gen-features.{h,c} need to be moved
>> > out into the top level Makefile.objs, otherwise make
>> > complains about the rules being defined multiple times
>> > due to target/s390x/Makefile.objs being included
>> > multiple times when expanding different subdir object
>> > lists.
>>=20
>> If the problem is re-definition, you can instead add a guard around the =
rules in
>> target/s390x/Makefile.objs. This avoids defining the rules multiple time=
s but
>> still keeps the target-specific rules in the target-specific makefile.

> What kind of guard to you mean ? What's happening is that the top
> level Makefile.target is including target/s390x/Makefile.objs
> multiple times to expand multiple vars. I don't see a way to
> distinguish which include we're being called from.

I think I did something like this to ensure rules are defined only once:

  ifneq($(TRACE_GUARD_TARGET_S390X),1)
  # ... rules ...
  TRACE_GUARD_TARGET_S390X=3D1
  endif

It's not the cleanest solution, but neither is having target-specific rules=
 in a
generic makefile. Choose your least evil.


Cheers,
  Lluis

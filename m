Received: from eggs.gnu.org ([2001:4830:134:3::10]:44694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRgNe-0000FQ-JB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRgNa-0007NE-2p
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:30 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:52528 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRgNZ-0007Hq-Mi
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:29:26 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
	<20170111174045.GT12072@redhat.com>
	<6ff77c17-5516-e967-27ec-6fb3bf2160d4@redhat.com>
	<87fukpf5ub.fsf@ac.upc.edu>
	<9456f50a-811a-03a7-2bf7-0533dabb0650@redhat.com>
Date: Thu, 12 Jan 2017 15:29:22 +0100
In-Reply-To: <9456f50a-811a-03a7-2bf7-0533dabb0650@redhat.com> (Paolo
	Bonzini's message of "Thu, 12 Jan 2017 09:48:20 +0100")
Message-ID: <87o9zc2vy5.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Paolo Bonzini writes:

> On 12/01/2017 02:02, Llu=C3=ADs Vilanova wrote:
>> Paolo Bonzini writes:
>> [...]
>>> A weird idea: what about doing
>>=20
>>> -DGENERATED_TRACERS_H=3D\"hw/scsi/generated-tracers.h\"
>>=20
>>> and then having
>>=20
>>> #ifdef GENERATED_TRACE_H
>>> #include GENERATED_TRACE_H
>>> #endif
>>=20
>>> in include/trace.h?
>>=20
>>> Then you can use full include path for special cases such as
>>> include/hw/xen/xen_common.h, but the common case is handled directly
>>> with just
>>=20
>>> #include "trace.h"
>>=20
>>> which refers to $(srcdir)/include/trace.h? (Take the above with a grain
>>> of salt because I haven't reviewed the patches closely).
>>=20
>> Feels like too much black magic to me for the benefit of a bit less typi=
ng.

> It's not less typing, it's about consistency.   Includes from the
> current directory are currently included with no path.

Ah, right. My subconscious made me ignore that, since I already said it's
cleaner to me to use the "full" path. Sorry about that :)


Cheers,
  Lluis

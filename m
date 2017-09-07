Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpuVj-0003Kc-KI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpuVf-0002Ob-P3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpuVf-0002OB-JR
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:58:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
Date: Thu, 07 Sep 2017 12:58:05 +0200
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	(=?utf-8?Q?=22Llu=C3=ADs?=
	Vilanova"'s message of "Wed, 6 Sep 2017 20:22:41 +0300")
Message-ID: <87a826epxe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/20] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

> This series adds an API to add instrumentation events.
>
> It also provides additional APIs for:
> * Controlling tracing events
> * Peek/poke guest memory
>
> There's still missing APIs for (can be added in later series?):
> * Provide something like tracing's per-vCPU trace states (i.e., so that e=
ach
>   vCPU can have different instrumentation code). It's still not clear to =
me if
>   we should extend the per-vCPU bitmap with instrumentation events, or ot=
herwise
>   somehow reuse the bits in tracing events (since they're currently limit=
ed).
> * Peek/poke guest registers
>
> The instrumentation code is dynamically loaded as a library into QEMU eit=
her
> when it starts or later using its remote control interfaces.
>
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

Taking a step back.

This looks like a way to dynamically load arbitrary code.  What
interfaces can this code use?  Your cover letter should answer this.

As long as the answer is "everything the dynamic linker is willing to
resolve", this series heading nowhere.  We can talk about an interface
for plugins, but "anything goes" is not on the menu.

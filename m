Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpxgt-0004Nz-1Z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpxgn-0007zQ-Pa
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:21:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpxgn-0007y9-IG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:21:53 -0400
Date: Thu, 7 Sep 2017 10:21:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170907142152.GA19705@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<87a826epxe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a826epxe.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Sep 07, 2017 at 12:58:05 +0200, Markus Armbruster wrote:
> Lluís Vilanova <vilanova@ac.upc.edu> writes:
> 
> > This series adds an API to add instrumentation events.
> >
> > It also provides additional APIs for:
> > * Controlling tracing events
> > * Peek/poke guest memory
> >
> > There's still missing APIs for (can be added in later series?):
> > * Provide something like tracing's per-vCPU trace states (i.e., so that each
> >   vCPU can have different instrumentation code). It's still not clear to me if
> >   we should extend the per-vCPU bitmap with instrumentation events, or otherwise
> >   somehow reuse the bits in tracing events (since they're currently limited).
> > * Peek/poke guest registers
> >
> > The instrumentation code is dynamically loaded as a library into QEMU either
> > when it starts or later using its remote control interfaces.
> >
> > Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Taking a step back.
> 
> This looks like a way to dynamically load arbitrary code.  What
> interfaces can this code use?  Your cover letter should answer this.
> 
> As long as the answer is "everything the dynamic linker is willing to
> resolve", this series heading nowhere.  We can talk about an interface
> for plugins, but "anything goes" is not on the menu.

A simple solution to this is to only export the API symbols by passing
--dynamic-file to the linker -- see patch 2 of the following series for an
example (ELF-only, although I'm pretty sure this can be achieved on Windows
as well):
  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01446.html

Thanks,

		Emilio

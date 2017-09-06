Received: from eggs.gnu.org ([2001:4830:134:3::10]:59693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphQQ-0005AU-Bs
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphQM-0001tN-H7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:59:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dphQM-0001tB-Af
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:59:50 -0400
Date: Wed, 6 Sep 2017 16:59:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906205947.GB25558@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
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
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 06, 2017 at 20:22:41 +0300, Lluís Vilanova wrote:
> This series adds an API to add instrumentation events.
> 
> It also provides additional APIs for:
> * Controlling tracing events

hmm didn't Stefan say that tracing should be decoupled from this?

> * Peek/poke guest memory
> 
> There's still missing APIs for (can be added in later series?):
> * Provide something like tracing's per-vCPU trace states (i.e., so that each
>   vCPU can have different instrumentation code). It's still not clear to me if
>   we should extend the per-vCPU bitmap with instrumentation events, or otherwise
>   somehow reuse the bits in tracing events (since they're currently limited).

As I said in the description of my alternative implementation [*], I don't see
much value in having per-vCPU events, as most instrumenters just care about
the guest application/system. I can only think of cases where the instrumenter
is only interested in a guest process (in system-mode), but that'd be ugly
anyway (would need to change both QEMU and the guest kernel to track the pid).

If the need ever arises, we could add __vcpu(cpu_index) registration functions.

[*] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01446.html

		E.

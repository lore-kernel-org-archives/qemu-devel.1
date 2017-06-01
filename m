Received: from eggs.gnu.org ([2001:4830:134:3::10]:52220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGWCD-0003Le-7z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGWC9-0006Lr-VX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:55:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dGWC9-0006LK-NC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:55:45 -0400
Date: Thu, 1 Jun 2017 15:55:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170601195544.GB10517@flamenco>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v7 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 13, 2017 at 21:48:09 +0100, Lluís Vilanova wrote:
(snip)
> To handle both issues, this series integrates the dynamic tracing event state
> into the TB hashing function, so that vCPUs tracing different events will use
> separate TBs. Note that only events with the 'vcpu' property are used for
> hashing (as stored in the bitmap of CPUState->trace_dstate).

Is this going to be picked up by anyone? AFAICT the patchset is close
to being merge-ready.

Lluís: I'm very interested in your instrumentation work [1]:

- How much up to date are the branches in [1]? I couldn't find this
  v7 iteration in there, although maybe I didn't look carefully enough.

- Are you planning on upstreaming it? I have some time to help with
  that if you're interested.

- Do you have instrumentation examples beyond what's in
  docs/instrumentation.txt? In particular I'd like to see how the basic
  block (BBL) instrumentation works, i.e. how a 'skeleton' simulator
  would work to decode the guest instructions and also track their
  dependences.

Thanks,

		Emilio

[1] https://projects.gso.ac.upc.edu/projects/qemu-dbi

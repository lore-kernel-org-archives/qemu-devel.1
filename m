Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlP41-0003gh-81
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlP3w-0004IP-IS
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:35:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dlP3v-0004I3-Tu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:34:56 -0400
Date: Fri, 25 Aug 2017 20:34:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170826003454.GA23546@flamenco>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v8 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Sun, Jul 30, 2017 at 17:08:18 +0300, Lluís Vilanova wrote:
> The hypertrace channel allows guest code to emit events in QEMU (the host) using
> its tracing infrastructure (see "docs/trace.txt"). This works in both 'system'
> and 'user' modes, is architecture-agnostic and introduces minimal noise on the
> guest.
> 
> See first commit for a full description, use-cases and an example.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>

This would be indeed very useful once TCG instrumentation is in place.

However, I'm not very excited about this being PCI-only and Linux-only for
system mode
I wonder how we could make this work on all hosts -- did you consider using
"magic" instructions? We'd need a different magic instruction for each
guest ISA, but the library would hide that anyway (and the library code
would be the same for user and system modes).

Thanks,

		Emilio

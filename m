Received: from eggs.gnu.org ([2001:4830:134:3::10]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLZ64-000564-I7
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLZ61-0002wZ-Gw
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:02:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLZ61-0002wB-7s
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:02:17 -0400
Date: Thu, 15 Jun 2017 14:02:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170615180216.GA8411@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [RFC PATCH v6 0/6] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 12, 2017 at 17:53:47 +0300, Lluís Vilanova wrote:
> This series proposes a generic (target-agnostic) instruction translation
> framework.
> 
> It basically provides a generic main loop for instruction disassembly, which
> calls target-specific functions when necessary. This generalization makes
> inserting new code in the main loop easier, and helps in keeping all targets in
> synch as to the contents of it.
> 
> This series also paves the way towards adding events to trace guest code
> execution (BBLs and instructions).
> 
> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits in the
> current organization, but will port the rest when this series gets merged.

It seems patch 5 didn't make it through the list (the list drops patches
sometimes):
  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02833.html

I think I've found it in your qemu-dbi tree though (1c97cf92b06).
I pasted it here: https://pastebin.ca/3832616

		E.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dM2Eo-0007d7-Gn
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 21:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dM2El-0004Gy-DW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 21:09:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dM2El-0004G8-73
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 21:09:15 -0400
Date: Fri, 16 Jun 2017 21:09:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170617010913.GA27059@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco> <20170615232507.GA15332@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615232507.GA15332@flamenco>
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, Jun 15, 2017 at 19:25:07 -0400, Emilio G. Cota wrote:
> Also, consider keeping the @is_jmp name instead of renaming it to
> @jmp_type. (@jmp would be shorter but it would be confusing though,
> e.g. cris has both dc->jmp and dc->is_jmp.)

It turns out that keeping the original names also makes the diff's
a lot more bearable.

I have a WIP branch with further modifications to your patches; the goal
is to break down the patchset to make it more easily reviewable, which
hopefully will also prevent us from introducing bugs.

You can see the WIP tree at:
  https://github.com/cota/qemu/tree/trloop
Note that I may rebase this branch any time.

Cheers,

		Emilio

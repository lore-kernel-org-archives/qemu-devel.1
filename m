Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1faBuC-0006EV-GL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1faBu7-0004Ub-Ji
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:23:04 -0400
Date: Mon, 2 Jul 2018 23:22:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180703032257.GA29222@flamenco>
References: <1530568927-4738-1-git-send-email-cota@braap.org>
	<20180703010348.GG3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703010348.GG3422@umbus.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Jul 03, 2018 at 11:03:48 +1000, David Gibson wrote:
> On Mon, Jul 02, 2018 at 06:02:07PM -0400, Emilio G. Cota wrote:
> > The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
> > to TranslatorOps", 2018-02-16).
> > 
> > Fix it by setting is_jmp, so that we break from the translation loop
> > as originally intended.
> > 
> > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> > (I'll send this to qemu-stable (for 2.12) once it's on master.)
> 
> Applied to ppc-for-3.0.  It's kind of lucky I happened to pick this up
> on qemu-ppc - I'm not able to read that all the time.  Things will get
> merged much faster if you CC me directly on things to go through the
> ppc tree.

Sorry I forgot to Cc you -- will do better next time.

Thanks,

		Emilio

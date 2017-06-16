Received: from eggs.gnu.org ([2001:4830:134:3::10]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwKt-0002dh-RX
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwKq-00039R-Ot
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:51:11 -0400
Date: Fri, 16 Jun 2017 14:50:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170616185056.GA3055@flamenco>
References: <1497567879-13734-1-git-send-email-cota@braap.org>
	<1497567879-13734-2-git-send-email-cota@braap.org>
	<df6ef6c7-6bb5-a509-5e8e-66757598b11f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6ef6c7-6bb5-a509-5e8e-66757598b11f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] gen-icount: pass cpu_env as a
 parameter to gen_* inlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Fri, Jun 16, 2017 at 10:32:14 +0200, Paolo Bonzini wrote:
> On 16/06/2017 01:04, Emilio G. Cota wrote:
> >              va = dest_gpr(ctx, ra);
> >              if (ctx->tb->cflags & CF_USE_ICOUNT) {
> > -                gen_io_start();
> > +                gen_io_start(cpu_env);
> >                  gen_helper_load_pcc(va, cpu_env);
> > -                gen_io_end();
> > +                gen_io_start(cpu_env);
> 
> Careful, looks like a cut-and-paste issue here.

Ouch, messed up the regex there -- thanks.

Fixed in the upcoming v2, which doesn't need to go through all this churn
and instead takes the value from tcg_ctx as Richard pointed out.

		E.

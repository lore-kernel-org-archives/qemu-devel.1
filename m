Received: from eggs.gnu.org ([2001:4830:134:3::10]:36320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhv1-000888-M3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhuy-0005fb-GN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:05:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYhuy-0005fL-8B
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:05:12 -0400
Date: Fri, 21 Jul 2017 20:05:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170722000511.GA9909@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-31-rth@twiddle.net>
	<20170721230258.GN10809@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170721230258.GN10809@flamenco>
Subject: Re: [Qemu-devel] [PATCH v14 30/34] target/arm: [tcg] Port to
 generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, vilanova@ac.upc.edu

On Fri, Jul 21, 2017 at 19:02:58 -0400, Emilio G. Cota wrote:
> On Fri, Jul 14, 2017 at 23:42:39 -1000, Richard Henderson wrote:
> > From: Lluís Vilanova <vilanova@ac.upc.edu>
> > 
> > Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> > Message-Id: <150002631325.22386.10348327185029496649.stgit@frigg.lan>
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/arm/translate.h     |   8 +---
> >  target/arm/translate-a64.c | 107 ++++++++-----------------------------------
> >  target/arm/translate.c     | 110 ++++++++++-----------------------------------
> >  3 files changed, 42 insertions(+), 183 deletions(-)
> 
> (snip)
> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index 4ea5f70..4b1230b 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -11897,7 +11897,9 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
> >          TCGv_i32 tmp = tcg_temp_new_i32();
> >          tcg_gen_movi_i32(tmp, 0);
> >          store_cpu_field(tmp, condexec_bits);
> > +        tcg_temp_free_i32(tmp);
> 
> This seems unrelated to the patch. Perhaps a better place to add
> this fix would be patch 20, with a mention to it in the commit log.
> Or just keep it here, but mention it in the commit log.

Silly me. This must go away, because store_cpu_field already
frees the temp.

		E.

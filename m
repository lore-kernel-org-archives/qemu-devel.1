Received: from eggs.gnu.org ([2001:4830:134:3::10]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjMy-00057v-TT
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEj9E-0001M8-KG
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 18:58:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gEj9D-0001Kq-Ub
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 18:58:08 -0400
Date: Mon, 22 Oct 2018 18:58:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181022225804.GA29980@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-8-cota@braap.org>
	<38c8c109-c231-696e-2fb8-4fae6f3fb641@linaro.org>
	<fde51a9d-331b-1456-d93a-cd015e8caba9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde51a9d-331b-1456-d93a-cd015e8caba9@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 07/56] target/m68k: rename cpu_halted to
 cpu_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On Sun, Oct 21, 2018 at 14:38:38 +0100, Richard Henderson wrote:
> On 10/21/18 1:53 PM, Richard Henderson wrote:
> > On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> >> To avoid a name clash with the soon-to-be-defined cpu_halted() helper.
> >>
> >> Cc: Laurent Vivier <laurent@vivier.eu>
> >> Signed-off-by: Emilio G. Cota <cota@braap.org>
> >> ---
> >>  target/m68k/translate.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Although for this usage it's probably better to avoid the
> > tcg_global_mem_new_i32 and just use tcg_gen_st_i32.
> 
> And, as I read further, you need to convert this use to a helper call.
> Otherwise you've still got an unlocked direct modification to cpu->halted
> from within the TCG generated code.
> 
> There are several other targets that do the same thing: alpha, cris, hppa,
> mips, microblaze, ppc.  And typically they will do exactly the same thing: set
> the flag and then raise the halt exception.

Ouch -- I entirely missed these!

For v4, I defined helper_cpu_halted_set in tcg-runtime, and
converted all direct setters to it.

Thanks,

		Emilio

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1caksS-0008GU-8O
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1caksR-0008FJ-EQ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:06:48 -0500
Date: Mon, 6 Feb 2017 16:06:33 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170206150633.GQ9606@toto>
References: <1486144135-4894-1-git-send-email-peter.maydell@linaro.org>
	<1486144135-4894-3-git-send-email-peter.maydell@linaro.org>
	<20170204143132.GP9606@toto>
	<CAFEAcA9ybZzMPKMUUyrALGq4ufwBbWPFAtZEctHmA1CKnnpLgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ybZzMPKMUUyrALGq4ufwBbWPFAtZEctHmA1CKnnpLgQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/arm: A32,
 T32: Create Instruction Syndromes for Data Aborts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, Feb 06, 2017 at 02:53:49PM +0000, Peter Maydell wrote:
> On 4 February 2017 at 14:31, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > On Fri, Feb 03, 2017 at 05:48:55PM +0000, Peter Maydell wrote:
> >> Add support for generating the ISS (Instruction Specific Syndrome)
> >> for Data Abort exceptions taken from AArch32. These syndromes are
> >> used by hypervisors for example to trap and emulate memory accesses.
> >>
> >> This is the equivalent for AArch32 guests of the work done for AArch64
> >> guests in commit aaa1f954d4cab243.
> 
> >> +static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
> >> +{
> >> +    /* We don't need to save all of the syndrome so we mask and shift
> >> +     * out uneeded bits to help the sleb128 encoder do a better job.
> >> +     */
> >> +    syn &= ARM_INSN_START_WORD2_MASK;
> >> +    syn >>= ARM_INSN_START_WORD2_SHIFT;
> >> +
> >> +    /* We check and clear insn_start_idx to catch multiple updates.  */
> >> +    assert(s->insn_start_idx != 0);
> >> +    tcg_set_insn_param(s->insn_start_idx, 2, syn);
> >> +    s->insn_start_idx = 0;
> >> +}
> >
> > Could we move this into translate.h and share it with translate-a64.c?
> 
> Sure; I'll just squash that change into this patch and put the
> results into the target-arm queue, rather than burdening the
> list with a v3 respin, if that's OK.

Sounds good, thanks!

Cheers,
Edgar

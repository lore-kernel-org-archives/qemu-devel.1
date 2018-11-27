Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRSKe-0007OW-BM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRSKa-0002Cr-BP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:38:32 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRSKa-0002Cl-7r
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:38:28 -0500
Date: Mon, 26 Nov 2018 20:38:25 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127013825.GE22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
	<7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Mon, Nov 26, 2018 at 11:30:25 -0800, Richard Henderson wrote:
> On 11/26/18 11:07 AM, Emilio G. Cota wrote:
> > The main reason why I added the qemu_plugin_insn_append calls
> > was to avoid reading the instructions twice from guest memory,
> > because I was worried that doing so might somehow alter the
> > guest's execution, e.g. what if we read a cross-page instruction,
> > and both pages mapped to the same TLB entry? We'd end up having
> > more TLB misses because instrumentation was enabled.
> 
> A better solution for this, I think is to change direct calls from
> 
>   cpu_ldl_code(env, pc);
> to
>   translator_ldl_code(dc_base, env, pc);
> 
> instead of passing around a new argument separate from DisasContextBase?

I think this + diff'ing pc_next should work to figure out the
contents and size of each instruction.

I'll do it this way in v2.

Thanks,

		Emilio

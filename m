Received: from eggs.gnu.org ([2001:4830:134:3::10]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUt0S-0006QN-MX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUt0R-00050y-QP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:11:36 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUt0R-00050U-KK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:11:35 -0400
Received: by mail-ot0-x241.google.com with SMTP id p95-v6so18180563ota.5
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 05:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1425bf1a-1502-b614-ffb1-b261cb24d1de@greensocs.com>
References: <20180606093101.30518-1-luc.michel@greensocs.com>
	<20180606093101.30518-4-luc.michel@greensocs.com>
	<CAFEAcA9Oh+faKrBwDb7LAG=drkQTtbtoOrV_WUqa7twJi974yQ@mail.gmail.com>
	<1425bf1a-1502-b614-ffb1-b261cb24d1de@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Jun 2018 13:11:14 +0100
Message-ID: <CAFEAcA9eU331c+hYQZ-+Y-G9iL-aUZhBpFBbFmxemfK-=ued8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/6] intc/arm_gic: Add the virtualization
 extensions to the GIC state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 18 June 2018 at 12:50, Luc Michel <luc.michel@greensocs.com> wrote:
> Indeed you are right, h_apr is a leftover that is not used in my
> implementation. I use apr[0] of the vCPU interface to store the APR
> value. If it's ok like this, I can simply remove h_apr from the struct
> and from the virt VMState.
>
> The same goes for h_eisr and h_elrsr, which are in the struct as a
> cached data, but that can be recomputed from the LRs, and thus don't
> need to be stored in the VMState. In my implementation they are
> recomputed in the VMState post_load function.
>
> If you agree with that, I'm going to publish a v2 with migration
> compatibility and without those three registers in the VMState.

Sounds fine to me (though keeping the APR in particular in the
same array as the physical APR values is the ugliest part of
maintaining migration compat so in that case I think it's worth
at least considering whether having the code look in h_apr
would be nicer overall).

Where struct fields are just cached-data, a brief comment in
the struct definition to that effect is helpful.

thanks
-- PMM

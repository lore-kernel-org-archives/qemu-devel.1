Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRH9u-0001Bo-PL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRH9u-0001IY-0q
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:42:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRH9t-0001I3-TE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:42:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so16617743otl.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 05:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
	<20181123135450.24829-2-edgar.iglesias@gmail.com>
	<75bcddbc-da2d-aeb3-71d3-52b635520d2a@redhat.com>
	<20181123165945.GM1148@toto>
	<CAFEAcA8vWT5sayyBzbU7S8BwA06Kj=G1izioufjHFJdsEkyq4g@mail.gmail.com>
	<20181126125230.GO1148@toto>
In-Reply-To: <20181126125230.GO1148@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 13:42:29 +0000
Message-ID: <CAFEAcA_AZWwW7uQFCScBSZnw23AOQFcqXGXDRfZKnz6E3-yCBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, mbilal <muhammad_bilal@mentor.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Mon, 26 Nov 2018 at 12:52, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> On Fri, Nov 23, 2018 at 05:09:35PM +0000, Peter Maydell wrote:
> > On Fri, 23 Nov 2018 at 16:59, Edgar E. Iglesias
> > <edgar.iglesias@gmail.com> wrote:
> > > Not sure if it's too late to even get the removal of the assert into this release? Peter?
> >
> > If you're happy that removing the assert is the correct fix,
> > yes, this could go in before rc3 next week.
>
>
> Yes, I think removing the assert is a suitable fix for the release.

OK, I have applied this to target-arm.next for rc3.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3K1E-000082-LA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3K19-0007L5-31
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:17:56 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3K18-0007KF-U3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:17:51 -0400
Received: by mail-wm0-x230.google.com with SMTP id m123so120820165wma.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:17:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b196d1fa-3db5-6d9b-8eff-dda153f23a01@twiddle.net>
References: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
	<b196d1fa-3db5-6d9b-8eff-dda153f23a01@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 11:17:28 +0100
Message-ID: <CAFEAcA_fD-MZR2RP4yXmskhqe9VJVKvwXPOzeU-T1+TboyzE1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/3] split core mmu_idx from ARMMMUIdx values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 26 April 2017 at 11:07, Richard Henderson <rth@twiddle.net> wrote:
> On 04/24/2017 06:33 PM, Peter Maydell wrote:
>>
>> Overall questions:
>>   * does this look like it's workable enough to justify taking
>>     it rather than the simple-but-worse-perf-on-some-archs
>>     option 1 ?
>
>
> I think it's workable.

Yes, I think I agree overall.

>>   * this does risk breaking A profile in corner cases, because
>>     C unfortunately doesn't typecheck int vs enum so if I forgot
>>     a call to an index conversion function somewhere things will
>>     break. are we happy the risk isn't too huge?
>
>
> If you like, we could add a tcg_debug assert somewhere that verifies that
> the given index is < NB_MMU_MODES...

There is one already, because in my testing I ran into it.
The problem is that since it's a runtime assert, it's not
certain that I caught everything.

thanks
-- PMM

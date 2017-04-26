Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3Jqt-0003hJ-NB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3Jqn-00026g-Q5
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:07:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b196d1fa-3db5-6d9b-8eff-dda153f23a01@twiddle.net>
Date: Wed, 26 Apr 2017 12:07:05 +0200
MIME-Version: 1.0
In-Reply-To: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] split core mmu_idx from ARMMMUIdx values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/24/2017 06:33 PM, Peter Maydell wrote:
> Overall questions:
>   * does this look like it's workable enough to justify taking
>     it rather than the simple-but-worse-perf-on-some-archs
>     option 1 ?

I think it's workable.

>   * this does risk breaking A profile in corner cases, because
>     C unfortunately doesn't typecheck int vs enum so if I forgot
>     a call to an index conversion function somewhere things will
>     break. are we happy the risk isn't too huge?

If you like, we could add a tcg_debug assert somewhere that verifies that the 
given index is < NB_MMU_MODES...


r~

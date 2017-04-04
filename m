Received: from eggs.gnu.org ([2001:4830:134:3::10]:52390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvN1P-0006ts-8j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvN1O-0006Dr-HA
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:53:15 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvN1O-0006Dl-9W
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:53:14 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k6so206960816wre.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 04:53:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170313184750.429-1-krzk@kernel.org>
References: <20170313184750.429-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 12:52:51 +0100
Message-ID: <CAFEAcA8ErNnDj9XsJGG0ziDyeCA+T_N-HZf1DhXSAVTvzG=wPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hw/arm/exynos: Minor cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 13 March 2017 at 18:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> Minor cleanups, no dependencies.
>
> Changes since v1
> ================
> 1. Patch 1/3: Address missed Philippe's comments about error reporting
>    verbosity.
>
> Changes since v2
> ================
> 1. Patch 1/3: Address Eric's comment.
> 2. Patch 2/3: Address Peter's comments about "const".
> 3. Patch 3/3: Use "unsigned int". I had impression that no consensus was
>    reached during discussion. If that is wrong impression, let me know.

Applied to target-arm.next for 2.10, thanks.

(I wrapped a long line in patch 1 that checkpatch complains about.)

thanks
-- PMM

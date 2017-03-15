Received: from eggs.gnu.org ([2001:4830:134:3::10]:56645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co3wH-0006zv-H8
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co3wC-00069b-JN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:05:45 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1co3wC-000690-CD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:05:40 -0400
Received: by mail-wm0-x230.google.com with SMTP id t189so16236709wmt.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 01:05:40 -0700 (PDT)
References: <20170313180432.7067-1-krzk@kernel.org> <87mvcnpzll.fsf@linaro.org>
	<20170314173513.wruppu4js7ikaxu2@kozik-lap>
	<CAHDbmO1apk81csbC7BJK2JFK23fvVBLb-wA5z7_y29T=ueFPyg@mail.gmail.com>
	<20170314185632.kzbccv2y7ah3nhqd@kozik-lap>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170314185632.kzbccv2y7ah3nhqd@kozik-lap>
Date: Wed, 15 Mar 2017 08:05:56 +0000
Message-ID: <87k27rotgb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/5] hw: arm: exynos: Bring
 up secondary CPU + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


Krzysztof Kozlowski <krzk@kernel.org> writes:

> On Tue, Mar 14, 2017 at 06:24:33PM +0000, Alex Bennée wrote:
>> That means you're on a pre-mttcg tree so that's not the reason.
>
> I managed to build it on current master (v2.8.0-2182-g5e2fb7c598c6). It
> behaves the same (with "-accel tcg,thread=single": cannot reach
> switching to init).

Interesting. Can you post your exact qemu command line and I'll have a
go at reproducing.

In the meantime you can always --enable-debug-tcg your build and see if
any of the asserts fire.

>
> Best regards,
> Krzysztof


--
Alex Bennée

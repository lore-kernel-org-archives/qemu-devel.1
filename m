Received: from eggs.gnu.org ([2001:4830:134:3::10]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnrcj-0005IL-8D
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnrci-0006Lv-HV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:56:45 -0400
Date: Tue, 14 Mar 2017 20:56:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170314185632.kzbccv2y7ah3nhqd@kozik-lap>
References: <20170313180432.7067-1-krzk@kernel.org> <87mvcnpzll.fsf@linaro.org>
	<20170314173513.wruppu4js7ikaxu2@kozik-lap>
	<CAHDbmO1apk81csbC7BJK2JFK23fvVBLb-wA5z7_y29T=ueFPyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHDbmO1apk81csbC7BJK2JFK23fvVBLb-wA5z7_y29T=ueFPyg@mail.gmail.com>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, Mar 14, 2017 at 06:24:33PM +0000, Alex Benn=C3=A9e wrote:
> That means you're on a pre-mttcg tree so that's not the reason.

I managed to build it on current master (v2.8.0-2182-g5e2fb7c598c6). It
behaves the same (with "-accel tcg,thread=3Dsingle": cannot reach
switching to init).

Best regards,
Krzysztof

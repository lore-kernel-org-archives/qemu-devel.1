Received: from eggs.gnu.org ([2001:4830:134:3::10]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksJ9-0005zx-3v
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksJ8-0001Su-9H
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:04:11 -0500
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-3-krzk@kernel.org>
	<2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
	<CAFEAcA8DOfstrMiEBLsgf6U6S9uT9ahA1ALrJdmQhcV+7K8Obw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4989d5b6-586a-de18-e8e6-6ab9e9ac131c@redhat.com>
Date: Mon, 6 Mar 2017 14:03:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8DOfstrMiEBLsgf6U6S9uT9ahA1ALrJdmQhcV+7K8Obw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/misc/exynos4210_pmu:
 Reorder local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On 06/03/2017 10:46, Peter Maydell wrote:
> On 6 March 2017 at 04:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>> your change seems OK but while you are here, 'unsigned' is considered
>> harmful since more than a decade.
>=20
> Considered harmful by who, and why?

It is true that unsigned has all the disadvantages of "int" (it may be
smaller than the size of the object" and all the disadvantages of
"size_t" (it doesn't optimize as well because the compiler cannot
exploit undefined behavior).

I wouldn't call it harmful, but it feels like the worst of both worlds.

Paolo

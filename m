Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUEb-0001Ya-SU
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUEa-0007df-UF
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:11:37 -0500
MIME-Version: 1.0
In-Reply-To: <af0b2841-feb6-cf3b-ac7f-4b681916ee10@amsat.org>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<CAFEAcA-gEjU+rBWSL8V4d520DOVheZoJZ76p5=9hmkXk3NqeOw@mail.gmail.com>
	<af0b2841-feb6-cf3b-ac7f-4b681916ee10@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:11:33 -0800
Message-ID: <CAHQ1cqE+4igRM3mtPP+SkwfCpa7kiw0qwqdkkzQBtf+SV4a_Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] i.MX FEC and SD changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Wed, Dec 13, 2017 at 6:09 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Andrey, Peter,
>
> On 12/12/2017 02:40 PM, Peter Maydell wrote:
>> On 11 December 2017 at 21:29, Andrey Smirnov <andrew.smirnov@gmail.com> =
wrote:
>>> Hi everyone,
>>>
>>> This patchset is a spin-off from original i.MX7 support submission
>>> found here [1], containing all of the patchest that are more or less
>>> agreed upon and are ready (hopefully!) for inclusion.
> [...]
>> Incidentally we should use the new i.MX SDHCI controller in the
>> imx6: coincidentally somebody ran into this bug recently:
>> https://stackoverflow.com/questions/47538951/qemu-freescale-i-mx6-dualli=
te-sabre-root-filesystem-does-not-mount/47552596
>>
>> I'll retest that this patchset works with my imx6 image, and
>> send a patch to sit on top of it to switch imx6 over to TYPE_IMX_USDHC.
>
> If you don't mind, I'd like to take the patches 12/13 (SDHCI) and adapt
> them to the SDHCI series I'm working on, to avoid a big diverge/clash.
>

I am fine with patches going in either way. I'll submit a v2 of my
patchset and if we decide to push SD portion of it as a part of your
work, then you can just pick those from there.

Thanks,
Andrey Smirnov

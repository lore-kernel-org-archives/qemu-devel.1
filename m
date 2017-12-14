Received: from eggs.gnu.org ([2001:4830:134:3::10]:56580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIxp-0003E4-TO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIxm-0000oz-TH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:09:34 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<CAFEAcA-gEjU+rBWSL8V4d520DOVheZoJZ76p5=9hmkXk3NqeOw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af0b2841-feb6-cf3b-ac7f-4b681916ee10@amsat.org>
Date: Wed, 13 Dec 2017 23:09:16 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gEjU+rBWSL8V4d520DOVheZoJZ76p5=9hmkXk3NqeOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/13] i.MX FEC and SD changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

Hi Andrey, Peter,

On 12/12/2017 02:40 PM, Peter Maydell wrote:
> On 11 December 2017 at 21:29, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Hi everyone,
>>
>> This patchset is a spin-off from original i.MX7 support submission
>> found here [1], containing all of the patchest that are more or less
>> agreed upon and are ready (hopefully!) for inclusion.
[...]
> Incidentally we should use the new i.MX SDHCI controller in the
> imx6: coincidentally somebody ran into this bug recently:
> https://stackoverflow.com/questions/47538951/qemu-freescale-i-mx6-duallite-sabre-root-filesystem-does-not-mount/47552596
> 
> I'll retest that this patchset works with my imx6 image, and
> send a patch to sit on top of it to switch imx6 over to TYPE_IMX_USDHC.

If you don't mind, I'd like to take the patches 12/13 (SDHCI) and adapt
them to the SDHCI series I'm working on, to avoid a big diverge/clash.

Regards,

Phil.

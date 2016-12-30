Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cMveM-0006EP-Il
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cMveJ-0007L8-CW
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:47:06 -0500
From: "Krzeminski, Marcin (Nokia - PL/Wroclaw)" <marcin.krzeminski@nokia.com>
Date: Fri, 30 Dec 2016 10:13:17 +0000
Message-ID: <AM4PR0701MB2130E7AB34BFBB36FCB75E53FE6A0@AM4PR0701MB2130.eurprd07.prod.outlook.com>
References: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
	<1481894559-13974-2-git-send-email-marcin.krzeminski@nokia.com>,
	<CAFEAcA-ODRCg1t=6iFBE5oue8X5GSHDXYWV2uy6sFttE8_tG6Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-ODRCg1t=6iFBE5oue8X5GSHDXYWV2uy6sFttE8_tG6Q@mail.gmail.com>
Content-Language: pl-PL
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Odp.: [RFC 1/3] nvic: Add CPU numebr property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "rfsw-patches@mlist.nokia.com" <rfsw-patches@mlist.nokia.com>, "mar.krzeminski@gmail.com" <mar.krzeminski@gmail.com>

Hi Peter,

sorry for late response - I missed your email.

> On 16 December 2016 at 13:22,  <marcin.krzeminski@nokia.com> wrote:
>> From: Marcin Krzeminski <marcin.krzeminski@nokia.com>
>>
>> In case of MultiCPU SoC M3 is not always CPU0.
>> This commit add cpu_id property to allow set CPU
>> number for NVIC model. Also address space that this used
>> by NVIC is updated to mach CPU's one.
>>
>> Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
>
> The right fix for this I think is probably for the NVIC to
> have an actual pointer to its CPU object, which the armv7m_init
> code sets up (perhaps with QOM links?) when it creates the CPU
> and the NVIC. The two really do need to be closely coupled,
> and the CPU already has a pointer to its NVIC. There's
> no need for the NVIC to get the CPU pointer by looking it up
> by CPU ID.

I was thinking about similar solution (maybe the same as you did in GIC v3)=
.
Generally this should be done automatically without any user interact.
>
> Once I've got the GICv3 virtualization out of the way, the
> next thing on my todo list is to pick up the NVIC refactoring
> that Michael Davidsaver posted last year:
>  https://lists.nongnu.org/archive/html/qemu-devel/2015-12/msg00504.html
> which makes some moves in that direction (though it doesn't
> init the NVIC's CPU pointer with a link, it just assumes
> first_cpu).

That is good news ;]. I think we can postpone this work until NVIC
refactoring will be finished.

Thanks,
Marcin
>
> thanks
> -- PMM
>

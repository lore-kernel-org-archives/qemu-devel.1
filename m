Received: from eggs.gnu.org ([2001:4830:134:3::10]:60283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTAld-0000SH-He
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTAlY-0002xa-2u
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:08:24 -0500
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:60601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTAlX-0002xN-SU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:08:20 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 80DFA6CBF5
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 18:08:17 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<CAFEAcA_4+potq55ep0ZQhpX2-31W_K6-0aoNAEWWKcm+ZqAPtA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2bda058-5367-21e1-7639-b4b13d00c822@kaod.org>
Date: Mon, 16 Jan 2017 18:08:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4+potq55ep0ZQhpX2-31W_K6-0aoNAEWWKcm+ZqAPtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Aspeed SMC controller fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 01/16/2017 06:00 PM, Peter Maydell wrote:
> On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Hello,
>>
>> I have reduced the patchset size to focus on some improvements of the
>> SMC (Flash) controller model only and will address the watchdog and
>> network models in other patchset.
>>
>> The main benefit of this series is to enable booting directly from a
>> flash image containing U-Boot. It adds :
>>
>>  - some minor fixes and code rearrangements
>>  - Command mode support. Flash contents is accessed directly on the
>>    AHB bus
>>  - auto strapping of configuration for boot flash
>>  - use CE0 as a boot ROM. Today, qemu can not boot from a MMIO region.
>>    As this is complex to do (TCG layer modification), we use a ROM
>>    region in which we copy the flash contents. Hopefully, I got it
>>    right this time.
>>  - dummy bytes support for Command mode only
>>
>> Still in the pipe for the SMC controller are :
>>
>>  - DMA support
>>  - dummy bytes support in user mode (hacky)
>>
>> which I will send later.
>=20
> Applied 1-10 to target-arm.next, but not 11 since there
> seemed to be some discussion on whether it was correct.

yes. 11 needs a change in the condition which is used=20
to send dummies. After that, I think we should be fine=20
for dummy support in Command mode, which we need to boot.

For User mode, this is another story.  =20

Thanks,

C.=20

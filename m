Received: from eggs.gnu.org ([2001:4830:134:3::10]:44391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXovU-0007vA-AQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXovP-00032F-Ke
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXovP-00031b-BS
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id q26so6062146wmf.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:58:47 -0800 (PST)
References: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
	<154472615125.23782.34468593847836502.malone@soybean.canonical.com>
	<87k1kc1afl.fsf@linaro.org>
	<CAFEAcA9ZjB8FidPOyjKwqP+PMaoNfD0szVk_XbQk11LzSU_ZfQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9ZjB8FidPOyjKwqP+PMaoNfD0szVk_XbQk11LzSU_ZfQ@mail.gmail.com>
Date: Fri, 14 Dec 2018 14:58:43 +0000
Message-ID: <87h8fg17fg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1806824] Re: SIE-200 (TrustZone) MPC: BLK_MAX
 returns an incorrect value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: 1806824@bugs.launchpad.net, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Dec 2018 at 13:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Thanks for the bug report and the test program. The fix seems straight=
forward -- just adjust what we return for the register value. I've sent a p=
atch:
>> > http://patchwork.ozlabs.org/patch/1013034/
>>
>> I know you had a bunch of M-profile test cases. Once we get tcg system
>> tests enabled would it be worth porting some of those into the QEMU src
>> tree?
>
> I don't have anything suitable -- unless we have
> support for "system test of this guest kernel", in which case
> we could add the arm trusted firmware boot/selftests.

That's the next step, enabling the building of a known good test case
from an external tree and depositing the images in the right place so we
can use them as tests.

Things like LTP, kvm-unit-tests and various kernels.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

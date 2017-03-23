Received: from eggs.gnu.org ([2001:4830:134:3::10]:33167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cr0xc-0001AT-0Y
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cr0xW-000518-EA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:31:20 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cr0xW-0004zv-82
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:31:14 -0400
Received: by mail-wm0-x22d.google.com with SMTP id u132so58600398wmg.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:31:14 -0700 (PDT)
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
	<87d1d8xn41.fsf@linaro.org>
	<CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
Date: Thu, 23 Mar 2017 11:31:11 +0000
Message-ID: <87bmssxm9s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 23 March 2017 at 11:13, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Technically its not a random thread its the vCPU context (which ensures
>> the vCPU isn't updating while the display is being updated). But I guess
>> the Cocoa is limited to not being able to update from an arbitrary
>> thread?
>
> Yes. It's very common for windowing libraries to mandate that you
> do all windowing operations from one specific thread.

Fair enough. Well let me know if that works OK on MacOS and I'll fold it
in to the other console patches. In fact I might as well do the
start/end_exclusive dance for all OSes and it will achieve the same thing.

--
Alex Bennée

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0jO-0005qk-5D
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0jN-0007gh-BR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:16:38 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr0jN-0007gU-57
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:16:37 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n11so57996884wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:16:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d1d8xn41.fsf@linaro.org>
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
	<87d1d8xn41.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 11:16:15 +0000
Message-ID: <CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 23 March 2017 at 11:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Technically its not a random thread its the vCPU context (which ensures
> the vCPU isn't updating while the display is being updated). But I guess
> the Cocoa is limited to not being able to update from an arbitrary
> thread?

Yes. It's very common for windowing libraries to mandate that you
do all windowing operations from one specific thread.

thanks
-- PMM

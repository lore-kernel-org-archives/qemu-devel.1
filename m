Received: from eggs.gnu.org ([209.51.188.92]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmYrQ-0000vg-8u
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmYrO-00085E-BX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmYrK-0006xw-7C
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:51:33 -0500
References: <20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
	<ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
	<20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
	<94b6e045-2348-b64b-048b-e585a236201c@gmx.com>
	<20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cdca16ff-7c3e-b525-86ee-76451c1b3323@redhat.com>
Date: Thu, 24 Jan 2019 07:51:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>
Cc: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 2019-01-24 07:38, Gerd Hoffmann wrote:
[...]
> I'm not going to join the sndio vs. pulse discussion.
> 
> But from a maintenance point of view it sucks big time to have a bunch
> of ways to play sound, and everybody uses a different one so you have to
> maintain a backend for each of those methods.
> 
> Maybe we should outsource that problem.  Write a gstreamer backend, then
> delete oss/alsa/sdl/pulse/whatever backends and let gstreamer handle
> that mess ...

Well, before writing a gstreamer backend, you could also say that we
only support SDL in QEMU, since SDL is also a wrapper around all the
other possible sound backends...

 Thomas

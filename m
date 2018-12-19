Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZbjt-0006Tp-1h
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZbjs-0007dQ-8K
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:18:16 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:39251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZbjr-0007I3-Sb
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:18:16 -0500
Received: by mail-ot1-x32f.google.com with SMTP id n8so19039644otl.6
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 05:18:10 -0800 (PST)
MIME-Version: 1.0
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
In-Reply-To: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 13:17:58 +0000
Message-ID: <CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben.hekster@foghorn.io
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 18 Dec 2018 at 21:57, Ben Hekster via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> Did it for me using stock QEMU 3.1.0.  (I need "-nographic"
> because the OS X port crashes without it)

OSX works for me, though I don't test it thoroughly. If you
are getting a crash that you can reproduce, please could
you repro it under a debugger with a debug build of QEMU
and send the all-threads backtrace for the crash?

thanks
-- PMM

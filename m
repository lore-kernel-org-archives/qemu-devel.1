Received: from eggs.gnu.org ([2001:4830:134:3::10]:57722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eeSvA-0003KQ-En
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eeSv9-0008HK-Os
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:49:28 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:45326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eeSv9-0008Gz-K6
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:49:27 -0500
Received: by mail-io0-x22c.google.com with SMTP id p188so6421441ioe.12
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 13:49:27 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 24 Jan 2018 22:49:26 +0100
Message-ID: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hi,

I built qemu-system-ppc for OSX and Windows from
https://github.com/stsquad/qemu/tree/softfloat-refactor-and-fp16-v3
and noticed a considerable drop in floating point performance on both
hosts.
Running Mac OS 9.2 in OSX, using MacBench 3.0, the score for the
floating point performance dropped from ~60 to ~42.

Recent tcg optimisations had improved processor and floating point
performance considerably, but that gain seems to be more than lost for
the floating point performance.

Any idea what is causing this?

Best regards,
Howard

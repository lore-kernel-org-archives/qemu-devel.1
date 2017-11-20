Received: from eggs.gnu.org ([2001:4830:134:3::10]:38879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGn9R-0006kg-Jt
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGn9Q-0006OQ-SI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:21 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGn9Q-0006O8-LF
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:20 -0500
Received: by mail-wr0-x243.google.com with SMTP id k18so3295015wre.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:34:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <877eulxc56.fsf@linaro.org>
References: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
	<878tf1xgff.fsf@linaro.org>
	<CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
	<877eulxc56.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 14:33:58 +0000
Message-ID: <CAFEAcA9SRhWr8R10wgTtyT_6k-4HZmg=+_US1E+Ttj5u2s+Sbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [question] mask SIGBUS in qemu main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: gengdongjiu <gengdongjiu@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>

On 20 November 2017 at 14:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I wonder why the choice was made to re-use SIGBUS for this. I guess the
> meaning is semantically the same (some hardware fault) but surprising
> they are now asynchronously delivered. When it eventually arrives at the
> vCPU it won't be directly tied to what tripped up the machine checking
> logic to trigger? Maybe this was never always the case?

I think the comments in cpus.c:sigbus_handler() mean "asynchronously"
in the sense of "at any time, not just when we explicitly check"
(in contrast to the main thread where we only process SIGBUS when
we want to, via signalfd). In general though some RAS errors are
not going to be synchronous-exceptions in the Arm ARM terms.

thanks
-- PMM

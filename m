Received: from eggs.gnu.org ([209.51.188.92]:37809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glazX-00044o-Pn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glatc-0003Yf-Tg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:49:53 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glatc-0003X6-ET
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:49:52 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so20778649otl.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 06:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20190118185402.3065-1-peter.maydell@linaro.org>
	<75f3486c-a1a9-6025-16af-e9a34cc4a663@redhat.com>
	<840a3bb1-1f60-50a6-5adb-2e3424a2d6b5@acm.org>
In-Reply-To: <840a3bb1-1f60-50a6-5adb-2e3424a2d6b5@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 14:49:38 +0000
Message-ID: <CAFEAcA-CPNbgR=JHs0dcOyGm-67R-S==PfYe4cjz6nWeGjG+4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Mon, 21 Jan 2019 at 14:32, Corey Minyard <minyard@acm.org> wrote:
>
> On 1/21/19 12:19 AM, Thomas Huth wrote:
> > On 2019-01-18 19:54, Peter Maydell wrote:
> >> The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> >> The frequency of this failure has recently gone up sharply to the
> >> point that I'm having to retry the NetBSD build multiple times
> >> to get a pass when merging pull requests.
> >>
> >> Disable the test until we can figure out why it's failing.

> I'll try to figure out why it's failing.  I assume I'll need a freebsd
> system.

No, the tests/vm setup will let you run the VM on a Linux
box (and that's what I do): just run
 make -C your-build-dir vm-build-netbsd J=8 V=1

It's also possible to log in to the VM rather than just
running tests and stopping: docs/devel/testing.rst has
the details.

thanks
-- PMM

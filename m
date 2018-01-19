Received: from eggs.gnu.org ([2001:4830:134:3::10]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eca3S-0005DO-No
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eca3R-0006TT-S3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:02:14 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:43516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eca3R-0006TG-M3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:02:13 -0500
Received: by mail-oi0-x22a.google.com with SMTP id t16so1554693oif.10
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:02:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 17:01:52 +0000
Message-ID: <CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 19 January 2018 at 16:43, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> As I remember, I tested build in QEMU's docker build system,
> but now I checked it on i386 Ubuntu, and yes linker says about unresolved
> atomic symbols. Next week, I'll have a time to investigate it deeper.

This sounds like exactly the problem I pointed out in a previous
round of this patchset :-(

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02103.html

Ignoring comments and sending patches anyway makes me grumpy,
especially when the result is exactly "fails obscurely on
some architectures only"...

thanks
-- PMM

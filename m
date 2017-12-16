Received: from eggs.gnu.org ([2001:4830:134:3::10]:48301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQCit-0000m7-C8
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 08:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQCis-0007fC-By
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 08:41:51 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:45787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQCis-0007e2-5f
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 08:41:50 -0500
Received: by mail-oi0-x22b.google.com with SMTP id x20so7948976oix.12
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 05:41:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGPq_PkxbnZHdZwKB8snqavyuWuHFjD9x_OdMSjzS3mRg@mail.gmail.com>
References: <20171214151906.3250-1-andrew.smirnov@gmail.com>
	<CAFEAcA-Chirj4y_YhK7Na_gf5504VNKUGZnfNTN6CHXN9gfZPA@mail.gmail.com>
	<CAHQ1cqGPq_PkxbnZHdZwKB8snqavyuWuHFjD9x_OdMSjzS3mRg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Dec 2017 13:41:28 +0000
Message-ID: <CAFEAcA_ZU=jNoD-M4J7ux6MuZXvz4tUJQfmVpYn8Q7cYk2HqbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc: Add code to emulate PFUZE3000 PMIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.orgn, Andrey Yurovsky <yurovsky@gmail.com>

On 15 December 2017 at 19:21, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Fri, Dec 15, 2017 at 6:56 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Is there a board which needs this device? We usually
>> only add devices together with whatever's using them.

> It's a pretty popular PMIC used on majority on i.MX reference designs,
> but I am not sure how many of those boards truly need it in QEMU. I
> ended up having to implement this code for a custom i.MX7 board that
> used one of PFUZE3000's output as a power supply for USB. I am not
> sure if I'm ever going to submit patches for that mystery board
> upstream. Looking at imx6qdl-sabresd.dtsi, in Linux source tree I
> think this emulation code would also be needed for USB emulation on
> i.MX6 SabreSD board, but I haven't verified it in practice.
>
> Is this enough of a case to justify the patch's inclusion, or should I
> go back and find a board QEMU supports that actually needs this
> (either answer is perfectly fine with me)?

I think what I'd like to see is some board model in QEMU
actually creating this device. (I assume it's not intended
as a "user creates it with -device" pluggable device.)
Otherwise it's just dead code from upstream's point of view.

thanks
-- PMM

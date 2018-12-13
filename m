Received: from eggs.gnu.org ([2001:4830:134:3::10]:42270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXSe5-0002o9-RY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXSe4-0005Q2-LD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:11:25 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:46843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXSe4-0005AB-6u
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:11:24 -0500
Received: by mail-oi1-x233.google.com with SMTP id x202so1848914oif.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 07:11:17 -0800 (PST)
MIME-Version: 1.0
References: <1544708743.4811.30.camel@rwth-aachen.de>
	<CAFEAcA-p-LC2swC8-AQt60QBhQN=PNJvBjbGXrtdvvvDd-74QA@mail.gmail.com>
	<1544713257.4811.32.camel@rwth-aachen.de>
In-Reply-To: <1544713257.4811.32.camel@rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 15:11:05 +0000
Message-ID: <CAFEAcA93tPS-jJBoT3fFekEvXx4pJPR_u3P-x1d3op470uexmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] Warning when DTB memory nodes are noped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lukas.juenger@rwth-aachen.de
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 15:00, J=C3=BCnger, Lukas
<lukas.juenger@rwth-aachen.de> wrote:
>
> On Thu, 2018-12-13 at 14:49 +0000, Peter Maydell wrote:
> > Was the deletion of the memory node actually wrong in your case?
> > If so we should look at fixing the wrong behaviour, rather than
> > just being noisier about what we're doing...

> I see. In my case I wanted to specify the memory using the DTB that I
> passed using the -dtb option. I had two memory ranges in the dtb and
> they didn't show up in the kernel later on because they were noped by
> QEMU. I found it confusing that QEMU makes changes to the DTB that I
> passed via -dtb.

Yeah, we don't edit the DTB much but we do fix it up to
indicate the memory, number of CPUs, kernel command line, etc
passed on the QEMU command line.

thanks
-- PMM

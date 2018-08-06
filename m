Received: from eggs.gnu.org ([2001:4830:134:3::10]:44619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcmZ-00072c-5p
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcmY-0007BO-Ap
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:30:35 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:45920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmcmX-0007B0-Mw
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:30:33 -0400
Received: by mail-oi0-x234.google.com with SMTP id q11-v6so21198706oic.12
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 03:30:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180801035357.7804-1-david@gibson.dropbear.id.au>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 11:30:12 +0100
Message-ID: <CAFEAcA8thAF-twHmoUqK0V9fo-Fpu9_2C=sSGuOcuiKAGQSXJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>

On 1 August 2018 at 04:53, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>
>   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180801
>
> for you to fetch changes up to 6484ab3dffadc79020a71376010f517d60b81b83:
>
>   sam460ex: Fix PCI interrupts with multiple devices (2018-08-01 11:01:38 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2018-08-01
>
> Here are a final couple of fixes for the 3.0 release.
>
> ----------------------------------------------------------------
> BALATON Zoltan (1):
>       sam460ex: Fix PCI interrupts with multiple devices
>
> Thomas Huth (1):
>       hw/misc/macio: Fix device introspection problems in macio devices

Since we needed an rc4, I've applied this to master (the bug
fixes are not strict regressions but they are limited in
scope to particular machines).

thanks
-- PMM

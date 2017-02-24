Received: from eggs.gnu.org ([2001:4830:134:3::10]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHHc-00047l-Qb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHHc-0001zF-1q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:55:44 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chHHb-0001yf-SC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:55:43 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so16484453wmd.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:55:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5077e2a9732e1b9afcb0754e93624b787589ac61.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<5077e2a9732e1b9afcb0754e93624b787589ac61.1487522123.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:55:21 +0000
Message-ID: <CAFEAcA8gde7GfWhyRLyOB5yL_5zrm4b7tj4pH=GTj=RwZO_4wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 10/10] ppc: Add SM501 device in config for
 ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> This is not used by default on any emulated machine yet but it is
> still useful to have it compiled so it can be added from the command
> line for clients that can use it (e.g. MorphOS has no driver for any
> other emulated video cards but can output via SM501)
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

If this is a generic PCI device then shouldn't it go into
default-configs/pci.mak ?

thanks
-- PMM

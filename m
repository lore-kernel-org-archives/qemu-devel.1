Received: from eggs.gnu.org ([2001:4830:134:3::10]:34355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrtY-0002cU-QF
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrtY-0004H5-0j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:25:36 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrtX-0004GG-QK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:25:35 -0500
Received: by mail-wm0-x235.google.com with SMTP id v186so21746587wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:25:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <edad9d33db70b1408cb4d82e688d0a767aa0a960.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<edad9d33db70b1408cb4d82e688d0a767aa0a960.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:25:14 +0000
Message-ID: <CAFEAcA-vSeTQPyV8RbwGEkvN1n1giu3im9FDQb264EEimsSQmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 06/13] sm501: Add emulation of chip
 connected via PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 18:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Only the display controller part is created automatically on PCI
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v2: Split off removing dependency on base address to separate patch
> v3: Added reset function and PCI ID constant definitions in pci_ids.h
>
>  hw/display/sm501.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_ids.h |  3 +++
>  2 files changed, 61 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

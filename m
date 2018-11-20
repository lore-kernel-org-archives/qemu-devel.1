Received: from eggs.gnu.org ([2001:4830:134:3::10]:47225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7O2-0006vi-GN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7O1-0003NV-BE
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:52:22 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7O0-0003Le-0w
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:52:21 -0500
Received: by mail-oi1-x243.google.com with SMTP id t204so1687932oie.7
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:52:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-14-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-14-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:51:59 +0000
Message-ID: <CAFEAcA91R47kzep1fNPC3YuPQeVWLtuY1G0Yda7aD3kiu6SPHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/22] puv3_pm.c: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19 November 2018 at 12:08, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> puv3_pm_class_init().
>
> Cc: gxt@mprc.pku.edu.cn
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  hw/misc/puv3_pm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

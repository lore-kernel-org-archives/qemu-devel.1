Received: from eggs.gnu.org ([2001:4830:134:3::10]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SyG-0008Rm-1J
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SyF-000402-EN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:20 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:53125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0SyF-0003xb-87
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:19 -0400
Received: by mail-wr0-x234.google.com with SMTP id k62so13067263wrc.9
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:47:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-2-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-2-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 14:46:57 +0100
Message-ID: <CAFEAcA88T4nACCLGG+bj+A7r+xmBJ3iVD4heKMuUy3nLZ3JQrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/17] imx_fec: Do not link to netdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Binding to a particular netdev doesn't seem to belong to this layer
> and should probably be done as a part of board or SoC specific code.
>
> Convert all of the users of this IP block to use
> qdev_set_nic_properties() instead.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

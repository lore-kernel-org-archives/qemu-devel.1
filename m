Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7Lv-0005nn-Mu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7Lu-0001QX-SY
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:50:11 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7Lu-0001QP-Oa
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:50:10 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so1665643oie.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:50:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-21-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-21-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:49:49 +0000
Message-ID: <CAFEAcA92SCAar143VMkJiLGEv0kUzMBXJySN8MEd7Ze9U_rBew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 20/22] xen_backend: Convert sysbus init
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19 November 2018 at 12:08, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> xen_sysdev_class_init().
>
> Cc: sstabellini@kernel.org
> Cc: anthony.perard@citrix.com
> Cc: xen-devel@lists.xenproject.org
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  hw/xen/xen_backend.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index 9a8e8771ec..73b0ed0169 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -809,9 +809,8 @@ static const TypeInfo xensysbus_info = {
>      }
>  };
>
> -static int xen_sysdev_init(SysBusDevice *dev)
> +static void xen_sysdev_realize(DeviceState *dev, Error **errp)
>  {
> -    return 0;
>  }
>
>  static Property xen_sysdev_properties[] = {
> @@ -821,9 +820,8 @@ static Property xen_sysdev_properties[] = {
>  static void xen_sysdev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = xen_sysdev_init;
> +    dc->realize = xen_sysdev_realize;
>      dc->props = xen_sysdev_properties;
>      dc->bus_type = TYPE_XENSYSBUS;
>  }

If the realize function doesn't do anything at all, can't
we just omit it ?

thanks
-- PMM

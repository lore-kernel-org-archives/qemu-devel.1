Received: from eggs.gnu.org ([2001:4830:134:3::10]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7MX-0000tx-Sb
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7MR-0000sk-MN
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:02:57 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQ7MR-0000qp-Gj
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:02:51 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so10061582otk.8
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 01:02:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
	<bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 09:02:29 +0000
Message-ID: <CAFEAcA_tmLbierkqRP6E3QDV89aAOASRdsA5-rt3TyeWE0tE0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozy <maozhongyi@cmss.chinamobile.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23 November 2018 at 03:10, maozy <maozhongyi@cmss.chinamobile.com> wrote:
> In order to void the subclasses whose parent_realize field is
> set to NULL, the k->realize function must be retained even
> though it doesn't do anything practical. Just like this:
>
>
> -/* TODO remove once all sysbus devices have been converted to realize*/
>  static void sysbus_realize(DeviceState *dev, Error **errp)
>  {
> -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
> -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
> -
> -    if (!sbc->init) {
> -        return;
> -    }
> -    if (sbc->init(sd) < 0) {
> -        error_setg(errp, "Device initialization failed");
> -    }
>  }
>
> it doesn't look elegant, but I didn't think of a better way, if you
> can give me some hints, I really appreciate it. :)

If we do take this approach, we should have a comment which
says why we have an empty realize function, so that we don't
in future forget and delete the apparently unnecessary code...

thanks
-- PMM

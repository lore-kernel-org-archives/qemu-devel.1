Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845DC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91212205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91212205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3z1-0006KO-Rm
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 13:34:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hO3y3-00061R-TG
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hO3y0-0002Hq-Vd
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:33:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hO3y0-0002FS-FZ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:33:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C57E72D7F5;
	Tue,  7 May 2019 17:33:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E0F05C21F;
	Tue,  7 May 2019 17:33:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 59B7A1132B35; Tue,  7 May 2019 19:33:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ernest Esene <eroken1@gmail.com>
References: <20190504181119.GA3317@erokenlabserver>
Date: Tue, 07 May 2019 19:33:09 +0200
In-Reply-To: <20190504181119.GA3317@erokenlabserver> (Ernest Esene's message
	of "Sat, 4 May 2019 19:11:19 +0100")
Message-ID: <87ftpqb25m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 07 May 2019 17:33:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ernest Esene <eroken1@gmail.com> writes:

> Add support for Linux I2C character device for I2C device passthrough
> For example:
> -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
>
> Signed-off-by: Ernest Esene <eroken1@gmail.com>

Could you explain briefly how passing through a host's I2C device can be
useful?

>
> ---
> v2:
>   * Fix errors
>   * update "MAINTAINERS" file.
> ---
>  MAINTAINERS                |   6 ++
>  chardev/Makefile.objs      |   1 +
>  chardev/char-i2c.c         | 140 +++++++++++++++++++++++++++++++++++++++=
++++++
>  chardev/char.c             |   3 +
>  include/chardev/char-i2c.h |  35 ++++++++++++
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |  18 ++++++
>  7 files changed, 204 insertions(+)
>  create mode 100644 chardev/char-i2c.c
>  create mode 100644 include/chardev/char-i2c.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7dd71e0a2d..b79d9b8edf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1801,6 +1801,12 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
>  F: chardev/baum.c
>=20=20
> +Character Devices (Linux I2C)
> +M: Ernest Esene <eroken1@gmail.com>
> +S: Maintained
> +F: chardev/char-i2c.c
> +F: include/chardev/char-i2c.h
> +

Thanks for backing your contribution with an offer to maintain it.
Accepting the offer is up to the Character device backends maintainer
Marc-Andr=C3=A9, I think.

>  Command line option argument parsing
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index d68e1347f9..6c96b9a353 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -16,6 +16,7 @@ chardev-obj-y +=3D char-stdio.o
>  chardev-obj-y +=3D char-udp.o
>  chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
>  chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
> +chardev-obj-$(CONFIG_POSIX) +=3Dchar-i2c.o
>=20=20
>  common-obj-y +=3D msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) +=3D baum.o
> diff --git a/chardev/char-i2c.c b/chardev/char-i2c.c
> new file mode 100644
> index 0000000000..4b068b0124
> --- /dev/null
> +++ b/chardev/char-i2c.c
> @@ -0,0 +1,140 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */

Any particular reason not to use GPLv2+?

My knowledge of I2C rounds to zero, so I can only review for basic
sanity.

> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/option.h"
> +#include "qemu-common.h"
> +#include "io/channel-file.h"
> +#include "qemu/cutils.h"
> +
> +#include "chardev/char-fd.h"
> +#include "chardev/char-i2c.h"
> +#include "chardev/char.h"
> +
> +#include <sys/ioctl.h>
> +#include <linux/i2c-dev.h>
> +
> +static int i2c_ioctl(Chardev *chr, int cmd, void *arg)
> +{
> +    FDChardev *fd_chr =3D FD_CHARDEV(chr);
> +    QIOChannelFile *floc =3D QIO_CHANNEL_FILE(fd_chr->ioc_in);
> +    int fd =3D floc->fd;
> +    int addr;
> +
> +    switch (cmd) {
> +    case CHR_IOCTL_I2C_SET_ADDR:
> +        addr =3D (int) (long) arg;

Would (int)arg make the compiler unhappy?

> +
> +        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
> +            /*
> +             * TODO: check if adapter support 10-bit addr
> +             * I2C_FUNC_10BIT_ADDR
> +             */

What's the impact of not having done this TODO?

Should it be mentioned in the commit message?

> +            if (ioctl(fd, I2C_TENBIT, addr) < 0) {
> +                goto err;
> +            }
> +        } else {
> +            if (ioctl(fd, I2C_SLAVE, addr) < 0) {
> +                goto err;
> +            }
> +        }
> +        break;
> +
> +    default:
> +        return -ENOTSUP;
> +    }
> +    return 0;
> +err:
> +    return -ENOTSUP;
> +}
> +
> +static void qmp_chardev_open_i2c(Chardev *chr, ChardevBackend *backend,
> +                                 bool *be_opened, Error **errp)
> +{
> +    ChardevI2c *i2c =3D backend->u.i2c.data;
> +    void *addr;
> +    int fd;
> +
> +    fd =3D qmp_chardev_open_file_source(i2c->device, O_RDWR | O_NONBLOCK,
> +                                      errp);
> +    if (fd < 0) {
> +        return;
> +    }
> +    qemu_set_block(fd);

Sure we want *blocking* I/O?  No other character device does.

> +    qemu_chr_open_fd(chr, fd, fd);
> +    addr =3D (void *) (long) i2c->address;

Would (void *)i2c->address make the compiler unhappy?

> +    i2c_ioctl(chr, CHR_IOCTL_I2C_SET_ADDR, addr);
> +}
> +
> +static void qemu_chr_parse_i2c(QemuOpts *opts, ChardevBackend *backend,
> +                               Error **errp)
> +{
> +    const char *device =3D qemu_opt_get(opts, "path");
> +    const char *addr =3D qemu_opt_get(opts, "address");
> +    long address;
> +    ChardevI2c *i2c;

Blank line between declarations and statements, please.

> +    if (device =3D=3D NULL) {
> +        error_setg(errp, "chardev: linux-i2c: no device path given");
> +        return;
> +    }
> +    if (addr =3D=3D NULL) {
> +        error_setg(errp, "chardev: linux-i2c: no device address given");
> +        return;
> +    }
> +    if (qemu_strtol(addr, NULL, 0, &address) !=3D 0) {
> +        error_setg(errp, "chardev: linux-i2c: invalid device address giv=
en");
> +        return;
> +    }

Why not make option "addr" QEMU_OPT_NUMBER and use
qemu_opt_get_number()?

> +    if (address < 0 || address > CHR_I2C_ADDR_10BIT_MAX) {
> +        error_setg(errp, "chardev: linux-i2c: device address out of rang=
e");
> +        return;
> +    }
> +    backend->type =3D CHARDEV_BACKEND_KIND_I2C;
> +    i2c =3D backend->u.i2c.data =3D g_new0(ChardevI2c, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevI2c_base(i2c));
> +    i2c->device =3D g_strdup(device);
> +    i2c->address =3D (int16_t) address;

No space between (int16_t) and address, please.  Same for other type
casts elsewhere.

> +}
> +
> +static void char_i2c_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> +
> +    cc->parse =3D qemu_chr_parse_i2c;
> +    cc->open =3D  qmp_chardev_open_i2c;
> +    cc->chr_ioctl =3D i2c_ioctl;
> +}
> +
> +static const TypeInfo char_i2c_type_info =3D {
> +    .name =3D TYPE_CHARDEV_I2C,
> +    .parent =3D TYPE_CHARDEV_FD,
> +    .class_init =3D char_i2c_class_init,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&char_i2c_type_info);
> +}
> +
> +type_init(register_types);
> diff --git a/chardev/char.c b/chardev/char.c
> index 54724a56b1..93732a9909 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -926,6 +926,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "logappend",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "address",
> +            .type =3D QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> diff --git a/include/chardev/char-i2c.h b/include/chardev/char-i2c.h
> new file mode 100644
> index 0000000000..81e97b7556
> --- /dev/null
> +++ b/include/chardev/char-i2c.h
> @@ -0,0 +1,35 @@
> +
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#ifndef CHAR_I2C_H
> +#define CHAR_I2C_H
> +
> +#define CHR_IOCTL_I2C_SET_ADDR 1
> +
> +#define CHR_I2C_ADDR_10BIT_MAX 1023
> +#define CHR_I2C_ADDR_7BIT_MAX 127
> +
> +void qemu_set_block(int fd);

Declaring qemu_set_block() again is inappropriate.  Include
qemu/sockets.h instead.

> +
> +#endif /* ifndef CHAR_I2C_H */

This header is included only by chardev/char.c.  Why does it exist?

> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index c0b57f7685..880614391f 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -245,6 +245,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **err=
p);
>  #define TYPE_CHARDEV_SERIAL "chardev-serial"
>  #define TYPE_CHARDEV_SOCKET "chardev-socket"
>  #define TYPE_CHARDEV_UDP "chardev-udp"
> +#define TYPE_CHARDEV_I2C "chardev-linux-i2c"
>=20=20
>  #define CHARDEV_IS_RINGBUF(chr) \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
> diff --git a/qapi/char.json b/qapi/char.json
> index a6e81ac7bc..2c05d6a93e 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -240,6 +240,23 @@
>    'data': { 'device': 'str' },
>    'base': 'ChardevCommon' }
>=20=20
> +##
> +# @ChardevI2c:
> +#
> +# Configuration info for i2c chardev.
> +#
> +# @device: The name of the special file for the device,
> +#          i.e. /dev/i2c-0 on linux
> +# @address: The address of the i2c device on the host.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'ChardevI2c',
> +  'data': { 'device': 'str',
> +            'address': 'int16'},
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_LINUX)'}
> +
>  ##
>  # @ChardevSocket:
>  #
> @@ -398,6 +415,7 @@
>    'data': { 'file': 'ChardevFile',
>              'serial': 'ChardevHostdev',
>              'parallel': 'ChardevHostdev',
> +            'i2c': 'ChardevI2c',
>              'pipe': 'ChardevHostdev',
>              'socket': 'ChardevSocket',
>              'udp': 'ChardevUdp',

Missing: documentation update for qemu-options.hx.


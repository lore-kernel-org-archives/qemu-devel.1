Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22936C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70EE2084F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70EE2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQCyU-0006Dy-1u
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:34:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQCuu-0003ux-39
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQCgB-0003bR-Lg
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQCgB-0003a3-Dj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B973C3092669;
	Mon, 13 May 2019 15:15:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE7565C225;
	Mon, 13 May 2019 15:15:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6592C11385E4; Mon, 13 May 2019 17:15:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ernest Esene <eroken1@gmail.com>
References: <20190510180410.GA10349@erokenlabserver>
Date: Mon, 13 May 2019 17:15:42 +0200
In-Reply-To: <20190510180410.GA10349@erokenlabserver> (Ernest Esene's message
	of "Fri, 10 May 2019 19:04:10 +0100")
Message-ID: <87d0kmfkrl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 15:15:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] chardev/char-i2c: Implement Linux I2C
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
> -chardev i2c,address=0x46,path=/dev/i2c-N,id=i2c-chardev
>
> QEMU supports emulation of I2C devices in software but currently can't
> passthrough to real I2C devices. This feature is needed by developers
> using QEMU for writing and testing software for I2C devices.
>
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
> ---
> v3:
>   * change licence to GPLv2+
>   * use non blocking IO for the chardev
>   * change "address" to QEMU_OPT_NUMBER
>   * update qemu-options.hx
> ---
> v2:
>   * Fixed errors
>   * update "MAINTAINERS" file.
> ---
>  MAINTAINERS              |   5 ++
>  chardev/Makefile.objs    |   1 +
>  chardev/char-linux-i2c.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++
>  chardev/char.c           |   3 ++
>  include/chardev/char.h   |   1 +
>  qapi/char.json           |  17 +++++++
>  qemu-options.hx          |  14 +++++-
>  7 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 chardev/char-linux-i2c.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66ddbda9c9..d834a12241 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1801,6 +1801,11 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
>  F: chardev/baum.c
>  
> +Character Devices (I2C)
> +M: Ernest Esene <eroken1@gmail.com>
> +S: Maintained
> +F: chardev/char-linux-i2c.c
> +
>  Command line option argument parsing
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index d68e1347f9..7b64009aa6 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -16,6 +16,7 @@ chardev-obj-y += char-stdio.o
>  chardev-obj-y += char-udp.o
>  chardev-obj-$(CONFIG_WIN32) += char-win.o
>  chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
> +chardev-obj-$(CONFIG_LINUX) +=char-linux-i2c.o

Space after +=, please.

>  
>  common-obj-y += msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) += baum.o
> diff --git a/chardev/char-linux-i2c.c b/chardev/char-linux-i2c.c
> new file mode 100644
> index 0000000000..847a18f611
> --- /dev/null
> +++ b/chardev/char-linux-i2c.c
> @@ -0,0 +1,126 @@
> +/*
> + * QEMU System Emulator
> + * Linux I2C device support as a character device.
> + *
> + * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/option.h"
> +#include "qemu-common.h"
> +#include "io/channel-file.h"
> +#include "qemu/cutils.h"
> +#include "qemu/sockets.h"
> +
> +#include "chardev/char-fd.h"
> +#include "chardev/char.h"
> +
> +#include <sys/ioctl.h>
> +#include <linux/i2c-dev.h>
> +#include <linux/i2c.h>
> +
> +#define CHR_IOCTL_I2C_SET_ADDR 1
> +
> +#define CHR_I2C_ADDR_10BIT_MAX 1023
> +#define CHR_I2C_ADDR_7BIT_MAX 127
> +
> +static int i2c_ioctl(Chardev *chr, int cmd, void *arg)
> +{
> +    FDChardev *fd_chr = FD_CHARDEV(chr);
> +    QIOChannelFile *floc = QIO_CHANNEL_FILE(fd_chr->ioc_in);
> +    int fd = floc->fd;
> +    int addr;
> +    unsigned long funcs;
> +
> +    switch (cmd) {
> +    case CHR_IOCTL_I2C_SET_ADDR:
> +        addr = (intptr_t)arg;
> +
> +        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
> +            if (ioctl(fd, I2C_FUNCS, &funcs) < 0) {
> +                goto err;
> +            }
> +            if (!(funcs & I2C_FUNC_10BIT_ADDR)) {
> +                goto err;
> +            }
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
> +    ChardevI2c *i2c = backend->u.i2c.data;
> +    void *addr;
> +    int fd;
> +
> +    fd = qmp_chardev_open_file_source(i2c->device, O_RDWR | O_NONBLOCK, errp);
> +    if (fd < 0) {
> +        return;
> +    }
> +    qemu_set_nonblock(fd);
> +    qemu_chr_open_fd(chr, fd, fd);
> +    addr = (void *)(intptr_t)i2c->address;
> +    i2c_ioctl(chr, CHR_IOCTL_I2C_SET_ADDR, addr);
> +}
> +
> +static void qemu_chr_parse_i2c(QemuOpts *opts, ChardevBackend *backend,
> +                               Error **errp)
> +{
> +    const char *device = qemu_opt_get(opts, "path");
> +    long address = qemu_opt_get_number(opts, "address", LONG_MAX);
> +    ChardevI2c *i2c;
> +
> +    if (device == NULL) {
> +        error_setg(errp, "chardev: i2c: no device path given");
> +        return;
> +    }
> +    if (address < 0 || address > CHR_I2C_ADDR_10BIT_MAX) {
> +        error_setg(errp, "chardev: i2c: device address out of range");
> +        return;
> +    }
> +    backend->type = CHARDEV_BACKEND_KIND_I2C;
> +    i2c = backend->u.i2c.data = g_new0(ChardevI2c, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevI2c_base(i2c));
> +    i2c->device = g_strdup(device);
> +    i2c->address = (int16_t)address;
> +}
> +
> +static void char_i2c_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc = CHARDEV_CLASS(oc);
> +
> +    cc->parse = qemu_chr_parse_i2c;
> +    cc->open = qmp_chardev_open_i2c;
> +    cc->chr_ioctl = i2c_ioctl;
> +}
> +
> +static const TypeInfo char_i2c_type_info = {
> +    .name = TYPE_CHARDEV_I2C,
> +    .parent = TYPE_CHARDEV_FD,
> +    .class_init = char_i2c_class_init,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&char_i2c_type_info);
> +}
> +
> +type_init(register_types);
> diff --git a/chardev/char.c b/chardev/char.c
> index 54724a56b1..8f5ffe16e6 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -926,6 +926,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "logappend",
>              .type = QEMU_OPT_BOOL,
> +        },{
> +            .name = "address",
> +            .type = QEMU_OPT_NUMBER,
>          },
>          { /* end of list */ }
>      },
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index c0b57f7685..0e08b70fc9 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -245,6 +245,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>  #define TYPE_CHARDEV_SERIAL "chardev-serial"
>  #define TYPE_CHARDEV_SOCKET "chardev-socket"
>  #define TYPE_CHARDEV_UDP "chardev-udp"
> +#define TYPE_CHARDEV_I2C "chardev-i2c"
>  
>  #define CHARDEV_IS_RINGBUF(chr) \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
> diff --git a/qapi/char.json b/qapi/char.json
> index a6e81ac7bc..7168b58cfe 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -240,6 +240,22 @@
>    'data': { 'device': 'str' },
>    'base': 'ChardevCommon' }
>  
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
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevSocket:
>  #
> @@ -398,6 +414,7 @@
>    'data': { 'file': 'ChardevFile',
>              'serial': 'ChardevHostdev',
>              'parallel': 'ChardevHostdev',
> +            'i2c': 'ChardevI2c',

Shouldn't this be 'if': 'defined(CONFIG_LINUX)'?

>              'pipe': 'ChardevHostdev',
>              'socket': 'ChardevSocket',
>              'udp': 'ChardevUdp',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51802cbb26..435b6975dd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2695,6 +2695,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>  #if defined(CONFIG_SPICE)
>      "-chardev spicevmc,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev spiceport,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
> +#endif
> +#ifdef CONFIG_LINUX
> +    "-chardev i2c,id=id,address=address[,path=path][,logfile=PATH][,logappend=on|off]\n"
>  #endif
>      , QEMU_ARCH_ALL
>  )
> @@ -2723,7 +2726,8 @@ Backend is one of:
>  @option{parallel},
>  @option{parport},
>  @option{spicevmc},
> -@option{spiceport}.
> +@option{spiceport},
> +@option{i2c}.
>  The specific backend will determine the applicable options.
>  
>  Use @code{-chardev help} to print all available chardev backend types.
> @@ -2990,6 +2994,14 @@ Connect to a spice virtual machine channel, such as vdiport.
>  
>  Connect to a spice port, allowing a Spice client to handle the traffic
>  identified by a name (preferably a fqdn).
> +
> +@item -chardev i2c,id=@var{id},address=@var{address},path=@var{path}
> +
> +@option{path} i2c character device (Eg: /dev/i2c-N on Linux)
> +
> +@option{address} address of the slave device.
> +
> +I2C device support as a character device.

This sentence no verb :)

>  ETEXI
>  
>  STEXI


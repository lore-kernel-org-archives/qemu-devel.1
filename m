Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB8FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BCA2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdpdx0Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BCA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48009 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9sA-0001ZX-37
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 14:03:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP9rJ-0001GW-90
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP9rH-000463-Oe
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:03:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hP9rH-00044V-E6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:02:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id d9so494207wrx.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=GD3Q8YZK/ZWAa/bCi1KAoBDy1eZOru2OMD4jJbCs5uo=;
	b=fdpdx0UqKpgYERqi6rtqnSI8CktjGOfZZfrwed4LzFuWtAvYAHKlLCWKutgxBgSpg9
	0IZN0/4qOnEvuLFGUcAdsmWdZGuL9l1gHiNh9cmtNOqZTDbxrR0ZMG9aw0VnBYHvUlSH
	9RlTwWdOEh09b5EYh+Sr24xiaEH9KB3yAjtjBomU/lH4BKpNkMiVJXajYVH4WZaeGtgd
	6uYNtQWIODEI2S/Q6BaYf+FiY5UXPCL8FqKSuB6h05kwUtgVn3C0GsCcN76EptakJvKz
	bf3MvGEQ6oY1srEtzfGgxSQ+YaUepXFC3StO9yIxzE9EPmaet5WOT2fWPnXb9ylSoV4Y
	0nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=GD3Q8YZK/ZWAa/bCi1KAoBDy1eZOru2OMD4jJbCs5uo=;
	b=qZZEnbCUbXU4+KlD7uS3VJ0KVBEoVWxWG72jSg84OxS8/oNYMZHFo0kQ86fCEzJO7r
	K5H55p1CMXLJ+fb24gE0wWuX4JBAZYb3ry7VzV3hwE7C8nKoCfh9NNlKaOZZG5kd8I8n
	+/Mwy9VO7rlFqgt+Sc3YibspBitVlkA7d62KKQeWlwLAaVsKzvXobz8m0Y+q5eOQ9o4C
	YPJc3170MeONt0dr7QGbOgakYSGERVYN88osrdqXdB+G96Iq89ta0dyeT4BkCwm7hHWb
	r1+ho59YapVDbYbR8bsIjBeVGxzjzvruaG4Sm4lugQGKP7WAMmpk777uc2FmMX4U6g4P
	NiWA==
X-Gm-Message-State: APjAAAXUJseoS0QpURJ9/L+EvRjxB4+r1s+NPncotFhz+nawPntB+mAJ
	zgIzIiL/rqnW6n5Op+nDEUUBBrrtES3Exw==
X-Google-Smtp-Source: APXvYqz/m9P9hcAt8ADHsy5Pn345eiWarc3IGOXKt/8yTI81Ra/swTUKpvKhTLAGHhy0WObiDOag9A==
X-Received: by 2002:adf:c709:: with SMTP id k9mr2120074wrg.144.1557511376038; 
	Fri, 10 May 2019 11:02:56 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.145])
	by smtp.gmail.com with ESMTPSA id f7sm3702948wmb.28.2019.05.10.11.02.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 11:02:54 -0700 (PDT)
Date: Fri, 10 May 2019 19:04:10 +0100
From: Ernest Esene <eroken1@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190510180410.GA10349@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3] chardev/char-i2c: Implement Linux I2C
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
Cc: Markus Armbruster <armbru@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Ernest Esene <eroken1@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for Linux I2C character device for I2C device passthrough
For example:
-chardev i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev

QEMU supports emulation of I2C devices in software but currently can't
passthrough to real I2C devices. This feature is needed by developers
using QEMU for writing and testing software for I2C devices.

Signed-off-by: Ernest Esene <eroken1@gmail.com>
---
v3:
  * change licence to GPLv2+
  * use non blocking IO for the chardev
  * change "address" to QEMU_OPT_NUMBER
  * update qemu-options.hx
---
v2:
  * Fixed errors
  * update "MAINTAINERS" file.
---
 MAINTAINERS              |   5 ++
 chardev/Makefile.objs    |   1 +
 chardev/char-linux-i2c.c | 126 +++++++++++++++++++++++++++++++++++++++++++=
++++
 chardev/char.c           |   3 ++
 include/chardev/char.h   |   1 +
 qapi/char.json           |  17 +++++++
 qemu-options.hx          |  14 +++++-
 7 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 chardev/char-linux-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 66ddbda9c9..d834a12241 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1801,6 +1801,11 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: chardev/baum.c
=20
+Character Devices (I2C)
+M: Ernest Esene <eroken1@gmail.com>
+S: Maintained
+F: chardev/char-linux-i2c.c
+
 Command line option argument parsing
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..7b64009aa6 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -16,6 +16,7 @@ chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
+chardev-obj-$(CONFIG_LINUX) +=3Dchar-linux-i2c.o
=20
 common-obj-y +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
diff --git a/chardev/char-linux-i2c.c b/chardev/char-linux-i2c.c
new file mode 100644
index 0000000000..847a18f611
--- /dev/null
+++ b/chardev/char-linux-i2c.c
@@ -0,0 +1,126 @@
+/*
+ * QEMU System Emulator
+ * Linux I2C device support as a character device.
+ *
+ * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu-common.h"
+#include "io/channel-file.h"
+#include "qemu/cutils.h"
+#include "qemu/sockets.h"
+
+#include "chardev/char-fd.h"
+#include "chardev/char.h"
+
+#include <sys/ioctl.h>
+#include <linux/i2c-dev.h>
+#include <linux/i2c.h>
+
+#define CHR_IOCTL_I2C_SET_ADDR 1
+
+#define CHR_I2C_ADDR_10BIT_MAX 1023
+#define CHR_I2C_ADDR_7BIT_MAX 127
+
+static int i2c_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    FDChardev *fd_chr =3D FD_CHARDEV(chr);
+    QIOChannelFile *floc =3D QIO_CHANNEL_FILE(fd_chr->ioc_in);
+    int fd =3D floc->fd;
+    int addr;
+    unsigned long funcs;
+
+    switch (cmd) {
+    case CHR_IOCTL_I2C_SET_ADDR:
+        addr =3D (intptr_t)arg;
+
+        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
+            if (ioctl(fd, I2C_FUNCS, &funcs) < 0) {
+                goto err;
+            }
+            if (!(funcs & I2C_FUNC_10BIT_ADDR)) {
+                goto err;
+            }
+            if (ioctl(fd, I2C_TENBIT, addr) < 0) {
+                goto err;
+            }
+        } else {
+            if (ioctl(fd, I2C_SLAVE, addr) < 0) {
+                goto err;
+            }
+        }
+        break;
+
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+err:
+    return -ENOTSUP;
+}
+
+static void qmp_chardev_open_i2c(Chardev *chr, ChardevBackend *backend,
+                                 bool *be_opened, Error **errp)
+{
+    ChardevI2c *i2c =3D backend->u.i2c.data;
+    void *addr;
+    int fd;
+
+    fd =3D qmp_chardev_open_file_source(i2c->device, O_RDWR | O_NONBLOCK, =
errp);
+    if (fd < 0) {
+        return;
+    }
+    qemu_set_nonblock(fd);
+    qemu_chr_open_fd(chr, fd, fd);
+    addr =3D (void *)(intptr_t)i2c->address;
+    i2c_ioctl(chr, CHR_IOCTL_I2C_SET_ADDR, addr);
+}
+
+static void qemu_chr_parse_i2c(QemuOpts *opts, ChardevBackend *backend,
+                               Error **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    long address =3D qemu_opt_get_number(opts, "address", LONG_MAX);
+    ChardevI2c *i2c;
+
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: i2c: no device path given");
+        return;
+    }
+    if (address < 0 || address > CHR_I2C_ADDR_10BIT_MAX) {
+        error_setg(errp, "chardev: i2c: device address out of range");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_I2C;
+    i2c =3D backend->u.i2c.data =3D g_new0(ChardevI2c, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevI2c_base(i2c));
+    i2c->device =3D g_strdup(device);
+    i2c->address =3D (int16_t)address;
+}
+
+static void char_i2c_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_i2c;
+    cc->open =3D qmp_chardev_open_i2c;
+    cc->chr_ioctl =3D i2c_ioctl;
+}
+
+static const TypeInfo char_i2c_type_info =3D {
+    .name =3D TYPE_CHARDEV_I2C,
+    .parent =3D TYPE_CHARDEV_FD,
+    .class_init =3D char_i2c_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_i2c_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 54724a56b1..8f5ffe16e6 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -926,6 +926,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "logappend",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "address",
+            .type =3D QEMU_OPT_NUMBER,
         },
         { /* end of list */ }
     },
diff --git a/include/chardev/char.h b/include/chardev/char.h
index c0b57f7685..0e08b70fc9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -245,6 +245,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 #define TYPE_CHARDEV_SERIAL "chardev-serial"
 #define TYPE_CHARDEV_SOCKET "chardev-socket"
 #define TYPE_CHARDEV_UDP "chardev-udp"
+#define TYPE_CHARDEV_I2C "chardev-i2c"
=20
 #define CHARDEV_IS_RINGBUF(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac7bc..7168b58cfe 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -240,6 +240,22 @@
   'data': { 'device': 'str' },
   'base': 'ChardevCommon' }
=20
+##
+# @ChardevI2c:
+#
+# Configuration info for i2c chardev.
+#
+# @device: The name of the special file for the device,
+#          i.e. /dev/i2c-0 on linux
+# @address: The address of the i2c device on the host.
+#
+# Since: 4.1
+##
+{ 'struct': 'ChardevI2c',
+  'data': { 'device': 'str',
+            'address': 'int16'},
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevSocket:
 #
@@ -398,6 +414,7 @@
   'data': { 'file': 'ChardevFile',
             'serial': 'ChardevHostdev',
             'parallel': 'ChardevHostdev',
+            'i2c': 'ChardevI2c',
             'pipe': 'ChardevHostdev',
             'socket': 'ChardevSocket',
             'udp': 'ChardevUdp',
diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb26..435b6975dd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2695,6 +2695,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 #if defined(CONFIG_SPICE)
     "-chardev spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPATH=
][,logappend=3Don|off]\n"
     "-chardev spiceport,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPAT=
H][,logappend=3Don|off]\n"
+#endif
+#ifdef CONFIG_LINUX
+    "-chardev i2c,id=3Did,address=3Daddress[,path=3Dpath][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
 #endif
     , QEMU_ARCH_ALL
 )
@@ -2723,7 +2726,8 @@ Backend is one of:
 @option{parallel},
 @option{parport},
 @option{spicevmc},
-@option{spiceport}.
+@option{spiceport},
+@option{i2c}.
 The specific backend will determine the applicable options.
=20
 Use @code{-chardev help} to print all available chardev backend types.
@@ -2990,6 +2994,14 @@ Connect to a spice virtual machine channel, such as =
vdiport.
=20
 Connect to a spice port, allowing a Spice client to handle the traffic
 identified by a name (preferably a fqdn).
+
+@item -chardev i2c,id=3D@var{id},address=3D@var{address},path=3D@var{path}
+
+@option{path} i2c character device (Eg: /dev/i2c-N on Linux)
+
+@option{address} address of the slave device.
+
+I2C device support as a character device.
 ETEXI
=20
 STEXI
--=20
2.14.2


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzVvRYACgkQJZ4JoaCv
xKpHFA/+O5QP6Z4k+Lro4tHjJLNQoh3kogSRDhLKYWkkY1Hk/7r+x2XkRbibHyZE
v0RbauWc99dLOHL8kY/NG8GDqU36sQvL9PRkFlh+JjLq9cYHpP6ZcYBP58VQXy9P
CTK9xUyWvOusSYkF8SpPYqTeF5HbqDKhGea4iCFB3w/3PF/rJOPlccvUijhKS9MI
xg8/xmXVXOc10QZJGExyoP3zNQ8n6aRsdmxMK6IUpLp0lQ5hL+O4u99fb1WGhR73
vT2N7v3GKB+BqYyndNFSKlj1jf3eYrWm14imAjEY2VO0dfMPaRdf5U/BxiQCr7OX
SuWBpv5XI1zhR8zwV2ILp4nXP7KG6Jjaj4FwmAqpdGZTr4Or+bmJheDAqYE0+HcR
B/HYRq3XwQ+Q81EGG+anwzH28PV/L9gxlRGcxY1O6+zghPPa4+73MkA2djaToz46
i8Q2+kTciviTxG65QUChtaahZP+ZC5yAfwhoelYVn1S4JUy/NSm8wr7vfVkEM+Yk
QlCwsrVjekQBBdwt+IvZG4a2/naqpoaYgQsqGinlHkG4P1qQG/O5uAmGfjkWKcgH
ThNgTpdeTmgelMGxts6iZHQ3MHr3b2Ur/OtUj3U5oOfKu1Ic54KXTI1ebAky524c
3hznzr1ZL3tIiPCj4cplVU5p66GTH0he2LxZqyF2SS7qw5YIwkI=
=DlE1
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


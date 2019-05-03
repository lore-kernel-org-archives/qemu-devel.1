Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C664C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 19:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D499C2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXOrVC42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D499C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMdsf-0006j4-3k
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 15:30:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMdrT-00067F-9h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMdrR-0007ju-Bf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hMdrP-0007fZ-U3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id p16so7933089wma.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=5C6839Al97Mp/dS3Xm88Bm3A/5rMIgZBGZSS0wwbDxk=;
	b=EXOrVC42af7O6YKc4mkxFrsB0T55zhQ9QRtaW0gJEryDa47dlzqdt0W3JSaNq/6E7r
	XFqMcjnqMgwz+QrOLN9yNumtIR5rVHkjHvPGlo87at32FazbZveXyvTWcKTDz9gOUOWG
	OzFah9Jd6vFquitZ1siDM9uNewf6uGGFXrhRxgLhqGKNSay7TAVXmnZJxH//zYqOTxNP
	51XLGfWmMTFVxCNrQ8aDQhZgzM96kift+sQHUcpbihz7AEyTVaNGjfLExvVnwqZ95S+D
	g2JH/ef3oBmb6MFYqWDedcqvz4hlKioiV+7k1FIbs7Zg6JjarGbVBQzR3eVLrbfqUtta
	4owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=5C6839Al97Mp/dS3Xm88Bm3A/5rMIgZBGZSS0wwbDxk=;
	b=Ur5dYi1cVpA0xSBOfsEcT9vk926aF5MZvuqhwOkoH50qSbPBz4ZgO92ZjbwKBfreZy
	x8bVdguxgPuuCx2o5M6hSQ24in/u3A4lxmoK4Vfz5jpx2D/ppTDqXp6qnldDN1FMMFAc
	XxcMQRY0D2klfMkyQ/ia/kFr1oUDXVeRno6yNEzDp74O64kEOFn8IRxVYtctxk8DU9yq
	asa7gDcOdQOWWR3SPSRZdbQaKIJKITHoJz+EsuHLBe1t/Ee2QrHCxQ6hPhQMfX6Msp6l
	2jvcK+Kct6nMrBx9VyrcDrVA3XaR5s4zYvxT7/YI/o15GHihytNspOD+zlkb53QltYj2
	ZOQA==
X-Gm-Message-State: APjAAAWJEo5Hk2sorXwWQq/SRIgV8yptjqLNqtkQk9enP7VJ5AHSGabC
	ggFIQyIk26N9gLPtuFLdPChsS7bmBU0=
X-Google-Smtp-Source: APXvYqwqcBqNxfElkFZNbyi6r0QWnroqQXejYBA3KrK3Rk9Vcfeck1K0BURGLG2c86Rhjq+EKdO3+A==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr7738962wmd.139.1556911720863;
	Fri, 03 May 2019 12:28:40 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.113])
	by smtp.gmail.com with ESMTPSA id
	j71sm3023174wmj.44.2019.05.03.12.28.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 03 May 2019 12:28:39 -0700 (PDT)
Date: Fri, 3 May 2019 20:31:41 +0100
From: Ernest Esene <eroken1@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190503193141.GA17700@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
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
Message-ID: <20190503193141.qmM5YBFHIaV9vyo1L7-BRgT7J3ThJRatQNXmT84U6RA@z>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for Linux I2C character device for I2C device passthrough
For example:
-chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev

Signed-off-by: Ernest Esene <eroken1@gmail.com>
---
 chardev/Makefile.objs  |   1 +
 chardev/char-i2c.c     | 142 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 chardev/char.c         |   3 ++
 include/chardev/char.h |   1 +
 qapi/char.json         |  16 ++++++
 5 files changed, 163 insertions(+)
 create mode 100644 chardev/char-i2c.c

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..6c96b9a353 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -16,6 +16,7 @@ chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
+chardev-obj-$(CONFIG_POSIX) +=3Dchar-i2c.o
=20
 common-obj-y +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
diff --git a/chardev/char-i2c.c b/chardev/char-i2c.c
new file mode 100644
index 0000000000..78cf973bd7
--- /dev/null
+++ b/chardev/char-i2c.c
@@ -0,0 +1,142 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu-common.h"
+#include "io/channel-file.h"
+
+#include "chardev/char-fd.h"
+#include "chardev/char.h"
+
+#include <sys/ioctl.h>
+#include <linux/i2c-dev.h>
+
+#define CHR_IOCTL_I2C_SET_ADDR 1
+
+#define CHR_I2C_ADDR_10BIT_MAX 1023
+#define CHR_I2C_ADDR_7BIT_MAX 127
+
+void qemu_set_block(int fd);
+
+static int i2c_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    FDChardev *fd_chr =3D FD_CHARDEV(chr);
+    QIOChannelFile *floc =3D QIO_CHANNEL_FILE(fd_chr->ioc_in);
+    int fd =3D floc->fd;
+    int addr;
+
+    switch (cmd) {
+        case CHR_IOCTL_I2C_SET_ADDR:
+            addr =3D (int) (long) arg;
+
+            if (addr > CHR_I2C_ADDR_7BIT_MAX) {
+                /*TODO: check if adapter support 10-bit addr
+                I2C_FUNC_10BIT_ADDR */
+                if (ioctl(fd, I2C_TENBIT, addr) < 0) {
+                    goto err;
+                }
+            }
+            else {
+                if (ioctl(fd, I2C_SLAVE, addr) < 0) {
+                    goto err;
+                }
+            }
+            break;
+
+        default:
+            return -ENOTSUP;
+           =20
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
+    fd =3D qmp_chardev_open_file_source(i2c->device, O_RDWR | O_NONBLOCK,
+                                      errp);
+    if (fd < 0) {
+       return;
+    }
+    qemu_set_block(fd);
+    qemu_chr_open_fd(chr, fd, fd);
+    addr =3D (void *) (long) i2c->address;
+    i2c_ioctl(chr, CHR_IOCTL_I2C_SET_ADDR, addr);
+}
+
+static void qemu_chr_parse_i2c(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    const char *addr =3D qemu_opt_get(opts, "address");
+    long address;
+    ChardevI2c *i2c;
+   =20
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: linux-i2c: no device path given");
+        return;
+    }
+    if (addr =3D=3D NULL) {
+        error_setg(errp, "chardev: linux-i2c: no device address given");
+        return;
+    }
+    address =3D strtol(addr, NULL, 0);
+    if (address < 0 || address > CHR_I2C_ADDR_10BIT_MAX) {
+        error_setg(errp, "chardev: linux-i2c: invalid device address given=
");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_I2C;
+    i2c =3D backend->u.i2c.data =3D g_new0(ChardevI2c, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevI2c_base(i2c));
+    i2c->device =3D g_strdup(device);
+    i2c->address =3D (int16_t) address;
+}
+
+static void char_i2c_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_i2c;
+    cc->open =3D  qmp_chardev_open_i2c;
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
index 54724a56b1..93732a9909 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -926,6 +926,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "logappend",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "address",
+            .type =3D QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
diff --git a/include/chardev/char.h b/include/chardev/char.h
index c0b57f7685..880614391f 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -245,6 +245,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 #define TYPE_CHARDEV_SERIAL "chardev-serial"
 #define TYPE_CHARDEV_SOCKET "chardev-socket"
 #define TYPE_CHARDEV_UDP "chardev-udp"
+#define TYPE_CHARDEV_I2C "chardev-linux-i2c"
=20
 #define CHARDEV_IS_RINGBUF(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac7bc..602b4099dc 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -240,6 +240,21 @@
   'data': { 'device': 'str' },
   'base': 'ChardevCommon' }
=20
+##
+# @ChardevI2c:
+#
+# Configuration info for i2c chardev (only on linux).
+#
+# @device: The name of the special file for the device,
+#          i.e. /dev/i2c-0 on linux
+# @address: The address of the i2c device on the host.
+#
+##
+{ 'struct': 'ChardevI2c',
+  'data': { 'device': 'str',
+            'address': 'int16'},
+  'base': 'ChardevCommon'}
+
 ##
 # @ChardevSocket:
 #
@@ -398,6 +413,7 @@
   'data': { 'file': 'ChardevFile',
             'serial': 'ChardevHostdev',
             'parallel': 'ChardevHostdev',
+            'i2c': 'ChardevI2c',
             'pipe': 'ChardevHostdev',
             'socket': 'ChardevSocket',
             'udp': 'ChardevUdp',
--=20
2.14.2


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzMlxgACgkQJZ4JoaCv
xKoz8hAAjEY9DZ//euQwkA6vbkUB9Kl2spnyfgDRCfNu/6uHRt/zKI5c+F+oE1cp
5RLffMzw+KgPlpnXX0c0ZPvXGhGUDVf1zJAACjnkskYAck+tPmazjkhMBGOQRKqC
das0WsUq2yC9ntGMv/JY2T+Diwx/idtPufNg/lf0e4FeMd/MEXGwMwmUJSCIuWnk
/vmbadlrVFtsTgkdp7+oUKmRD0iyLHmrqpCe75yWrVPi/bhXVA6pWgXi4Mwnfa/3
YUPjJBSbz6fd7DCMxwksFzpvWg0ZlbdKa7WlrA8gWh1ZI+09SEUEVnMi15hxi8ov
jJzCN7F0WnsyRni727roRuvKsyxYABWOhIde5PZStbqwr0Ikcr5TcxqfLt7dPDZ+
hpblYZntd8DIvC12arwITcbv/Bx8j2bIKOR9plTbqBZU4as8Sy9zF3UbIcqVXLSo
xct+X3+/9t2e2mxRy5rUm3M1fVmhzYBHgWwOzmanif7ZxiBVkyC42o5J0aRCoIMx
/8b7ToR5qHLk3q3RA4d/E1vBDGgeEgr4U7r59SVDFdmmDY7KnQbJQvYLXmgrbZil
AaRSVj59QyfSLQwHWCh/xcPaHVPOYwvtxxhv5e1nf2wLTrMbzW+jIXxaZmriq8aY
vveizKK8839yZr/hmHQQW/9YKI/7C9lr2CLQ5/lkPZd9QvQnoZM=
=pl4N
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


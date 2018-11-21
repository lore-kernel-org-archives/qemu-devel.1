Received: from eggs.gnu.org ([2001:4830:134:3::10]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPai1-0007Oi-7B
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPahx-0006vP-21
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPahq-0006ng-V0
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:48 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:47 +0400
Message-Id: <20181121220647.18844-31-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 30/30] build-sys: add a basic
 meson build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This is a minimal file to build a libslirp shared library.

It has been tested to build on Linux and with mingw64 cross-compilation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/meson.build | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 slirp/meson.build

diff --git a/slirp/meson.build b/slirp/meson.build
new file mode 100644
index 0000000000..aa6f1b39e2
--- /dev/null
+++ b/slirp/meson.build
@@ -0,0 +1,48 @@
+project('slirp', 'c', version : '3.1')
+
+add_global_arguments('-std=3Dgnu99', language : 'c')
+
+host_system =3D host_machine.system()
+
+glib_dep =3D dependency('glib-2.0')
+
+cc =3D meson.get_compiler('c')
+
+platform_deps =3D []
+
+if host_system =3D=3D 'windows'
+  platform_deps +=3D [
+    cc.find_library('ws2_32'),
+    cc.find_library('iphlpapi')
+  ]
+endif
+
+shared_library('slirp',
+               'arp_table.c',
+               'bootp.c',
+               'cksum.c',
+               'dhcpv6.c',
+               'dnssearch.c',
+               'if.c',
+               'ip6_icmp.c',
+               'ip6_input.c',
+               'ip6_output.c',
+               'ip_icmp.c',
+               'ip_input.c',
+               'ip_output.c',
+               'mbuf.c',
+               'misc.c',
+               'ncsi.c',
+               'ndp_table.c',
+               'sbuf.c',
+               'slirp.c',
+               'socket.c',
+               'tcp_input.c',
+               'tcp_output.c',
+               'tcp_subr.c',
+               'tcp_timer.c',
+               'tftp.c',
+               'udp.c',
+               'udp6.c',
+               'util.c',
+               dependencies : [glib_dep, platform_deps])
--=20
2.20.0.rc1

Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56CC282E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E435214AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E435214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIvVK-0006Wl-Uq
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 09:30:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMR-000743-2m
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMO-0005gQ-Ug
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hIvMO-0005YH-LF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BA782D7FB
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:21:09 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C4176013D;
	Tue, 23 Apr 2019 13:20:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 15:19:58 +0200
Message-Id: <20190423132004.13725-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 23 Apr 2019 13:21:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423131958.g_2C-rwyYIVOYfGIrI1QgIWX8nxwv_GMe2D9vei2gmI@z>

Add a new vhost-user message to give a unix socket to a vhost-user
backend for GPU display updates.

Back when I started that work, I added a new GPU channel because the
vhost-user protocol wasn't bidirectional. Since then, there is a
vhost-user-slave channel for the slave to send requests to the master.
We could extend it with GPU messages. However, the GPU protocol is
quite orthogonal to vhost-user, thus I chose to have a new dedicated
channel.

See vhost-user-gpu.rst for the protocol details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |   1 +
 include/hw/virtio/vhost-backend.h     |   2 +
 contrib/libvhost-user/libvhost-user.c |   1 +
 hw/virtio/vhost-user.c                |  11 ++
 MAINTAINERS                           |   6 +
 docs/interop/index.rst                |   2 +-
 docs/interop/vhost-user-gpu.rst       | 238 ++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |   9 +
 8 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 docs/interop/vhost-user-gpu.rst

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 414ceb0a2f..eac5c120de 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -94,6 +94,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_GET_INFLIGHT_FD =3D 31,
     VHOST_USER_SET_INFLIGHT_FD =3D 32,
+    VHOST_USER_GPU_SET_SOCKET =3D 33,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index d6632a18e6..6f6670783f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -170,4 +170,6 @@ int vhost_backend_invalidate_device_iotlb(struct vhos=
t_dev *dev,
 int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
                                           struct vhost_iotlb_msg *imsg);
=20
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
+
 #endif /* VHOST_BACKEND_H */
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e738f6ce88..c9823a1354 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -130,6 +130,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_POSTCOPY_END),
         REQ(VHOST_USER_GET_INFLIGHT_FD),
         REQ(VHOST_USER_SET_INFLIGHT_FD),
+        REQ(VHOST_USER_GPU_SET_SOCKET),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 553319c7ac..4ca5b2551e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -96,6 +96,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_GET_INFLIGHT_FD =3D 31,
     VHOST_USER_SET_INFLIGHT_FD =3D 32,
+    VHOST_USER_GPU_SET_SOCKET =3D 33,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -353,6 +354,16 @@ static int vhost_user_write(struct vhost_dev *dev, V=
hostUserMsg *msg,
     return 0;
 }
=20
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd)
+{
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_GPU_SET_SOCKET,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    return vhost_user_write(dev, &msg, &fd, 1);
+}
+
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e727299de..337eca10a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1659,6 +1659,12 @@ F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.c
 F: include/hw/virtio/virtio-gpu.h
=20
+vhost-user-gpu
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: docs/interop/vhost-user-gpu.rst
+
 Cirrus VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 2df977dd52..28ead07466 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -15,4 +15,4 @@ Contents:
    bitmaps
    live-block-operations
    pr-helper
-
+   vhost-user-gpu
diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gp=
u.rst
new file mode 100644
index 0000000000..9cc1106b02
--- /dev/null
+++ b/docs/interop/vhost-user-gpu.rst
@@ -0,0 +1,238 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Vhost-user-gpu Protocol
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Licence: This work is licensed under the terms of the GNU GPL,
+          version 2 or later. See the COPYING file in the top-level
+          directory.
+
+.. contents:: Table of Contents
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The vhost-user-gpu protocol is aiming at sharing the rendering result
+of a virtio-gpu, done from a vhost-user slave process to a vhost-user
+master process (such as QEMU). It bears a resemblance to a display
+server protocol, if you consider QEMU as the display server and the
+slave as the client, but in a very limited way. Typically, it will
+work by setting a scanout/display configuration, before sending flush
+events for the display updates. It will also update the cursor shape
+and position.
+
+The protocol is sent over a UNIX domain stream socket, since it uses
+socket ancillary data to share opened file descriptors (DMABUF fds or
+shared memory). The socket is usually obtained via
+``VHOST_USER_GPU_SET_SOCKET``.
+
+Requests are sent by the *slave*, and the optional replies by the
+*master*.
+
+Wire format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Unless specified differently, numbers are in the machine native byte
+order.
+
+A vhost-user-gpu request consists of 2 header fields and a payload.
+
++---------+------+---------+
+| request | size | payload |
++---------+------+---------+
+
+Header
+------
+
+:request: ``u32``, type of the request
+
+:size: ``u32``, size of the payload
+
+A reply consists only of a payload, whose content depends on the request=
.
+
+Payload types
+-------------
+
+Depending on the request type, **payload** can be:
+
+VhostUserGpuCursorPos
+^^^^^^^^^^^^^^^^^^^^^
+
++------------+---+---+
+| scanout-id | x | y |
++------------+---+---+
+
+:scanout-id: ``u32``, the scanout where the cursor is located
+
+:x/y: ``u32``, the cursor postion
+
+VhostUserGpuCursorUpdate
+^^^^^^^^^^^^^^^^^^^^^^^^
+
++-----+-------+-------+--------+
+| pos | hot_x | hot_y | cursor |
++-----+-------+-------+--------+
+
+:pos: a ``VhostUserGpuCursorPos``, the cursor location
+
+:hot_x/hot_y: ``u32``, the cursor hot location
+
+:cursor: ``[u32; 64 * 64]``, 64x64 RGBA cursor data
+
+VhostUserGpuScanout
+^^^^^^^^^^^^^^^^^^^
+
++------------+---+---+
+| scanout-id | w | h |
++------------+---+---+
+
+:scanout-id: ``u32``, the scanout configuration to set
+
+:w/h: ``u32``, the scanout width/height size
+
+VhostUserGpuUpdate
+^^^^^^^^^^^^^^^^^^
+
++------------+---+---+---+---+------+
+| scanout-id | x | y | w | h | data |
++------------+---+---+---+---+------+
+
+:scanout-id: ``u32``, the scanout content to update
+
+:x/y/w/h: ``u32``, region of the update
+
+:data: RGBA data (the size is computed based on the region size, and
+       the request type)
+
+VhostUserGpuDMABUFScanout
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
++------------+---+---+---+---+-----+-----+--------+-------+--------+
+| scanout-id | x | y | w | h | fdw | fwh | stride | flags | fourcc |
++------------+---+---+---+---+-----+-----+--------+-------+--------+
+
+:scanout-id: ``u32``, the scanout configuration to set
+
+:x/y: ``u32``, the location of the scanout within the DMABUF
+
+:w/h: ``u32``, the scanout width/height size
+
+:fdw/fdh/stride/flags: ``u32``, the DMABUF width/height/stride/flags
+
+:fourcc: ``i32``, the DMABUF fourcc
+
+
+C structure
+-----------
+
+In QEMU the vhost-user-gpu message is implemented with the following str=
uct:
+
+.. code:: c
+
+  typedef struct VhostUserGpuMsg {
+      uint32_t request; /* VhostUserGpuRequest */
+      uint32_t size; /* the following payload size */
+      union {
+          VhostUserGpuCursorPos cursor_pos;
+          VhostUserGpuCursorUpdate cursor_update;
+          VhostUserGpuScanout scanout;
+          VhostUserGpuUpdate update;
+          VhostUserGpuDMABUFScanout dmabuf_scanout;
+          uint64_t u64;
+      } payload;
+  } QEMU_PACKED VhostUserGpuMsg;
+
+Protocol features
+-----------------
+
+None yet.
+
+As the protocol may need to evolve, new messages and communication
+changes are negotiated thanks to preliminary
+``VHOST_USER_GPU_GET_PROTOCOL_FEATURES`` and
+``VHOST_USER_GPU_SET_PROTOCOL_FEATURES`` requests.
+
+Communication
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Message types
+-------------
+
+``VHOST_USER_GPU_GET_PROTOCOL_FEATURES``
+  :id: 1
+  :request payload: N/A
+  :reply payload: ``u64``
+
+  Get the supported protocol features bitmask.
+
+``VHOST_USER_GPU_SET_PROTOCOL_FEATURES``
+  :id: 2
+  :request payload: ``u64``
+  :reply payload: N/A
+
+  Enable protocol features using a bitmask.
+
+``VHOST_USER_GPU_GET_DISPLAY_INFO``
+  :id: 3
+  :request payload: N/A
+  :reply payload: ``struct virtio_gpu_resp_display_info`` (from virtio s=
pecification)
+
+  Get the preferred display configuration.
+
+``VHOST_USER_GPU_CURSOR_POS``
+  :id: 4
+  :request payload: ``VhostUserGpuCursorPos``
+  :reply payload: N/A
+
+  Set/show the cursor position.
+
+``VHOST_USER_GPU_CURSOR_POS_HIDE``
+  :id: 5
+  :request payload: ``VhostUserGpuCursorPos``
+  :reply payload: N/A
+
+  Set/hide the cursor.
+
+``VHOST_USER_GPU_CURSOR_UPDATE``
+  :id: 6
+  :request payload: ``VhostUserGpuCursorUpdate``
+  :reply payload: N/A
+
+  Update the cursor shape and location.
+
+``VHOST_USER_GPU_SCANOUT``
+  :id: 7
+  :request payload: ``VhostUserGpuScanout``
+  :reply payload: N/A
+
+  Set the scanout resolution. To disable a scanout, the dimensions
+  width/height are set to 0.
+
+``VHOST_USER_GPU_UPDATE``
+  :id: 8
+  :request payload: ``VhostUserGpuUpdate``
+  :reply payload: N/A
+
+  Update the scanout content. The data payload contains the graphical bi=
ts.
+  The display should be flushed and presented.
+
+``VHOST_USER_GPU_DMABUF_SCANOUT``
+  :id: 9
+  :request payload: ``VhostUserGpuDMABUFScanout``
+  :reply payload: N/A
+
+  Set the scanout resolution/configuration, and share a DMABUF file
+  descriptor for the scanout content, which is passed as ancillary
+  data. To disable a scanout, the dimensions width/height are set
+  to 0, there is no file descriptor passed.
+
+``VHOST_USER_GPU_DMABUF_UPDATE``
+  :id: 10
+  :request payload: ``VhostUserGpuUpdate``
+  :reply payload: ``u32``
+
+  The display should be flushed and presented according to updated
+  region from ``VhostUserGpuUpdate``.
+
+  Note: there is no data payload, since the scanout is shared thanks
+  to DMABUF, that must have been set previously with
+  ``VHOST_USER_GPU_DMABUF_SCANOUT``.
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 4dbd530cb9..1be2c74cc7 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -1051,6 +1051,15 @@ Master message types
       the shared inflight buffer back to slave so that slave could get
       inflight I/O after a crash or restart.
=20
+ * VHOST_USER_GPU_SET_SOCKET
+      Id: 33
+      Master payload: N/A
+      Slave payload: N/A
+
+      Sets the GPU protocol socket file descriptor, which is passed as
+      ancillary data. The GPU protocol is used to inform the master of
+      rendering state and updates. See vhost-user-gpu.rst for details.
+
 Slave message types
 -------------------
=20
--=20
2.21.0.313.ge35b8cb8e2



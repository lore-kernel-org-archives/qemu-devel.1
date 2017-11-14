Received: from eggs.gnu.org ([2001:4830:134:3::10]:37103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <djmk@google.com>) id 1eEOt3-00067h-5w
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <djmk@google.com>) id 1eEOt2-0000t0-DO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:15:33 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:52619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <djmk@google.com>) id 1eEOt2-0000sK-8C
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:15:32 -0500
Received: by mail-io0-x22c.google.com with SMTP id u42so4571361ioi.9
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 16:15:31 -0800 (PST)
MIME-Version: 1.0
From: Joe Kniss <djmk@google.com>
Date: Mon, 13 Nov 2017 16:15:30 -0800
Message-ID: <CAOvnNvYpQSdM5PXoBZXwf6op+FVNd3j0CPBnKGqxfa2V3pnJjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu+virgl on systems without dmabuf and/or GBM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi,

  I am developing using qemu with virglrenderer on linux systems that
do not support dmabufs or GBM.   I have been successful making this
work using glx and ignoring egl/dmabuf/gbm use in qemu.
Unfortunately, there is currently no way to configure qemu to use
opengl but disable egl/dmabuf/gbm.  This use case could be handled
with a straight-forward configure fix, but I am not sure what the
preferred approach would be.  Here are some options for example:

1) Check for gbm in configure, if it is unavailable disable ui/egl*
since this egl implementation depends on gbm.
2) Check for gbm in configure, modify ui/egl* to work when gbm is missing.
3) Add disable-egl flag to configure, ignore gbm package when egl is disabled.

For our use case, option 3 is the simplest, since we don't need either
egl or gbm and gbm is only used with egl in qemu.  We also encountered
an additional issue with either gtk or qemu (I forget which)
attempting to share glx and egl contexts.

Naturally, we want to come up with a solution that is most generally
useful,  feedback is greatly appreciated.

Cheers,
-Joe Kniss

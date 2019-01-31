Received: from eggs.gnu.org ([209.51.188.92]:49618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCC3-0004Ph-S5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCBz-0002Qx-Sd
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:15:45 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCBz-0002F3-KK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:15:43 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:15:27 +0300
Message-ID: <20190131131527.23264.28881.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 01/25] replay: add missing fix for internal
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

From: pbonzini@redhat.com <pbonzini@redhat.com>

This is a fix which was missed by patch
74c0b816adfc6aa1b01b4426fdf385e32e35cbac, which added current_step
parameter to the replay_advance_current_step function.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-internal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 8f87e9b..7e6de03 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -229,7 +229,7 @@ void replay_mutex_unlock(void)
 
 void replay_advance_current_step(uint64_t current_step)
 {
-    int diff = (int)(replay_get_current_step() - replay_state.current_step);
+    int diff = (int)(current_step - replay_state.current_step);
 
     /* Time can only go forward */
     assert(diff >= 0);

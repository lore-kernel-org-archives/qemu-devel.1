Received: from eggs.gnu.org ([2001:4830:134:3::10]:59215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oi-00081G-4X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oh-0002Lw-AQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Oh-0002Ci-4g
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OR-0003RN-LY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:37 +0100
Message-Id: <1500295494-8991-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/18] qdev-properties.h: Explicitly set the
 default value for arraylen properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In DEFINE_PROP_ARRAY, because we use a PropertyInfo (qdev_prop_arraylen)
which has a .set_default_value member we will set the field to a default
value. That default value will be zero, by the C rule that struct
initialization sets unmentioned members to zero if at least one member
is initialized. However it's clearer to state it explicitly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 1499788408-10096-2-git-send-email-peter.maydell@linaro.org
---
 include/hw/qdev-properties.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f6692d5..12c0c7b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -111,6 +111,7 @@ extern const PropertyInfo qdev_prop_link;
                           _arrayfield, _arrayprop, _arraytype) {        \
         .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
         .info = &(qdev_prop_arraylen),                                  \
+        .defval.u = 0,                                                  \
         .offset = offsetof(_state, _field)                              \
             + type_check(uint32_t, typeof_field(_state, _field)),       \
         .arrayinfo = &(_arrayprop),                                     \
-- 
2.7.4

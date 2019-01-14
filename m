Received: from eggs.gnu.org ([209.51.188.92]:57020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KM-0000kd-Tx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KL-0005ki-19
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3KK-0005kH-RS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Jan 2019 12:34:32 -0200
Message-Id: <20190114143432.4771-6-ehabkost@redhat.com>
In-Reply-To: <20190114143432.4771-1-ehabkost@redhat.com>
References: <20190114143432.4771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] i386/kvm: add a comment explaining why
 .feat_names are commented out for Hyper-V feature bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Hyper-V .feat_names are, unlike hardware features, commented out and it is
not obvious why we do that. Document the current status quo.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20181221141604.16935-1-vkuznets@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ece83696e..2f5412592d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -929,6 +929,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
          */
         .no_autoenable_flags = ~0U,
     },
+    /*
+     * .feat_names are commented out for Hyper-V enlightenments because we
+     * don't want to have two different ways for enabling them on QEMU command
+     * line. Some features (e.g. "hyperv_time", "hyperv_vapic", ...) require
+     * enabling several feature bits simultaneously, exposing these bits
+     * individually may just confuse guests.
+     */
     [FEAT_HYPERV_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-- 
2.18.0.rc1.1.g3f1ff2140

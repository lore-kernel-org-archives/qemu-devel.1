Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7CC-0004pz-9K
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7C9-0006PS-G6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7C9-0006Ns-9x
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:12 -0300
Message-Id: <20170401004624.30886-8-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 07/19] kvmclock: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

kvmclock should be used by guests only when the appropriate CPUID
feature flags are set on the VCPU, and it is automatically
created by kvmclock_create() when those feature flags are set.
This means creating a kvmclock device using -device is useless.
Remove user_creatable from its device class.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/clock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 0dbf083b17..13eca374cd 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -286,11 +286,6 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
     dc->props = kvmclock_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo kvmclock_info = {
-- 
2.11.0.259.g40922b1

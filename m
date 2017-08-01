Received: from eggs.gnu.org ([2001:4830:134:3::10]:59612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrc-0004QD-8L
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrb-0007GU-Bg
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:44 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrb-0007Fs-4b
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:43 -0400
Received: by mail-wr0-x242.google.com with SMTP id 12so1794868wrb.4
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:18 +0200
Message-Id: <1501604245-33460-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/17] qemu-options: document existance of
 versioned machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The -machine docs did not explain what the versioned machine
types are for, nor that they'll be maintained across
releases.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170725141041.1195-1-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 746b5fa..9f6e2ad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -49,7 +49,20 @@ STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
 @findex -machine
 Select the emulated machine by @var{name}. Use @code{-machine help} to list
-available machines. Supported machine properties are:
+available machines.
+
+For architectures which aim to support live migration compatibility
+across releases, each release will introduce a new versioned machine
+type. For example, the 2.8.0 release introduced machine types
+``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
+
+To allow live migration of guests from QEMU version 2.8.0, to QEMU
+version 2.9.0, the 2.9.0 version must support the ``pc-i440fx-2.8''
+and ``pc-q35-2.8'' machines too. To allow users live migrating VMs
+to skip multiple intermediate releases when upgrading, new releases
+of QEMU will support machine types from many previous versions.
+
+Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-- 
1.8.3.1

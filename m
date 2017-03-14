Received: from eggs.gnu.org ([2001:4830:134:3::10]:36561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9Z-0003OJ-Ar
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9X-0006XE-Tc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:29 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9X-0006Wb-Mn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id v190so582762wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:04 +0100
Message-Id: <1489508300-48184-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/18] docs: Add a note about mixing bootindex
 with "-boot order"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Occasionally the users try to mix the bootindex properties with the
"-boot order" parameter - and this likely does not give the expected
results. So let's add a proper statement that these two concepts
should not be used together.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1488303601-23741-1-git-send-email-thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/bootindex.txt | 9 +++++++++
 qemu-options.hx    | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/bootindex.txt b/docs/bootindex.txt
index f84fac7..b9a8ba1 100644
--- a/docs/bootindex.txt
+++ b/docs/bootindex.txt
@@ -41,3 +41,12 @@ has three bootable devices target1, target3, target5 connected to it,
 the option ROM will have a boot method for each of them, but it is not
 possible to map from boot method back to a specific target.  This is a
 shortcoming of the PC BIOS boot specification.
+
+== Mixing bootindex and boot order parameters ==
+
+Note that it does not make sense to use the bootindex property together
+with the "-boot order=..." (or "-boot once=...") parameter. The guest
+firmware implementations normally either support the one or the other,
+but not both parameters at the same time. Mixing them will result in
+undefined behavior, and thus the guest firmware will likely not boot
+from the expected devices.
diff --git a/qemu-options.hx b/qemu-options.hx
index 8dd8ee3..99af8ed 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -252,7 +252,10 @@ drive letters depend on the target architecture. The x86 PC uses: a, b
 (floppy 1 and 2), c (first hard disk), d (first CD-ROM), n-p (Etherboot
 from network adapter 1-4), hard disk boot is the default. To apply a
 particular boot order only on the first startup, specify it via
-@option{once}.
+@option{once}. Note that the @option{order} or @option{once} parameter
+should not be used together with the @option{bootindex} property of
+devices, since the firmware implementations normally do not support both
+at the same time.
 
 Interactive boot menus/prompts can be enabled via @option{menu=on} as far
 as firmware/BIOS supports them. The default is non-interactive boot.
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdD99-0007E6-Dt
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdD95-0000He-DX
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:42:11 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:50813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdD95-0000HT-3K
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:42:07 -0500
Message-Id: <58A1EFE702000062000CF3CD@prv-mh.provo.novell.com>
Date: Mon, 13 Feb 2017 02:41:59 -0700
From: "Lin Ma" <lma@suse.com>
References: <20170213092709.24711-1-lma@suse.com>
In-Reply-To: <20170213092709.24711-1-lma@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSN77yaICBbUEFUQ0hdIHRyYWNlOiBmaXgg?=
 =?utf-8?q?trace-events-all_dependencies_in_Makefile=2Eobjs?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com

Oops, I didn't notice that the issue was fixed already, Sorry about that.
Lin

>>> Lin Ma <lma@suse.com> 2017/2/13 =E6=98=9F=E6=9C=9F=E4=B8=80 =
=E4=B8=8B=E5=8D=88 5:27 >>>
It causes that file trace-events-all isn't generated during build, make
install reports 'No such file or directory'. The patch fixes it.

Signed-off-by: Lin Ma <lma@suse.com>
---
trace/Makefile.objs | 8 ++++----
1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 7de840a..8e5e85a 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -17,7 +17,7 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)

$(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-ti=
mestamp
	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) =
$(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-a=
ll $(BUILD_DIR)/config-host.mak $(tracetool-y)
	$(call quiet-command,$(TRACETOOL) \
		--group=3Dall \
		--format=3Dtcg-helper-wrapper-h \
@@ -26,7 +26,7 @@ $(obj)/generated-helpers-wrappers.h-timestamp: $(trace-ev=
ents-files) $(BUILD_DIR

$(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/c=
onfig-host.mak $(tracetool-y)
+$(obj)/generated-helpers.h-timestamp: $(BUILD_DIR)/trace-events-all =
$(BUILD_DIR)/config-host.mak $(tracetool-y)
	$(call quiet-command,$(TRACETOOL) \
		--group=3Dall \
		--format=3Dtcg-helper-h \
@@ -35,7 +35,7 @@ $(obj)/generated-helpers.h-timestamp: $(trace-events-file=
s) $(BUILD_DIR)/config-

$(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(trace-events-files) $(BUILD_DIR)/c=
onfig-host.mak $(tracetool-y)
+$(obj)/generated-helpers.c-timestamp: $(BUILD_DIR)/trace-events-all =
$(BUILD_DIR)/config-host.mak $(tracetool-y)
	$(call quiet-command,$(TRACETOOL) \
		--group=3Dall \
		--format=3Dtcg-helper-c \
@@ -49,7 +49,7 @@ target-obj-y +=3D generated-helpers.o

$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(trace-events-files) $(BUILD_DI=
R)/config-host.mak $(tracetool-y)
+$(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all =
$(BUILD_DIR)/config-host.mak $(tracetool-y)
	$(call quiet-command,$(TRACETOOL) \
		--group=3Dall \
		--format=3Dtcg-h \
--=20
2.9.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v7T-0003BF-TH
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v7S-0004Ls-Q9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2v7S-0004LP-Jh
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:14:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB5A8C057FAF
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 08:14:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Oct 2017 10:14:47 +0200
Message-Id: <20171013081450.29647-9-kraxel@redhat.com>
In-Reply-To: <20171013081450.29647-1-kraxel@redhat.com>
References: <20171013081450.29647-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] Add pc-bios/keymaps/Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Update files where I think I've figured the correct xkb maps.
TODO: nl-be sl sv

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20171005153330.19210-3-kraxel@redhat.com
---
 pc-bios/keymaps/Makefile | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 pc-bios/keymaps/Makefile

diff --git a/pc-bios/keymaps/Makefile b/pc-bios/keymaps/Makefile
new file mode 100644
index 0000000000..f0e44fd110
--- /dev/null
+++ b/pc-bios/keymaps/Makefile
@@ -0,0 +1,56 @@
+
+KEYMAP	:= $(shell which qemu-keymap 2>/dev/null)
+
+MAPS	:= ar bepo cz da de de-ch en-us en-gb es et fi fo \
+	   fr fr-be fr-ca fr-ch \
+	   hr hu is it ja lt lv mk nl no pl pt pt-br ru th tr
+
+ar	: MAP_FLAGS :=	-l ar
+bepo	: MAP_FLAGS :=	-l fr -v dvorak
+cz	: MAP_FLAGS :=	-l cz
+da	: MAP_FLAGS :=	-l dk
+de	: MAP_FLAGS :=	-l de
+de-ch	: MAP_FLAGS :=	-l ch
+en-us	: MAP_FLAGS :=	-l us
+en-gb	: MAP_FLAGS :=	-l gb
+es	: MAP_FLAGS :=	-l es
+et	: MAP_FLAGS :=	-l et
+fi	: MAP_FLAGS :=	-l fi
+fo	: MAP_FLAGS :=	-l fo
+fr	: MAP_FLAGS :=	-l fr
+fr-be	: MAP_FLAGS :=	-l be
+fr-ca	: MAP_FLAGS :=	-l ca -v fr
+fr-ch	: MAP_FLAGS :=	-l ch -v fr
+hr	: MAP_FLAGS :=	-l hr
+hu	: MAP_FLAGS :=	-l hu
+is	: MAP_FLAGS :=	-l is
+it	: MAP_FLAGS :=	-l it
+ja	: MAP_FLAGS :=	-l jp -m jp106
+lt	: MAP_FLAGS :=	-l lt
+lv	: MAP_FLAGS :=	-l lv
+mk	: MAP_FLAGS :=	-l mk
+nl	: MAP_FLAGS :=	-l nl
+no	: MAP_FLAGS :=	-l no
+pl	: MAP_FLAGS :=	-l pl
+pt	: MAP_FLAGS :=	-l pt
+pt-br	: MAP_FLAGS :=	-l br
+ru	: MAP_FLAGS :=	-l ru
+th	: MAP_FLAGS :=	-l th
+tr	: MAP_FLAGS :=	-l tr
+
+ifeq ($(KEYMAP),)
+
+all:
+	@echo "nothing to do (qemu-keymap not found)"
+
+else
+
+all: $(MAPS)
+
+clean:
+	rm -f $(MAPS)
+
+$(MAPS): $(KEYMAP) Makefile
+	$(KEYMAP) -f $@ $(MAP_FLAGS)
+
+endif
-- 
2.9.3

Received: from eggs.gnu.org ([209.51.188.92]:41943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK987-0006gA-Sd
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK985-0000WE-Te
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:15:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Apr 2019 18:15:27 -0400
Message-Id: <20190426221528.30293-2-jsnow@redhat.com>
In-Reply-To: <20190426221528.30293-1-jsnow@redhat.com>
References: <20190426221528.30293-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, kchamart@redhat.com, armbru@redhat.com, aliang@redhat.com, nsoffer@redhat.com, Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org, eblake@redhat.com

If we add references that don't resolve (or accidentally remove them),
it will be helpful to have an error message alerting us to that.

Turn warnings into errors so we can be alerted to problems in building
the documentation when they arise.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 626a04d305..1211e78c91 100644
--- a/Makefile
+++ b/Makefile
@@ -926,7 +926,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/inter=
op/index.html
=20
 # Canned command to build a single manual
-build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -b htm=
l -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/$1 =
$(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$=
1")
+build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n =
-b html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctre=
es/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILD=
DIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
=20
--=20
2.20.1

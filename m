Received: from eggs.gnu.org ([209.51.188.92]:58959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFd-0003Pk-Cm
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFc-0006zb-Ea
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:25 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 22 Apr 2019 18:17:13 -0400
Message-Id: <20190422221714.7630-2-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-1-jsnow@redhat.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: aliang@redhat.com, kchamart@redhat.com, eblake@redhat.com, Fam Zheng <fam@euphon.net>, nsoffer@redhat.com, qemu-stable@nongnu.org, armbru@redhat.com, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>

If we add references that don't resolve (or accidentally remove them),
it will be helpful to have an error message alerting us to that.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 04a0d45050..ff9ce2ed4c 100644
--- a/Makefile
+++ b/Makefile
@@ -899,7 +899,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/inter=
op/index.html
=20
 # Canned command to build a single manual
-build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -b htm=
l -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/$1 =
$(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$=
1")
+build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -n -b =
html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/=
$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR=
)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
=20
--=20
2.20.1

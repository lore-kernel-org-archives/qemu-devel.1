Received: from eggs.gnu.org ([2001:4830:134:3::10]:46366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb28-0001qi-Gg
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb27-000350-NB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cQb27-00034g-HR
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3ACF3D953
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:34:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  9 Jan 2017 15:34:22 +0100
Message-Id: <20170109143437.30554-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 06/21] qga/schema: improve guest-set-vcpus
 Returns: section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Itemize the possible return values of guest-set-vcpus.

Drop the blank lines for consistency with itemized
lists elsewhere.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 94c03128fd..d421609dcb 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -697,21 +697,18 @@
 # Returns: The length of the initial sublist that has been successfully
 #          processed. The guest agent maximizes this value. Possible cas=
es:
 #
-#          0:                if the @vcpus list was empty on input. Gues=
t state
+#          - 0:              if the @vcpus list was empty on input. Gues=
t state
 #                            has not been changed. Otherwise,
-#
-#          Error:            processing the first node of @vcpus failed =
for the
+#          - Error:          processing the first node of @vcpus failed =
for the
 #                            reason returned. Guest state has not been c=
hanged.
 #                            Otherwise,
-#
-#          < length(@vcpus): more than zero initial nodes have been proc=
essed,
+#          - < length(@vcpus): more than zero initial nodes have been pr=
ocessed,
 #                            but not the entire @vcpus list. Guest state=
 has
 #                            changed accordingly. To retrieve the error
 #                            (assuming it persists), repeat the call wit=
h the
 #                            successfully processed initial sublist remo=
ved.
 #                            Otherwise,
-#
-#          length(@vcpus):   call successful.
+#          - length(@vcpus): call successful.
 #
 # Since: 1.5
 ##
--=20
2.11.0

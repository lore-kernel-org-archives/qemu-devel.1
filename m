Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPG-00035g-2T
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPF-0001CC-Bw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCPF-0001Bh-5x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:17 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:46 +0800
Message-Id: <20170628124850.12821-4-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] qom: Save type name in LinkProperty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qom/object.h | 1 +
 qom/object.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4659e6a..262cd44 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1618,6 +1618,7 @@ typedef struct {
     Object **child;
     void (*check)(Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
+    const char *type;
 } LinkProperty;
 
 void object_get_link_property(Object *obj, Visitor *v,
diff --git a/qom/object.c b/qom/object.c
index dd9c3fa..b3073a6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1562,6 +1562,7 @@ void object_property_add_link(Object *obj, const char *name,
     prop->child = child;
     prop->check = check;
     prop->flags = flags;
+    prop->type = type;
 
     full_type = g_strdup_printf("link<%s>", type);
 
-- 
2.9.4

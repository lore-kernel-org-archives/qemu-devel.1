Received: from eggs.gnu.org ([2001:4830:134:3::10]:36327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396I-0000U7-Oc
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396G-0002XH-5O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396F-0002X7-Ux
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E413F3DBC1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:30 +0200
Message-Id: <20170425223739.6703-18-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 17/26] audio: GUSword is uint16_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/gusemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
index 1c1a63c..69dadef 100644
--- a/hw/audio/gusemu.h
+++ b/hw/audio/gusemu.h
@@ -28,11 +28,9 @@
 /* data types (need to be adjusted if neither a VC6 nor a C99 compatible compiler is used) */
 
 #if defined _WIN32 && defined _MSC_VER /* doesn't support other win32 compilers yet, do it yourself... */
- typedef unsigned short GUSword;
  typedef unsigned int GUSdword;
  typedef signed short GUSsample;
 #else
- typedef uint16_t GUSword;
  typedef uint32_t GUSdword;
  typedef int16_t GUSsample;
 #endif
-- 
2.9.3

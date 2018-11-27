Received: from eggs.gnu.org ([2001:4830:134:3::10]:38456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n3-S9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBi-0001Kx-Kg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001G5-Bl
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECC873086259
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:49:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:27 +0100
Message-Id: <20181127064932.7299-2-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
References: <20181127064932.7299-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, P J P <ppandit@redhat.com>

Cc: P J P <ppandit@redhat.com>
Reported-by: Wangjunqing <wangjunqing@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181030082340.17170-1-kraxel@redhat.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e7e578a48e..e008e72d7a 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -72,8 +72,8 @@ typedef struct fm_opl_f {
 	/* Rhythm sention */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
-	int32_t AR_TABLE[75];	/* atttack rate tables */
-	int32_t DR_TABLE[75];	/* decay rate tables   */
+	int32_t AR_TABLE[76];	/* attack rate tables  */
+	int32_t DR_TABLE[76];	/* decay rate tables   */
 	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
 	int32_t *ams_table;
--=20
2.9.3

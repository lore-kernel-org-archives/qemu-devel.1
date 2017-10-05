Received: from eggs.gnu.org ([2001:4830:134:3::10]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l6-00031r-Rf
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l5-0003Sr-Mo
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l5-0003RG-GN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79BABC059B61
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:52:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:55 +0100
Message-Id: <20171005105157.10831-4-dgilbert@redhat.com>
In-Reply-To: <20171005105157.10831-1-dgilbert@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] hmp-commands-info: Fix "info rocker-FOO"
 misspellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Screwed up in commit da76ee7.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002134538.23332-2-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 4f1ece93e5..574db7d24e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -730,8 +730,8 @@ ETEXI
     },
=20
 STEXI
-@item info rocker_ports @var{name}-ports
-@findex ocker-ports
+@item info rocker-ports @var{name}-ports
+@findex rocker-ports
 Show rocker ports.
 ETEXI
=20
@@ -744,7 +744,7 @@ ETEXI
     },
=20
 STEXI
-@item info rocker_of_dpa_flows @var{name} [@var{tbl_id}]
+@item info rocker-of-dpa-flows @var{name} [@var{tbl_id}]
 @findex rocker-of-dpa-flows
 Show rocker OF-DPA flow tables.
 ETEXI
--=20
2.13.6

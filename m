Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICL-00023c-9Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICJ-0002nJ-5p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSICI-0002mf-TS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4145D30820EE
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:01:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:01:16 +0100
Message-Id: <20181129090120.28828-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 0/4] Small checkpatch fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Right now, patchew has a small script around checkpatch to show
some feedback about which patches have problems.  The idea behind
this series is that patchew should be able to do just
"scripts/checkpatch.pl --mailback base..", and everything
should just work.

Paolo

Paolo Bonzini (4):
  checkpatch: fix premature exit when no input or --mailback
  checkpatch: check Signed-off-by in --mailback mode
  checkpatch: improve handling of multiple patches or files
  checkpatch: colorize output to terminal

 scripts/checkpatch.pl | 92 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 19 deletions(-)

--=20
2.19.1

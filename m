Received: from eggs.gnu.org ([2001:4830:134:3::10]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0r-0001hH-08
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0m-0004Qr-6s
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOO0m-0004Oi-0J
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD152525B
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 12:48:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 14:48:26 +0200
Message-Id: <20170623124829.24260-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Queue/misc patches
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

The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e3938=
32:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-re=
quest' into staging (2017-06-22 19:01:58 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/queue/misc-pull-request

for you to fetch changes up to 1b8274d4f926836a4c773c310318e6039c4794a1:

  applesmc: fix port i/o access width (2017-06-23 13:35:01 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Gabriel L. Somlo (3):
  applesmc: cosmetic whitespace and indentation cleanup
  applesmc: implement error status port
  applesmc: fix port i/o access width

 hw/misc/applesmc.c | 219 +++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 155 insertions(+), 64 deletions(-)

--=20
2.9.3

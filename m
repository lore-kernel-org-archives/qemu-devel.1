Received: from eggs.gnu.org ([2001:4830:134:3::10]:54565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l6-00031n-MX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l2-0003Li-NC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l2-0003Kx-H4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F1DD4E34A
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:51:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:52 +0100
Message-Id: <20171005105157.10831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] hmp queue
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10=
ea:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-10-03 16:27:24 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20171005

for you to fetch changes up to 1b591700e6410d1a8f7700a13686a16759977204:

  hmp-commands-info: Change "@findex FOO" to "@findex info FOO" (2017-10-=
05 10:08:39 +0100)

----------------------------------------------------------------
HMP pull 2017-10-05

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      hmp: Missing handle_errors
      hmp: Fix unknown command for subtable

Markus Armbruster (3):
      hmp-commands-info: Fix "info rocker-FOO" misspellings
      hmp-commands-info: Move Texinfo stanzas to conventional place
      hmp-commands-info: Change "@findex FOO" to "@findex info FOO"

 hmp-commands-info.hx | 138 +++++++++++++++++++++++++--------------------=
------
 hmp.c                |   2 +
 monitor.c            |   7 +--
 3 files changed, 75 insertions(+), 72 deletions(-)

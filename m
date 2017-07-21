Received: from eggs.gnu.org ([2001:4830:134:3::10]:47141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYKV-0005tH-5S
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYKR-0002TN-9u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYKR-0002So-3o
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D42746213
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:50:48 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3058E88D65
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:50:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 08:50:45 -0500
Message-Id: <20170721135047.25005-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Update qemu-nbd version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

=E9=99=B3=E5=9F=B9=E6=B3=93 reported that 'qemu-nbd -V' was stuck at 0.0.=
1; fix that,
along with a nearby style issue noticed in the process.  Not
having a useful version number is a bug in my eyes, so I'm
proposing this series for 2.10.

Eric Blake (2):
  qemu-nbd: Update version string
  maint: Reorder include directives for qemu-{nbd,io}

 qemu-img.c |  3 ++-
 qemu-nbd.c | 13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

--=20
2.13.3

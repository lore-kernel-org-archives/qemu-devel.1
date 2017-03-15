Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8og-0002gE-Jd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8oc-0005H0-L7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8oc-0005Gi-Ew
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:18:10 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ADEB2BCD73
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:18:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v2FDI9mH016022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 09:18:10 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 14:18:05 +0100
Message-Id: <1489583887-14126-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Miscellaneous patches for 2017-03-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:

  Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2017-03-15

for you to fetch changes up to 4d0e72396b69656f36f484b54ffe64893d793a80:

  coverity-model: model address_space_read/write (2017-03-15 13:59:16 +0100)

----------------------------------------------------------------
Miscellaneous patches for 2017-03-15

----------------------------------------------------------------
Markus Armbruster (1):
      tests: Use error_free_or_abort() where appropriate

Paolo Bonzini (1):
      coverity-model: model address_space_read/write

 scripts/coverity-model.c            | 17 +++++++++++++----
 tests/test-qemu-opts.c              |  3 +--
 tests/test-qobject-output-visitor.c |  6 ++----
 3 files changed, 16 insertions(+), 10 deletions(-)

Markus Armbruster (1):
  tests: Use error_free_or_abort() where appropriate

Paolo Bonzini (1):
  coverity-model: model address_space_read/write

 scripts/coverity-model.c            | 17 +++++++++++++----
 tests/test-qemu-opts.c              |  3 +--
 tests/test-qobject-output-visitor.c |  6 ++----
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.7.4

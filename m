Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAn5-0007bE-GA
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAgk-0002wF-9D
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuAgk-0002vt-4h
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EB8F7A7E5
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:07:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C577A9E56
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:07:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 08:07:41 +0200
Message-Id: <20180827060744.13770-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Error reporting patches for 2018-08-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 235c82acca0491465e94be3cae2583b42d37c8=
59:

  Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180823'=
 into staging (2018-08-25 13:08:57 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-08-27

for you to fetch changes up to d111ed70a7d0357dfe92548768751a2b9fadacbc:

  intel-iommu: replace more vtd_err_* traces (2018-08-27 06:38:45 +0200)

----------------------------------------------------------------
Error reporting patches for 2018-08-27

* Provide error_report_once(), along with first users

----------------------------------------------------------------
Peter Xu (3):
      qemu-error: introduce {error|warn}_report_once
      intel-iommu: start to use error_report_once
      intel-iommu: replace more vtd_err_* traces

 hw/i386/intel_iommu.c       | 127 ++++++++++++++++++++++++++++----------=
------
 hw/i386/trace-events        |  13 -----
 include/qemu/error-report.h |  32 +++++++++++
 3 files changed, 113 insertions(+), 59 deletions(-)

--=20
2.17.1

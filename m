Received: from eggs.gnu.org ([2001:4830:134:3::10]:40754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb5-0000gl-2L
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb0-0005s3-4j
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzgaz-0005rq-Ui
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:06 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  4 Oct 2017 12:07:59 +0200
Message-Id: <1507111682-66171-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] add DEFINE_TYPES() helper to simplify
 batch type registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, peter.maydell@linaro.org

following thread '[PATCH 01/38] qom: add helper type_init_from_array()'
here is reworked variant of above patch as Eduardo have suggested
(+ split in several atomic parts)

PS:
posting for early review, I'll wait for a couple of days before reposting whole
series that will use DEFINE_TYPES() to simplify cpu types registration

CC: ehabkost@redhat.com
CC: peter.maydell@linaro.org

Igor Mammedov (3):
  qom: update doc comment for type_register[_static]()
  qom: introduce type_register_static_array()
  qom: add helper macro DEFINE_TYPES()

 include/qom/object.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 qom/object.c         |  9 +++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.7.4

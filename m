Received: from eggs.gnu.org ([209.51.188.92]:42590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1grof0-0005jA-9M
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1groez-0004hr-CW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:44:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43166
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1groez-0004g9-70
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:44:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x17IdXjZ044072
	for <qemu-devel@nongnu.org>; Thu, 7 Feb 2019 13:44:27 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qgrq0wmne-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 13:44:26 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Thu, 7 Feb 2019 18:44:25 -0000
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Thu,  7 Feb 2019 16:43:46 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190207184346.6840-1-muriloo@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] docs/devel/testing: Add -a option to usermod
 command on docker setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org

The option -G of usermod command will remove user from other groups
not listed, i.e.: $USER will belong only to group 'docker' after
following the documentation as is.

>From usermod(8) manual page:

    If the user is currently a member of a group which is not listed,
    the user will be removed from the group. This behaviour can be
    changed via the -a option, which appends the user to the current
    supplementary group list.

This patch improves the situation by adding the -a option to the
usermod command, which will just append user to the supplementary
group list.

Cc: qemu-trivial@nongnu.org
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 docs/devel/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 18e2c0868a..135743a2bf 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -301,7 +301,7 @@ An alternative method to set up permissions is by adding the current user to
 .. code::
 
   $ sudo groupadd docker
-  $ sudo usermod $USER -G docker
+  $ sudo usermod $USER -a -G docker
   $ sudo chown :docker /var/run/docker.sock
 
 Note that any one of above configurations makes it possible for the user to
-- 
2.20.1

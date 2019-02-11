Received: from eggs.gnu.org ([209.51.188.92]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHc-0007UG-VS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHb-0004C4-1E
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBHZ-0003rV-9q
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id y185so14539541wmd.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:05:06 +0000
Message-Id: <20190211130507.8710-18-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/18] docs/devel/testing: Add -a option to
 usermod command on docker setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

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
Message-Id: <20190207184346.6840-1-muriloo@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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

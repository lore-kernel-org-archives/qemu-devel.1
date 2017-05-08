Received: from eggs.gnu.org ([2001:4830:134:3::10]:36736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akD-0003N2-Nt
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akC-0007oY-1X
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:00 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akB-0007oR-TZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:59 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so8245565qte.0
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:57:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:56:55 -0300
Message-Id: <20170508045715.21770-4-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 03/23] shippable: ignore SSL verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

shippable logs:
--------------
git_sync
- ssh-agent bash -c 'ssh-add /tmp/ssh/01_deploy; git clone https://github.com/philmd/qemu.git /root/src/github.com/philmd/qemu'
Identity added: /tmp/ssh/01_deploy (rsa w/o comment)
Cloning into '/root/src/github.com/philmd/qemu'...
fatal: unable to access 'https://github.com/philmd/qemu.git/': Problem with the SSL CA cert (path? access rights?)
retrying 1 of 3 times...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 5170486ff9..b661e667b3 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -2,6 +2,10 @@ language: c
 env:
   global:
     - LC_ALL=C
+    # sometimes Shippable fails to clone from github (git_sync stage):
+    # "Problem with the SSL CA cert (path? access rights?)"
+    # for now disable SSL verification.
+    - GIT_SSL_NO_VERIFY=1
   matrix:
     - IMAGE=debian-armhf-cross
       TARGET_LIST=arm-softmmu,arm-linux-user
-- 
2.11.0

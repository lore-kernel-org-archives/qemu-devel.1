Received: from eggs.gnu.org ([2001:4830:134:3::10]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAGfg-0004F5-E4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAGfd-0003OK-Bc
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:40 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:54688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eAGfd-0003LQ-5T
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:37 -0400
Received: by mail-wm0-x234.google.com with SMTP id r68so11917311wmr.3
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 07:40:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Nov 2017 14:40:33 +0000
Message-Id: <20171102144034.888-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] cross-compiler build fixes for softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit d2b9d71432687eef947f243a57409381151701d5:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171030' into staging (2017-10-31 11:18:00 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-ci-updates-for-softfreeze-021117-2

for you to fetch changes up to e58c1f9b35e81dec90c3d483b57351256cecfc41:

  docker: add python stdlib dependency (required by keycodemapdb) (2017-11-02 11:46:41 +0000)

----------------------------------------------------------------
One fix for win32/64 cross compiles.

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      docker: add python stdlib dependency (required by keycodemapdb)

 tests/docker/dockerfiles/debian8-mxe.docker | 1 +
 1 file changed, 1 insertion(+)

--
2.14.2

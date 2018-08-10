Received: from eggs.gnu.org ([2001:4830:134:3::10]:56465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwO-00074m-QD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwL-0007hF-DZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1foAwL-0007fT-5H
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id e7-v6so8889488wrs.9
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Aug 2018 18:10:58 +0100
Message-Id: <20180810171102.16451-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  0/3] tweaks for QEMU's C standard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

While I was reviewing Richard's SVE series I found Travis choking on
some perfectly valid c99. It turns out that Travis default image is
old enough that gcc defaults to -std=gnu89 hence the problem. However
switching to c99 isn't enough as we use GNUisms and even gnu99 still
trips up on qemu-secomp.

Of course we could just jump to C11 already?

This is an RFC because this could descend into a C standards
bike-shedding exercise but I thought I'd at least put it out there on
a Friday afternoon ;-)

Alex Bennée (3):
  HACKING: mention the C GNU extensions we use
  qemu-seccomp: manually expand SCMP_A1
  .travis.yml: ensure we support C99 on old compilers

 .travis.yml    | 2 +-
 HACKING        | 5 +++++
 qemu-seccomp.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

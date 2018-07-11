Received: from eggs.gnu.org ([2001:4830:134:3::10]:48108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6ph-00057a-Jk
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pe-0005nU-H5
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:29 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pe-0005nE-BN
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:26 -0400
Received: by mail-qk0-x243.google.com with SMTP id a132-v6so12801175qkg.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 21:34:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 11 Jul 2018 01:34:15 -0300
Message-Id: <20180711043417.24097-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-3.1 0/2] Shippable: build TriCore
 docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

Quick and dirty RFC to go a bit further with TriCore cross-testing.

Philippe Mathieu-Daudé (2):
  docker: Fix TriCore binutils build
  shippable: Build the TriCore docker image

 .shippable.yml                                |  2 ++
 .../dockerfiles/debian-tricore-cross.docker   | 23 ++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.18.0

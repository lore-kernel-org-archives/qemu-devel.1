Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evluT-0002fv-3l
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evluP-0004AI-4x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:17 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evluO-00049l-U6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:13 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l8so25151wrg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 08:32:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 13 Mar 2018 15:32:06 +0000
Message-Id: <20180313153210.28264-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/4] Travis Build Speed-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

As QEMU has grown it has started to hit the Travis timeouts a lot
more. These patches try and address that by selectively adding
--disable-user and --disable-system to the place (and adding a new
matrix entry).

: patch 0001/.travis.yml drop setting default log output.patch needs review
: patch 0002/.travis.yml split default config into system and .patch needs review
: patch 0003/.travis.yml add disable user with the rest of the.patch needs review
: patch 0004/.travis.yml add disable tools to the modules buil.patch needs review

Alex Bennée (4):
  .travis.yml: drop setting default log output
  .travis.yml: split default config into system and user
  .travis.yml: add --disable-user with the rest of the disables
  .travis.yml: add --disable-tools to the modules build

 .travis.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.16.2

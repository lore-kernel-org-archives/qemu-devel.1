Received: from eggs.gnu.org ([2001:4830:134:3::10]:55832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzRo-0001ho-A7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzRl-0003jG-7S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:44 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzRk-0003hF-VL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:41 -0400
Received: by mail-wr0-x235.google.com with SMTP id c11so9457316wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:59:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:31 +0100
Message-Id: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/6] arm: fixes for eret,
 isb and DISAS_UPDATE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Hopefully this is the final iteration after:

  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02452.html

The only major change is fixing up gen_goto_tb for arm and then using
that in both a32 and a64 for the ISB changes. Other than that I've
applied the review tags.

Hopefully there isn't anything else that needs fixing so I guess the
next question is who's tree should this go through?

Alex Bennée (6):
  include/exec/exec-all: document common exit conditions
  target/arm/translate: make DISAS_UPDATE match declared semantics
  target/arm/translate.h: expand comment on DISAS_EXIT
  target/arm/translate: ensure gen_goto_tb sets exit flags
  target/arm: use gen_goto_tb for ISB handling
  target/arm: use DISAS_EXIT for eret handling

 include/exec/exec-all.h    | 29 ++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 19 ++++++++++---------
 target/arm/translate.c     | 22 ++++++++++++++--------
 target/arm/translate.h     |  5 ++++-
 4 files changed, 54 insertions(+), 21 deletions(-)

-- 
2.13.0

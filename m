Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcA-0004yE-P2
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tc7-0002qV-L8
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:22:58 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:38565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tc7-0002pj-GC
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:22:55 -0400
Received: by mail-qk0-x229.google.com with SMTP id 132so24686490qkd.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:22:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Apr 2018 22:22:37 -0300
Message-Id: <20180405012241.25714-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 0/4] memory: fix
 access_with_adjusted_size() and misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi, these are few memory related patches.

Patch #2 v1 was:
http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02255.html
I'll send the related qtests in v3.

Patch #4 is a failed attempt to change a region priority at runtime.

Phil.

Philippe Mathieu-Daudé (4):
  memory: Avoid to create tiny RAM regions, handled as subpages
  memory: Fix access_with_adjusted_size() when size < access_size_min
  memory: Fix memory_region 'priority' property sign
  memory: Add memory_region_set_priority()

 memory.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 24 deletions(-)

-- 
2.16.3

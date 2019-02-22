Received: from eggs.gnu.org ([209.51.188.92]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx4Ap-0002zC-C9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx3xv-0003Mh-CW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:05:44 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:40200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gx3xv-0002yo-0i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:05:43 -0500
Received: by mail-pg1-x52a.google.com with SMTP id u9so613355pgo.7
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:05:08 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	f67sm1452522pfc.141.2019.02.21.22.05.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Feb 2019 22:05:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 22:05:02 -0800
Message-Id: <20190222060504.17715-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/hppa: Minor fix and improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first patch is via inspection.  Linux only uses priv
levels 0 and 3, and I suspect that HP-UX is the same.

The second patch comes from examining traces.


r~


Richard Henderson (2):
  target/hppa: Do not return freed temporary
  target/hppa: Optimize blr r0,rn

 target/hppa/translate.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.17.2

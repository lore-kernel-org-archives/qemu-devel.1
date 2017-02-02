Received: from eggs.gnu.org ([2001:4830:134:3::10]:35279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU2-0005M4-QH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITz-0005Qf-3S
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:34 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39802 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITy-0005Ok-Re
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:31 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:53 +0300
Message-Id: <1486046099-17726-16-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 15/21] target/aarch64: do not check for
 non-existent TCGMemOp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

MO_64|MO_SIGN is not a valid TCGMemOp. This code compiles only because by
coincidence this value equals to MO_SSIGN mask defined in the same enum.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---

Bugfix which is only indirectly related to this series. Other changes of
the series exposed the problem.

---
 target/arm/translate-a64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d0352e2..8a1f70e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -990,7 +990,6 @@ static void read_vec_element(DisasContext *s, TCGv_i64 tcg_dest, int srcidx,
         tcg_gen_ld32s_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_64:
-    case MO_64|MO_SIGN:
         tcg_gen_ld_i64(tcg_dest, cpu_env, vect_off);
         break;
     default:
-- 
2.1.4

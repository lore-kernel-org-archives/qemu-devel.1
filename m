Received: from eggs.gnu.org ([2001:4830:134:3::10]:54179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQw-0005lQ-8v
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQq-0007Xs-6M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEvQp-0007WU-V2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id g9-v6so1410469wrq.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 13:04:49 +0100
Message-Id: <20181023120454.28553-3-richard.henderson@linaro.org>
In-Reply-To: <20181023120454.28553-1-richard.henderson@linaro.org>
References: <20181023120454.28553-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/7] decodetree: Remove "insn" argument from
 trans_* expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

??? Needs simultaneous corresponding changes to all
translators using decodetree.
---
 scripts/decodetree.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a9b10452ef..c0bb447095 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -468,8 +468,7 @@ class Pattern(General):
         output('typedef ', self.base.base.struct_name(),
                ' arg_', self.name, ';\n')
         output(translate_scope, 'bool ', translate_prefix, '_', self.name,
-               '(DisasContext *ctx, arg_', self.name,
-               ' *a, ', insntype, ' insn);\n')
+               '(DisasContext *ctx, arg_', self.name, ' *a);\n')
 
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
@@ -481,7 +480,7 @@ class Pattern(General):
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         output(ind, 'return ', translate_prefix, '_', self.name,
-               '(ctx, &u.f_', arg, ', insn);\n')
+               '(ctx, &u.f_', arg, ');\n')
 # end Pattern
 
 
-- 
2.17.2

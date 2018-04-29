Received: from eggs.gnu.org ([2001:4830:134:3::10]:41991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fCjMf-0007Cd-Be
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 06:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fCjMa-0005AY-DL
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 06:15:29 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:46057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rafaelkioji@gmail.com>)
	id 1fCjMa-00059C-6T
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 06:15:24 -0400
Received: by mail-pg0-x22a.google.com with SMTP id i29-v6so4451562pgn.12
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 03:15:23 -0700 (PDT)
Received: from [143.89.131.93] (eepc93.ee.ust.hk. [143.89.131.93])
	by smtp.googlemail.com with ESMTPSA id
	s17sm10987043pfi.165.2018.04.29.03.15.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 29 Apr 2018 03:15:21 -0700 (PDT)
From: Rafael Kioji <rafaelkioji@gmail.com>
Message-ID: <7366cfc5-e37f-483d-917b-2aae41d1e59e@gmail.com>
Date: Sun, 29 Apr 2018 18:15:18 +0800
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Difference between tcg_gen_ld_i64 and
 tcg_gen_qemu_ld_i64.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear all,

What is the difference between these two functions? They are located in 
the file "tcg/tcg-op.c". Here is their header:

 1. static inline void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2,
    tcg_target_long offset)
 2. void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx,
    TCGMemOp memop)

I don't quite understand the need for function (1). Especially because 
it is usually passed "cpu_env" for arg2. Like in 
target/arm/translate-a64.c:595:

> /* Convenience accessors for reading and writing single and double
>  * FP registers. Writing clears the upper parts of the associated
>  * 128 bit vector register, as required by the architecture.
>  * Note that unlike the GP register accessors, the values returned
>  * by the read functions must be manually freed.
>  */
> static TCGv_i64 read_fp_dreg(DisasContext *s, int reg)
> {
>     TCGv_i64 v = tcg_temp_new_i64();
>
>     tcg_gen_ld_i64(v, cpu_env, fp_reg_offset(s, reg, MO_64));
>     return v;
> }


Thanks!

  
--
Att.,
Rafael

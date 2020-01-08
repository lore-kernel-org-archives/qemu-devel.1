Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C37C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F60820692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F60820692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0Dt-0007ly-Ed
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ip0DG-0007K3-S8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ip0DE-0007W0-MF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:32:46 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ip0DE-0007QY-3K; Tue, 07 Jan 2020 20:32:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436294|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.200841-0.0081891-0.79097;
 DS=CONTINUE|ham_enroll_verification|0.0641648-0.000136801-0.935698;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03296; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GYCpkVL_1578447157; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GYCpkVL_1578447157)
 by smtp.aliyun-inc.com(10.147.41.121);
 Wed, 08 Jan 2020 09:32:38 +0800
Subject: Re: [Qemu-devel] [PATCH v2 05/17] RISC-V: add vector extension load
 and store instructions
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-6-git-send-email-zhiwei_liu@c-sky.com>
 <4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <b927f28a-2057-ed1e-c426-63cf9fade27f@c-sky.com>
Date: Wed, 8 Jan 2020 09:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------3DE5936481B0F275A8101956"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wenmeng_zhang <wenmeng_zhang@c-sky.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------3DE5936481B0F275A8101956
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard,

Sorry to reply so late for this comment.  I will move forward on part 2.
On 2019/9/12 22:23, Richard Henderson wrote:
>> +static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
>> +        uint32_t reg, bool widen)
>> +{
>> +    int legal = widen ? (lmul * 2) : lmul;
>> +
>> +    if ((lmul != 1 && lmul != 2 && lmul != 4 && lmul != 8) ||
>> +        (lmul == 8 && widen)) {
>> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
>> +        return false;
>> +    }
>> +
>> +    if (reg % legal != 0) {
>> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
>> +        return false;
>> +    }
>> +    return true;
>> +}
> These exceptions will not do the right thing.
>
> You cannot call helper_raise_exception from another helper, or from something
> called from another helper, as here.  You need to use riscv_raise_exception, as
> you do elsewhere in this patch, with a GETPC() value passed down from the
> outermost helper.
>
> Ideally you would check these conditions at translate time.
> I've mentioned how to do this in reply to your v1.
As discussed in part1,  I will check these conditions at translate time.
>> +        } else if (i < vl) {
>> +            switch (width) {
>> +            case 8:
>> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
>> +                    while (k >= 0) {
>> +                        read = i * (nf + 1)  + k;
>> +                        env->vfp.vreg[dest + k * lmul].u8[j] =
>> +                            cpu_ldub_data(env, env->gpr[rs1] + read);
> You must not modify vreg[x] before you've recognized all possible exceptions,
> e.g. validating that a subsequent access will not trigger a page fault.
> Otherwise you will have a partially modified register value when the exception
> handler is entered.
There are two questions here.

1) How to validate access before real access to registers?

As pointed in another comment for patchset v1,

"instructions that perform more than one host store must probe
       the entire range to be stored before performing any stores.
"

I didn't see the validation of page in SVE,  for example, sve_st1_r,
which directly use the  helper_ret_*_mmu  that may cause an page fault 
exception or ovelap a watchpoint,
before probe the entire range to be stored .

2) Why not use the  cpu_ld*  API?

I see in SVE that ld*_p is used to directly access the host memory. And 
helper_ret_*_mmu
is used to access guest memory. But from the definition of cpu_ld*, it's 
the combination of
ld*_p and helper_ret_*_mmu.

     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
oi, retaddr);
     } else {
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }


So I don't know  why not use cpu_ld* API?
> Without a stride, and without a predicate mask, this can be done with at most
> two calls to probe_access (one per page).  This is the simplification that
> makes splitting the helper into two very helpful.
>
> With a stride or with a predicate mask requires either
> (1) temporary storage for the loads, and copy back to env at the end, or
> (2) use probe_access for each load, and then perform the actual loads directly
> into env.
>
> FWIW, ARM SVE uses (1), as probe_access is very new.
>
>> +                        k--;
>> +                    }
>> +                    env->vfp.vstart++;
>> +                }
>> +                break;
>> +            case 16:
>> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
>> +                    while (k >= 0) {
>> +                        read = i * (nf + 1)  + k;
>> +                        env->vfp.vreg[dest + k * lmul].u16[j] =
>> +                            cpu_ldub_data(env, env->gpr[rs1] + read);
> I don't see anything in these assignments to vreg[x].uN[y] that take the
> endianness of the host into account.
>
> You need to think about how the architecture defines the overlap of elements --
> particularly across vlset -- and make adjustments.
>
> I can imagine, if you have explicit tests for this, your tests are passing
> because the architecture defines a little-endian based indexing of the register
> file, and you have only run tests on a little-endian host, like x86_64.
>
> For ARM, we define the representation as a little-endian indexed array of
> host-endian uint64_t.  This means that a big-endian host needs to adjust the
> address of any element smaller than 64-bit.  E.g.
>
> #ifdef HOST_WORDS_BIGENDIAN
> #define H1(x)   ((x) ^ 7)
> #define H2(x)   ((x) ^ 3)
> #define H4(x)   ((x) ^ 1)
> #else
> #define H1(x)   (x)
> #define H2(x)   (x)
> #define H4(x)   (x)
> #endif
>
>      env->vfp.vreg[reg + k * lmul].u16[H2(j)]
>
I will take it.  However I didn't have  a big-endian host to test the 
feature.
>
>> +        if (base >= abs_off) {
>> +            return base - abs_off;
>> +        }
>> +    } else {
>> +        if ((target_ulong)((target_ulong)offset + base) >= base) {
>> +            return (target_ulong)offset + base;
>> +        }
>> +    }
> Why all the extra casting here?  They are exactly what is implied by C.
>
>> +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
>> +    return 0;
> (1) This exception call won't work, as above,
> (2) Where does this condition against wraparound come from?
>      I don't see it in the specification.
> (3) You certainly cannot detect this after having written a
>      previous element to the register file.
>
> [ Skipping lots of functions that are basically the same. ]
>
>> +void VECTOR_HELPER(vsxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
>> +    uint32_t rs1, uint32_t rs2, uint32_t rd)
> Pass rs1 by value.
>
>> +            case 8:
>> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
>> +                    while (k >= 0) {
>> +                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
>> +                        cpu_stb_data(env, addr,
>> +                            env->vfp.vreg[dest + k * lmul].s8[j]);
> Must probe_access all of the memory before any stores.
> Unlike loads, you don't have the option of storing into a temporary.
> Which suggests a common subroutine to perform the probe(s), rather
> than bother with a temporary for loads.
>
> r~
Thanks again for your informative comments.

Best Regards,
Zhiwei


--------------3DE5936481B0F275A8101956
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Richard,<br>
    <br>
    Sorry to reply so late for this comment.  I will move forward on
    part 2. <br>
    <div class="moz-cite-prefix">On 2019/9/12 22:23, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
+        uint32_t reg, bool widen)
+{
+    int legal = widen ? (lmul * 2) : lmul;
+
+    if ((lmul != 1 &amp;&amp; lmul != 2 &amp;&amp; lmul != 4 &amp;&amp; lmul != 8) ||
+        (lmul == 8 &amp;&amp; widen)) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return false;
+    }
+
+    if (reg % legal != 0) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return false;
+    }
+    return true;
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
These exceptions will not do the right thing.

You cannot call helper_raise_exception from another helper, or from something
called from another helper, as here.  You need to use riscv_raise_exception, as
you do elsewhere in this patch, with a GETPC() value passed down from the
outermost helper.

Ideally you would check these conditions at translate time.
I've mentioned how to do this in reply to your v1.
</pre>
    </blockquote>
    As discussed in part1,  I will check these conditions at translate
    time.<br>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        } else if (i &lt; vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k &gt;= 0) {
+                        read = i * (nf + 1)  + k;
+                        env-&gt;vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, env-&gt;gpr[rs1] + read);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You must not modify vreg[x] before you've recognized all possible exceptions,
e.g. validating that a subsequent access will not trigger a page fault.
Otherwise you will have a partially modified register value when the exception
handler is entered.
</pre>
    </blockquote>
    There are two questions here.<br>
    <br>
    1) How to validate access before real access to registers?<br>
    <br>
    As pointed in another comment for patchset v1,  <br>
    <pre class="moz-quote-pre" wrap="">"instructions that perform more than one host store must probe
      the entire range to be stored before performing any stores.
"</pre>
    I didn't see the validation of page in SVE,  for example, sve_st1_r,
    <br>
    which directly use the  helper_ret_*_mmu  that may cause an page
    fault exception or ovelap a watchpoint,<br>
    before probe the entire range to be stored .<br>
    <br>
    2) Why not use the  cpu_ld*  API?<br>
    <br>
    I see in SVE that ld*_p is used to directly access the host memory.
    And helper_ret_*_mmu<br>
    is used to access guest memory. But from the definition of cpu_ld*,
    it's the combination of<br>
    ld*_p and helper_ret_*_mmu.<br>
       <br>
    <table width="932" height="252" cellspacing="2" cellpadding="2"
      border="1">
      <tbody>
        <tr>
          <td valign="top">    entry = tlb_entry(env, mmu_idx, addr);<br>
                if (unlikely(entry-&gt;ADDR_READ !=<br>
                             (addr &amp; (TARGET_PAGE_MASK | (DATA_SIZE
            - 1))))) {<br>
                    oi = make_memop_idx(SHIFT, mmu_idx);<br>
                    res = glue(glue(helper_ret_ld, URETSUFFIX),
            MMUSUFFIX)(env, addr,<br>
                                                                       
            oi, retaddr);<br>
                } else {<br>
                    uintptr_t hostaddr = addr + entry-&gt;addend;<br>
                    res = glue(glue(ld, USUFFIX), _p)((uint8_t
            *)hostaddr);<br>
                }</td>
        </tr>
      </tbody>
    </table>
    <br>
    So I don't know  why not use cpu_ld* API?<br>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org">
      <pre class="moz-quote-pre" wrap="">
Without a stride, and without a predicate mask, this can be done with at most
two calls to probe_access (one per page).  This is the simplification that
makes splitting the helper into two very helpful.

With a stride or with a predicate mask requires either
(1) temporary storage for the loads, and copy back to env at the end, or
(2) use probe_access for each load, and then perform the actual loads directly
into env.

FWIW, ARM SVE uses (1), as probe_access is very new.
</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+                        k--;
+                    }
+                    env-&gt;vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k &gt;= 0) {
+                        read = i * (nf + 1)  + k;
+                        env-&gt;vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_ldub_data(env, env-&gt;gpr[rs1] + read);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't see anything in these assignments to vreg[x].uN[y] that take the
endianness of the host into account.

You need to think about how the architecture defines the overlap of elements --
particularly across vlset -- and make adjustments.

I can imagine, if you have explicit tests for this, your tests are passing
because the architecture defines a little-endian based indexing of the register
file, and you have only run tests on a little-endian host, like x86_64.

For ARM, we define the representation as a little-endian indexed array of
host-endian uint64_t.  This means that a big-endian host needs to adjust the
address of any element smaller than 64-bit.  E.g.

#ifdef HOST_WORDS_BIGENDIAN
#define H1(x)   ((x) ^ 7)
#define H2(x)   ((x) ^ 3)
#define H4(x)   ((x) ^ 1)
#else
#define H1(x)   (x)
#define H2(x)   (x)
#define H4(x)   (x)
#endif

    env-&gt;vfp.vreg[reg + k * lmul].u16[H2(j)]

</pre>
    </blockquote>
    I will take it.  However I didn't have  a big-endian host to test
    the feature.<br>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org"><br>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        if (base &gt;= abs_off) {
+            return base - abs_off;
+        }
+    } else {
+        if ((target_ulong)((target_ulong)offset + base) &gt;= base) {
+            return (target_ulong)offset + base;
+        }
+    }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why all the extra casting here?  They are exactly what is implied by C.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    return 0;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
(1) This exception call won't work, as above,
(2) Where does this condition against wraparound come from?
    I don't see it in the specification.
(3) You certainly cannot detect this after having written a
    previous element to the register file.

[ Skipping lots of functions that are basically the same. ]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+void VECTOR_HELPER(vsxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Pass rs1 by value.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k &gt;= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env-&gt;vfp.vreg[dest + k * lmul].s8[j]);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Must probe_access all of the memory before any stores.
Unlike loads, you don't have the option of storing into a temporary.
Which suggests a common subroutine to perform the probe(s), rather
than bother with a temporary for loads.

</pre>
      <pre class="moz-quote-pre" wrap="">r~</pre>
    </blockquote>
    Thanks again for your informative comments.<br>
    <br>
    Best Regards,<br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------3DE5936481B0F275A8101956--


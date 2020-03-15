Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81900C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F29B206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F29B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDN6o-000689-Cn
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 02:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDN5d-0005Co-4D
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDN5a-0005eA-At
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:49:36 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDN5Y-0005G0-SX; Sun, 15 Mar 2020 02:49:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07613426|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0130516-0.00220786-0.98474;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.hzIms_1584254959; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.hzIms_1584254959)
 by smtp.aliyun-inc.com(10.147.42.135);
 Sun, 15 Mar 2020 14:49:19 +0800
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
 <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <67e2c762-8ae5-3bd3-a16a-5b763cd7832e@c-sky.com>
Date: Sun, 15 Mar 2020 14:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------550FDD432642029EB67F62FF"
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------550FDD432642029EB67F62FF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/15 13:16, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> +#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t offset = s1, i;                                              \
>> +                                                                          \
>> +    if (offset > vl) {                                                    \
>> +        offset = vl;                                                      \
>> +    }                                                                     \
> This isn't right.
That's to process a corner case.  As you can see the behavior of 
vslideup.vx from Section 17.4.1

0 < i < max(vstart, OFFSET) 	  unchanged
max(vstart, OFFSET) <= i < vl 	  vd[i] = vs2[i-OFFSET] if mask enabled, 
unchanged if not
vl <= i < VLMAX
	  tail elements, vd[i] = 0


The spec v0.7.1 or v0.8 does not specified when OFFSET > vl.

Should The elements (vl <=  i  < OFFSET) be seen as tail elements, or 
unchanged?

And it is possible because OFFSET is from a scalar register.

Here (vl <=  i  < OFFSET) elements are seen as tail elements.

>
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (((i < offset)) || (!vm && !vext_elem_mask(v0, mlen, i))) {    \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
>> +    }                                                                     \
>> +    if (i == 0) {                                                         \
>> +        return;                                                           \
>> +    }                                                                     \
> You need to eliminate vl == 0 first, not last.
> Then
>
>      for (i = offset; i < vl; i++)
>
> The types of i and vl need to be extended to target_ulong, so that you don't
> incorrectly crop the input offset.
Yes, I should.
>
> It may be worth special-casing vm=1, or hoisting it out of the loop.  The
> operation becomes a memcpy (at least for little-endian) at that point.  See
> swap_memmove in arm/sve_helper.c.
>
>
>> +#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t offset = s1, i;                                              \
>> +                                                                          \
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        if (i + offset < vlmax) {                                         \
>> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));      \
> Again, eliminate vl == 0 first.  In fact, why don't we make that a global
> request for all of the patches for the next revision.
I don't get it.

Check vl == 0 first for all patches. Is it right?
>   Checking for i == 0 last
> is silly, and checks for the zero twice: once in the loop bounds and again at
> the end.

>
> It is probably worth changing the loop bounds to
>
>      if (offset >= vlmax) {
>         max = 0;
>      } else {
>         max = MIN(vl, vlmax - offset);
>      }
>      for (i = 0; i < max; ++i)
>
Yes.
>> +        } else {                                                          \
>> +            *((ETYPE *)vd + H(i)) = 0;                                    \
>> +        }
> Which lets these zeros merge into...
It's a mistake here.
>
>> +    for (; i < vlmax; i++) {                                              \
>> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
>> +    }                                                                     \
> These zeros.
>
>> +#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t i;                                                           \
>> +                                                                          \
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        if (i == 0) {                                                     \
>> +            *((ETYPE *)vd + H(i)) = s1;                                   \
>> +        } else {                                                          \
>> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
>> +        }                                                                 \
>> +    }                                                                     \
>> +    if (i == 0) {                                                         \
>> +        return;                                                           \
>> +    }                                                                     \
>> +    for (; i < vlmax; i++) {                                              \
>> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
>> +    }                                                                     \
>> +}
> As a preference, I think you can do away with this helper.
> Simply use the slideup helper with argument 1, and then
> afterwards store the integer register into element 0.  You should be able to
> re-use code from vmv.s.x for that.
I will try just in line.

Zhiwei
>> +#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
> Likewise.
>
>
> r~


--------------550FDD432642029EB67F62FF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/3/15 13:16, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 3/12/20 7:58 AM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    uint32_t offset = s1, i;                                              \
+                                                                          \
+    if (offset &gt; vl) {                                                    \
+        offset = vl;                                                      \
+    }                                                                     \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This isn't right.</pre>
    </blockquote>
    That's to process a corner case.  As you can see the behavior of
    vslideup.vx from Section 17.4.1<br>
    <br>
    <table width="40%" cellspacing="2" cellpadding="2" border="1">
      <tbody>
        <tr>
          <td valign="top">0 &lt; i &lt; max(vstart, OFFSET)</td>
          <td valign="top">  unchanged</td>
        </tr>
        <tr>
          <td valign="top">max(vstart, OFFSET) &lt;= i &lt; vl</td>
          <td valign="top">  vd[i] = vs2[i-OFFSET] if mask enabled,
            unchanged if not</td>
        </tr>
        <tr>
          <td valign="top">vl &lt;= i &lt; VLMAX    <br>
          </td>
          <td valign="top">  tail elements, vd[i] = 0</td>
        </tr>
      </tbody>
    </table>
    <br>
    The spec v0.7.1 or v0.8 does not specified when OFFSET &gt; vl. <br>
    <br>
    Should The elements (vl &lt;=  i  &lt; OFFSET) be seen as tail
    elements, or unchanged?<br>
    <br>
    And it is possible because OFFSET is from a scalar register.<br>
    <br>
    Here (vl &lt;=  i  &lt; OFFSET) elements are seen as tail elements.
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    for (i = 0; i &lt; vl; i++) {                                            \
+        if (((i &lt; offset)) || (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i))) {    \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You need to eliminate vl == 0 first, not last.
Then

    for (i = offset; i &lt; vl; i++)

The types of i and vl need to be extended to target_ulong, so that you don't
incorrectly crop the input offset.</pre>
    </blockquote>
    Yes, I should.<br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">

It may be worth special-casing vm=1, or hoisting it out of the loop.  The
operation becomes a memcpy (at least for little-endian) at that point.  See
swap_memmove in arm/sve_helper.c.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    uint32_t offset = s1, i;                                              \
+                                                                          \
+    for (i = 0; i &lt; vl; i++) {                                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i + offset &lt; vlmax) {                                         \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));      \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Again, eliminate vl == 0 first.  In fact, why don't we make that a global
request for all of the patches for the next revision. </pre>
    </blockquote>
    I don't get it. <br>
    <br>
    Check vl == 0 first for all patches. Is it right? <br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap=""> Checking for i == 0 last
is silly, and checks for the zero twice: once in the loop bounds and again at
the end.</pre>
    </blockquote>
    <br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">

It is probably worth changing the loop bounds to

    if (offset &gt;= vlmax) {
       max = 0;
    } else {
       max = MIN(vl, vlmax - offset);
    }
    for (i = 0; i &lt; max; ++i)

</pre>
    </blockquote>
    Yes.<br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Which lets these zeros merge into...</pre>
    </blockquote>
    It's a mistake here.<br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    for (; i &lt; vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
These zeros.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i &lt; vl; i++) {                                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i == 0) {                                                     \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    for (; i &lt; vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
As a preference, I think you can do away with this helper.
Simply use the slideup helper with argument 1, and then
afterwards store the integer register into element 0.  You should be able to
re-use code from vmv.s.x for that.
</pre>
    </blockquote>
    I will try just in line.<br>
    <br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:28063df7-bf38-d136-2d32-39651692c4c6@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Likewise.


r~
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------550FDD432642029EB67F62FF--


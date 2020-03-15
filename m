Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E89C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF6A20409
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF6A20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcfM-0005Lb-1d
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDcbd-0004lG-Fl
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDcbb-00026H-7P
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:23:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDcba-0001SS-I2; Sun, 15 Mar 2020 19:23:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436344|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0827748-0.00136813-0.915857;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H0.EY-v_1584314609; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H0.EY-v_1584314609) by smtp.aliyun-inc.com(10.147.40.2);
 Mon, 16 Mar 2020 07:23:30 +0800
Subject: Re: [PATCH v5 24/60] target/riscv: vector single-width averaging add
 and subtract
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-25-zhiwei_liu@c-sky.com>
 <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
 <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
 <d48f77ee-ad99-26fa-a597-6cdcd2d55508@c-sky.com>
 <426e31f8-1b54-7b5a-b2a9-a2742f9c74af@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <e40db19f-0bf6-9ccd-3f41-855f67cf88f2@c-sky.com>
Date: Mon, 16 Mar 2020 07:23:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <426e31f8-1b54-7b5a-b2a9-a2742f9c74af@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------3A65678DA80138844DF550B5"
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
--------------3A65678DA80138844DF550B5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/15 9:00, Richard Henderson wrote:
> On 3/14/20 4:12 PM, LIU Zhiwei wrote:
>> I am not sure whether I get it. In my opinion, the code should be modified like
>>
>> static inline int8_t aadd8_rnu(CPURISCVState *env, int8_t a, int8_t b)
>> {
>>      int16_t res = (int16_t)a + (int16_t)b;
>>      uint8_t round = res & 0x1;
>>      res   = (res >> 1) + round;
>>      return res;
>> }
>>
>> static inline int8_t aadd8_rne(CPURISCVState *env, int8_t a, int8_t b)
>> {
>>      int16_t res = (int16_t)a + (int16_t)b;
>>      uint8_t round = ((res & 0x3) == 0x3);
>>      res   = (res >> 1) + round;
>>      return res;
>> }
>>
>> static inline int8_t aadd8_rdn(CPURISCVState *env, int8_t a, int8_t b)
>> {
>>      int16_t res = (int16_t)a + (int16_t)b;
>>      res   = (res >> 1);
>>      return res;
>> }
>>
>> static inline int8_t aadd8_rod(CPURISCVState *env, int8_t a, int8_t b)
>> {
>>      int16_t res = (int16_t)a + (int16_t)b;
>>      uint8_t round = ((res & 0x3) == 0x1);
>>     res   = (res >> 1) + round;
>>      return res;
>> }
>>
>> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rnu, OP_SSS_B, H1, H1, H1, aadd8_rnu)
>> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rne, OP_SSS_B, H1, H1, H1, aadd8_rne)
>> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rdn, OP_SSS_B, H1, H1, H1, aadd8_rdn)
>> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rod, OP_SSS_B, H1, H1, H1, aadd8_rod)
>>
>> void do_vext_vv_env(void *vd, void *v0, void *vs1,
>>                      void *vs2, CPURISCVState *env, uint32_t desc,
>>                      uint32_t esz, uint32_t dsz,
>>                      opivv2_fn *fn, clear_fn *clearfn)
>> {
>>      uint32_t vlmax = vext_maxsz(desc) / esz;
>>      uint32_t mlen = vext_mlen(desc);
>>      uint32_t vm = vext_vm(desc);
>>      uint32_t vl = env->vl;
>>      uint32_t i;
>>      for (i = 0; i < vl; i++) {
>>          if (!vm && !vext_elem_mask(v0, mlen, i)) {
>>              continue;
>>          }
>>          fn(vd, vs1, vs2, i, env);
>>      }
>>      if (i != 0) {
>>          clear_fn(vd, vl, vl * dsz,  vlmax * dsz);
>>      }
>> }
>>
>> #define GEN_VEXT_VV_ENV(NAME, ESZ, DSZ, CLEAR_FN)         \
>> void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>                    void *vs2, CPURISCVState *env,          \
>>                    uint32_t desc)                          \
>> {                                                         \
>>      static opivv2_fn *fns[4] = {                          \
>>          NAME##_rnu, NAME##_rne,                           \
>>          NAME##_rdn, NAME##_rod                            \
>>      }                                                     \
>>      return do_vext_vv_env(vd, v0, vs1, vs2, env, desc,    \
>>                            ESZ, DSZ, fns[env->vxrm],       \
>>                CLEAR_FN);                      \
>> }
>>
>> Is it true?
> While that does look good for this case, there are many other uses of
> get_round(), and it may not be quite as simple there.
>
> My suggestion was
>
> static inline int32_t aadd32(int vxrm, int32_t a, int32_t b)
> {
>      int64_t res = (int64_t)a + b;
>      uint8_t round = get_round(vxrm, res, 1);
>
>      return (res >> 1) + round;
> }
>
> static inline int64_t aadd64(int vxrm, int64_t a, int64_t b)
> {
>      int64_t res = a + b;
>      uint8_t round = get_round(vxrm, res, 1);
>      int64_t over = (res ^ a) & (res ^ b) & INT64_MIN;
>
>      /* With signed overflow, bit 64 is inverse of bit 63. */
>      return ((res >> 1) ^ over) + round;
> }
>
> RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
> RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
> RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
> RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)
>
> static inline void
> vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
>               uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
>               opivv2_rm_fn *fn)
> {
>      for (uint32_t i = 0; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, mlen, i)) {
>              continue;
>          }
>          fn(vd, vs1, vs2, i, vxrm);
>      }
> }
>
> static inline void
> vext_vv_rm_2(void *vd, void *v0, void *vs1,
>               void *vs2, CPURISCVState *env, uint32_t desc,
>               uint32_t esz, uint32_t dsz,
>               opivv2_rm_fn *fn, clear_fn *clearfn)
> {
>      uint32_t vlmax = vext_maxsz(desc) / esz;
>      uint32_t mlen = vext_mlen(desc);
>      uint32_t vm = vext_vm(desc);
>      uint32_t vl = env->vl;
>
>      if (vl == 0) {
>          return;
>      }
>
>      switch (env->vxrm) {
>      case 0: /* rnu */
>          vext_vv_rm_1(vd, v0, vs1, vs2,
>                       vl, vm, mlen, 0, fn);
>          break;
>      case 1: /* rne */
>          vext_vv_rm_1(vd, v0, vs1, vs2,
>                       vl, vm, mlen, 1, fn);
>          break;
>      case 2: /* rdn */
>          vext_vv_rm_1(vd, v0, vs1, vs2,
>                       vl, vm, mlen, 2, fn);
>          break;
>      default: /* rod */
>          vext_vv_rm_1(vd, v0, vs1, vs2,
>                       vl, vm, mlen, 3, fn);
>          break;
>      }
>
>      clear_fn(vd, vl, vl * dsz,  vlmax * dsz);
> }
>
> >From vext_vv_rm_2, a constant is passed down all of the inline functions, so
> that a constant arrives in get_round() at the bottom of the call chain.  At
> which point all of the expressions get folded by the compiler and we *should*
> get very similar generated code as to what you have above.
Yes, it will be much better.

I still have one question here.

Many other fixed point instructions also need vxsat besides vxsrm.

In that cases, can I just define OPIVV2_RM like this:

#define OPIVV2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)     \
static inline void                                                  \
do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
           CPURISCVState *env, int vxrm)                             \
{                                                                   \
     TX1 s1 = *((T1 *)vs1 + HS1(i));                                 \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1);                    \
}

static inline int32_t aadd32(|__attribute__((unused)) |CPURISCVState *env,
			     int vxrm, int32_t a, int32_t b)
{
     int64_t res = (int64_t)a + b;
     uint8_t round = get_round(vxrm, res, 1);

     return (res >> 1) + round;
}


In this way， I can write just one OPIVV2_RM instead of (OPIVV2_RM, 
OPIVV2_RM_ENV, OPIVV2_ENV).

Zhiwei

>
> r~


--------------3A65678DA80138844DF550B5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+DQogIDxoZWFkPg0KICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgPC9oZWFkPg0KICA8Ym9k
eT4NCiAgICA8YnI+DQogICAgPGJyPg0KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZp
eCI+T24gMjAyMC8zLzE1IDk6MDAsIFJpY2hhcmQgSGVuZGVyc29uDQogICAgICB3cm90ZTo8
YnI+DQogICAgPC9kaXY+DQogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSINCiAgICAgIGNp
dGU9Im1pZDo0MjZlMzFmOC0xYjU0LTdiNWEtYjJhOS1hMjc0MmY5Yzc0YWZAbGluYXJvLm9y
ZyI+DQogICAgICA8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3cmFwPSIiPk9uIDMvMTQv
MjAgNDoxMiBQTSwgTElVIFpoaXdlaSB3cm90ZToNCjwvcHJlPg0KICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+DQogICAgICAgIDxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdy
YXA9IiI+SSBhbSBub3Qgc3VyZSB3aGV0aGVyIEkgZ2V0IGl0LiBJbiBteSBvcGluaW9uLCB0
aGUgY29kZSBzaG91bGQgYmUgbW9kaWZpZWQgbGlrZQ0KDQpzdGF0aWMgaW5saW5lIGludDhf
dCBhYWRkOF9ybnUoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQ4X3QgYSwgaW50OF90IGIpDQp7
DQrCoMKgwqAgaW50MTZfdCByZXMgPSAoaW50MTZfdClhICsgKGludDE2X3QpYjsNCsKgwqDC
oCB1aW50OF90IHJvdW5kID0gcmVzICZhbXA7IDB4MTsNCsKgwqDCoCByZXPCoMKgID0gKHJl
cyAmZ3Q7Jmd0OyAxKSArIHJvdW5kOw0KwqDCoMKgIHJldHVybiByZXM7DQp9DQoNCnN0YXRp
YyBpbmxpbmUgaW50OF90IGFhZGQ4X3JuZShDUFVSSVNDVlN0YXRlICplbnYsIGludDhfdCBh
LCBpbnQ4X3QgYikNCnsNCsKgwqDCoCBpbnQxNl90IHJlcyA9IChpbnQxNl90KWEgKyAoaW50
MTZfdCliOw0KwqDCoMKgIHVpbnQ4X3Qgcm91bmQgPSAoKHJlcyAmYW1wOyAweDMpID09IDB4
Myk7DQrCoMKgwqAgcmVzwqDCoCA9IChyZXMgJmd0OyZndDsgMSkgKyByb3VuZDsNCsKgwqDC
oCByZXR1cm4gcmVzOw0KfQ0KDQpzdGF0aWMgaW5saW5lIGludDhfdCBhYWRkOF9yZG4oQ1BV
UklTQ1ZTdGF0ZSAqZW52LCBpbnQ4X3QgYSwgaW50OF90IGIpDQp7DQrCoMKgwqAgaW50MTZf
dCByZXMgPSAoaW50MTZfdClhICsgKGludDE2X3QpYjsNCsKgwqDCoCByZXPCoMKgID0gKHJl
cyAmZ3Q7Jmd0OyAxKTsNCsKgwqDCoCByZXR1cm4gcmVzOw0KfQ0KDQpzdGF0aWMgaW5saW5l
IGludDhfdCBhYWRkOF9yb2QoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQ4X3QgYSwgaW50OF90
IGIpDQp7DQrCoMKgwqAgaW50MTZfdCByZXMgPSAoaW50MTZfdClhICsgKGludDE2X3QpYjsN
CsKgwqDCoCB1aW50OF90IHJvdW5kID0gKChyZXMgJmFtcDsgMHgzKSA9PSAweDEpOw0KwqDC
oCByZXPCoMKgID0gKHJlcyAmZ3Q7Jmd0OyAxKSArIHJvdW5kOw0KwqDCoMKgIHJldHVybiBy
ZXM7DQp9DQoNClJWVkNBTEwoT1BJVlYyX0VOViwgdmFhZGRfdnZfYl9ybnUsIE9QX1NTU19C
LCBIMSwgSDEsIEgxLCBhYWRkOF9ybnUpDQpSVlZDQUxMKE9QSVZWMl9FTlYsIHZhYWRkX3Z2
X2Jfcm5lLCBPUF9TU1NfQiwgSDEsIEgxLCBIMSwgYWFkZDhfcm5lKQ0KUlZWQ0FMTChPUElW
VjJfRU5WLCB2YWFkZF92dl9iX3JkbiwgT1BfU1NTX0IsIEgxLCBIMSwgSDEsIGFhZGQ4X3Jk
bikNClJWVkNBTEwoT1BJVlYyX0VOViwgdmFhZGRfdnZfYl9yb2QsIE9QX1NTU19CLCBIMSwg
SDEsIEgxLCBhYWRkOF9yb2QpDQoNCnZvaWQgZG9fdmV4dF92dl9lbnYodm9pZCAqdmQsIHZv
aWQgKnYwLCB2b2lkICp2czEsDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2b2lkICp2czIsIENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMyX3QgZGVzYywNCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGVzeiwgdWlu
dDMyX3QgZHN6LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Bp
dnYyX2ZuICpmbiwgY2xlYXJfZm4gKmNsZWFyZm4pDQp7DQrCoMKgwqAgdWludDMyX3Qgdmxt
YXggPSB2ZXh0X21heHN6KGRlc2MpIC8gZXN6Ow0KwqDCoMKgIHVpbnQzMl90IG1sZW4gPSB2
ZXh0X21sZW4oZGVzYyk7DQrCoMKgwqAgdWludDMyX3Qgdm0gPSB2ZXh0X3ZtKGRlc2MpOw0K
wqDCoMKgIHVpbnQzMl90IHZsID0gZW52LSZndDt2bDsNCsKgwqDCoCB1aW50MzJfdCBpOw0K
wqDCoMKgIGZvciAoaSA9IDA7IGkgJmx0OyB2bDsgaSsrKSB7DQrCoMKgwqDCoMKgwqDCoCBp
ZiAoIXZtICZhbXA7JmFtcDsgIXZleHRfZWxlbV9tYXNrKHYwLCBtbGVuLCBpKSkgew0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCsKgwqDCoMKgwqDCoMKgIH0NCsKgwqDC
oMKgwqDCoMKgIGZuKHZkLCB2czEsIHZzMiwgaSwgZW52KTsNCsKgwqDCoCB9DQrCoMKgwqAg
aWYgKGkgIT0gMCkgew0KwqDCoMKgwqDCoMKgwqAgY2xlYXJfZm4odmQsIHZsLCB2bCAqIGRz
eizCoCB2bG1heCAqIGRzeik7DQrCoMKgwqAgfQ0KfQ0KDQojZGVmaW5lIEdFTl9WRVhUX1ZW
X0VOVihOQU1FLCBFU1osIERTWiwgQ0xFQVJfRk4pwqDCoMKgwqDCoMKgwqDCoCBcDQp2b2lk
IEhFTFBFUihOQU1FKSh2b2lkICp2ZCwgdm9pZCAqdjAsIHZvaWQgKnZzMSzCoMKgwqDCoMKg
wqDCoMKgwqAgXA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICp2
czIsIENQVVJJU0NWU3RhdGUgKmVudizCoMKgwqDCoMKgwqDCoMKgwqAgXA0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBkZXNjKcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCnvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCsKgwqDC
oCBzdGF0aWMgb3BpdnYyX2ZuICpmbnNbNF0gPSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KwqDCoMKgwqDCoMKgwqAgTkFNRSMjX3Ju
dSwgTkFNRSMjX3JuZSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwNCsKgwqDCoMKgwqDCoMKgIE5BTUUjI19yZG4sIE5BTUUjI19yb2TC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XA0KwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcDQrCoMKgwqAgcmV0dXJuIGRvX3ZleHRfdnZfZW52KHZkLCB2MCwgdnMxLCB2
czIsIGVudiwgZGVzYyzCoMKgwqAgXA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgRVNaLCBEU1osIGZuc1tlbnYtJmd0O3Z4cm1dLMKgwqDC
oMKgwqDCoCBcDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDTEVBUl9GTik7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCn0NCg0KSXMgaXQgdHJ1
ZT8NCjwvcHJlPg0KICAgICAgPC9ibG9ja3F1b3RlPg0KICAgICAgPHByZSBjbGFzcz0ibW96
LXF1b3RlLXByZSIgd3JhcD0iIj4NCldoaWxlIHRoYXQgZG9lcyBsb29rIGdvb2QgZm9yIHRo
aXMgY2FzZSwgdGhlcmUgYXJlIG1hbnkgb3RoZXIgdXNlcyBvZg0KZ2V0X3JvdW5kKCksIGFu
ZCBpdCBtYXkgbm90IGJlIHF1aXRlIGFzIHNpbXBsZSB0aGVyZS4NCg0KTXkgc3VnZ2VzdGlv
biB3YXMNCg0Kc3RhdGljIGlubGluZSBpbnQzMl90IGFhZGQzMihpbnQgdnhybSwgaW50MzJf
dCBhLCBpbnQzMl90IGIpDQp7DQogICAgaW50NjRfdCByZXMgPSAoaW50NjRfdClhICsgYjsN
CiAgICB1aW50OF90IHJvdW5kID0gZ2V0X3JvdW5kKHZ4cm0sIHJlcywgMSk7DQoNCiAgICBy
ZXR1cm4gKHJlcyAmZ3Q7Jmd0OyAxKSArIHJvdW5kOw0KfQ0KDQpzdGF0aWMgaW5saW5lIGlu
dDY0X3QgYWFkZDY0KGludCB2eHJtLCBpbnQ2NF90IGEsIGludDY0X3QgYikNCnsNCiAgICBp
bnQ2NF90IHJlcyA9IGEgKyBiOw0KICAgIHVpbnQ4X3Qgcm91bmQgPSBnZXRfcm91bmQodnhy
bSwgcmVzLCAxKTsNCiAgICBpbnQ2NF90IG92ZXIgPSAocmVzIF4gYSkgJmFtcDsgKHJlcyBe
IGIpICZhbXA7IElOVDY0X01JTjsNCg0KICAgIC8qIFdpdGggc2lnbmVkIG92ZXJmbG93LCBi
aXQgNjQgaXMgaW52ZXJzZSBvZiBiaXQgNjMuICovDQogICAgcmV0dXJuICgocmVzICZndDsm
Z3Q7IDEpIF4gb3ZlcikgKyByb3VuZDsNCn0NCg0KUlZWQ0FMTChPUElWVjJfUk0sIHZhYWRk
X3Z2X2IsIE9QX1NTU19CLCBIMSwgSDEsIEgxLCBhYWRkMzIpDQpSVlZDQUxMKE9QSVZWMl9S
TSwgdmFhZGRfdnZfaCwgT1BfU1NTX0gsIEgyLCBIMiwgSDIsIGFhZGQzMikNClJWVkNBTEwo
T1BJVlYyX1JNLCB2YWFkZF92dl93LCBPUF9TU1NfVywgSDQsIEg0LCBINCwgYWFkZDMyKQ0K
UlZWQ0FMTChPUElWVjJfUk0sIHZhYWRkX3Z2X2QsIE9QX1NTU19ELCBIOCwgSDgsIEg4LCBh
YWRkNjQpDQoNCnN0YXRpYyBpbmxpbmUgdm9pZA0KdmV4dF92dl9ybV8xKHZvaWQgKnZkLCB2
b2lkICp2MCwgdm9pZCAqdnMxLCB2b2lkICp2czIsDQogICAgICAgICAgICAgdWludDMyX3Qg
dmwsIHVpbnQzMl90IHZtLCB1aW50MzJfdCBtbGVuLCBpbnQgdnhybSwNCiAgICAgICAgICAg
ICBvcGl2djJfcm1fZm4gKmZuKQ0Kew0KICAgIGZvciAodWludDMyX3QgaSA9IDA7IGkgJmx0
OyB2bDsgaSsrKSB7DQogICAgICAgIGlmICghdm0gJmFtcDsmYW1wOyAhdmV4dF9lbGVtX21h
c2sodjAsIG1sZW4sIGkpKSB7DQogICAgICAgICAgICBjb250aW51ZTsNCiAgICAgICAgfQ0K
ICAgICAgICBmbih2ZCwgdnMxLCB2czIsIGksIHZ4cm0pOw0KICAgIH0NCn0NCg0Kc3RhdGlj
IGlubGluZSB2b2lkDQp2ZXh0X3Z2X3JtXzIodm9pZCAqdmQsIHZvaWQgKnYwLCB2b2lkICp2
czEsDQogICAgICAgICAgICAgdm9pZCAqdnMyLCBDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQz
Ml90IGRlc2MsDQogICAgICAgICAgICAgdWludDMyX3QgZXN6LCB1aW50MzJfdCBkc3osDQog
ICAgICAgICAgICAgb3BpdnYyX3JtX2ZuICpmbiwgY2xlYXJfZm4gKmNsZWFyZm4pDQp7DQog
ICAgdWludDMyX3QgdmxtYXggPSB2ZXh0X21heHN6KGRlc2MpIC8gZXN6Ow0KICAgIHVpbnQz
Ml90IG1sZW4gPSB2ZXh0X21sZW4oZGVzYyk7DQogICAgdWludDMyX3Qgdm0gPSB2ZXh0X3Zt
KGRlc2MpOw0KICAgIHVpbnQzMl90IHZsID0gZW52LSZndDt2bDsNCg0KICAgIGlmICh2bCA9
PSAwKSB7DQogICAgICAgIHJldHVybjsNCiAgICB9DQoNCiAgICBzd2l0Y2ggKGVudi0mZ3Q7
dnhybSkgew0KICAgIGNhc2UgMDogLyogcm51ICovDQogICAgICAgIHZleHRfdnZfcm1fMSh2
ZCwgdjAsIHZzMSwgdnMyLA0KICAgICAgICAgICAgICAgICAgICAgdmwsIHZtLCBtbGVuLCAw
LCBmbik7DQogICAgICAgIGJyZWFrOw0KICAgIGNhc2UgMTogLyogcm5lICovDQogICAgICAg
IHZleHRfdnZfcm1fMSh2ZCwgdjAsIHZzMSwgdnMyLA0KICAgICAgICAgICAgICAgICAgICAg
dmwsIHZtLCBtbGVuLCAxLCBmbik7DQogICAgICAgIGJyZWFrOw0KICAgIGNhc2UgMjogLyog
cmRuICovDQogICAgICAgIHZleHRfdnZfcm1fMSh2ZCwgdjAsIHZzMSwgdnMyLA0KICAgICAg
ICAgICAgICAgICAgICAgdmwsIHZtLCBtbGVuLCAyLCBmbik7DQogICAgICAgIGJyZWFrOw0K
ICAgIGRlZmF1bHQ6IC8qIHJvZCAqLw0KICAgICAgICB2ZXh0X3Z2X3JtXzEodmQsIHYwLCB2
czEsIHZzMiwNCiAgICAgICAgICAgICAgICAgICAgIHZsLCB2bSwgbWxlbiwgMywgZm4pOw0K
ICAgICAgICBicmVhazsNCiAgICB9DQoNCiAgICBjbGVhcl9mbih2ZCwgdmwsIHZsICogZHN6
LCAgdmxtYXggKiBkc3opOw0KfQ0KDQomZ3Q7RnJvbSB2ZXh0X3Z2X3JtXzIsIGEgY29uc3Rh
bnQgaXMgcGFzc2VkIGRvd24gYWxsIG9mIHRoZSBpbmxpbmUgZnVuY3Rpb25zLCBzbw0KdGhh
dCBhIGNvbnN0YW50IGFycml2ZXMgaW4gZ2V0X3JvdW5kKCkgYXQgdGhlIGJvdHRvbSBvZiB0
aGUgY2FsbCBjaGFpbi4gIEF0DQp3aGljaCBwb2ludCBhbGwgb2YgdGhlIGV4cHJlc3Npb25z
IGdldCBmb2xkZWQgYnkgdGhlIGNvbXBpbGVyIGFuZCB3ZSAqc2hvdWxkKg0KZ2V0IHZlcnkg
c2ltaWxhciBnZW5lcmF0ZWQgY29kZSBhcyB0byB3aGF0IHlvdSBoYXZlIGFib3ZlLg0KPC9w
cmU+DQogICAgPC9ibG9ja3F1b3RlPg0KICAgIFllcywgaXQgd2lsbCBiZSBtdWNoIGJldHRl
ci48YnI+DQogICAgPGJyPg0KICAgIEkgc3RpbGwgaGF2ZSBvbmUgcXVlc3Rpb24gaGVyZS4g
PGJyPg0KICAgIDxicj4NCiAgICBNYW55IG90aGVyIGZpeGVkIHBvaW50IGluc3RydWN0aW9u
cyBhbHNvIG5lZWQgdnhzYXQgYmVzaWRlcyB2eHNybS48YnI+DQogICAgPGJyPg0KICAgIElu
IHRoYXQgY2FzZXMsIGNhbiBJIGp1c3QgZGVmaW5lIE9QSVZWMl9STSBsaWtlIHRoaXM6PGJy
Pg0KICAgIDxicj4NCiAgICA8cHJlPiNkZWZpbmUgT1BJVlYyX1JNKE5BTUUsIFRELCBUMSwg
VDIsIFRYMSwgVFgyLCBIRCwgSFMxLCBIUzIsIE9QKSAgICAgXA0Kc3RhdGljIGlubGluZSB2
b2lkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQpkb18jI05BTUUodm9pZCAqdmQsIHZvaWQgKnZzMSwgdm9pZCAqdnMyLCBpbnQgaSwgICAg
ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICBDUFVSSVNDVlN0YXRlICplbnYsIGludCB2
eHJtKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KeyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQog
ICAgVFgxIHMxID0gKigoVDEgKil2czEgKyBIUzEoaSkpOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCiAgICBUWDIgczIgPSAqKChUMiAqKXZzMiArIEhTMihpKSk7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICooKFREICopdmQgKyBIRChp
KSkgPSBPUChlbnYsIHZ4cm0sIHMyLCBzMSk7ICAgICAgICAgICAgICAgICAgICBcDQp9DQoN
CnN0YXRpYyBpbmxpbmUgaW50MzJfdCBhYWRkMzIoPGNvZGUgY2xhc3M9IiAgbGFuZ3VhZ2Ut
Y3BwIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAxZW07IGZv
bnQtZmFtaWx5OiBDb25zb2xhcywgTW9uYWNvLCAmcXVvdDtBbmRhbGUgTW9ubyZxdW90Oywg
JnF1b3Q7VWJ1bnR1IE1vbm8mcXVvdDssIG1vbm9zcGFjZTsgcGFkZGluZzogMHB4OyBib3Jk
ZXI6IG5vbmU7IHZlcnRpY2FsLWFsaWduOiB1bnNldDsgd2hpdGUtc3BhY2U6IGluaGVyaXQ7
IGNvbG9yOiBpbmhlcml0OyBiYWNrZ3JvdW5kOiBub25lIHRyYW5zcGFyZW50OyB0ZXh0LWFs
aWduOiBsZWZ0OyB3b3JkLXNwYWNpbmc6IG5vcm1hbDsgd29yZC1icmVhazogbm9ybWFsOyBv
dmVyZmxvdy13cmFwOiBub3JtYWw7IGxpbmUtaGVpZ2h0OiAxLjU7IHRhYi1zaXplOiA0OyBo
eXBoZW5zOiBub25lOyBwb3NpdGlvbjogcmVsYXRpdmU7Ij48c3BhbiBjbGFzcz0idG9rZW4g
ZnVuY3Rpb24iIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBjb2xvcjogcmdiKDI0
MCwgMTQxLCA3Myk7Ij5fX2F0dHJpYnV0ZV9fPC9zcGFuPjxzcGFuIGNsYXNzPSJ0b2tlbiBw
dW5jdHVhdGlvbiIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGNvbG9yOiByZ2Io
MjA0LCAyMDQsIDIwNCk7Ij4oPC9zcGFuPjxzcGFuIGNsYXNzPSJ0b2tlbiBwdW5jdHVhdGlv
biIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGNvbG9yOiByZ2IoMjA0LCAyMDQs
IDIwNCk7Ij4oPC9zcGFuPnVudXNlZDxzcGFuIGNsYXNzPSJ0b2tlbiBwdW5jdHVhdGlvbiIg
c3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGNvbG9yOiByZ2IoMjA0LCAyMDQsIDIw
NCk7Ij4pPC9zcGFuPjxzcGFuIGNsYXNzPSJ0b2tlbiBwdW5jdHVhdGlvbiIgc3R5bGU9ImJv
eC1zaXppbmc6IGJvcmRlci1ib3g7IGNvbG9yOiByZ2IoMjA0LCAyMDQsIDIwNCk7Ij4pIDwv
c3Bhbj48L2NvZGU+Q1BVUklTQ1ZTdGF0ZSAqZW52LCANCgkJCSAgICAgaW50IHZ4cm0sIGlu
dDMyX3QgYSwgaW50MzJfdCBiKQ0Kew0KICAgIGludDY0X3QgcmVzID0gKGludDY0X3QpYSAr
IGI7DQogICAgdWludDhfdCByb3VuZCA9IGdldF9yb3VuZCh2eHJtLCByZXMsIDEpOw0KDQog
ICAgcmV0dXJuIChyZXMgJmd0OyZndDsgMSkgKyByb3VuZDsNCn0NCjwvcHJlPg0KICAgIDxi
cj4NCiAgICBJbiB0aGlzIHdhee+8jCBJIGNhbiB3cml0ZSBqdXN0IG9uZSBPUElWVjJfUk0g
aW5zdGVhZCBvZiAoT1BJVlYyX1JNLA0KICAgIE9QSVZWMl9STV9FTlYsIE9QSVZWMl9FTlYp
Ljxicj4NCiAgICA8YnI+DQogICAgWmhpd2VpPGJyPg0KICAgIDxicj4NCiAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIg0KICAgICAgY2l0ZT0ibWlkOjQyNmUzMWY4LTFiNTQtN2I1YS1i
MmE5LWEyNzQyZjljNzRhZkBsaW5hcm8ub3JnIj4NCiAgICAgIDxwcmUgY2xhc3M9Im1vei1x
dW90ZS1wcmUiIHdyYXA9IiI+DQoNCnJ+DQo8L3ByZT4NCiAgICA8L2Jsb2NrcXVvdGU+DQog
ICAgPGJyPg0KICA8L2JvZHk+DQo8L2h0bWw+DQo=
--------------3A65678DA80138844DF550B5--


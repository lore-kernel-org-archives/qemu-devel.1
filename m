Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E27C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689F721473
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFR4tvqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689F721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQNu-0003Su-It
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 02:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40936 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQMf-0002x1-U3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 02:57:23 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQMc-0004G3-Lq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 02:57:09 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41079)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQMc-0004ET-Ay
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 02:57:06 -0400
Received: by mail-ed1-x541.google.com with SMTP id d16so6225519edv.8
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+RaLOTHSKcIpMNYxzGzfOuJa9J2naYEdK3d/cXnjVLk=;
 b=uFR4tvqqulZ4+dB2xDMMdeF/gq7NZ3PzjY8Sf2x3gq15/+sKEbrG7TYCmZ8eAsZqEm
 zJEGk9EJmzp8nx/g6FMePtfR4JMX78oBvn6rAhd/Ey8xA6Kx/XSTolBdOCYSPt1AQWkl
 cBHEtaQGOpxRjPU1IuvXcX0rIlJiFM4JSRx5a1vTRbdpQ6qBT3hFCBvJ616Cl8cUPErQ
 IudT0yNUi9MUseA7T8VKozesEauPdXhtKQFsHdb4agaYEDZUcJCsePjONNmhYC1XOn7U
 ywoSRgOoeCB7YhLMb4PpHFWZiURgMgxcNJzkNbe+8XYatgxjUYcqUUqV0KztylFKQo5d
 Xz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+RaLOTHSKcIpMNYxzGzfOuJa9J2naYEdK3d/cXnjVLk=;
 b=PCga7R6Lo5T9EwzcHclu7JKECzPuhBuGX3wBsxNHHGJcagbteytneY3N8arCVf1+JU
 7cIaajEToA5uMq/5Hj1uIvyd/mk/UvPyhbli9Jyhqk98D4/e9NuK/F8qUAaqcINqIGd7
 5tBQSlVTXW2mpzmsFvAAmObKRWVBfY1AVp8PP12G/IeFWp7/oZ4FyP+pO/DKE0aBIH51
 xvhyACn/8SPCA0L+jSPbXRDg5f3AlxnDrGXg9s5Xlg1chUFPhowAo7LbUMNV1VsZzUpz
 twhDqwiWHqCGJN/y1gCKtDWM3uEhafYotd8KZc/Rb0jOmGUCt7mhod3YWJIXHzNnrgG9
 9QDw==
X-Gm-Message-State: AGi0PubMPpFKsfCQQ+EZK4DCPPOI5JcgNiJ/yDj1Dm4O920AK75Y0ns/
 PLmXQWQXyXwIHyGdFqMdyQNYDPt0k2Q=
X-Google-Smtp-Source: APiQypInb2zn9ym+zzJ9f6oqe5OhOpeyzSbbrmc2aON9NxyVjJC0Y1v01rJkfyUGnYN1q1jiYSk/Zg==
X-Received: by 2002:a05:6402:8c1:: with SMTP id
 d1mr7295123edz.236.1587365824087; 
 Sun, 19 Apr 2020 23:57:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i16sm31958ejy.64.2020.04.19.23.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2020 23:57:03 -0700 (PDT)
Subject: Re: [PATCH 01/16] tcg: Add temp_readonly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200418161914.4387-1-richard.henderson@linaro.org>
 <20200418161914.4387-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <43df1b6b-db63-223d-4526-3b33692cefa3@amsat.org>
Date: Mon, 20 Apr 2020 08:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200418161914.4387-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::541
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/18/20 6:18 PM, Richard Henderson wrote:
> In most, but not all, places that we check for TEMP_FIXED,
> we are really testing that we do not modify the temporary.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/tcg/tcg.h |  5 +++++
>  tcg/tcg.c         | 21 ++++++++++-----------
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 3534dce77f..27e1b509a6 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -678,6 +678,11 @@ struct TCGContext {
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
>  };
>  
> +static inline bool temp_readonly(TCGTemp *ts)
> +{
> +    return ts->kind == TEMP_FIXED;
> +}
> +
>  extern TCGContext tcg_init_ctx;
>  extern __thread TCGContext *tcg_ctx;
>  extern TCGv_env cpu_env;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index eaf81397a3..92b3767097 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3132,7 +3132,7 @@ static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
>     mark it free; otherwise mark it dead.  */
>  static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
>  {
> -    if (ts->kind == TEMP_FIXED) {
> +    if (temp_readonly(ts)) {
>          return;
>      }
>      if (ts->val_type == TEMP_VAL_REG) {
> @@ -3156,7 +3156,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
>  static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
>                        TCGRegSet preferred_regs, int free_or_dead)
>  {
> -    if (ts->kind == TEMP_FIXED) {
> +    if (temp_readonly(ts)) {
>          return;
>      }
>      if (!ts->mem_coherent) {
> @@ -3314,8 +3314,7 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
>  {
>      /* The liveness analysis already ensures that globals are back
>         in memory. Keep an tcg_debug_assert for safety. */
> -    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM
> -                     || ts->kind == TEMP_FIXED);
> +    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM || temp_readonly(ts));
>  }
>  
>  /* save globals to their canonical location and assume they can be
> @@ -3373,7 +3372,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>                                    TCGRegSet preferred_regs)
>  {
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(ots->kind != TEMP_FIXED);
> +    tcg_debug_assert(!temp_readonly(ots));
>  
>      /* The movi is not explicitly generated here.  */
>      if (ots->val_type == TEMP_VAL_REG) {
> @@ -3413,7 +3412,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>      ts = arg_temp(op->args[1]);
>  
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(ots->kind != TEMP_FIXED);
> +    tcg_debug_assert(!temp_readonly(ots));
>  
>      /* Note that otype != itype for no-op truncation.  */
>      otype = ots->type;
> @@ -3474,7 +3473,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>                   * Store the source register into the destination slot
>                   * and leave the destination temp as TEMP_VAL_MEM.
>                   */
> -                assert(ots->kind != TEMP_FIXED);
> +                assert(!temp_readonly(ots));
>                  if (!ts->mem_allocated) {
>                      temp_allocate_frame(s, ots);
>                  }
> @@ -3511,7 +3510,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>      its = arg_temp(op->args[1]);
>  
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(ots->kind != TEMP_FIXED);
> +    tcg_debug_assert(!temp_readonly(ots));
>  
>      itype = its->type;
>      vece = TCGOP_VECE(op);
> @@ -3742,7 +3741,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>              ts = arg_temp(arg);
>  
>              /* ENV should not be modified.  */
> -            tcg_debug_assert(ts->kind != TEMP_FIXED);
> +            tcg_debug_assert(!temp_readonly(ts));
>  
>              if ((arg_ct->ct & TCG_CT_ALIAS)
>                  && !const_args[arg_ct->alias_index]) {
> @@ -3784,7 +3783,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>          ts = arg_temp(op->args[i]);
>  
>          /* ENV should not be modified.  */
> -        tcg_debug_assert(ts->kind != TEMP_FIXED);
> +        tcg_debug_assert(!temp_readonly(ts));
>  
>          if (NEED_SYNC_ARG(i)) {
>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
> @@ -3916,7 +3915,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>          ts = arg_temp(arg);
>  
>          /* ENV should not be modified.  */
> -        tcg_debug_assert(ts->kind != TEMP_FIXED);
> +        tcg_debug_assert(!temp_readonly(ts));
>  
>          reg = tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] == NULL);
> 


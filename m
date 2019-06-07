Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909DE207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909DE207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFFC-0005It-S4
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF9h-00013J-Lf
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF9g-0003aI-2H
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:43:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF9f-0003YC-Rm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:43:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so1975624wma.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sGtH6PB92xX+nFKQN239komPjU8dVP8CV1SI2YCXwXw=;
 b=oMqaV9EP7WWd/OE7OLb6kT0J4fWt+TCWfVr4x0VN989SM+sagVQ/RwTp1FdT7nekM1
 H0CnUrQfu/eK+arodk8dYYYMlad6DZaNuH6FWHYCoEzpYLElThkSlFlrjzl25Zy+Y2eL
 2pfZcWerMV+7gUWyXFah45XwPLNuxf6vb4NK90edOAvR9pjqg3Y+XFVtjMVRJjNKcHov
 3BNrCu5HeKlaDHc65ghG9iBTdyApkUwsDoD8ajQfKOvvHOuXKoiWS8pGSd01wSu7AXsU
 mupbJ4T1SuOkc/vBgfhatqtVysRJwZTCld3qfOWPxV6lhCy0WQ6o/biG6Pam6y/pQ1x5
 pM8g==
X-Gm-Message-State: APjAAAUlSCpmwz7IJMvE9i7YzFVV4RE46ZdkvLarRwoKWiJKSpQvbiro
 PiVda+X0cvXvSjNnC76m7oI/cw==
X-Google-Smtp-Source: APXvYqyfLhuKz2kwddlNMg+sLrJg/R/zAKYfVPg7NtXIn/PSxcP/pYDfGIGxSKsqxA+GO/PTbu9UpQ==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr3497530wml.37.1559915018823; 
 Fri, 07 Jun 2019 06:43:38 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id b203sm1454137wmd.41.2019.06.07.06.43.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:43:38 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-23-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d0eab7c1-9fd0-2fde-268c-ee1476c7a7c0@redhat.com>
Date: Fri, 7 Jun 2019 15:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-23-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v17 22/24] target/rx: Collect all bytes
 during disassembly
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Collected, to be used in the next patch.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/disas.c | 62 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index ebc1a44249..5a32a87534 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -25,43 +25,59 @@ typedef struct DisasContext {
>      disassemble_info *dis;
>      uint32_t addr;
>      uint32_t pc;
> +    uint8_t len;
> +    uint8_t bytes[8];
>  } DisasContext;
>  
>  
>  static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
> -                           int i, int n)
> +                                  int i, int n)
>  {
> -    bfd_byte buf;
> +    uint32_t addr = ctx->addr;
> +
> +    g_assert(ctx->len == i);
> +    g_assert(n <= ARRAY_SIZE(ctx->bytes));
> +
>      while (++i <= n) {
> -        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
> -        insn |= buf << (32 - i * 8);
> +        ctx->dis->read_memory_func(addr++, &ctx->bytes[i - 1], 1, ctx->dis);
> +        insn |= ctx->bytes[i - 1] << (32 - i * 8);
>      }
> +    ctx->addr = addr;
> +    ctx->len = n;
> +
>      return insn;
>  }
>  
>  static int32_t li(DisasContext *ctx, int sz)
>  {
> -    int32_t addr;
> -    bfd_byte buf[4];
> -    addr = ctx->addr;
> +    uint32_t addr = ctx->addr;
> +    uintptr_t len = ctx->len;
>  
>      switch (sz) {
>      case 1:
> +        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 1;
> -        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> -        return (int8_t)buf[0];
> +        ctx->len += 1;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
> +        return (int8_t)ctx->bytes[len];
>      case 2:
> +        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 2;
> -        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> -        return ldsw_le_p(buf);
> +        ctx->len += 2;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
> +        return ldsw_le_p(ctx->bytes + len);
>      case 3:
> +        g_assert(len + 3 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 3;
> -        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
> -        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
> +        ctx->len += 3;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 3, ctx->dis);
> +        return (int8_t)ctx->bytes[len + 2] << 16 | lduw_le_p(ctx->bytes + len);
>      case 0:
> +        g_assert(len + 4 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 4;
> -        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
> -        return ldl_le_p(buf);
> +        ctx->len += 4;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 4, ctx->dis);
> +        return ldl_le_p(ctx->bytes + len);
>      default:
>          g_assert_not_reached();
>      }
> @@ -110,7 +126,7 @@ static const char psw[] = {
>  static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
>  {
>      uint32_t addr = ctx->addr;
> -    uint8_t buf[2];
> +    uintptr_t len = ctx->len;
>      uint16_t dsp;
>  
>      switch (ld) {
> @@ -119,14 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
>          out[0] = '\0';
>          return;
>      case 1:
> +        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 1;
> -        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> -        dsp = buf[0];
> +        ctx->len += 1;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
> +        dsp = ctx->bytes[len];
>          break;
>      case 2:
> +        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
>          ctx->addr += 2;
> -        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> -        dsp = lduw_le_p(buf);
> +        ctx->len += 2;
> +        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
> +        dsp = lduw_le_p(ctx->bytes + len);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -1392,8 +1412,10 @@ int print_insn_rx(bfd_vma addr, disassemble_info *dis)
>      DisasContext ctx;
>      uint32_t insn;
>      int i;
> +
>      ctx.dis = dis;
>      ctx.pc = ctx.addr = addr;
> +    ctx.len = 0;
>  
>      insn = decode_load(&ctx);
>      if (!decode(&ctx, insn)) {
> 


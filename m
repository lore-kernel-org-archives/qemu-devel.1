Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA59EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38D02342A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38D02342A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2DW-0001BP-Vm
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:42:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY2CQ-0000cP-Dd
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY2CP-0005xy-Ap
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:41:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY2CP-0005tw-4Z
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:41:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so5047378wmg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=62Z11njhhYUk706I6uYG8BsZxBDI+RDe73b/Jet8hJI=;
	b=Ybezs3Wb0OgrkYn14nuDQGFzq0Cv/VqiT4NboJE8jMTVsDq+/WhjZITPjHLRNsQKCt
	8hDRy25s30IdyTNBgTn8gTJ5OduMOoXHDCpyE/BuxWQtpduitncTcvaVMltpYK154Mce
	KQ7fq7fJ6w6IHEQcccIBxLekT24GM6RzKh2VdB7IzwfLWeesZYlGxlfdT/9WTdI4/I0J
	tfix5Jo5vjpUhWOutveDwcsPWfAQM1hNctfSLhaR82gx+r3okOC2ZI2jB8Hc0G3ApKS1
	e2gpazHtmuR4E0Rtfek0DDI9240cnaR9+Gmb0Uxo+x/xFmWib6YXcqDokEYueAhNBcP/
	zSGg==
X-Gm-Message-State: APjAAAVPWIQQqAOvocSjF7eWhJSbcFXrLu9zqR8dKFkXdIEPwOuaA9OX
	aOOSF72CkHFXDmuai/PoiUM+kA==
X-Google-Smtp-Source: APXvYqzbufunQ4Gw7sY2/lteVM2laeuE0soOGGAPd592G95PdA45iSn3WEGdWflRM5mx4yUEusBmsg==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr8892392wmb.17.1559626887558; 
	Mon, 03 Jun 2019 22:41:27 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	z5sm15109638wma.36.2019.06.03.22.41.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:41:27 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c196a6b1-c8cc-1ba4-01f5-be83f2683b14@redhat.com>
Date: Tue, 4 Jun 2019 07:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v16 22/23] target/rx: Collect all bytes
 during disassembly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Collected, to be used in the next patch.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/rx/disas.c | 62 ++++++++++++++++++++++++++++++++---------------
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFAC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D920424E09
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D920424E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2AN-0007GN-4K
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:39:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY275-0004jl-SI
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY273-0007mk-VE
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:35:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY271-0007jK-TV
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:35:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so14363297wro.4
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sk4iNQYwli028PZd8oQlftvipe73FWtqrtHilorjNKI=;
	b=dHhc8/h2gmjIpK0nE2c7JtjZQVQQwpSkJDjijeUuMcy7s4kBH1VeOdwMYy1qJIR1Vq
	Omo5AWbToBwy62K9Nis+r4hSRFCStiiu6eRcVwy/lV10BzM4x1RdOG7xMciPQBTDXTB3
	Ynp7WGujk9NBAzf0Xnkk7b86OD2dDgLxhYx+tinOk4yF3enFBtQdyQmqIJafgbwK/2qY
	Y6Hi1fIJ/g+bnjB4oW+OjHRRHrB952UtZM8W/MNCoJdp2t33YzCs5np8bDVGt6kxI9/r
	+Q4YfLrGZUPwLiYl1MzxC+46bOh5e90CEJTHBclQCelmgbo/FyZ0ShvIOWm9ybpNUxz+
	0Z2A==
X-Gm-Message-State: APjAAAXCvMnXajvblZVO4abk8AQmlvGJN0tHCSTVZTFSiaIDpLLS1Y8V
	dSBqN8Ugo5wcydhTdVorYg2aXA==
X-Google-Smtp-Source: APXvYqytpd2Hmnn5SMzPEmqu5ytjtyUFk9wk0tRDAL0q/5mterrNiuN8vFHHjiIO2ucoWHpEdoj0JA==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr3980488wrn.123.1559626554341; 
	Mon, 03 Jun 2019 22:35:54 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id y12sm8928062wrr.3.2019.06.03.22.35.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:35:53 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <46da7cb3-1c9f-80af-edb8-bc4658373471@redhat.com>
Date: Tue, 4 Jun 2019 07:35:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v16 23/23] target/rx: Dump bytes for each
 insn during disassembly
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
> There are so many different forms of each RX instruction
> that it will be very useful to be able to look at the bytes
> to see on which path a bug may lie.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/rx/disas.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index 5a32a87534..d73b53db44 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
>  /* Include the auto-generated decoder.  */
>  #include "decode.inc.c"
>  
> -#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS__)
> +static void dump_bytes(DisasContext *ctx)
> +{
> +    int i, len = ctx->len;
> +
> +    for (i = 0; i < len; ++i) {
> +        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i]);
> +    }
> +    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
> +}
> +
> +#define prt(...) \
> +    do {                                                        \
> +        dump_bytes(ctx);                                        \
> +        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
> +    } while (0)
>  
>  #define RX_MEMORY_BYTE 0
>  #define RX_MEMORY_WORD 1
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


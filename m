Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F7BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF142177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1tiIJQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF142177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpWb-0008Ff-C9
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:20:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpUy-0007EL-Ck
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpUx-0007x2-EM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:18:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpUx-0007wQ-7J
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:18:35 -0400
Received: by mail-lj1-x241.google.com with SMTP id r76so3116984lja.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EboLdqc0K/Cg4mDsAPCNCN/bIVPHENADZqfRKr4mdOY=;
	b=Y1tiIJQYtQoI3hiVZ+CwYSJnUyD2VXZk4D9vFXj8g9RzqbxJVlCH2vmYge9EgEbh0D
	MwzmaQQeQX7sUklM2kSLhg+BMptW8GKI2xG0qMGy9rqkUl0pBoN/MN/epL50w04Ugmn/
	OY4y1YOo4sc/NPSiTxrltL56uLeZsPr2wGrn4xyytekY9Z+2wiJSS6p12QJQmBogSE/i
	1mvSM7HzF+LIp6gCb5/+zm3GhQj4ixajqboy2OI/4xQy3ELGFZ0r+k8dxyvh48a9bNlO
	RcpMHrINI8mQglzSCI58a/DkCoT8R3y/cEJkdvbSzl21ELA0eZcQKncJ+HBwTdDj4KkQ
	sWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EboLdqc0K/Cg4mDsAPCNCN/bIVPHENADZqfRKr4mdOY=;
	b=RMnNiCsIB6nPaM7wdEXDAgXQWeULHA8D4yvGrkHMxBmWu/uxyRxFthtrjo7/ZOymyh
	XCQenkZf1JQ3JoamhcZDxX8D1U3xhiYHZGfV/5IftaoNZLlAok0VDRXnT0pDZ0wbGvkk
	AqTFOVFL7TLxfv6QKDeL5/b0CnRqRhC1jvTJWJS+iMl+l9mCgi+Y7ZSPBtQFqpFhQlsg
	crZNj9bQHyrC0u/4RqzxrUefRaGHfTQV0iMf578cJ0697hqR4HKFcQmpwQWfxQlZ7v5z
	ckr6skAPAGtUKmjRQt+tuEVShrEfepc37GFEgpaQ4iGsJyni+lzdLJYaZFvAeZ8RyhCR
	0oeA==
X-Gm-Message-State: APjAAAXWLJR1iJsoPZc4cshW+k8D5tlZ2CnmQne7O2Je/JVgeIZZuU2+
	CJXFNo78MWmZhvRZAddciaJIXgB1y0GJ6lvVBJehuUwh
X-Google-Smtp-Source: APXvYqyRh8G5tCsN01kFXjrnV65JcDVbKHj9sG7qWT/t9IH2PYNftALHbUJnu9uO5qjmNys0+8cPtkf2N3qj/mwL2+4=
X-Received: by 2002:a2e:8988:: with SMTP id c8mr3181088lji.99.1557433114058;
	Thu, 09 May 2019 13:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-28-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-28-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:16:27 -0700
Message-ID: <CAKmqyKOiS0howCejpijEo0jNdVSf=SKM8eyEe1=jPQMf4P2tsQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 27/39] target/tilegx: Use env_cpu
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:28 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/tilegx/cpu.h          | 5 -----
>  linux-user/tilegx/cpu_loop.c | 2 +-
>  target/tilegx/helper.c       | 2 +-
>  3 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index 135df63523..7f8fe7c513 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -138,11 +138,6 @@ typedef struct TileGXCPU {
>      CPUTLGState env;
>  } TileGXCPU;
>
> -static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
> -{
> -    return container_of(env, TileGXCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(TileGXCPU, env)
>
>  /* TILE-Gx memory attributes */
> diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
> index 4f39eb9ad3..d4abe29dcd 100644
> --- a/linux-user/tilegx/cpu_loop.c
> +++ b/linux-user/tilegx/cpu_loop.c
> @@ -206,7 +206,7 @@ static void do_fetch(CPUTLGState *env, int trapnr, bool quad)
>
>  void cpu_loop(CPUTLGState *env)
>  {
> -    CPUState *cs = CPU(tilegx_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>
>      while (1) {
> diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
> index 4964bb9111..a57a679825 100644
> --- a/target/tilegx/helper.c
> +++ b/target/tilegx/helper.c
> @@ -28,7 +28,7 @@
>
>  void helper_exception(CPUTLGState *env, uint32_t excp)
>  {
> -    CPUState *cs = CPU(tilegx_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      cpu_loop_exit(cs);
> --
> 2.17.1
>
>


Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA0DC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB3020862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wO9uBX+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB3020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvnD-0003zX-4a
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:26:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvkp-0002Gm-0B
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvac-0001mx-C2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:13:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQvac-0001hi-4Z
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:13:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id e15so3119266wrs.4
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ig9fMrZaBNK6PguGD1OfQ26inyYK2n0Bdj94H1/THFs=;
	b=wO9uBX+5oLBA0qfVT2IiE+g7o4YtID04CY1XKo1sXje9JeUXca3YA4IoJsJq6bTaT+
	LW6Gjd2XzoKAdBADf6YcPJn6pEKt1I9DsZGHU8wLFACDBXy0whuOr+wx5Fx8FpoFDXXM
	6biRvCuG1LGoUexigcF0Ao2BLPANgQSznasKU77Pvc6ps916+NGDUImjHxD4I+/Y1coE
	Ap1rCleNh+Xq36KlXCx4n4FYghyvPTu/MKgiKd6BIYff3bfhlov0BVO2PEUDVFzcixFw
	9DFhroobY0njIkxEvSuaB+swWnbCKzmTQGH3kP616+zcJunETkrhwEmJxrBDWctioRPN
	W/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ig9fMrZaBNK6PguGD1OfQ26inyYK2n0Bdj94H1/THFs=;
	b=W6A99/dHso8B7WZ6sACKSpvRsd5TXuGT4KLoDdr4XJlprSKF9uEcUTjmT9/hlFUFey
	M1FYKJ/bLtnDkwJUsryvATUkDQHgxVrvXv7/1ywnFWuHr8dUlnvnXt/wfNGwCkIXkz3e
	+kLtj6bBKn8JA8jXb3q3GiET1B7lec8yRiV7GJO+/Cyr0EHKpbtS+aH0wTI/IN+dknyI
	hwTS+n26n/vhUBvCmvHB8dJoxaNAYtLTjEGu+9Zv6YA5Ez5a4OhcrvuH09J4XsSha3ev
	HABtZkLkB/QdkOEAwqNWdzGAoWThN3Jf5loFOr5S94d6EoSlQqARDM1ZmdPsbH5n2med
	iWIw==
X-Gm-Message-State: APjAAAWNvOjAxLbLM4UEF4EPSV8mRMydR51jvvJetv7Rml0yAfhbAi0J
	R5UPsfAz6RQN6eIVawe2ZjNCWA==
X-Google-Smtp-Source: APXvYqxhIq0YU/F9UDQaGyiqlK0qNz1clT5R8LFVAtPlHvioHfXGT6vNS4WdYh2fSYtS66vtcqqoXA==
X-Received: by 2002:adf:e288:: with SMTP id v8mr20942088wri.7.1557933184544;
	Wed, 15 May 2019 08:13:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a10sm3282483wrm.94.2019.05.15.08.13.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 08:13:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 694261FF87;
	Wed, 15 May 2019 16:13:03 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-24-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-24-arilou@gmail.com>
Date: Wed, 15 May 2019 16:13:03 +0100
Message-ID: <87r28zn43k.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v9 23/27] gdbstub: Implement qemu physical
 memory mode
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Add a new query/set which changes the memory GDB sees to physical memory
> only.
>
> gdb> maint packet qqemu.PhyMemMode
> will reply the current phy_mem_mode state (1 for enabled, 0 for disabled)
> gdb> maint packet Qqemu.PhyMemMode:1
> Will make GDB read/write only to physical memory, set to 0 to disable
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 00c07d6ec0..88ff6224e6 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -46,11 +46,23 @@
>  #define GDB_ATTACHED "1"
>  #endif
>
> +static int phy_memory_mode;
> +
>  static inline int target_memory_rw_debug(CPUState *cpu, target_ulong add=
r,
>                                           uint8_t *buf, int len, bool is_=
write)
>  {
> -    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    CPUClass *cc;
>
> +    if (phy_memory_mode) {
> +        if (is_write) {
> +            cpu_physical_memory_write(addr, buf, len);
> +        } else {
> +            cpu_physical_memory_read(addr, buf, len);
> +        }
> +        return 0;
> +    }
> +

I think this is the commit that breaks the build. As the gdbstub can run
for both system and linux-user emulation modes you need to take care to
disable the bits that don't make sense for linux-user emulation. You'll
see other places in the code doing that with #if[n]def CONFIG_USER_ONLY.


> +    cc =3D CPU_GET_CLASS(cpu);
>      if (cc->memory_rw_debug) {
>          return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
>      }
> @@ -2129,7 +2141,29 @@ static void handle_query_attached(GdbCmdContext *g=
db_ctx, void *user_ctx)
>
>  static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *us=
er_ctx)
>  {
> -    put_packet(gdb_ctx->s, "sstepbits;sstep");
> +    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
> +}
> +
> +static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
> +                                           void *user_ctx)
> +{
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memor=
y_mode);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *u=
ser_ctx)
> +{
> +    if (!gdb_ctx->num_params) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (!gdb_ctx->params[0].val_ul) {
> +        phy_memory_mode =3D 0;
> +    } else {
> +        phy_memory_mode =3D 1;
> +    }
> +    put_packet(gdb_ctx->s, "OK");
>  }
>
>  static GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
> @@ -2212,6 +2246,20 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
>          .handler =3D handle_query_qemu_supported,
>          .cmd =3D "qemu.Supported",
>      },
> +    {
> +        .handler =3D handle_query_qemu_phy_mem_mode,
> +        .cmd =3D "qemu.PhyMemMode",
> +    },
> +};
> +
> +static GdbCmdParseEntry gdb_gen_set_table[] =3D {
> +    /* Order is important if has same prefix */
> +    {
> +        .handler =3D handle_set_qemu_phy_mem_mode,
> +        .cmd =3D "qemu.PhyMemMode:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
>  };
>
>  static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
> @@ -2245,7 +2293,11 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx,=
 void *user_ctx)
>          return;
>      }
>
> -    put_packet(gdb_ctx->s, "");
> +    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                           gdb_gen_set_table,
> +                           ARRAY_SIZE(gdb_gen_set_table))) {
> +        put_packet(gdb_ctx->s, "");
> +    }
>  }
>
>  static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)


--
Alex Benn=C3=A9e


Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD720815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPl0wVoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBD720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxeW-0000XF-Be
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:25:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxdj-0000Dt-Rs
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxdj-0004D0-1P
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:24:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxdi-0004Ax-Qz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:24:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id f204so863291wme.0
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Va+vWtF9ngQjoSQJ13yaIm+IuSK05WsxTCtG6Rlf0nY=;
	b=BPl0wVoHi0iUB/ZGaxP2gi8Bv7NG527haoHJAoe3oueP/p5pV09l4aYAdTPjwYvMNK
	uERp4aryjFu5KeFgzoXcO04DlkpVhESSYbNhiZEvuOWpbmXLIvfnq2XjSRTbPoU4Iyej
	Lfpkq5GpalLwlesSF93geK1VJllAfT1Mrgo60YW7leR1pNsUWiFejpl//6hzJiGUlimv
	vIUq2gTUZHnUmBc3NUXCDNX7QQ+6ARv1enJGfSWGlj78TTtF5bbHS9uvFbxIDKHe8rAt
	/RAUtFXUv2ufhqvrlwRtFpT3lck4gslezQyRFrzmXlgBoi6ZssQ3OgaIgGv5xtJsAj3l
	Lg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Va+vWtF9ngQjoSQJ13yaIm+IuSK05WsxTCtG6Rlf0nY=;
	b=GNFrGj/2jLeDfXxcfd55tsS8Lq95MseR2QXwK3r3j6b6ie75GwIBAvBhqKSO/my9zW
	02amhddKwSAXZXVHwssKN55H+VOggo3/bQm7N4VmN+ihoA8eJonwYp4tRLAFkIInz1aO
	Ztrk4m3BPzalx+g/wzGXEPsy5hfZvxjLEF7Sf043XSEzUGB6VkQBdaWJROTTAszHRku2
	d7upMgSws7CV9J9EqN8l9Wi1MdyNHIKenYttcV9mf9sr86/otYqqrxfAjSrZ5XsCxFT6
	NIbp4lOowXqFZtnMKioBi1eDKEChGWRkEhHFMjGk2CePJD4VgUFwJ/bjeulzf+hlqsjB
	0iaA==
X-Gm-Message-State: APjAAAWelghBxN62lGa6IMUjrP+Kbt/3T/4qTBdeQj9HhNIgH4L9nnfO
	iHyniBHapc21dDwBvz2Gc53ccwYBWig=
X-Google-Smtp-Source: APXvYqwwr2GivtC7yxCnvIG7wmhmTLVN7I+h/tPKmn0dxroYAKSYH55J1rBnqgEC05u0thGUlLPDPw==
X-Received: by 2002:a1c:ca19:: with SMTP id a25mr3099807wmg.105.1557941065286; 
	Wed, 15 May 2019 10:24:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y130sm3285145wmc.44.2019.05.15.10.24.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:24:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3B5241FF87;
	Wed, 15 May 2019 18:24:24 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-22-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-22-arilou@gmail.com>
Date: Wed, 15 May 2019 18:24:24 +0100
Message-ID: <87d0kjmy0n.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v9 21/27] gdbstub: Clear unused variables
 in gdb_handle_packet
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

> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index d678191705..8bdfae4b29 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2259,17 +2259,11 @@ static void handle_target_halt(GdbCmdContext *gdb=
_ctx, void *user_ctx)
>
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
> -    const char *p;
> -    int ch;
> -    uint8_t mem_buf[MAX_PACKET_LENGTH];
> -    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
>
> -    p =3D line_buf;
> -    ch =3D *p++;
> -    switch(ch) {
> +    switch (line_buf[0]) {
>      case '!':
>          put_packet(s, "OK");
>          break;
> @@ -2486,8 +2480,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>          break;
>      default:
>          /* put empty packet */
> -        buf[0] =3D '\0';
> -        put_packet(s, buf);
> +        put_packet(s, "");
>          break;
>      }


--
Alex Benn=C3=A9e


Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBFC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA3E2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uB0ErtZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA3E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxvz-0004Cf-SM
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:43:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxum-0003by-PZ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxuk-0003V5-5u
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:42:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxuj-0003Ra-Ub
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:42:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so879990wmj.1
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=xgEx5RrxvWRH/90Xm3rePtn/4mw+kf9KQVfbBidRDXo=;
	b=uB0ErtZmKYqPhZ9W+E7XbCxrcYxdjVYkxMZxXfIIuMvhy5RvQgJmtH8pKEAJqikP6r
	ih8etjNVkhXi+P+zzAg3zduH5OoR+LD1wdRcQtDAsnUQFCmKUg6SvpzfoYvAdXQ1DeLb
	8LbWAHkGLE+fD7XZJ27flZMqCc9XA6YWg3rbI/HYcsVF0V7suujHnqLRezfjkDtBhWNa
	Oka2at6UZJc795bln18HbRaXIOfbI7B2DNbPhd96sMBN/RTFiy2BLdoHC+o8REzEcrqD
	9MYxHtXUrGcdz9sZ6mEMDr8eWcdIxpqLFr7pc7lnBUhAwqEjP2gz025fRNX4gk9grFQH
	D26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=xgEx5RrxvWRH/90Xm3rePtn/4mw+kf9KQVfbBidRDXo=;
	b=InIUamqlxoqdJ2NGtSjP79xBJ5LDpILtVknlUHY1OcRUdgTWOtXpyPBja9x7RFjNxV
	CTCWglOt/M+K8PitTB7X+jL+jaKI7gOKssQ7tLDEzPtu8h+K+5h5Np2U5IqPma00eMYt
	fWE9b4XEsR+5AtXAPecf79/iE+7aLzhXWvbOzEZkGKB+GzzMt8TbVNgUCiLKGuVx6OO5
	ICPUHVUZrfSM1aowVTJ2ZejNtFn3OIrRWYW1PfdQlIYU1k5z9VwYnJK4TNXWE7MgpRKn
	Q34OSJPaF0oH4RZl+Td4udwNWNiWJI0avE5wniPgOh65jY0RgTpIq62CQ6APt8SP4n5U
	pH7Q==
X-Gm-Message-State: APjAAAV3vXa23JC0UX1zfAflHG6Tv4e8OwZHUnPkzeunBg4i3+6ymfsG
	jpe/obznLESzaZtuMOjrrvrl8g==
X-Google-Smtp-Source: APXvYqxZcN+NrDIGYF5/IJxtU6/LfjwxXtbj65RnG9EweoSXrdppcOMRPynk6kBD9wWKVDIub9Sp7Q==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr15619699wml.7.1557942118908; 
	Wed, 15 May 2019 10:41:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c20sm3438430wre.28.2019.05.15.10.41.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:41:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C90241FF87;
	Wed, 15 May 2019 18:41:57 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-23-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-23-arilou@gmail.com>
Date: Wed, 15 May 2019 18:41:57 +0100
Message-ID: <87bm03mx7e.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v9 22/27] gdbstub: Implement generic query
 qemu.Supported
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

> qemu.Supported query reply back with the supported qemu query/set
> commands (commands are seperated with a semicolon from each other).
>
> gdb> maint packet qqemu.Supported
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 8bdfae4b29..00c07d6ec0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2127,6 +2127,11 @@ static void handle_query_attached(GdbCmdContext *g=
db_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, GDB_ATTACHED);
>  }
>
> +static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *us=
er_ctx)
> +{
> +    put_packet(gdb_ctx->s, "sstepbits;sstep");

To maintain bisectability this response should be extended as each
feature is added.

> +}
> +
>  static GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
>      /* Order is important if has same prefix */
>      {
> @@ -2203,6 +2208,10 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
>          .handler =3D handle_query_attached,
>          .cmd =3D "Attached",
>      },
> +    {
> +        .handler =3D handle_query_qemu_supported,
> +        .cmd =3D "qemu.Supported",
> +    },
>  };
>
>  static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)


--
Alex Benn=C3=A9e


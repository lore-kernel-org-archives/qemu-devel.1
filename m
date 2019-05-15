Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCDBC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8CB2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypowBj58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8CB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQy1H-0008RP-8L
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:48:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxxT-0005YE-LN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxxR-0005Gb-LS
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:44:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxxP-0005Bk-NN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:44:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id o189so919059wmb.1
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=TcwrMWwdJof5qFv+/Qa6hbmxZa+HfUpUkitfi1xZ5Qw=;
	b=ypowBj58apjP8dVZkCR1UHHFzhYyz2bTrDpPmgGLjFVaW7Qg0YjePKc23I8yMYkidD
	Spy/1Q7E9fk9HNpl9AoRTRwr6XQvJf2240WWPbxalhgsnjNYxPv56pyw0cedhmMPAX5U
	C2XJSWNE7munu4pQJ/JgMj44FhammTyt7n5fVlqPS0Z6iVVguq8ib1c1KQdR3ury5aiC
	7b1CCw5YP4MNOEDkmw/DXT4/WFjGi+SGSeFZJZwIuKN+eJE7m5fvrU+U8ntJhZFu4Yvg
	GE268hGuyF3P6LO937k1X5OU0Fl97kJoRxgk95wyUBq6/69Annrtxm7giJ0tIySrb2uC
	hIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=TcwrMWwdJof5qFv+/Qa6hbmxZa+HfUpUkitfi1xZ5Qw=;
	b=F4XQWdzP5tKuxCGakGBFB+oyZDfojqi4vQD8xi4JWtD3CKfVlmqwjGC+AR7+MEA7dA
	a1D1ktZPgvK+cFzB4jp1AVEV07Om1mifDDhqkWaw0TX6hGLkfRDqyV/IkB2ckJ7uUiQt
	YErWuhlRo75fuLUJkJPRd43jAggsi86+Utdi9RgU9VxBnjIXUs9sPAgV9JCt5ja4T55W
	9+44vw7RrYdxY4MpIXhZUEdABswk0/zf2cL1IxSq5mNlJ90OO5XxvLAOmm2+SruT42Bv
	AJIBjR7A0TsifwmK6JlBdOpiyfkngacpIpWfXBxezL5thz7tLVnOqXayDGc1XW9fWoER
	ATJw==
X-Gm-Message-State: APjAAAWE/03FxeADob+C9MTLnPkVI305TqeUbx3yaE7wZxoxKiL7IY6d
	yof05odiIoctDkIeCylbaYx0pmBSV0o=
X-Google-Smtp-Source: APXvYqxVAI2LWPZ9C7gNYfWvgd0m3JbyKyEVuxMHuSz3F9BexlvtW10KWmtifCstkJg67r6M2oVGEg==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr23146710wmj.32.1557942283437; 
	Wed, 15 May 2019 10:44:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f2sm3369439wme.12.2019.05.15.10.44.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:44:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 58F2B1FF87;
	Wed, 15 May 2019 18:44:42 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-25-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-25-arilou@gmail.com>
Date: Wed, 15 May 2019 18:44:42 +0100
Message-ID: <87a7fnmx2t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v9 24/27] gdbstub: Add another handler for
 setting qemu.sstep
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

> Follow GDB general query/set packet conventions, qemu.sstep can now
> be set with the following command as well:
> gdb> maint packet Qqemu.sstep:Value

I;m not sure about exposing internal values to a protocol like this.
Maybe text based flags would be better?

>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 88ff6224e6..34da10260d 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2260,6 +2260,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] =3D {
>          .cmd_startswith =3D 1,
>          .schema =3D "l0"
>      },
> +    {
> +        .handler =3D handle_set_qemu_sstep,
> +        .cmd =3D "qemu.sstep:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },

Hmm the implementation seems to have gone in earlier. These should be
together as a feature patch (along with changing the query/probe
responses).

>  };
>
>  static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)


--
Alex Benn=C3=A9e


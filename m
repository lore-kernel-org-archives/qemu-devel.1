Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A400C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB49F21473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0L2TDLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB49F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQc9S-0004eJ-RX
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:27:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQc7a-00037y-Lm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQc6J-0006LX-IZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:24:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQc6J-0006Jw-B8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:24:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id f8so2474823wrt.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=RADhbBuE5RfT5cw48fawSD6DvBE0/5p53QDlsTfuiwM=;
	b=D0L2TDLVE68se+4VXoLRLI1b+MSQOUaqjvkrUjeAJmhMhq3BiwhGiD5qh44w+8BWpo
	TEQuKqd/865v1NiFGNHnmhtVkc/5o5X07yu2Lzzvxw+3bmtNWcJnGcLmCY3gl3kqibW0
	4Kv7w+LtTI4lLKlmbSSTd+9adQ5W0gajdvk+cWrPl653Zy9dt5nUh/4VxfThChHZsleY
	tOSnnpMk5CSsVXLoD55Mv++Kn7mPL3OhHwRFPONeOwLWiSp3m1ZqaRqboHVjtG/raxVf
	tr1zLQ6INSSCc7ZZX2fKj9fJCPY72TMz07fWU5lTA26MxV1L5menZDXj0aIOYk8AytCN
	jrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=RADhbBuE5RfT5cw48fawSD6DvBE0/5p53QDlsTfuiwM=;
	b=r+3H8R86ZPCEXVQeoTprGni6GPLRJnZUD6nOsIswngQGFxN7d33vhFKL+6PxX/V9bM
	nshbWRbZbhmNkflm1GB50b2XIpx3MhQv/7X+P74EumwxZpm2KX+xOK+xewkRl8RFobwB
	5EQPDRqAzAa5stzLu5zWczIXsgTd9idNTRdf+ra4LkA5D5hZbRRll/DcP70oJUI/mHYP
	L0sKOOcMKseTKtSPdBd7awqKSOTzH+9YdAH1NuFhtV0kEzptmlr1u6UEd030gvaUDDBj
	H51jaiEccDiK3Vr0b62q5KbWrpDQZaGZyLWqSD1bJ4j544efg6Tt34Bq/C9icYlYfQQj
	GxNw==
X-Gm-Message-State: APjAAAXzDy5QeTiP3IntDCSu/QgbebsA3IniSz0+E4Kf2pHuoYuqTcb6
	xOQ1rP32SCaNpoeLP3bBB0ngJw==
X-Google-Smtp-Source: APXvYqzxkn3wBxhmJH1TpX94jsy8H0BUczAhr0GTnrcXQSwR4YghtFCSNSEy1N3R55KoPdgpLpvLCg==
X-Received: by 2002:adf:8184:: with SMTP id 4mr23787063wra.27.1557858269350;
	Tue, 14 May 2019 11:24:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o81sm6089292wmb.2.2019.05.14.11.24.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 11:24:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 121651FF87;
	Tue, 14 May 2019 19:24:28 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-2-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-2-arilou@gmail.com>
Date: Tue, 14 May 2019 19:24:28 +0100
Message-ID: <878sv8opwj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v9 01/27] gdbstub: Add infrastructure to
 parse cmd packets
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
> ---
<snip>
> +
> +/*
> + * cmd_startswith -> cmd is compared using startswith
> + *
> + *
> + * schema definitions:
> + * Each schema parameter entry consists of 2 chars,
> + * the first char represents the parameter type handling
> + * the second char represents the delimiter for the next parameter
> + *
> + * Currently supported schema types:
> + * 'l' -> unsigned long (stored in .val_ul)
> + * 'L' -> unsigned long long (stored in .val_ull)
> + * 's' -> string (stored in .data)
> + * 'o' -> single char (stored in .opcode)
> + * 't' -> thread id (stored in .thread_id)
> + * '?' -> skip according to delimiter
> + *
> + * Currently supported delimiters:
> + * '?' -> Stop at any delimiter (",;:=3D\0")
> + * '0' -> Stop at "\0"
> + * '.' -> Skip 1 char unless reached "\0"
> + * Any other value is treated as the delimiter value itself
> + */
> +typedef struct GdbCmdParseEntry {
> +    GdbCmdHandler handler;
> +    const char *cmd;
> +    union {
> +        int flags;
> +        struct {
> +            int cmd_startswith:1;
> +        };
> +    };

This union seems a little over the top given flags isn't used AFAICT.
Why not just have a bool cmd_startswith for now? You can always expand
the structure later if you need to.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e


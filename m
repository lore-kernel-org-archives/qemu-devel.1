Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F904C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B93B21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJto2Tqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBTR-0003sW-AP
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:59:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVBSg-0003bI-2Z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVBSd-0003Xa-Ro
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:58:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVBSc-0003VH-13
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:58:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id f204so15333467wme.0
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=mKnh+3d78vie1QJTDRdq2u0je9n7tu4k6+l8Hwhnyys=;
	b=TJto2TqhEnZBxDNyu6tLSI3RDRXU3F/6HGgsd680N22zDK5xX51Cy6TELNs6p7XwGD
	4kHYpHUux460JSz6u7seBKt6CCCwoU/aeL+WlMfv8BliVdzJzuGnkoDMrC90U+4DfOj2
	7miNbhD56J/ed3szhBiB2n1Yr1PH+ThYiucdwPEyTfZ+4hJ4ReVyJAhsbmoRUobyQi81
	uV2IszwJriHrfDp0dxJG1hxafmDGiMe1cOTQ/omHhIxfGch4hRJPzU64A+gBmWMnbX2b
	z77vhLD0Fw07kGfkcE/CSzvJxnwlRwA9kumfq0ikrROTv6u5bLf47kDJEnk1XYJnPBQQ
	Dd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=mKnh+3d78vie1QJTDRdq2u0je9n7tu4k6+l8Hwhnyys=;
	b=KfMxJlRVFuogVTOUBIDA7AI27HhNayhGMJakHiUreBi62wOf0dKouZxbUid1FPh0Hj
	zdT19jI7V/FsAc+dzbj1QJqjyoiqy/EU1MnxZo8+lhSbj38pwdxylbuMCxSBFsC3SNnZ
	unGFWugcbwRqD5MWmVT+O1NX0397sX/GNs0Cg8Jf6tIiYenbn9iw5WFxZRdqsbK41tOE
	EjcPkSydb6/z/GI0b8rIt4ErzuxiQPUgffQb0zWuV8d7ydup44Iqilt/0Wky2YEBD4gJ
	FnVMR2qoU8sIoHwBlhCJFUIJXNx3+nkkrPZ+mQmGcl2dWPHw3hUZym8fty+J1YFmOrK6
	aL5w==
X-Gm-Message-State: APjAAAXirdudUDhL1paSTpV9NawPDY+GDdkirBw8zQ8OUC9jDpEy926O
	YCKVWYZpC6dN9RTUiaFM7g+pHXBtC2Y=
X-Google-Smtp-Source: APXvYqw3bEmJy4qf6ns45DnUneBOU350EGqUsdl/Fif+r9mA9hbkFPy9cXdJDo2AbtNg2o5TQpKpdg==
X-Received: by 2002:a1c:2889:: with SMTP id o131mr9334576wmo.101.1558947504136;
	Mon, 27 May 2019 01:58:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 16sm9232934wmx.45.2019.05.27.01.58.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 01:58:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3776D1FF87;
	Mon, 27 May 2019 09:58:23 +0100 (BST)
References: <20190524160118.31134-1-arilou@gmail.com>
	<20190524160118.31134-3-arilou@gmail.com>
	<87o93oqonk.fsf@zen.linaroharston>
	<87muj8qntz.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <87muj8qntz.fsf@zen.linaroharston>
Date: Mon, 27 May 2019 09:58:23 +0100
Message-ID: <87lfysqno0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v11 02/20] gdbstub: Implement deatch (D
 pkt) with new infra
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Jon Doron <arilou@gmail.com> writes:
>>
>>> Signed-off-by: Jon Doron <arilou@gmail.com>
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Hmm although I bisected to this patch which fails on:
>
> 09:49 alex@zen/x86_64  [linux.git/master@origin] >gdb ./builds/arm64/vmli=
nux -x ~/lsrc/qemu.git/tests/guest-debug/test-gdbstub.py
<snip>
> Connecting to remote
> 0x0000000040000000 in ?? ()
> Checking we can step the first few instructions
> warning: Invalid remote reply:
<snip>
>>>      }
>>> +
>>> +    if (cmd_parser) {
>>> +        /* helper will respond */
>>> +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1);
>>> +    } else {
>>> +        /* unknown command, empty respone */
>>> +        put_packet(s, "");
>>> +    }
>>> +

We can't default to this empty response until we have converted the
table otherwise we get strangeness and double responses.

>>>      return RS_IDLE;
>>>  }


--
Alex Benn=C3=A9e


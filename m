Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2469C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4C7216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niae1qW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4C7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6Qm-0007C2-Ky
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:23:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6Oz-00063f-5P
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6Ox-0008Eu-71
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:21:33 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP6Ot-0008DO-Mr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:21:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id r136so4632266oie.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=dFaoTsiJTSzJWMVHdKu/z6BrzGtnGzTphxT8juCWe/Q=;
	b=niae1qW6HR9HPA+K3s39bKRUbolClb006ghPXPKOFkSuaG73k0YYg6OhfPGzH80W0L
	JA8CueMsg0UVyN+st6D2XttVWCb4pe+NujnKCqOD9D7LeD7ij2SSxZD+biNPyMyk+9PK
	u7J2j5kRUqhsRYznTLT3rUdkdDyBsUI8MVxwb/0mLRYO+Ql+Q0sqVxnz8XONWFR7A5+o
	puouLXbzJOT1bDhrdDx91AmYnqxpgSrVwzhXe686dHGMzXzL7mA/G3FtWB+ZiQ6Ag7zz
	ylZDSSBl3nvbLexvBwkePUcTFna6kF8G/91LP2O6++NhjoZnR46Xh/qjOsmhdn8lbiTT
	vmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=dFaoTsiJTSzJWMVHdKu/z6BrzGtnGzTphxT8juCWe/Q=;
	b=a0No9zI7fDW73vAxArDBCWNx4TteMqws++bsVMOAzAzvrQkzz5TvNB/DCHVpu89QvY
	An/HoCjVjbd/YtdPZBDF6hRuh7hzF/k22n3ZTk8X/UcRoWeol3bmktIb5J4AomNzS2zV
	sx4nF+kukUk16RHZZObjrGuhfyCppEz97avxuUjFLPE/OlKzBjZLzvhOsAncVeuUvCHA
	GIDVXcUgnAlJazv0POusRFHZMK4BZGh/9p7prvpkAzCT18DJGFVyIfuvwwjz6GMN2SCn
	TWYmHW2572iIbC9kpXfuBjMqKWaZ4CVD3a7VIxG1gX/4U0/O7f67l72qs6/VpUVgC2Qj
	/5bg==
X-Gm-Message-State: APjAAAXvv/wAHjL+rFDtWfYP7LxJhYrFTLqEh2Mdbb7uN+016N40LLag
	0DCyiUtv+nmkVLlQe8eVux42s4j3/lSVDz6KxhGIFw==
X-Google-Smtp-Source: APXvYqzVwdUVuEULloKDhUnHyrj1uENXg09eSrEUk07p+9dPbuzfUC830Qnyak5NbQ0kK37uokj995M3kK/+AXjwUTc=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr5376574oib.170.1557498085561; 
	Fri, 10 May 2019 07:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
	<87pnoq4x4o.fsf@zen.linaroharston>
	<f6abf67c-94af-22a6-c648-2fdbfe73974d@linaro.org>
	<87v9yibe13.fsf@zen.linaroharston>
In-Reply-To: <87v9yibe13.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 15:21:14 +0100
Message-ID: <CAFEAcA-Y7Jx-qyGZYzvP4mtTsi47rb9rBqd2r27hGarNLWpkVg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Only for the first one though.. that said I'm sure the write string is
> leaking when we do gdb output with whatever lock_user_string is trying
> to achieve.

Yes, there looks like there's a leak there. (The fix is
complicated because we need to check whether the string
buffer is required to hang around until the asynchronous
gdb operation is finished and the arm_semi_cb is invoked,
or whether we can free it as soon as arm_gdb_syscall() returns.)

lock_user_string is basically "give me a host pointer to the
string at this address in guest memory":
 * on softmmu, the 'lock' operation copies the contents of
   guest memory into a local buffer, and 'unlock' then frees
   the buffer (possibly copying the updated local buffer
   contents back to the guest)
 * on linux-user, 'lock' does the guest-addr-to-host-addr
   conversion, and if DEBUG_REMAP is defined then it will
   also copy it into a separate buffer (and unlock will
   copy it back)

thanks
-- PMM


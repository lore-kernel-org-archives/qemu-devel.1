Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF81C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C6322469
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So8PrMPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C6322469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUGQ-00053Q-I4
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUUFl-0004c0-1o
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUUFj-00079R-Qb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:22:32 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUUFj-00079D-K3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:22:31 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so2538900wmj.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lgc9HnwAqEhcwHeP/ylrT9ezgtM9J+lnwxwRcdIwHCY=;
 b=So8PrMPnt1dbeXAiD4CWKGTqSDJfywACdpyZFpgLIEp+zvVEt/Npof5ZdzJ96w6Wgt
 HIk0OQ9wfBMpqs+GZQw3GgOzgDq+PpVPfUTv1RIVl3p5gEGdym2La6Df8fio+Vfr0UpM
 axp3vyQjIWSQr/6cxVS0vfIx+iX0YMEfOQI9gBlXGt42AcSB5DZvTcTvSsjGyh4qds0o
 jknMkHqUGWRr5R9WEo51a4Qrm2TJb3bkyS6Wi4Tw8/SnfWMw3WYGoWIoLAlh2xAwKXnf
 ldQfxOl5ekZhwckqAZP/IRvFuqqowgcOOSQH+k2uwiqUOkqKQVGbAFtToHeetJzby7l6
 OVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lgc9HnwAqEhcwHeP/ylrT9ezgtM9J+lnwxwRcdIwHCY=;
 b=LLIxgmpoIUV9W35l13V2j5u4OPSp01nj4g7eedH108TY0eJW0Ghwz0QINjzlS2kEfT
 GT9nvMiR1kWi5cfe1Hq8RSkPOk7v6TsHVDyAvC26wXX9W+BV3qnTDIoLRyoSSMY+pLOK
 j6FKOCIjRuaY5j/OVVZDpbjwT/NdVQO32N5EZ8gz9ztu6GfU+EStfoaE6+wupGNLx1dd
 dJRx4nf96Jbz93KnYru1OCWnMWUtPBSecWZlDqIrOrVDNhtFXdugMozxw4Igxw5v/68d
 9CFDCViDLFSgyltZacEsf9oVo9WFIhIH5+lUuhieC2adi8+sZRHObUTW5W8/ETUPNs+j
 +UfA==
X-Gm-Message-State: APjAAAWxH+uDTpnUUmChsAB8wvk0Ej+Egq8WsTIhTSTUJg11glmC3j2u
 bBIJJ3PIMswyleQTSVxPwPuAPg==
X-Google-Smtp-Source: APXvYqweUHkzcYcmTKHU1sPLnz3haU7RUEKF2WterCcZ5xnFMjLVAv/Hwrkqqhbqq2s1YZubEsuVZA==
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr3565015wmg.177.1573557749428; 
 Tue, 12 Nov 2019 03:22:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u187sm3067052wme.15.2019.11.12.03.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 03:22:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADB881FF87;
 Tue, 12 Nov 2019 11:22:27 +0000 (GMT)
References: <20191111203524.21912-1-eblake@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
In-reply-to: <20191111203524.21912-1-eblake@redhat.com>
Date: Tue, 12 Nov 2019 11:22:27 +0000
Message-ID: <87zhh18hl8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eric Blake <eblake@redhat.com> writes:

> Coverity warns that we store the address of a stack variable through a
> pointer passed in by the caller, which would let the caller trivially
> trigger use-after-free if that stored value is still present when we
> finish execution.  However, the way coroutines work is that after our
> call to qemu_coroutine_yield(), control is temporarily continued in
> the caller prior to our function concluding, and in order to resume
> our coroutine, the caller must poll until the variable has been set to
> NULL.  Thus, we can add an assert that we do not leak stack storage to
> the caller on function exit.
>
> Fixes: Coverity CID 1406474
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>

It's a worthwhile documentation of what's going on even if it doesn't
shut up coverity.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e


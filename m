Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E730C4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1B420693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFQDJhtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1B420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MtB-0002EL-FL
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Mrk-0000q7-IG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Mrj-0000cS-FN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:02:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8Mrj-0000c4-7A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:02:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id q18so6948920wmq.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=S0d1i2cQHD9HXefS+Cbwq7p/inW6YG+OxXckcnHHP0Y=;
 b=UFQDJhtI0yaXYQZfdCNYINXM6gsZjqVFptBRX2kUFR1dmxGuHyLOilLTXotetchv+j
 0Gh7GtjzRarnOEr8yk68WgRdN6XT+pOupcfZUhwfiC6qwpOEZVP84hNArPbqM1UVE3Zp
 cKUcR/pzo95elmneQ0HSdTchzBwuwe84Jn8nHWa4H/MdFG8GNoXKnpGVwrsWSKosm2ev
 Qn24Pxs7/CB81PspwxqjrsgPJUj7Gw5N+IX8+N7JndlKhJxiKHhQ0Cj+iBiKVsxyrVOI
 uZQUUQZtw7FZjlkXhQmhLz3IJWN9UY6rv9MDjDL95meY3ew/PcK7eJnenWKAR/EA1XEF
 p19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=S0d1i2cQHD9HXefS+Cbwq7p/inW6YG+OxXckcnHHP0Y=;
 b=tEcyujFSfTeN6JjpY2lS7NHpZOitBo0oA4qEmeT2koeBPs2YegKk3P4GKWlrm4oEcj
 o0KaiHHG0huun5lShV5ZFgsEIDVsND0CQbgOAwSBdDoQgdnzvGLCCGiTWDRh1aiZG7n5
 +UAE4SswpB1nK+irRIU2PdG3iMXjYcf4W3Ae3/KLuOOxs6Fj0s2Xmm4qRvz2BFiH/8Jf
 SmTl6oP9itAqYqM57OdB8yHfcWJNwZasL/4L7m4k1Az7y1vcRLGOcu+vHtNxaV7LfqSV
 gsWyUsgT3TcAluJoS0D2Rysi4utYyN2esH5OgFJVVRbPUPw2UPQkg4B4pC7rDcsRNDWx
 +DBw==
X-Gm-Message-State: APjAAAUYxOMKW7BnNO7T5pIi2F74KvOgP5toXUii4gl50GjhnR5R3vBO
 /kwq+X7HDvzfqOiJ+kVJxQJPYw==
X-Google-Smtp-Source: APXvYqxsmd6h4OrV7vZu2xtwug1Tn2wa4vFIxhdi4E+bA8S3KgmDEYt8IiZOthxumP1hOQLeOjaYBQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr7680392wmi.62.1568286137574;
 Thu, 12 Sep 2019 04:02:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g15sm4611183wmk.17.2019.09.12.04.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:02:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 469A11FF87;
 Thu, 12 Sep 2019 12:02:16 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-4-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:02:16 +0100
Message-ID: <87pnk5zsjr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 03/13] target/arm/arm-semi: Make
 semihosting code hand out its own file descriptors
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Currently the Arm semihosting code returns the guest file descriptors
> (handles) which are simply the fd values from the host OS or the
> remote gdbstub. Part of the semihosting 2.0 specification requires
> that we implement special handling of opening a ":semihosting-features"
> filename. Guest fds which result from opening the special file
> won't correspond to host fds, so to ensure that we don't end up
> with duplicate fds we need to have QEMU code control the allocation
> of the fd values we give the guest.
>
> Add in an abstraction layer which lets us allocate new guest FD
> values, and translate from a guest FD value back to the host one.
> This also fixes an odd hole where a semihosting guest could
> use the semihosting API to read, write or close file descriptors
> that it had never allocated but which were being used by QEMU itself.

I'm kind surprised QEMU doesn't already need this sort of facility for
something else. I guess virtfs and 9p have their own thing?
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e


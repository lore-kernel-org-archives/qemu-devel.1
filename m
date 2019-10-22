Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274132084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcjvTSKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274132084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN1YZ-0007my-99
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 17:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iN1X9-0006cy-M1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iN1X8-0008Pj-M2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:17:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iN1X8-0008Os-Ej
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:17:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id g7so814960wmk.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vAN4yF+WMDBLTLHD8AUtoccJ/pWPasV18VP0hsw/NFY=;
 b=zcjvTSKZXeaAw/Ys7OB5S3bTBBFCojMsxktwqoJswzPrU/3rhOB/XtDMUpO+F+0Zqd
 ErU9egN++SWk5ROyx/LsuT5Ypl02h/ulLflvCAHhXSUIbzbUfu9UpOgyBCrI/r8VpLhY
 4hjFm5Tf42rwccFWbkAOuBErulnWSO0sh0xXy8aTlfNG9Ne3kHX77hWH3da9u09lcuwf
 8gcxixg5NsLTptKPlgkfvmnYmt1POEXAgUbdur5gZhlGi+6GTIA4u3Kdmr8Wer2FN8N8
 RH/KQ8PGS4EWNZzmsdVUvNH07ATWf0ZL9oUT5V8XmaiE6MrO28fWGJmgYd4j/392aQEQ
 1VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vAN4yF+WMDBLTLHD8AUtoccJ/pWPasV18VP0hsw/NFY=;
 b=YqfY2ZWMUdZ8R8Zl0GroZVM1sL5uCMbKGiCPn5dQIipXyiFKZJ8hXIQ3ozWV78r2L/
 b2+naQK/WM3NQjbx3yHYW0UT6qAACbXZrJWE+bvrjEnvEuSosrXKBxEG0AcUvrxG/pLM
 h/IJy0O1JgJE6+E3YNkaPRc/vNJjdRK5NcPKGXLTGemU/S2igj4TCcLYu8spw9E1aPVn
 xRVNBafjTF+U8cF7djJWBV/cDhS13IUR6QmfxrbeIuMBQ4jD6oXlRtjiome+TSvdtJy0
 PQB7Mi5J99SRbCA7ZQJpOM/JoV5hw6zAxLWXsEAC4EPcnIZh5oLnF53Xx8oYhLgfkFpe
 1FZw==
X-Gm-Message-State: APjAAAWmYITzMu4tV3LBZDuD6roEbWh5E964JeJWYR1W7GPGsf/Q2Zxj
 oCEA8UJTPtA813mrKbLJZDpyVQ==
X-Google-Smtp-Source: APXvYqyC97i9qrua5Jog8ocuTKvmYjxRdtPjXO1xv/aEE/2GQp1V2UzhZcR6DzziaA2HEJoyYkSogw==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr2852828wmf.78.1571779056529;
 Tue, 22 Oct 2019 14:17:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm20023427wmc.24.2019.10.22.14.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 14:17:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03D361FF87;
 Tue, 22 Oct 2019 22:17:35 +0100 (BST)
References: <20191022191704.6134-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for 4.2 v1 00/19] testing/next before softfreeze
In-reply-to: <20191022191704.6134-1-alex.bennee@linaro.org>
Date: Tue, 22 Oct 2019 22:17:35 +0100
Message-ID: <871rv4wkcw.fsf@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is the current status of testing/next. I dropped the Travis arm64
> build due to stability concerns. As far as I can tell Thomas' latest
> iotest updates are working fine. If there are any other patches worth
> considering before the softfreeze now is the time to shout.
>
<snip>
> John Snow (1):
>   iotests: remove 'linux' from default supported platforms
>
> Thomas Huth (5):
<snip>
>   iotests: Test 041 only works on certain systems
>   iotests: Test 183 does not work on macOS and OpenBSD
>   iotests: Skip "make check-block" if QEMU does not support virtio-blk
>   iotests: Enable more tests in the 'auto' group to improve test
>     coverage
>   iotests: Remove 130 from the "auto" group
<snip>

I'll drop these from my tree so they can go in with the rest of the
iotests stuff.

--
Alex Benn=C3=A9e


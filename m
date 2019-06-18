Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51647C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7B42085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYqaU4nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7B42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdEAQ-0008Io-Mk
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdE9I-0007e1-Ak
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdE9G-0004Z1-W8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:27:44 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdE9G-0004VA-PX
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:27:42 -0400
Received: by mail-ot1-x334.google.com with SMTP id n5so14592349otk.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9qmhK2V8t7arqCFZN1AemCdA1c9GCSOlhhVlFESWyAY=;
 b=YYqaU4njgyvShbcjmL5FoVQ8boGEtyfRixjLKiqz9wg18ucsHzofqj0Oa1yvsC7gq0
 1jqsbxup/N6yWEGgMFpDBy9Io+40aDKxlHvqPJVmnXQIvkYfmDF/6pp8NRh9G50Sh9KZ
 NML9ikt+6Kk1mq5cwtseiZECTs8RqS7TQDn19PlvkyN3J5/bYrLoMGzUd7xoMoDLtmkM
 cTHn/bghGpJsy1oSLyp/UEjgclqKyI3kHJJEpNil5VD6SIpgFfgSVxw50QCxI2QUuJXL
 vX8QW/KWFdQ0S3WX4i2XKhaR6OHt8mL5/9Syn1i1oYAQHkytzZxtZ6Wkst3Kg5IZlkX+
 2b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9qmhK2V8t7arqCFZN1AemCdA1c9GCSOlhhVlFESWyAY=;
 b=TUnGljyaZm5GGCEZBkOYRatg1uiySG1LRgYU/loL/JHhQkPB6GkDwm5hTB3Q1yZh4u
 yCkPxs2OVlt4wPIHCc6LPus++0RdkxuGftIvIVoy1xHJWfcnOkIZSwRe/bRi4OUgL2IH
 M4SVfN6OiXm3XZ4iK8kNiIEBlL4KzU0yaSusi2JD3ulphZ+aaFIXK0ntvW/MmpBRKc1G
 56jjh4CzrCxcq+diL/G3DJwQDLWLAOZcXqkR4lnOTwXb+pxF2F2i02t3MaCzPpobpHvJ
 t2EP5cZ35wDJnR/N9kzsXOW9o3HibHMSh8UlVFNnIB3+1fe/FlQD7/JUJ4ruiQyPbg/A
 w0+Q==
X-Gm-Message-State: APjAAAVcl+U/OzBgJEYHF44JkgZY26mP1Yx8GJ9hmsNiQ4orLT4xD2G8
 odyI9BPxuVJnfKDpQhfSxrkERslenuD9p4JNErzt0Q==
X-Google-Smtp-Source: APXvYqwrU3mLS56JWjd5wMSM+Lez52DeORV0+355v8kmg3N8EwO/lifWMvlh6iAITG7zff+6ujTyhSh0bBhksmn0Bds=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr23526491otn.135.1560864460360; 
 Tue, 18 Jun 2019 06:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190611171456.23444-1-ehabkost@redhat.com>
In-Reply-To: <20190611171456.23444-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 14:27:29 +0100
Message-ID: <CAFEAcA8MO=g2_ce9JGuUafYJRxpsTjQetYXRannYGbhTv_dYHw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/6] Python queue, 2019-06-11
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 18:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes from 2019-06-07: Python 2 deprecation and Python 3 check
> for 3.5+ were removed.
>
> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b7=
62:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2019-06-11 16:02:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 6d7a134da4afebe8551a69329478415cfb4cbe91:
>
>   travis: Make check-acceptance job more verbose (2019-06-11 14:13:09 -03=
00)
>
> ----------------------------------------------------------------
> Python queue, 2019-06-11
>
> * New boot_linux_console test cases (Philippe Mathieu-Daud=C3=A9)
> * Make check-acceptance Travis job more verbose (Eduardo Habkost)
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (1):
>   travis: Make check-acceptance job more verbose
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   tests/boot_linux_console: Let extract_from_deb handle various
>     compressions
>   BootLinuxConsoleTest: Do not log empty lines
>   BootLinuxConsoleTest: Test the SmartFusion2 board
>   BootLinuxConsoleTest: Test nanoMIPS kernels on the I7200 CPU
>   BootLinuxConsoleTest: Run kerneltests BusyBox on Malta

Hi -- it looks like the Travis check-acceptance run started
failing when this pull was merged. Could somebody have a look
at it, please?

https://travis-ci.org/qemu/qemu/jobs/544724911

thanks
-- PMM


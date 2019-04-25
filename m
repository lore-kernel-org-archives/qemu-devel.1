Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE104C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBFC206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2A3q+Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBFC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJex1-0004Jb-Tv
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:02:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJega-00067h-Gp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJegZ-0002nI-JS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJegZ-0002m3-C3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so7826692wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=7Rdr+2prk79GSiVzQlNowAT1lxEf1X9LGvL2XtYKt3E=;
	b=w2A3q+DfMHD2ICAEfUlBI8+NxyQdKFDC4LGitfZPgEhCbF7GwKp3K6GkOepGTgGpXK
	MO6akM2KGI17XV3irjki78T/EHJu5hpXl23DPMEBsQVgegSVcpbb9KOK9g57CcKBzSR+
	KYqVquFXR6BMuzF0ZWHEOigfJnel0Wq57iskFVYG8/xKC17qafmYcrI43hYKksGIHWAd
	qtjAcahGxCQjKulVi5LpcGRjfHqt3eoUorPTIXvPTS260h5KGh77scroPbYIaDJsOGBW
	srpF5nusazkSXrxbXsAScaHE0zJqsDvJlCfETMbByDIVfsRqtaLmzOC/WW0Y9GBKoJjE
	1jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=7Rdr+2prk79GSiVzQlNowAT1lxEf1X9LGvL2XtYKt3E=;
	b=tSS9PgKTBTYbCFxyY/rtbX10NSAaUV9RJU67bcEKcCS7qu6vYw0qiGYF4+jrnDxugp
	suiK722D0e1sYwuvb70LL47pQD+RxvWlXvDbotWlKovWlq6RNA8fFpnZMoodRMgkvS9v
	n3uNy4/+UwaWwXPgptWuugPf0muKac92gnQBoxkoL/SKUA4qX/1sCHgk6Ydq/FJX26bv
	iKmR6p+UxzoC3u7IGWFtairEmF9QqTG3CJg/JBDadIYz40/arM4Ct0BhYRJhnD+79vgy
	MpYYG5o/rlzrLaOAix6R6JFpJIaatWV0e2++h/nBjd2D8rIgvdHj12k5h9lqsgyGkNJj
	smgw==
X-Gm-Message-State: APjAAAU3PlwOmgJ6tUKX68GtjpgTnxPu3LUCWIqcc+uxhJCfREZiXZiU
	v/orTCyuzNKfvdB/sklNnFSB8Q==
X-Google-Smtp-Source: APXvYqzGwAU8HmmwDhoyQtG3/Vp0v53xDKWSBvNbklDw8X4nWp/tRiVOe+d+5rGIZAzohXh0j0r4fA==
X-Received: by 2002:a5d:4b92:: with SMTP id b18mr3181781wrt.11.1556199909895; 
	Thu, 25 Apr 2019 06:45:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x192sm35792073wmf.48.2019.04.25.06.45.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:45:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id ADB5E1FF87;
	Thu, 25 Apr 2019 14:45:08 +0100 (BST)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190408182748.1238-1-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:45:08 +0100
Message-ID: <87y33yurkr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425134508.ESqmXHK5cRLSvENo7dsYQGj2mmr4SaJD3ucHyPasjRY@z>


Jan Bobek <jan.bobek@gmail.com> writes:

> Hi all,
>
<snip>
> Thanks,
> -Jan Bobek
>
> P.S. This is my first time using git send-email, so please bear with
>      me if something goes wrong and/or let me know how I can improve
>      my future submissions. Thank you!

Looks good to me. Excellent first patch series ;-)

I assume you'll post a v2 once you've integrated Richard's fixups to the
appropriate patches.

Have you had a chance to look at getting a .risu and risugen working yet?

--
Alex Benn=C3=A9e


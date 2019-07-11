Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832AC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718D720665
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYlac6r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718D720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXIl-0007iR-6x
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlXHw-00073P-Ve
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlXHv-0007Th-US
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:31:00 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlXHv-0007SS-MQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:30:59 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r6so5489778oti.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n9h+l7zfjbFTjzSbBjlvzaQnM98sJDFa70lf9OiwVJc=;
 b=fYlac6r6OJakJJV7Rd3BFhJp/Z0bKMpTYdjS6FxD9JV+8g8tpjDq6Uk+RTqTZWEN7G
 qXHgDsUJJ432KHYSVow1CkGRzTxyZHrRQ9U3n3u7iokoZuR67TQsLrZKhwyrCEWldooQ
 bJwWzxEQeCvorjE/NVb9hv4ENDqGGSYDjtWWayIRDp2RvFSOEFEhPbL5qAibqKKg5erZ
 hmTOJISWV52Gooy4ifPIqs4CQf/qldtiB6UAEfjXQFMQM5XLBheX8cq1qgaiaQcWdeUb
 YUas5zS1AaKRQEnJkF5/M8fMgutDHPBWYmcSbIUFlezucx28ZBdDmyOtmXhmbs5B1xiT
 au8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n9h+l7zfjbFTjzSbBjlvzaQnM98sJDFa70lf9OiwVJc=;
 b=nclc6Y7K6sXjkR25gyUNUhHo/ehhPvsROGbsuVWWi8GQK6QbvoGnjsSdInXbpe4zcg
 RE1ixmw3zxL2MajhFAZ8tA9G8zd4S3N+JXJtDb6MFjNQ/XVPASOabsojC15Xm2T+PvfJ
 Hs2wJb1foLUtBCzFPGefzRrp+LK+yKPyKkHoeW+tIqlj7joOzCs7ldmYmI/foC2sXMDR
 LGd7IxUqhteRIBtrOFghxAvc7pJCzceRFBtDfZMJ/hwPLPlrz59sxU8l53MxpnhWZj/a
 OMmfEWrZFJxhVu7yvRajxxleC8otdQtNmn0IIVO1x8r3+a8ULAR4kO04yd0OCwbglawF
 p79Q==
X-Gm-Message-State: APjAAAWI5B4R/lOAFKitALIrCYlPMXcEdE3Dg059rUy+PeZoqTXr4ykE
 Y2nPW7iIiadAylYHpZs54WNSEe1UVCLSlyP5FJbfIA==
X-Google-Smtp-Source: APXvYqwJWCXZUsYSshFsoYnQfBBZPemPZ2x/DAuk2gV6clHvkxPZwsUzJF0kDxxt+sWFr4y3b/Cl3ndDZADTwsEUd+g=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3056300otn.135.1562844658550; 
 Thu, 11 Jul 2019 04:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190710192306.28604-1-jsnow@redhat.com>
In-Reply-To: <20190710192306.28604-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 12:30:47 +0100
Message-ID: <CAFEAcA_pWT9qM-n76v81rPZiAX4y_72CYeKa3Tf9yprTnmP6hQ@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jul 2019 at 20:23, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
>
>   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to a7786bfb0effe0b4b0fc61d8a8cd307c0b739ed7:
>
>   docs/bitmaps: use QMP lexer instead of json (2019-07-10 15:08:07 -0400)
>
> ----------------------------------------------------------------
> Pull request:
>   This is a build fix.
>
> ----------------------------------------------------------------
>
> John Snow (3):
>   docs/interop/bitmaps.rst: Fix typos
>   sphinx: add qmp_lexer
>   docs/bitmaps: use QMP lexer instead of json


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


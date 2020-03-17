Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1FC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0D220724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFIrhuzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0D220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEG33-0004i0-93
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEG2E-0004Bq-6l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEG2C-00079X-2I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:29:45 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEG2B-00074H-Qj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:29:44 -0400
Received: by mail-ot1-x32c.google.com with SMTP id t28so19876261ott.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5iqfpJYNHTtuays6U7MVeaPb82O2zfD+zyN2Te24nGQ=;
 b=IFIrhuzPuR6YleqpUtB6g9tF2+zE6o95Q3P2y8L+BxqYpJrVEwXDsxm3s78ztqicpr
 SpJ36jb/+H+GvAFWP+BduzR+hrUrmaRgCMQrTcz3HaV132KchBvKfLbTOOz7CHgT/uRu
 WNDs9HV9q7EdDM7V+iRirUEm99ipW2j4eGjwxvo9EaJ+mXAsNIO26URUWpTp0Y+DCrwJ
 p2TXulD/CEVMeY0QECteCnKIMurybDsSQUu21Ur3A/l24mRznTSGvOlaOyZSZGlFmO1S
 4Cjoido/ss1T7iy7XA4pTFNR2ei03VZXLy8RV3QkdJo+wVn+4hHG8CQMH7r5mWJLz4ZL
 nYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5iqfpJYNHTtuays6U7MVeaPb82O2zfD+zyN2Te24nGQ=;
 b=MAptkZmvBeEw717+iZe6uqunXEJmP+IDMwxIHIeek3RR0fT/Xnn66m1w7Nl0EYq/N+
 jlfoDJXAx4R7IAKw6zwrurduBSQJqUX9CO08EYLbbAv0rOaLtHcwOGs6CbElGyGFLdXY
 FCKaSwZZqGm0EXhCGDXMXlh/XweaOczb/IeTSooQOz6fuGDPWvHy0SQGqr+F1v6NrP+6
 11K6Jb0aPp12cOgiajVFTpDp9Rf0Y/boD85XiasjD4WZIn7zQvidrVEVM7MSy4VBvoEU
 aNHG5FJ5MNMETm5KKBH7vgNUs/6GdnErjE59thSiq/HwGlZBKpaerCgbZU8YVdT67XmK
 K5jA==
X-Gm-Message-State: ANhLgQ33TaERx0iXdQmTHEokF4kel6c+mJI28Sli+KrUpAIRV0k9mzyl
 vY84wQ+thNxWqbRD1p2VetmRTZBqL/jezcHRS/uKVAojLWY=
X-Google-Smtp-Source: ADFU+vtkEIhrOCAGp0k7nCGq2uTU6C28KKA5KRYZWkN4Buom3Rf5A77ecXEpsI+CjB6tVFBEhTbEQBzEL8kqJWfwoWI=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr245726ota.221.1584466182527; 
 Tue, 17 Mar 2020 10:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <1584450269-26897-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1584450269-26897-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 17:29:31 +0000
Message-ID: <CAFEAcA8YezPxjq+BXqOX77t9pZNYqbkeD2-i1Jdk_yFbXyxJiw@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS queue for March 17th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 13:04, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-mar-17-2020
>
> for you to fetch changes up to c0ac595b69a71fe04529b05406b7aa958b7efb99:
>
>   MAINTAINERS: Add a file to the main MIPS section (2020-03-17 13:51:37 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for March 17th, 2020
>
>   - maintaining and enhancing MIPS maintainership
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


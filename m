Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3FC3F2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8D624690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axjqCfTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8D624690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7R2w-00021r-KC
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j7R2L-0001UC-01
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j7R2J-0006J2-Td
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:49:40 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j7R2H-0006Fg-Kc; Thu, 27 Feb 2020 16:49:37 -0500
Received: by mail-lf1-x143.google.com with SMTP id n30so549521lfh.6;
 Thu, 27 Feb 2020 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2YFo13JeBiET7bAmKbDjgEr8zneKHVMEzIGM7cv+T/U=;
 b=axjqCfTHL+XlsIvsFAdNXIttY+MFxh62SAWtkS03TIGPmti9uMjUEBqyIYuKDsxeEi
 fmCR6QC/kWPlcSD2n3I4E8lG/w2klAT5LGV3O/Cvf+M3DSJqgn/7HW9zxXCVFNNqif4h
 ooB4Q2MbxN+/tBYtOElYkIyVCTddIElGuMAg/O9nj9255fIXHmyFKbjUjV/2VHE8lRZs
 aUrRHrPay1CjDV21oZ/4FSWBHuF6xENiO6WoiytvDWCMgD5VSuqLfJHYeuN+DfSRhwsf
 SBSfDqEeFMbk1IGqDGiel7zLq1YY0sS4KMrCaZrMXXRU/CvFo2NWAhCOIKk2JCwRgRD1
 FGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2YFo13JeBiET7bAmKbDjgEr8zneKHVMEzIGM7cv+T/U=;
 b=rLFnJRyCoHfC8igSaNTR64TfzJL9Qt/vsQHd66Iit8c2djdX7+1bkFDg793hAydGCV
 Q+sMmHqEgNJnf11oJrSONzdjGNAuL2XIH3Va+YhuHnN5XY2ikQT5tL30QsO13EsjKPsW
 9B7cTcWGke1TU335/DpLic7DI+9lrEzkNR7ugI00iUAoyd7/ZoMZCYyITzh8RtZ2fMvD
 pVRhYuOYYD5a/hra/7ykXNCMOpT9y2mVDqejd3V0th/k3y+gLqdUwl3P2EV0xIweCWVT
 ESjS+idiHM/6wUsVuHitBHVvTq0RvLXnAIA3rHtUu6Am3Bz0a6A+RSP/RooZjFOUbhXb
 c6Qw==
X-Gm-Message-State: ANhLgQ0rdMBAnOdO+9lqP4cDkSEe86Os+xI4l93Ph1ee9seVDTRa9PU1
 LDujlN9DMbamXcxkNZSJx7aVAKF19a/J0LijX8c=
X-Google-Smtp-Source: ADFU+vuRjJHtVUiADyLjFTvr665nb98AzrvzkSlGGMvr0CREm6gQlyYKg43wd1dZb7l55PrtA6GVIiyvP3NScVTRoA0=
X-Received: by 2002:ac2:5111:: with SMTP id q17mr796743lfb.51.1582840175870;
 Thu, 27 Feb 2020 13:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20200227115005.66349-1-root@stephanos.io>
 <20200227115005.66349-3-root@stephanos.io>
 <88ad7129-9654-088d-6569-066949973a86@redhat.com>
 <CAKmqyKMkTsgqSEWhrkCmbQ3LMNz1OgdeHE6zFaMsZdRjAFvdRA@mail.gmail.com>
 <CAFEAcA_i9Qjvq1Bp8Me2JnUwL5bwEaUTi+8uvusNMcoc7OwfkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_i9Qjvq1Bp8Me2JnUwL5bwEaUTi+8uvusNMcoc7OwfkQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Feb 2020 13:41:55 -0800
Message-ID: <CAKmqyKNJWbf0Er=jLyr_vmrS_vDOFWz9eW8mRjFkDjk3WJHZXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Stephanos Ioannidis <root@stephanos.io>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 1:44 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 27 Feb 2020 at 21:37, Alistair Francis <alistair23@gmail.com> wrote:
> > I do hit this problem, Peter described a workaround in the previous
> > version of this patch, that is to link at address 0 instead of the
> > alias address.
>
> Do you happen to have a simple test case you can send me
> that demonstrates the bug? That will save me a bit of
> messing around when I come to try to fix it...

Yep!

This repo: https://github.com/alistair23/CSSE3010-QEMU-Examples

Run: np2_env.sh to setup variables

Then build an example in the examples directory.

That repo will hard fault on QEMU currently (it doesn't have the address fix).

Alistair

>
> thanks
> -- PMM


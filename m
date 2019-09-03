Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F692339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJPHYZzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F692339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58V5-0001Kr-Ad
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i58Sq-0007Zc-0C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i58So-0000HE-Fm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:03:15 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:35727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i58So-0000Gw-A4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:03:14 -0400
Received: by mail-oi1-x235.google.com with SMTP id a127so12672305oii.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HvVPAvT3kNOnl98ittPQxmPEYgOBNwA2DfKj4sDIT0E=;
 b=DJPHYZzEs81t9sQk7VVouh+wWREiJPTfFLn5hqARtJwGdo/8KmoZhEC5LXq1sGjnrC
 evh183Vnph8sB8DQ+SKoRePfDI87K1Sop7HD+j/rgKWPTWUFgEZSYDwdAWA2ZkdLP5Jc
 2MS+LPSJNJaGIoNZmpvIin/IFc0aTuWMGTKbnsFWtzHLHdHjaXOlsdyubrDsn5W0Lbvw
 JJfW2Bm5X9mxQRWw+uftKSfX77MV5/i+3i1VmpeKrx7bTEmqXYNdwjarp0pxg3mJN9Vu
 u7THPGmRXGy9iPmeIEuAfubkOIF+yK8Uk0ywXxOZud7eH+GOM+AVeW52gamXJdelHoks
 BtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HvVPAvT3kNOnl98ittPQxmPEYgOBNwA2DfKj4sDIT0E=;
 b=ky6HVggk9sG2l2twI/uM/hHqKNxjmRmHZLoo7gO21pDzH+JTLOIO1kySuzFr59jQns
 meakUgBOpgl1kyF7VgpR++pxg2ZaE3xXn1f3DDrtXgIIC0DQmZCzni9lwfmAYpOJVdk4
 ZqwCfJ7ESZFPf5zFsMgGPBAbfsKC4Mqnj6ayvEPbbBT7hHkEWfeC/oM6kW0Izas6BfJi
 vMtIHr6lCIvelDW2FSnlBW5fQjLVYtAddtSQHEOiNjQPSeOnBG2e2ZhaBgu/U6aZWn12
 q9o0rfuM3QdNMil0SwuyD4+NqHfwEm0qFJqWzzbK6Jt1wk+7CkVA2+Eet+m85VHgzJ34
 FG2w==
X-Gm-Message-State: APjAAAV/9AoZoVXZdasjoaZ1msIXQoG3AFuC1uoqUQOIcsthP+mO7/NA
 AQESaJx/Et67Znw7spvpGgM4R/e7EPUwmTv14CsiSA==
X-Google-Smtp-Source: APXvYqw2SGMIrT3meADGnL7F7Xswh8QaLpxsH3TwzLfsa32pQKr1AEkKUh8i9CxQ+KeP0dc33QBTcWzPm1JG9kHIo0w=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr9491086oib.146.1567515793332; 
 Tue, 03 Sep 2019 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190827203340.31195-1-stefanha@redhat.com>
In-Reply-To: <20190827203340.31195-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 14:03:02 +0100
Message-ID: <CAFEAcA-BgsEbXsDK4+W6irzMJJj-yr3q18ncLZv30Wkf=Y_SDw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 21:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit dac03af5d5482ec7ee9c23db467bb7230b33c0d9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190825' into staging (2019-08-27 10:00:51 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 9f591a5d95e1969969632ab44cf35e505c8ddc3b:
>
>   trace: Clarify DTrace/SystemTap help message (2019-08-27 15:12:36 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


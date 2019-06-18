Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2370C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F59206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaKhBIzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F59206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHC6-0004Me-MX
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdGNl-0005GY-CB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdGNj-0006BE-DB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:50:49 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdGNi-00062u-U2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:50:47 -0400
Received: by mail-ot1-x329.google.com with SMTP id p4so5665949oti.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QxQtM8Fhg0po3knQrY5ef5nPTR2bX/f1vmKCZYFXjJQ=;
 b=IaKhBIzQ+vPkxOsn1nvk6OyHwKULii0ETiWaYFdH2njzavf7A4hZdnBUGJwbsjmaaQ
 euAVv96ZHE8C6Dwd5zv9Btor4BXQHbWYBIofTx3mqdtwk9D7S1RYmOAkR1GMTqYq7jq7
 J4yuQ/6CaupDT+vw+u9cB6viUeFbR1Qj4bAlLXAqpUfg5EkXtfkIBE/jb23hR3LAeueF
 IRIV/PH946/fM5YWnbaV1rPI1fyyURKiHPT55EVW4+UiCjDJEj89u8hyT2BqzYtLI2nQ
 Efzs5dTpbkfLNkYrqV6P6S1Aj7Qo/M4tsZlvKTh0+zkA1if7/y1KYqsVHPqILPNA+Upc
 yMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QxQtM8Fhg0po3knQrY5ef5nPTR2bX/f1vmKCZYFXjJQ=;
 b=ZmtxQMXDmp9PtWLGxkfjmylAYwPIJQPLoUVBJOEsNTOifEBwDCqlmqeff0NM0hXb+0
 mgZ9mrRap47vTlRk3ecsMzelUmUA13ca1H5m+PmoiAOSEF0VWtL/RYl78+td1fLNUjkp
 Pum/8uOfx0gMBUQlMNGA4nQG4QranMYEuLbqHo+kS+P4SBCDif2Rm5aWqhf3hBScVmxV
 dA7fcTcxHCPr4KXQWd4HLqzu8KQ8LqPmzW57mk4TqI5rn6b9nF/QyQrsIw/Zw2PskWD8
 QoKkAfY4TaMDJy7qro/cFSg+cY6BCIVLemFrIVIUr1+OmWvYrHrXXDYplpZI3U1aqsEB
 4ahg==
X-Gm-Message-State: APjAAAXneLCBHl8P/YXdVFa7GjvnFRmMrXJbzLGwTK2rSAS9/edjBD/l
 edOc5kVjwnQ7XeW3eQjUeOf0q0cCGpXiWqF4YmMYrg==
X-Google-Smtp-Source: APXvYqwOc5FAq7j+NsDwEJ6AVji4MtVSXGfudClA7LPEQAKoZKl0pZ8DNRmXMuPeE8gl/ffzolz6QSGIrszwxq3LWyU=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr5847302otr.303.1560873042800; 
 Tue, 18 Jun 2019 08:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190618144013.6537-1-ehabkost@redhat.com>
In-Reply-To: <20190618144013.6537-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 16:50:31 +0100
Message-ID: <CAFEAcA-V86udi-kS6sg6W2y7z09+GdCQmWPS3stKbokOJ3kwUw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 0/2] Python queue, 2019-06-18
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 15:40, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit cdfaa2720f4a09e5254868bd1f6e33f3e9eae76f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-06-17-v2' into staging (2019-06-18 10:47:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to c21f30ebc779cd4210b488dd702b3f8653aee82b:
>
>   Travis: print acceptance tests logs in case of job failure (2019-06-18 11:15:08 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2019-06-18
>
> Use a different method to dump avocado job log, to work around
> timing-dependent issues in the arm test cases.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


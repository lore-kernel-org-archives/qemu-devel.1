Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3841C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710192071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jb09MUJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710192071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCP8V-00067W-NF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCP7I-0005Ov-Rc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCP7H-0000wY-QE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:47:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCP7H-0000tQ-Kh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:47:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id a49so3728562otc.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8lm+kNx1+NAMSROcMZ075p+BSlwn52aq3fNXqjdd6q0=;
 b=Jb09MUJx3G9vcl1nsGNVyNinFcZe4A0FNU6jo4eDEtMY9u3NmC4GTio/lSc86HwqWU
 1XkP+dCR7NC9gFjEbpQmSno1J2qLVGmUuCOmhd5/DcU0l+jq/AvFDI7CvabHnWp7HMHE
 s2TjkcGOd5+uADBfqkGaFEK0NqA/VEYM2LXPvGiaRQekJimfjgbG1ibcoEiMy0fYHpJi
 ntJZ9EG5NlJ9PVT0eL0GGy/wXs6ok89EcIrZ27xg0QG+X0iAADY77ATC9Zk8feUP3CfZ
 JkYtNtZ8vLMwlXYfTSKZmLaAuLHbnUDFd4+057tn4QADfJhsnIw9wWesxOiGy01T4CYK
 rsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8lm+kNx1+NAMSROcMZ075p+BSlwn52aq3fNXqjdd6q0=;
 b=gz5Wn9HKbqoG59x2dGAjCe6giEHzmDzGcLlwJpvjpe3+7CJfbj77HplS2EeCJYA+w/
 Tg7Rp63mxm+fd9KAr9Iqg8Q5orVoBZqv3u+d7opj+tzZeeQNeU0IaeVsgs/Veu0vMlPd
 yvODCu6wxT60fZqeqqO/TW5B88KwJG6nuSKTrS30+KTXp6ULObP5oUuRnw0McyB2CgNX
 JmqdMntpfEVxQADADLBggUNmYj5+rgXi0LZPZoRwPzvesdt2qoYzTlIj+05Mbnl/QgbP
 blQ/NrtCMqtuiphWEYX7wXeJD4vdHM/3rjXm66heOG88vhIBiti4IG/OGCSe8tpiO5gy
 /VnA==
X-Gm-Message-State: ANhLgQ3TAHeqnhbiK0ehpS743pQQDaZRCJctx5x7bTYd+ZwA2HfB15YN
 GKW83COtXLzkLlhfXpajiHon1Sc3TVCakSN+JxVjlv0S78g=
X-Google-Smtp-Source: ADFU+vvbcOPOh/zyPS3LZxV8BqNxIR+YDwc1Py/Wcatqp9cbvp/32e4FQQJzrMjPKEYKBeEIMuQaMxoerFGcy75nM+k=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr6684172otl.135.1584024438239; 
 Thu, 12 Mar 2020 07:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200310152141.13959-1-peter.maydell@linaro.org>
In-Reply-To: <20200310152141.13959-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 14:47:07 +0000
Message-ID: <CAFEAcA9pHZUwJLYFiiCXq-3tj31D7aWYWMgv8QgN=fPk2=uXFQ@mail.gmail.com>
Subject: Re: [PATCH] tests: Disable dbus-vmstate-test
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 15:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The dbus-vmstate-test has been failing in some Patchew configs
> since about the 6th March:
>
>   dbus-daemon[9321]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
>
>   **
>   ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>   cleaning up pid 9321
>   ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>   make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
>   make: *** Waiting for unfinished jobs....
>
> It's not clear why this is happening (perhaps a recently revealed
> race condition or a change in the patchew build environment?).
>
> For the moment, disable this test so that patchew test runs are
> useful and don't email the list with spurious failure mails.

I've applied this to master to suppress the patchew emails.
(If people would prefer to turn the relevant patchew config
off again instead we can then revert this commit. AFAICT we
lose test coverage either way...)

thanks
-- PMM


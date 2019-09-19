Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E134021907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFpu34aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E134021907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyYh-0006lE-2t
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAyWY-0004Tp-0f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAyWW-0000rv-K4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:39:13 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAyWW-0000rd-F3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:39:12 -0400
Received: by mail-ot1-x333.google.com with SMTP id z6so3503938otb.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y5B/GOqMJ71PwInQuQozQR2zkvMueHRZHDn470otJe0=;
 b=rFpu34aLTVZuG3gGNpIuNCPFlzrTJHHvmB5FDXbc58Xnn+7dni0mnqFeW0e+I2E77v
 +yxrCrlMBFsvrMBel8z9n9UMP+I/tO/21DuvFo4gxlLjL33UbZ7cWgxoySwRtg3XCJZu
 tiVF/FmorQsSxW8uv0L67PNlZGhE/On/l6J+gxDMu+16i9Fk9aPbGVV7n6BkLb9nexsy
 i+esYnJxvZOA8xasKzDgreJfLjr2+LwPFqAmYi1dE3tAWDDsp4CaAvA2hynKHbUUDpc+
 KROxseveq95vHiu+q10QshrkQlVY3+4V2tRM1YMzXQ4eWykzPKUQT383FwJL278fk8bn
 o9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y5B/GOqMJ71PwInQuQozQR2zkvMueHRZHDn470otJe0=;
 b=i2/oSGY+Fd0eOSRqfhfiboCgQ9saxvdSnb9V0/TU2m5Ob948aH91bcayMvJDstpjBa
 gCFEQZCEOncK1ERoLlcdYotSbyf/78uaw+NB8qq3Rgqm2oIRrorbBNTgfTKM/s2WTF1K
 MP0634IxaPYRGPFm8qyPmdwhGfty4KQRg876NGgR8HFIuXzd9rjaf60Pj7cnUkeX8zsA
 HffZiZqV2UShYfhKoW8RR96MPzwj7chiHRbJeIVf08832nw2Afq8oE3LlAODsaQ3jQvM
 7/KVctm533OGqs2gbwdXnkirKJ08G2utux77c+aes5rk9ZVOx5MCscQw6v8LVLDQcdXt
 hRkQ==
X-Gm-Message-State: APjAAAVIqvPTNNiZJ9wKTxIEdEzT+Wq0MUmh0zZpqD9jvCpsvQk6GLmr
 iKWeJ3mgCAv92omIkrJZ21HRgqHq2pmo+X3cY6U/Wg==
X-Google-Smtp-Source: APXvYqyRV37Ar7VH8j3x5XvMCosn14U8QrvxgBvT94qqJ0tL3M618+T/VtNxq26ISsbElRQT4BcKXowR330uRygUEDY=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr7481281oti.135.1568907551484; 
 Thu, 19 Sep 2019 08:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
 <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
 <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
 <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
 <e5956649-c691-c7f1-de33-afa2bb272a20@redhat.com>
In-Reply-To: <e5956649-c691-c7f1-de33-afa2bb272a20@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 16:39:00 +0100
Message-ID: <CAFEAcA90=bpsPhYyoYMzxCnnr8V+_dDuGXPLn5B_VqQFEu3Dvw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 16:37, Eric Blake <eblake@redhat.com> wrote:
>
> On 9/19/19 10:22 AM, Peter Maydell wrote:
>
> > Alex looked at this and suggests the problem is probably because
> > you're doing an in-tree build.
>
> Bingo.  I thought we wanted to get rid of that, though.  What's the
> status on forcing out-of-tree builds?  (I'll adapt, but only once
> patches are in that force me to).

I think the general consensus was that it would probably
be a good idea, but nobody's actually written any code :-)
(Among other things, various bits of CI infra, probably
the tests/vm code, etc, need updating to not try to do
an in-tree build.)

thanks
-- PMM


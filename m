Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E6C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70D4206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1u1OGUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D4206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8ye-0007QA-2D
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs8y7-00071T-5R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs8y6-00077c-1f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:57:51 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs8y5-000778-St
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:57:49 -0400
Received: by mail-ot1-x336.google.com with SMTP id r21so57242388otq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VOnqB8c/TWfN21tE1ezIjLYTSLiUylMjFza/99WS0kk=;
 b=d1u1OGUVizbkjGbdl3QcD5LhLId1ErK17iAxtPO1wywZajiDzzZD0oGoTzLGPbMkuN
 jK7hTmGikfkj3CTu/QjpR3A9tSapUpiS3fGYQvDONHJy2Fj5VQNSFPunOpA9Fo6y1a95
 Zg1PnfLeZPOraudw7R1f4uX0SUfpe+Fu4f3fomM0BWTB4Sc1ASXyWOcqpeAy00xcYa7L
 NhQCu6FiGLFCqRcKf/AEbotczchQdJ396VlW8OuFlDSp2Oz8kc7RNv2wJSo/aunpYGPv
 0olRRYGI8aJpY086mbYHSWWMUZ8d6lXGqbe44u9Nf+hV/iEpc4rkOsHOFEya6f4OU5wc
 cqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VOnqB8c/TWfN21tE1ezIjLYTSLiUylMjFza/99WS0kk=;
 b=Kmy5MF3s7R5qF6Yi7cs0zV+wcHUV2ZbHLctz761wTNuM+DcBLmFqDymn9BLYN7sYN3
 7Ge6vPiCpyAVBeZ4LcESk+wdDFBE4CSsQzY2Kqgais5PFOkDfmQqVejAd7zIzdcWTXOS
 wsIFkLIEmeYVROpv7lZZhMQM4Bv8i7+ZCtJTXGNS/H1yrKQotTApzUP2B1Pw2XevckNT
 eZVtMldN05K3OuC93DqsjF2sBIhwpNp1WTUkWcXqz+D9xxMWU5RxH2+tLkigxfJ07aBv
 7MCdhiiewLkZMu48lgIIkiVdUh3hB7g06nXVgyAn3tnrPUlTdR3EAUKpp9A5z6qXmfB2
 ZWfA==
X-Gm-Message-State: APjAAAUDI7L/ue1J68/G9Unh3/CVKwzZssH+pEUtPyVnWJm23mQoWE7w
 c5dY4K5cuxKyeR/3xwwzR3wyrQ4pcMW1YQ2kbUR8H7Hc
X-Google-Smtp-Source: APXvYqw3qfKIyfHCttE1e1VvBJ5c1Hg+sRSjBkGJxtwoBRx37olgsae44zYKrZqbY/y0Q/iuUXDjkupSCobtrhw0mwM=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr876771otk.221.1564419468944;
 Mon, 29 Jul 2019 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190729160959.24364-1-ehabkost@redhat.com>
In-Reply-To: <20190729160959.24364-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 17:57:38 +0100
Message-ID: <CAFEAcA-uhYXYvabV_UFomftUO5XLbA1ewkKf3BT1ozWWt5Ppnw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 0/1] x86 queue for 4.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 17:10, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 893dc8300c80e3dc32f31e968cf7aa0904da50c3:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-07-29 12:04:53 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to ff656fcd338a70c4d9783a800733c4ab3806e5b0:
>
>   i386: Fix Snowridge CPU model name and features (2019-07-29 13:08:02 -0300)
>
> ----------------------------------------------------------------
> x86 queue for 4.1
>
> * Rename and fix SnowRidge CPU model (Paul Lai)
>
> ----------------------------------------------------------------
>
> Paul Lai (1):
>   i386: Fix Snowridge CPU model name and features
>
>  target/i386/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --
> 2.18.0.rc1.1.g3f1ff2140


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


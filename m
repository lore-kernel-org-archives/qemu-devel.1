Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B92C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E9320693
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf8Ieapp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E9320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1rR-0003l9-6K
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1r3-0003Mb-GW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1r2-0005Nx-Lz
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:22:05 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs1r2-0005Km-F0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:22:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id 65so44739508oid.13
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uzGS3Zm8Gq+ewBjn3bRqGFjKSDzhWTw2y+NLYBVeNhw=;
 b=Bf8Ieappe/zEr6iTbcsSXZpTL5XvZEB/pQgRkw0bN1rpEPRZA/uTkboXaLY2iT3BiM
 vzwNhMJZ64hpmM+ifHmWmI7rlWzdn7eenDCJqtRMx5nyA8Rgi87CB0pvjz1r8POGg4pz
 fyUvx9lkn/MuAnDGnwq4QAZ6Ua1G+UnvO/tydund7YtW1D3yneEjM3WAkuyOg9sEaJ9t
 MbRGu6wjfg2HldhGA4imtE7AME6kqbVzLDNoiX7rQ8ZFX25g+VL6Qx7HCOl08iZWSqP/
 eiCCkWZFciYLPOnMbgRyJfwX6mC4rXqE7y94bcbk66X5S0esrfpvQ/QsXv+SLQKbxQgJ
 Ty4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uzGS3Zm8Gq+ewBjn3bRqGFjKSDzhWTw2y+NLYBVeNhw=;
 b=LepNwbEBMg+zZxsqZyA8oiCimVwNqiTn4LdswMnMOr4vAnULqvyLn+al1Gpkx0l18V
 urPXYvZ60vSNbjDdfeiSeFFc7jxL3TQH9hW1Urmz1K5w/PsOmnaXN2r+Qt87qr1YkvWQ
 jU8lvroyGTJ+GBh5QKiGHkH8YaI5RAmcC3ghw8OKt448xBUyq12h7g8Nkd/xhP4FTHCm
 HCqjpfLrg373s4r/g5RDK8PvIGHaoj6sRvAzGFWphAYc9b3Owh2Nlz8dIkZu14U2YtUM
 jiuScV8t2t0/QyPrQ92mbH9UWPt7hHlV5G7rbJCnRWV3//BIE5R0CKn74sFFFfOPLJWY
 6vnw==
X-Gm-Message-State: APjAAAUDuFLJV9cdDoZ/Omvni0+/IDEMIOmuI0UuLQ8ybd/l5bD+78q7
 O2ZVbiu4UMi00DgjnzVkGLGI/CS4rJ339eenak5PVA==
X-Google-Smtp-Source: APXvYqzJ9Sl+YdxZ0a0ZIPLCKZ2s5XeKSf8j4TOBiXupk5a/27/OeQl3sME/C+HD1iyJGZAfTRzBYS1QL0+GvjSsLLM=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr51547320oij.98.1564392123407; 
 Mon, 29 Jul 2019 02:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
 <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
In-Reply-To: <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 10:21:52 +0100
Message-ID: <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 09:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> There is no case where we're using per-.o file CFLAGS for anything other
> than dependencies.

disas/libvixl is a counterexample -- we use per-.o-file CFLAGS for:
 * suppressing warnings in third-party code we don't want to
   carry local modifications to
 * dealing with a NetBSD weirdness about header inclusion order

thanks
-- PMM


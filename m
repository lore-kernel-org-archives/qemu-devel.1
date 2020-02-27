Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2727C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723202468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLXQ0vdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723202468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hht-0004nh-Kr
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hgt-0003sJ-Ly
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hgs-0001ZG-RQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:50:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Hgs-0001Yd-M9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:50:54 -0500
Received: by mail-ot1-x343.google.com with SMTP id w6so2652144otk.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dCD6uI7skxdZ3eMGy82HovpQZ6JUYZZFa/SrHZzf/z8=;
 b=CLXQ0vdn+m7CBaDcLXMsGi+5Hs5p7aMGPqZevUfhrKc8RU2QU/3ZuxwtHd2tMZHdQu
 OD7PnclTx+vedkql2OeRjefZFlTJHtfDp+NgQieTZPXAMsBvywg4VS+xlD8dOWrs8iHj
 QtZ90yUjPSmfllf4GrnYdu5+4rAugxl0D9f+kbKj/yARLSWOTd6pTrw96UjvQyYPu2vH
 EixSbwbypprBUWydbP0/DrnBDuG1Rr3QkGDyOnORBwKRpk4Qr1ecMtsFcAZLNgInsyLU
 tOrluawzg5uBNiqpmr1QdGX+gUIy7q8XaD75UhFaCnuZwH5hMqGn9hjtlmL4IAJ7yYGZ
 0DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCD6uI7skxdZ3eMGy82HovpQZ6JUYZZFa/SrHZzf/z8=;
 b=S0AezWzFCoFpLmxBuJkyWt1sEckFNk+BWurYT4mqGm7myM8PiR8dUZWUlACdnlLZTH
 IITz5tFFwn2K2HFinzwfUKrLL9HHMgWaCfV2ndQ7jo9yoo/oravVLi55batPIqXXd18g
 R8SHKSruLaV3o9xXjxCwKeBYMrh+pAepDUuzEO15N6XnQPDz/gstL3paibmvr5P85sS4
 eMnD6E/+unojPKKN4FOzq8zfUb8B0eJ/OhfKqv9JzPGh18P0GeYcev+HgSKTRW5MEWiN
 0RPkX4u+VJ1YGCDr3h7/Egtr+oiqNtWmPDwRI5BRpThp24k69WezZdgPeKtovRf2XWUJ
 E4Vg==
X-Gm-Message-State: APjAAAVpHXli/fRXW0gv/mNKj2NTj55lNkH4zqnbvUk8qAW8SnUlzHgK
 wgjD+KV1Kz8p0/s9xHrmjRElv9r7svjujdlhLVqfNA==
X-Google-Smtp-Source: APXvYqy1bcua1C/EBQApGElgOJeekO5R9EsyoYeKir7r8EQAqWiX8yQJwnZ7jpI/rSDTcHFQ4pQ1Qzf0dmMmbnTR3cY=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2985660otd.91.1582804253957; 
 Thu, 27 Feb 2020 03:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-13-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-13-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 11:50:42 +0000
Message-ID: <CAFEAcA9CkOLP8ZFxNHSiQ1UkrjdCAdJiAdy0q169LLXm1x6wKQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] qemu-doc: remove indices other than findex
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> These indices are not well-maintained, and pandoc also chokes on the
> directives.  Just nuke them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


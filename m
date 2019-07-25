Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A80C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6674D21901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XudQBnDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6674D21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbcV-0001dW-BT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqbcL-0001EF-B0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqbcK-0003uo-6Y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:09:01 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:35033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqbcK-0003uV-08
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:09:00 -0400
Received: by mail-oi1-x22a.google.com with SMTP id a127so37338028oii.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0yncFcBSQXTBN4FvH5NbG6quVf/0NH8lo8zs6P5ZOkU=;
 b=XudQBnDi0e0mIMNHFqsV6HL5JNxT3fV5v2c7K8aXVGSCSh3LdxhHLCeBHr4uHIG1FF
 VWneFxxbpzRMUzvSxnp4DJ6UoI4E+mZelC+DrFWVOIwxzWhP+xeaYJfxP5USQN8PqwlJ
 qABUNmVaryPoWIrp3wLaJ2vjy2LTyYl2iQJSY01QEgfpQ/tPxxcBa0t3gYzBQKK4QBZH
 paFmiCA72+6PUGsALBysmYK/eTHhzoBAE91UgOL6FsRJ5pGz0qibJuykB1fcqaukavIN
 zfxSdaNQUdNsrQVGzMWAaLJ0wSTnOJc+clB6SjnhcWv/Jum4PjGWlItIaMxD8c05TqDj
 F/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0yncFcBSQXTBN4FvH5NbG6quVf/0NH8lo8zs6P5ZOkU=;
 b=sY73xapj6J2csjI+mT7ak/4k6sxhdeWtnUCQ2uGi2Dum9gtD5LEMNBJHeYo/MhgFue
 +tGSgorboOMZG8LFzozsQY9EzCVMfFOmUeu51Etx7YLSrPKZROYMFtAAN0ZOW91rvY+x
 chVc6duxx24VHGjeLFEjO822pbyH9SONm3LDrRUTmdP+wUXDDQsNjPtui3GxQPdR4hje
 lurFzxbAqyg7kyWhgUfpPA2htViWuTRJdf0qNQNvCUIqRRq4+dHJ8e3puP7kOuRpw85m
 rq46ciMTc8fRwc/1CeKyBlQO3pJ2Df2CNDgdaP4QedttGAdYkO4HR9Lqb1yUPZRoaLDV
 nBtQ==
X-Gm-Message-State: APjAAAWH/4xI86fb5ZeXm/FVwoW5/P+u2gYMctqjM7K52UwIJceOIrB9
 +2l71nFl3Lp9OvWJ+b+PzedeRjztyM87KuNLLjXZSw==
X-Google-Smtp-Source: APXvYqynlwsenRB0o3qLfVfqMDh9W3qE0dIAVHcctBKMXAR71WRdTIO/VwR2NL8JbqOFQkd4bGkWRREIXBLKF1h1Lp4=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr41813238oij.98.1564052938856; 
 Thu, 25 Jul 2019 04:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190724131309.1378-1-pbonzini@redhat.com>
In-Reply-To: <20190724131309.1378-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 12:08:47 +0100
Message-ID: <CAFEAcA-2oDEAy9QsTpGp+6Wer_ec9pUD4eBG1Hdmkza_g+wc7Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL 0/3] Fixes for QEMU 4.1.0-rc3
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

On Wed, 24 Jul 2019 at 14:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe=
96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6baabe5cf8d42ce6bc542fb3ec0bfc10c0ee6c5e:
>
>   docs: correct kconfig option (2019-07-24 11:21:59 +0200)
>
> ----------------------------------------------------------------
> Two more bugfix patches + 1 doc fix.
>
> ----------------------------------------------------------------
> Jan Kiszka (1):
>       i386/kvm: Do not sync nested state during runtime
>
> Marc-Andr=C3=A9 Lureau (1):
>       docs: correct kconfig option
>
> Zhengui li (1):
>       virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching scsi=
 disk


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


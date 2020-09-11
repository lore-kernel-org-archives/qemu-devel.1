Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EEC21D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/Sgo5dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EEC21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGp4y-0002jV-12
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGp4Q-0002DP-Qa
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:50:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:46545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGp4P-00037U-0a
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:50:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id a12so11268574eds.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O+NwWoXfxBvG3K6Ih3zDcyIxILtoWbkQIHcbZzBQEiw=;
 b=J/Sgo5dMKUhhg4RKzQ1/3LkY/QGB8X7bXDH8YIarK0ChZu9zGeeda8yvPYqCGznyk6
 ch0cq4GswuD4xiDH2Xu8rj1UMV2IXLAZD7Ba0TJHJqHmpZq+RXpcElCF+8Je1WONVB+Y
 DiF8HqoHUWmvUArJHtKigdsKcK8MAEhQPfkYtlbuNt0QMAzW2S7mm8kKBGb/Et7MrJB6
 8bEuOfRxOEWsDmhfweSnyafPo2hry+l1ABomEntispJRXJcTq/Hb+JS+j/Yp4bKEWTy1
 j1/d4kblctDmcj/3G1+68OfA9V5LOhExKKcleV7HYbiHnla/P3eXDE/nkSQJ4Jc7pUW1
 Fezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O+NwWoXfxBvG3K6Ih3zDcyIxILtoWbkQIHcbZzBQEiw=;
 b=JrFHhTAVC900yBQ6wqU75FXONt6/D/siPeZdVQxWjvSsG5AbcQB1X0fFEwv3XzTazl
 +hekP7Ak22UWiF0EeG61UwUGrOJkG/845LnQXKGidcFUaYUqSraDKIhS10JkskdSMcYO
 +NYvQz+DQsiK88pti+Qms+UPlzx4coDYVK3ab0XGOSaaCndI7CS7zc/PpLW2/Ygi8XHH
 CASlfwLSPrwOj6bQO3akA3lbfBAPMQvZDvMxR/Cc3tA8kNurrLYj/Tv7qU6NpKLHoF6P
 7qXNOY5158itvxgAVeXse/64njApjkdut/Euq5Xfqn10k1HiZXPeYNOKFWkNor512WvH
 WqOg==
X-Gm-Message-State: AOAM530qRSPXMxNRxvNCpXiQrOwQxF/DvKV4sP9S0+rzWGQYl3ys1jvX
 XwaBnAgXyCmJI+syUaNdfuIlULNheOU7bRSGu5EUvA==
X-Google-Smtp-Source: ABdhPJwIJYPFH3gTuNx4c7fKXKGQeibfe5HaVktSdLLnj+g0wa+ceq9mnWNdVpfcbdIlnKvxnDBIdStRLvuE0LYdFK0=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr3969313edw.251.1599853851111; 
 Fri, 11 Sep 2020 12:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200910182112.4030917-1-ehabkost@redhat.com>
In-Reply-To: <20200910182112.4030917-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 20:50:40 +0100
Message-ID: <CAFEAcA-6V3mYmz_zwuuZMNnCMAZR_KuU4PzT_O03NxS1n=hNWw@mail.gmail.com>
Subject: Re: [PULL 00/33] QOM boilerplate cleanup (v4)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 19:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Hopefully the last respin.
>
> Changes v3 -> v4:
> * Removed patch "chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV"
> * Removed all chardev/char-parallel.c changes
>
> The following changes since commit 6779038537360e957dbded830f76b08ef50701=
61:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-08'=
 into staging (2020-09-08 17:23:31 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to b84bf23c88699098973de3bdec316c796f1b3794:
>
>   virtio-vga: Use typedef name for instance_size (2020-09-09 13:20:22 -04=
00)
>
> ----------------------------------------------------------------
> QOM boilerplate cleanup
>
> Documentation build fix:
> * memory: Remove kernel-doc comment marker (Eduardo Habkost)
>
> QOM cleanups:
> * Rename QOM macros for consistency between
>   TYPE_* and type checking constants (Eduardo Habkost)
>
> QOM new macros:
> * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrang=C3=A9)
> * DECLARE_*_CHECKER macros (Eduardo Habkost)
>
> Automated QOM boilerplate changes:
> * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


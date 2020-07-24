Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECC5206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ7WHkiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECC5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzNL-0007wR-DP
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyzLB-0006iy-J4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:10:32 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:40629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyzL9-0002vj-9q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:10:29 -0400
Received: by mail-ot1-x32e.google.com with SMTP id c25so7208606otf.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+AVwACM5Pf4cD6L55W24xZp7hWVTSsDfwnZ4xBRBc+w=;
 b=UJ7WHkiMOg1GM84qpF422pi+fxaIfbrk7wZ6+P3sg7Je4q+m8rB6IBo9HKkd8kIfby
 HY+jgvWFhCY2xFfp9AQqLNWA5X8W3yXxMk1nt1ds82TF6ssR8mkqQrEBzaMxQKGEZlML
 k1FnrXxve11yWI02BS4SAFG7EIBF50auSK8nQcM5w8WLsAZXcBtwtB6jjz9u7fDpemWC
 owjyKMXjJ+JpIrf7oBFzLYb0NgE8NiOViftcx1g+K752MUWxlFOnKpLT5vSdVnOJfvDw
 vI4GlkwF4YOTUB2zQANZsJh0AHNPKpvNFd/apek2azlTAoVJCaAJFz5C3LW9J+h2TV2N
 1qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+AVwACM5Pf4cD6L55W24xZp7hWVTSsDfwnZ4xBRBc+w=;
 b=FIMu35V37e3EpaSvgsXMv2gOBli9UitaHF+pd9nlvMz38FBaTT+sdN2SCkUO6IZSIz
 jjQ9eAO3A8eMyYECQ3Yxqxf+Ut+Wd8R6kaBulO7vJyonssbpieznvhVVVQ6Y/diGsvuD
 LPvptBZDNj80fmDUIAPgZp9epY3HldBLEbJ2mFt5ljL89aoPJ0m2Ee3IO2khL+Q/p7o+
 8MuJX6ENoiFI4JPv/kDCGUznimDuTEvbOyghzZ9MTciWTXPD1oZezebQU5RjFtMIQoAz
 LyiMEyHSp9YgTBos1RxZNsBFRdSPceZBu9RTVpbAW1wGD8PmnHMVX3O6tqz9A1cyObXG
 ENOw==
X-Gm-Message-State: AOAM5334WVCZbdsSfoisVlvdhKFee21/5w3Ty0FK83ru2kJwbgCer0zt
 kqGYwfGa//B3RRMaohGuBxZKQb1yKQ/005M2BGCaTQ==
X-Google-Smtp-Source: ABdhPJxgMbSyFCU+wc/Sc0UKfbf8kSx4wbjL8RHWUpVpV7Owc3Ff6hgUlC/08cdidPR5l8uiZ+Cy0F6gl4KxlJcYW3Y=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr9476680oto.135.1595603425651; 
 Fri, 24 Jul 2020 08:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200723191327.3003969-1-ehabkost@redhat.com>
In-Reply-To: <20200723191327.3003969-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 16:10:14 +0100
Message-ID: <CAFEAcA-+uwH4D7=rZmoa5zhrn7V8qdFn-fFES4P9i9=opsOtKw@mail.gmail.com>
Subject: Re: [PULL 0/1] x86 bug fix for -rc2
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 at 20:14, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 8ffa52c20d5693d454f65f2024a1494edfea65d4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-07-23 13:38:21 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-for-5.1-pull-request
>
> for you to fetch changes up to 0baa4b445e28f37243e5dc72e7efe32f0c9d7801:
>
>   KVM: fix CPU reset wrt HF2_GIF_MASK (2020-07-23 15:03:54 -0400)
>
> ----------------------------------------------------------------
> x86 bug fix for -rc2
>
> A fix from Vitaly Kuznetsov for a CPU reset bug
> reported by Jan Kiszka.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


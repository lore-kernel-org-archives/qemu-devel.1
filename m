Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4A22071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP2sImrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4A22071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDj28-0003UI-Eu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDj1G-00032y-Rk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:46:50 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33]:33133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDj1F-0005Zm-63
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:46:50 -0400
Received: by mail-yb1-xb33.google.com with SMTP id c17so1464570ybe.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FjT5//9JSVN7FtxRKOB/lSDjjGchyoskY8uRxpcFfP4=;
 b=tP2sImrkf8IefPEtEUN6E5ZihiE64BSmVWWGe831cTpDht1MuuoPUUqd1d0qbL0oQt
 9jI9nmmaIMf/3+huIKpUpZKU8ukj8r55UNn/+ANK1sKAQDV0agxMfoyiGgQaNdYOQtS+
 CCgwl5180XuzSSsiZ8qdlVGGC8tBvD5wstc8hHCGt9tFeu1RNXkmUgR82xsEXeYHJTuM
 GCYzhvO9BLdIlNCbNtVsL019jbfREF+aOMuDr/iEswQJQ/WuxyHCWdrc+CAxmiHiwivS
 D9x7o2iQHouLX2Y1/BH0xtraP6Sh3hdijqUf1SA9PZxuoZOpW7Vup8HZ602jZ47/+Dt2
 lV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FjT5//9JSVN7FtxRKOB/lSDjjGchyoskY8uRxpcFfP4=;
 b=qzRMYiZ5c8LX2lzgxmdzpUh14J1j5dC6CC4NkOiddU5nfP8fZI4YdRC83/a9+AVsjd
 cabAoKJFgaxPloyUklgH15dV0KUdmjytzLxRGZncXfDs8K4bS+I3ivfZauR06jaIhZsz
 j33Onnto2ffwENzL7JKGA5CQ+RPsVKf3MEZZpxnJF5eqVwUI8Yj8vYbJzelLpZsM1BYw
 55H1BAWofPxD9+qc40oZxOIHOXqDOeJOfVqZqJdO6UZ/oRyqiGvRy5wRHzrGM868EIO7
 pcWtr3ARmQBuzUc+IpZcB9JhtlQ780Td3o446A4eV1TmYcbeJPbnE2jMl9aoWJr0jcze
 7vYw==
X-Gm-Message-State: AOAM5337bvXdKpgVzS8FT13uVjJsuLr1C8FdK/qssMqjAELCRnClCljT
 E/bBChCX4H1uGmQT1Hp4NxZpcxy8Qf+pdt8sGxU=
X-Google-Smtp-Source: ABdhPJw1Fn+LxVaSkbU2A8UEMTRQ4Mu6bOUGH/Ybe/FlmsWZy7zpgr0iSDyTkx3MXQZ7/epwZ41XGMGJobBb8Ohmve4=
X-Received: by 2002:a25:d946:: with SMTP id q67mr633517ybg.517.1599115608110; 
 Wed, 02 Sep 2020 23:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmUOtjEsQzUQZsARBcr9jjpEAu6Br8zozV8f8fQBxznFdg@mail.gmail.com>
 <CABgObfaVC5ts953qaJ5-0wLaF9o4BgXzQbenrY7F_SLFBR+K=A@mail.gmail.com>
In-Reply-To: <CABgObfaVC5ts953qaJ5-0wLaF9o4BgXzQbenrY7F_SLFBR+K=A@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 3 Sep 2020 14:46:37 +0800
Message-ID: <CAEUhbmXR-yqwy=j-gMVHSBZhxa3vP_7R1KnUyb8aGJ66A_dy8g@mail.gmail.com>
Subject: Re: meson: how to determine which directory applies to the c_args
 during build?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On Thu, Sep 3, 2020 at 1:28 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il gio 3 set 2020, 06:43 Bin Meng <bmeng.cn@gmail.com> ha scritto:
>>
>> It seems to me that when building hw/char directory NEED_CPU_H is not
>> defined. However when building hw/riscv and hw/intc NEED_CPU_H is
>> defined. I have no clue where to control c_args to build sub-directories. Any suggestions?
>
>
> Hi!
>
> The common_ss sourceset (and most others: block_ss, softmmu_ss, etc.) will not have NEED_CPU_H; only specific_ss will, in addition to the entire directories hw/riscv and target/riscv.
>
> In other words, specific_ss is equivalent to the old obj-y Makefile variable.

Thank you! It works.

Regards,
Bin


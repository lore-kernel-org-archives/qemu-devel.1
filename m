Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8825BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548C5206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QT7Yh7u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548C5206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjRj7-0000Fq-Ha
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 14:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjRiA-0008Em-Q2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:13:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45019)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjRi8-000576-Pn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:13:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so5249283ote.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d0OiiyKtI69FJxy2gWZkt0wIRgV7ojwd4zqvGn9q+Ds=;
 b=QT7Yh7u1FcDjoct6KkwmJ3NOot/A13Ly94HiqLIivDskn6Wnq5Prf04gq5PFbncIo7
 83Wby5C3aktRVtLJbYKmSUa8A19xN4XpmaUgJE9Wh2ufmv22se5nzo+V9G2YJmMYMgaA
 nDSahoWzrM7npnoXByImIgQd/FnzxwuEBHk6rWK7hKKS6lTe9j13lLShw/emPRGXTokQ
 JubEze0JDO8QN1F3VJHJzrfBI3TpZbYvNVd/wzbja2HBpf3xLzGWf0jstEaL46mwBTGu
 0N61V4MWleqXYwsvvnMSqukjP5JmhmuSOHXiGQngznhmlxgHryY2lEFMJKPpO8fGQsUv
 g22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d0OiiyKtI69FJxy2gWZkt0wIRgV7ojwd4zqvGn9q+Ds=;
 b=sANcSu4S6etrTUBkIFh5XwmOQiLJs4AY+A48WTCzuE0mr+M/mcoj5It4z4c/rznR4m
 hysaMCgSdMMCmuf9jfo6uerGg/I4W/MEuM/ATerAsaWskdIH5HQIbGUO8stQ20uKWBXo
 rjE4Ctpq+rcItk0BzW2R2PHThSwdkR2IzXrwYC78W0tl0cBe/Rtuh014oEz1dWVff902
 yvV87RQGHtGXaphwik5FbOXXHpM6M99MKNLbzGKmf/nPD7i4KG/JFvuMsh+sXxKB/H7J
 7AuYa4BiZNYSdF7WV68siiqjKz2BnSUxvCn+s4fDb/g27n24wGNjbeUS0LaWwz0Ex3KP
 H9Lw==
X-Gm-Message-State: AOAM530yZ4O+hYBjxj6Xs3bGghupwVeMuwHH5yLsSsnxB0YpTX00J6SU
 1NxzNVoVJMstJzhDOyPzKH1Nt/xMiGV+V5KYCrznTw==
X-Google-Smtp-Source: ABdhPJy7RSwRF+II2xQ4jjRxOwao/FqXbjMD481A4GyQcyF0nvNPbSho/kUCswBeuopGd2zp41cRQgQiluO0eLpmFSg=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr7606092oto.91.1591899226465; 
 Thu, 11 Jun 2020 11:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200610042613.1459309-1-mst@redhat.com>
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 19:13:35 +0100
Message-ID: <CAFEAcA-5yy9Gs57Cc7A8QJ=oSuUDaja+sBWt2miM5QiX65pOtA@mail.gmail.com>
Subject: Re: [PULL 00/56] virtio,acpi,pci: features, fixes, cleanups, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 at 05:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
>/tmp/par8snSu.par

>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 23fe04b63b412276c7c2f67c550961af9d0b4e1e:
>
>   Fix parameter type in vhost migration log path (2020-06-09 14:18:04 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi,pci: features, fixes, cleanups, tests
>
> Max slots negotiation for vhost-user.
> Free page reporting for balloon.
> Partial TPM2 ACPI support for ARM.
> Support for NVDIMMs having their own proximity domains.
> New vhost-user-vsock device.
>
> Fixes, cleanups in ACPI, PCI, virtio.
> New tests for TPM ACPI.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; I'm afraid this has format string issues:

/Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:759:51: error:
format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                                 "%lX", __func__, reply_gpa,
                                                  ^~~~~~~~~
/Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:760:34: error:
format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                                 dev->mem->regions[reg_idx].guest_phys_addr);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:1876:67:
error: format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                             "This limit should never decrease.", ram_slots,
                                                                  ^~~~~~~~~

(repros on OSX, OpenBSD, and 32-bit hosts)

thanks
-- PMM


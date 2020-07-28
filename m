Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D18C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E957A2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ctx1jIdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E957A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Tei-0006o0-67
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 13:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Tdp-0006Gz-VZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:43:54 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Tdo-00060T-CJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:43:53 -0400
Received: by mail-ot1-x341.google.com with SMTP id t18so15504638otq.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wsZd9wdsKXEq3Ycicng5U+6JmRAPhW3z/F7dMy5btkA=;
 b=Ctx1jIdm40ojASlWvcUPR27xSqErJQ43VgScTHVL+KKlOHPE+fuuyFWu/BEVKVJFcY
 uE0Fphg305UgbYafriQo+mb3ARrmbo7Y+kVFHfc4S/eN8jRDPAnTUBAzzxugJqs5fVyP
 HJYViJ03BSi1iulw6P8IWeez9+wXe6EqVgiSZH1o+4ZacbBVdoh2Y7GaYi5DF4ETEbnk
 sQn7SeBCgx1Ubzdx1Tx6Nr/9IAJtdDadRol8BsywzPLP6HL+QzcvpvYXl3fFbP+K3rLW
 UgboLwsfYwgmA5rz54jR56SvcnPO8/lqsHsv6LVlDPoK/75vCe/R/JI9aL+TRFAY3Q7w
 J9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wsZd9wdsKXEq3Ycicng5U+6JmRAPhW3z/F7dMy5btkA=;
 b=EFBR55oTjJ+m4nbidADZcwhYx4maQLD9FQyB+QLBy3hsp+RAXNljs1O7CjhjtE+0qy
 9YgOxKpARPixivodrw1P9stiUs/+L3fNe7MwzLCyQSzo+OgLpN5srV3Ha5eY2BwZHbXD
 +tBaWdhJyW8FTjgEt5CBkBVeq9U6JSRzUnae7aIPTwpVn1kJgJks2RA7jG7nNpj4gsKm
 p7RPtL80cQbDD3FkoTn5HBlDMM6T+mAVd6rfEr1dpXVynfA3Y9wkQsKmbOCfcj8uazm6
 JDli5x41Wxpj+nGO4IVy4bUFYmEV9kC/tMJ2gsLXNlaK83IqOXuFzTUTd96OI9liMmv6
 GDeg==
X-Gm-Message-State: AOAM533AC+eBc7vogdbifGsVgdicIxwZ2oDD8IqQK5wD1JXKRPvvfpTf
 eo32v/g1AenwVhXxAxzI4NOKkX0u9tK3VYAQkwupkA==
X-Google-Smtp-Source: ABdhPJz7GjJK9TK1FmA5jCLB9HUjdqWRPIA7Rma3RY/kl9TZtCppvtt3QVT/M6b56ltaarX+bkCq2SawNwtFAOnL5hE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr26051719oto.135.1595958227430; 
 Tue, 28 Jul 2020 10:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200728134840.1557546-1-mreitz@redhat.com>
In-Reply-To: <20200728134840.1557546-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 18:43:36 +0100
Message-ID: <CAFEAcA-k6MMKPaMUmEGRJqbhhDuYQ=9z3vdt62eumo0n94DR6w@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches for 5.1.0-rc2?
To: Max Reitz <mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 14:48, Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> Sorry for the very late pull request.  The iotest issue only appeared
> today, and the I/O path issue was only tracked down today.  We need the
> fixes for the latter in 5.1, so if they do not make it into rc2, we will
> need them in rc3.
>
>
> The following changes since commit 23ae28783f4674e98f7539d1c05d793166c2fc12:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-27' into staging (2020-07-28 09:15:44 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-07-28
>
> for you to fetch changes up to afac471b71da92d91cc56fb64c0719b8a4a2d96b:
>
>   iotests/197: Fix for non-qcow2 formats (2020-07-28 15:28:56 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.1.0:
> - Fix block I/O for split transfers
> - Fix iotest 197 for non-qcow2 formats


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


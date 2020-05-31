Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D03C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 20:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80289206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 20:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmnwEBB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80289206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfUtq-0000QA-N1
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 16:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfUtI-0008Qj-35
 for qemu-devel@nongnu.org; Sun, 31 May 2020 16:49:08 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfUtG-0001vr-Cd
 for qemu-devel@nongnu.org; Sun, 31 May 2020 16:49:07 -0400
Received: by mail-ot1-x32b.google.com with SMTP id f18so6331748otq.11
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iyMsGlq/7eT0NcUuCNB/QVFwEkWYjHYt2d2BE28FakM=;
 b=kmnwEBB62xicAYaBxdOegwhMRVyTmtHmJvRZx4xn9/NtscV4A1frlPPUwUgWA8nU9Q
 OqTWXxL7DJoEv914yeDCbN0IATpHo/xBJRyPWjPbojIzwkoBxqVh2GY9+gHDSo8gJ8CZ
 iltRaH75J83pqVGqRn3rMSuwFjoLmhaMWwRkPfX+SFMNoM2ney4A1TqNfTSNBDWjWtDC
 R5kzApDcSlJeKCOr8UGod4OkicURUybHji2OnHIHU0cvNYZ6H9+Cjn92KkGjzmekkUtM
 cCERoZu04cBtEY3OGZOrlbVL/SHMHQ1ISEhcAjBGXSyBaJoPIsJgWWQTMw7fVVyaybL6
 +LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iyMsGlq/7eT0NcUuCNB/QVFwEkWYjHYt2d2BE28FakM=;
 b=avWTUjFZqXcUEXTLIlx3DG2heW534GRPUdgn45l1E7Xt69+icjMhBWpUfkcoRGr/Mh
 chYN6sixBHIj2JoWmpSzOow5fTFAnMjwwXXHvU8plwv2yw5NX+QvS3Nwg+ixqIyJC+Ra
 F2Z3GkTi0G8NeAOUGkczMIVJfhx2rfUl1aMM7b9JjCH3c8Wj9Ws1lrZqnr4oeigK8snx
 fpjy08qzXjjvUCnGrhpyo/R5MIr6V3OrvzjqIZ4XnaTM4YapbB9mILg8h01Z7Qf9qE3y
 67mP8z06nMED0vs+xKbMxGyD7pwBt+CcS4PL4wxuVbXuCCX0oXNQgBuhLJ6HBYeOV2J2
 D87g==
X-Gm-Message-State: AOAM533ys9DSujeYO/vPfpPW4OJ3dQX1L7DZKWGfMKIMKP7PhtItpvDI
 AtzlJbPO4UjpSpCP1yWJ9PITCu8bufXf9tSmcTzYeA==
X-Google-Smtp-Source: ABdhPJyHblONxA9gZtkFHLxe0IEXdm4KmJG1RLCx5A+7vCIbZoLZ1cSzulKXo4gzhd2WcvJetxApQFzIHgEmTpI0ydo=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr14045452otb.91.1590958145118; 
 Sun, 31 May 2020 13:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200530075320.18854-1-huth@tuxfamily.org>
In-Reply-To: <20200530075320.18854-1-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 21:48:54 +0100
Message-ID: <CAFEAcA_h2ay4fPTpTP49xOOz1M5q=uLpoQ5vU2zUOwC58VkvTw@mail.gmail.com>
Subject: Re: [PULL 0/2] m68k coldfire machine cleanup patches
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 May 2020 at 08:53, Thomas Huth <huth@tuxfamily.org> wrote:
>
>  Hi Peter,
>
> the following changes since commit c86274bc2e34295764fb44c2aef3cf29623f9b4b:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plugins-270520-1' into staging (2020-05-29 17:41:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-05-30
>
> for you to fetch changes up to b809667808b1f742a85d6cce0d77800be20bcaa0:
>
>   hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask() (2020-05-30 09:17:46 +0200)
>
> ----------------------------------------------------------------
> * Replace hw_error() with qemu_log_mask() in the m68k coldfire machine code
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


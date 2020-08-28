Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D30C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7170820848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8wowcHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7170820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfAB-0004Zb-Nx
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBf9F-00047Y-AR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:14:33 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBf9D-0004L5-HA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:14:33 -0400
Received: by mail-ej1-x644.google.com with SMTP id l2so1723109eji.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=42Fgqxons4GOksjn+0OB+Sx+dKMHYJV/Twqp1+jphOU=;
 b=d8wowcHXM3X/XJp3YSp14LWaLv2dy9ivkMABGuVQQp1c77NQDTtciCzjB16qB24CnI
 RCgQTwb/WfTk1PrE8MZ5fTBudCfiUpfigmiJwufJR0KvR1KANLRahJFHuN3GK7GTHPJV
 nX1dlCX9ojCgXWDecBHWUyK1TYC6SHGFSibtlNrRK8Qdre1yxQ8AhkKDhAqX/xDBxxX9
 x8O/HJg94PY/CHivHsu/m/7LwBUz5lFuAe4CHb6MWXKnsW5oAraB/tVApbhGNkui4Rvf
 GYgTrWr+TgPHEG8kn8Y8ucXgzZguilIz2HpAsJ6XEfzkdssqGK/K05lK04QbTeCtXH6Y
 YISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=42Fgqxons4GOksjn+0OB+Sx+dKMHYJV/Twqp1+jphOU=;
 b=S+PcqeE62Yhyp8GQui6vYwYO9N15uceURI9yQ0XfDI/cMT3ZoHlqSFU/VMfi7vS52Y
 G4eZrULi9ejgjWw148kS1lsz2HN7w9fQmCahWKt0rrKBWPjzMtWWvl1zZNqjoURVb4Uq
 ZmeaEVEBQeyeDxRF/px8HxoAe8exzDVz4q4Dhnlox6D3+rJL7L4kXAr28xMZuU+qkpcL
 GFoR74otPjpueNdORqDpCJLTEbDsPXwP9V9ygfhrEJlY/A4O3cHhUQHEOwJDrZGt1UbW
 NBmdXhcYEZY2k3NW/epkhydZySj910p0UbMoZ7FviCoXksr+yQWSIsEulRGa+WsvSnyo
 hd5w==
X-Gm-Message-State: AOAM533GF2eQL+Elh+HBL+9UFTVV7GrpYFhar7LxAiWCwH7B6KYYVcb0
 7Us8WN14mhczLvjTnZ7tJQC2OIfZKgRQHM/wre3BmA==
X-Google-Smtp-Source: ABdhPJyqciG1yN7UILyiCbJtA5SN5ZtgAtwYfsxp5Wd3rWdWyZREKteceF6DUgTUvQyCb9Ck4xnRu0OdrmHipmzoKEE=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr2160714ejn.56.1598624069662; 
 Fri, 28 Aug 2020 07:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200828080845.28287-1-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 15:14:18 +0100
Message-ID: <CAFEAcA8rSCDnSvymWigeU4VPjyrEB-WMws57q0-Q3cNijQjEBw@mail.gmail.com>
Subject: Re: [PULL 00/18] Usb 20200828 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 09:13, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 19591e9e0938ea5066984553c256a043bd5d822f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (=
> 2020-08-27 16:59:02 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200828-pull-request
>
> for you to fetch changes up to 51a3da5b6398dcad7655e9cd6052eb52e6c31d21:
>
>   usb: fix setup_len init (CVE-2020-14364) (2020-08-28 07:20:21 +0200)
>
> ----------------------------------------------------------------
> usb: usb_packet_map fixes for ehci and xhci.
> usb: u2f key support (GSoC), 32bit build fixed.
> usb: setup_len fix (CVE-2020-14364).

This causes Meson to complain on one of my build systems:

Has header "sasl/sasl.h" : YES (cached)
Library sasl2 found: YES
Found CMake: /usr/bin/cmake (2.8.12.2)
WARNING: The version of CMake /usr/bin/cmake is 2.8.12.2 but version
>=3.4 is required
Run-time dependency u2f-emu found: NO (tried pkgconfig and cmake)

Why is Meson trying to use CMake here? I don't think we want
to bring in another build tool dependency...

thanks
-- PMM


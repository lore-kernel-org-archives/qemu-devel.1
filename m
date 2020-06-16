Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21352C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECC920734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUNXXPwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECC920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAmf-0002nI-35
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlAlc-0001Zb-1h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:32:40 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:43220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlAla-00056q-5k
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:32:39 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id i4so1297315ooj.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sPlLIq2GHsQqLUqC9tReo7ZRmDa6wLM9/aEI3GPriG0=;
 b=RUNXXPwmEfi/JBZpovCCZpZb5qRZwTirpoVpDG6pSDAnDTlT6sSbR1sdiEm7239b+7
 TLwEAY/Syba7XMtPHH/Bwitsyin+mhgn4dvXBF6Po5/3qdlPLDsUSGZjQwdd19vqbrPq
 PnIBigeL142g3OVlycIalV81GYOdNJK/CNrhwRoEu74PiV7I+MFYT0LcVjbdY3bBi4V+
 wxsY9XeIhf+U6syi0hW6+TAtGrA507/paRZYJ/XAK4VvEQRyW4Ote06E3gPGCr/ivjwU
 rYh4C3/QcrIJYka9ZvpY9zmuAanAQF7yJq/tSeEQMq5f8fOOPxHjzfobIsKE54YASphy
 cC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sPlLIq2GHsQqLUqC9tReo7ZRmDa6wLM9/aEI3GPriG0=;
 b=NFjiey/wruUZGcuAi5CVPhgjx/auJ0LumiPbXSLDpxiU87eQraEGt4+4we4q8s5g8l
 T9t68/YmQ7ydJEnJDpA5VgEJo+vf9qLwmEkcGi6DDLk93O1rCWVZeC9UUdoZ9X9fdyQQ
 THIndai/+ClC5YveyJFVsN7GojnPflQa7rpH2h8ZgcihBzDXo4yUGMVRfvwc3qv7pCpt
 tbgChtDonp6BkMZwdZu/wz5FVzCAZPDX/H8GpzpEQHuCDdhOXCTdXJEZ0XHibfNs1/EQ
 imP4z1Oyud6oepWCgCqB8OimPohnQtcWVdVxkg2eumjok2JkvocC9rqNhGY6BUA4MUAK
 SLXw==
X-Gm-Message-State: AOAM533AcQUf0PJ70EAHvv+ZrH7Ik77ah8DPnIBB9TWYa0mMOUXuVOfX
 Hbtp7ih0+S6a1x20a6Vp20BzBcWG/DcB0/UomCzDyc4e6QzOAQ==
X-Google-Smtp-Source: ABdhPJyc0hX4nFsLbQck7otwhCpLATLJIThxkgWe/AiK2vlcOo4YPYcwkp8YAcQMG3YjYuATFchRRi9L48vEGfjLrVw=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr2094875ooa.69.1592310756962; 
 Tue, 16 Jun 2020 05:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 13:32:26 +0100
Message-ID: <CAFEAcA-7sG8_oOL+f=Q8dSevX-c26GeAcrLU6Ah6mOApfzizKQ@mail.gmail.com>
Subject: Re: [PULL 00/33] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2d.google.com
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

On Tue, 16 Jun 2020 at 07:45, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 955aab203f932b8a7c23ff9c58ba036997cb3ed8:
>
>   net: Drop the NetLegacy structure, always use Netdev instead (2020-06-16 14:40:40 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build (all hosts):

hw/net/virtio-net.o: In function `virtio_net_device_realize':
/home/pm215/qemu/hw/net/virtio-net.c:3380: undefined reference to
`net_rx_pkt_init'
hw/net/virtio-net.o: In function `virtio_net_device_unrealize':
/home/pm215/qemu/hw/net/virtio-net.c:3418: undefined reference to
`net_rx_pkt_uninit'
hw/net/virtio-net.o: In function `virtio_net_process_rss':
/home/pm215/qemu/hw/net/virtio-net.c:1607: undefined reference to
`net_rx_pkt_set_protocols'
/home/pm215/qemu/hw/net/virtio-net.c:1609: undefined reference to
`net_rx_pkt_get_protocols'
/home/pm215/qemu/hw/net/virtio-net.c:1625: undefined reference to
`net_rx_pkt_calc_rss_hash'
/home/pm215/qemu/hw/net/virtio-net.c:1613: undefined reference to
`net_rx_pkt_get_ip6_info'
/home/pm215/qemu/hw/net/virtio-net.c:1610: undefined reference to
`net_rx_pkt_get_ip4_info'
collect2: error: ld returned 1 exit status

thanks
-- PMM


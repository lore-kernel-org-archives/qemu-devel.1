Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E30C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758182065F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2X4mIn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758182065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jos4N-0007xo-PE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jos3c-0007Ks-DB
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:22:32 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jos3a-00066e-B2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:22:31 -0400
Received: by mail-ot1-x32c.google.com with SMTP id 18so9307419otv.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8I7j0/u5s8298FZsdQj0TSVpDRr+E4w8CpszIaYzKAA=;
 b=R2X4mIn5bqytvtg35HusZMEkMSDk6SQTYDMgDWq8rl591giT+wvS/rN74+/qQgZOrg
 z/VATUBijNHtDgbx48gdCNdTAGk2DbEjaT7AIdvhu3SnGK/UbZ2crYR8tfANswc1QZrf
 g0ghPabxH2AravXDQ3PStVY0EcwQ6bAwi86ygdX2i2UCjR55yiz+MVOmm0oLulS3zJs5
 xQm3kq1zp9kQbn9hoR3w7/8YxKljfeoXcFY00VZrkVSgD8Wmnv3OUIi0zqiya9kHKLh8
 wXmP7E4wDhRdCj2ovQSUR+EOb0Gw32CeP9TNHDnok1skhRqqnZYGKRE0DK0fCSCMTU2t
 YRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8I7j0/u5s8298FZsdQj0TSVpDRr+E4w8CpszIaYzKAA=;
 b=tHcIQOcoo57VGfZ2rEycybfjTWinY9xqmfLBNG19CG2U+TmTswyeUYX2QCE54h8N1i
 zA5TiEHxyHev8CCvUTMHCYVAnwA5AJWsA+ac413dHd2oXlGMJhfQSNt6dRxcE0qt0Ua0
 eKI51ZS0qF3DqdfT63N6hykJtz3DH7moCT3iWKOAjFHRD75ReOcif4x8LbTXE2IP02gj
 bTExUFG44E8g19JTizYo3b3F+cf/xDGxD6NZfLGEKuX84Dr/jJERjbJD9wzHadPoUEwU
 tF6mxu87BasTKVdlrGWk/toBRNcXOU7D/94/f6JmS+sPLXdUjgyz4feER5ZMQMQJ094V
 ddMQ==
X-Gm-Message-State: AOAM533Yy0P7C5R56C08/8SRqtO87tDO0MhbjyJ/i5/0cOjeCRuDAcgM
 OdbRFruYV5BUgE2M7SsWrZh3nPh3RPubmS99h5wWIQ==
X-Google-Smtp-Source: ABdhPJwxN1UKsMdvEsf65hBKrqMYrE53/Td49lPv3shMWeUsnmXL6PAS2pRCNWwO253HLCztRwgw3EQ8pb3DpG89bEQ=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr3125269otn.221.1593192148943; 
 Fri, 26 Jun 2020 10:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200626135608.6920-1-pbonzini@redhat.com>
In-Reply-To: <20200626135608.6920-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 18:22:17 +0100
Message-ID: <CAFEAcA8KVKus6OZOEfxs_RKOigS=B6vK-pChi=4aKVfHxEc-zg@mail.gmail.com>
Subject: Re: [PULL v2 00/31] Misc patches for 2020-06-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32c.google.com
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

On Fri, 26 Jun 2020 at 14:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 5acc270a355120ce967ca1f1eeca0abbdb9303c8:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20200625-xtensa' into staging (2020-06-25 21:20:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 730319aef0fcb94f11a4a2d32656437fdde7efdd:
>
>   i386: Mask SVM features if nested SVM is disabled (2020-06-26 09:39:40 -0400)
>
> ----------------------------------------------------------------
> * Various fixes
> * libdaxctl support to correctly align devdax character devices (Jingqi)
> * initial-all-set support for live migration (Jay)
> * forbid '-numa node, mem' for 5.1 and newer machine types (Igor)
> * x87 fixes (Joseph)
> * Tighten memory_region_access_valid (Michael) and fix fallout (myself)
> * Replay fixes (Pavel)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


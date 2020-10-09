Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62722C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FE922251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGAwr1Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FE922251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvg4-0007SC-5g
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQvAO-0003VS-RP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:22:49 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:37398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQvAN-00041v-4L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:22:48 -0400
Received: by mail-ed1-x536.google.com with SMTP id o18so9968585edq.4
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pWu/kzTPRkIETnPK0GSVo7E3PLlSPIL400aj8BSM0ds=;
 b=JGAwr1ShsIgtaTmXxUPkKy9LWv/HdrU8mdpUboZjmEM+2mjQhjBpO9CpIgsDJjjR9J
 prLG2dPu8LraJy4doeEm9+uWpLlIKVtt0FTkS4Jj07PF8va1UNfrR+YAGXpNGn3zFJEe
 lonye8gxIOV11GDMXnpzT1l+7OWogIBJlFFOnO481gft7ipXqxiu9KhoMQY3pLUKZU8q
 JxvKMoYrT/3mx484xpQf5I4fAnFiRBUHmuPGHn8fQQtSrppOTCWVBGriTUY7gy73pSuj
 1lL+0zJfJc1nAwXZ2WOpmFlBevdAKTIAAZlm9gXvFFOgqr16oxCXDOvizAoyuJvw6CZh
 5kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pWu/kzTPRkIETnPK0GSVo7E3PLlSPIL400aj8BSM0ds=;
 b=DPaldxxBIGgvrxwXyqqDVwYp4lzZhMqcf0EmhJjlzuehx3G91n2/jgTa0WYuHOTihs
 bMfzCbD8X8KOGFJ0/o15tmGLmqK6480NAG0fmYoR+NI6geIkPvwUMynz39zsbptCDtU+
 De11G33V2BgTnzUpBOPg00cehwmc0D5Q6WSMoDmwrbL4r3orN2v8CkBw3pnY6qxbH+yU
 g3BMP/SgWnDpCa+qsVjseTxufWLPvB+gDes2bNZy3UP3SYAda6hDM/Iug7V7hU0Z5rH7
 R17X52NIarAlg72DmcryfzVp+aDaqv72aDA4ThDICuKqPMb8YOnQ1CqfAlJD2IqXXgSk
 ClhQ==
X-Gm-Message-State: AOAM530sCSqb6EhiPCkmQ8grmiK08QHUlCknK4Uuyw+7kYqNDt5zOwsz
 CRWS7dNBqErZAEHbEP1Cjde60pBOfb40zXENacJ9eQ==
X-Google-Smtp-Source: ABdhPJyUtgNjYK0QpJAj+iFauayWb6O5uEjiG2FRpgJy+XiAZMIfgmrKyKBw6mmscqlzhC1QcXj5Xg1PyAGpQgWYe+M=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr16060460edf.52.1602260565287; 
 Fri, 09 Oct 2020 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 17:22:33 +0100
Message-ID: <CAFEAcA9Bv2WtaPOmWtps+bfV8pLbqHnai__m5k5ChzXcRbowXA@mail.gmail.com>
Subject: Re: [PULL 00/20] ppc-for-5.2 queue 20201009
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nonngu.org,
 Greg Kurz <groug@kaod.org>, dbarboza@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 11:20, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20201009
>
> for you to fetch changes up to 307e7a34dc474c050f345eeb519d957a42f10c77:
>
>   specs/ppc-spapr-numa: update with new NUMA support (2020-10-09 15:06:14 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-10-09
>
> Here's the next set of ppc related patches for qemu-5.2.  There are
> two main things here:
>
> * Cleanups to error handling in spapr from Greg Kurz
> * Improvements to NUMA handling for spapr from Daniel Barboza
>
> There are also a handful of other bugfixes.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


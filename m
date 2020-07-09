Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD4B20720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYaLusCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD4B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYaa-0007hF-Gq
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYVi-0004ok-SE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:30:55 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:38149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYVg-0002wt-VZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:30:54 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id x2so422533oog.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LZ2scqa74xY7+R2DH2sIaVzQl/Nm2D5IeCM5UcDtuAE=;
 b=LYaLusCd6QgLJlnxwWAVy1JPE08A9pbOHel3zwFXK1nEkN/oR6UN18GeBkr9qpLsE1
 Z3IiVH/3F+IChLTvUJpwN4/uvonYdIobaBVCganuaBDqPXdUrlYK9q6FuWWeS2DepQ7o
 jQK74qKgtHAxFwLAN0V3RIMGBxwkot+E9i25/lUqcrxIxc00DQFMlesSsTCHHsQLRhds
 eBjhXA6hc5dufPjxFV8c2l1e21xWq1DScWVj9yGrnIpL41bt3YSRx1jqki03IM2Rcn7U
 M8azQKaV6MGAz20yXOIdv9MX4EdjugFvelujGQvWjR1VBrKA9ex2J6iabscD+ywz3bLE
 Zg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LZ2scqa74xY7+R2DH2sIaVzQl/Nm2D5IeCM5UcDtuAE=;
 b=iD/GSmgpyb4VNgM9u7ONprctfocEevSL5a6X36CrBRhereo9hVJQ4oUwER1XvTb5U/
 Os0ODhLwvLOnl1+a3BCyEiklGXc3jExrYP6k461oN8NkiA2S7k9ULPzf26ZTG4gfc0T/
 AEhAYoNV06tLaR/Dwm6MXeVn1x4MxQ3zVsNE5QWn0acMHQBRYNId3haC2Z25WzchO2/h
 I8AThfI1hioMKItrMVcohkWyAusHM1IXkoXbtZj7ZzmeonU2Mtad0jSs4zDKq7yiLbpn
 +K8r5VxSEfv6HbJiJ55HziuUnfbWIKcIk6JDXJbTW4wrPpg4v4txSStKGWBVE77LvDFs
 CKeA==
X-Gm-Message-State: AOAM533C8AfwRCoh8mlSx9zY6ROLLnF+JkMGFGKHti2y1/Y00vXkxPNA
 UTniVC5aTaGDSCfRQqL4vhFNK1qvgcjS1KX1O8euaA==
X-Google-Smtp-Source: ABdhPJwP+Harkf0RReGW9soJ9+RdpgXkii9+ctQPWT0WYdRzgTP87yZtF1VFCGEtmkbznPRES8PiOO7m36F7PY2c7vI=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr33146168ooi.85.1594308651759; 
 Thu, 09 Jul 2020 08:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
In-Reply-To: <20200709152630.GW3753300@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:30:40 +0100
Message-ID: <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
Subject: Re: Is VXHS actually maintained?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2a.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> If it doesn't even compile, do we even need to go through the full
> deprecation cycle ? I tend to feel like the release where it first
> fails to compile automatically starts the deprecation countdown.

Mmm, assuming that it's "couldn't possibly compile for anybody"
rather than "doesn't compile for me (but maybe it would be OK
on some other host OS config)".

Marc-Andr=C3=A9, what are the details of the compilation failure?

thanks
-- PMM


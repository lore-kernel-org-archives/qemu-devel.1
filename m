Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D5BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F3720723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywQX3XD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F3720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnem2-00028T-Hr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnelL-0001Mf-Rw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:58:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnelI-0006vk-54
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:58:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id n6so15857645otl.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qNJiThyqXPntnlcC3EqOQoLtt8QjHHTlq9xYcX3tzUg=;
 b=ywQX3XD+OIcFX61cpn9Gl6tsly1JtVnzTMJHnNC17e+yJWRYFd1gPRjV3b8ejViLYa
 to+4osmBGwQYcjqwMtX2R5WLa0REgAx3hnnlQkg4rctVNYZHPr4Vqfn+qnWCKuG96h0y
 6ndpTPYixDQopXgxC5a5wMdClAO2IpXEqVXkO7EJrC1LztVnFe/XUFjJD6qfJTdqkkdA
 h+O2nTtwl7onAxy4pEoaAH7qpwd5cy0xUjj2vJln0TcCQDfqye/U2grUbjNsTrCX05xY
 UIMF/rqT3i0i6OD88D2dfqFT8m8RFd0fp2FSHYRHyitEEhv6Ar/VWo66zkLiONZpXu2H
 ieMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qNJiThyqXPntnlcC3EqOQoLtt8QjHHTlq9xYcX3tzUg=;
 b=EDhvAUJQhEqubQsRT475Q0s1b79vHzbvB8jsW1Ni03yI12l/dgPRR7CFG7V8NHrtl2
 d4c8xEWxbeiJ4MVMJ25iGXrsplH6UuqF/O6CGr+ny5p0TglZ1rRx0G99+6atTjDpeW1f
 WknX8gyE7+e7ii1QpzmmcY0KdDPd+rfhKD4fd2uWiTOleogo4dnVaMzHxYWj8w2cCGO5
 1ICNGUDk7pEsQiXuSqZobiQF9SHrrm1BkQHALQ7oJKC6pLezMOI8/kvPEcLig2PJH12r
 xGAHX/teenhyQvV2L6znI0zjQniharZRnJYhbW2dMBkgnEurIESwwiqleZe9SIHg1I1/
 Cung==
X-Gm-Message-State: AOAM532VUsqbPjJW5lIhwSIR+E4qaKxpOienpM4OfRMl1bqOmGwSZBai
 DdbGczKobqXhyQSo1/Dpc3tkUWN5dzY5mx1tY1O6Tw==
X-Google-Smtp-Source: ABdhPJxSNCThsO8ylvmhttnwERW8/X4ax9R+z566N3W1Bb8SKhqA659cbDJ+ngM6KFXZK3/JngUBupwS9nk9vqOmtCU=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr16622588otn.221.1592902714661; 
 Tue, 23 Jun 2020 01:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <1592650156-25845-1-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1592650156-25845-1-git-send-email-raphael.norwitz@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 09:58:23 +0100
Message-ID: <CAFEAcA90x+7LgSgwkSs2Ah+UwKv+Wouq71K690sh9j4AROhxdw@mail.gmail.com>
Subject: Re: [PATCH v2] Stop vhost-user sending uninitialized mmap_offsets
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 00:50, Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> Prior to this change, the vhost_user_fill_msg_region function filled out
> all elements of the VhostUserMemoryRegion struct except the mmap_offset.
>
> This function is often called on uninitialized structs, which are then
> copied into VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD/REM_MEM_REG
> messages. In some cases, where the mmap_offset was not needed, it was
> left uninitialized, causing QEMU to send the backend uninitialized data,
> which Coverity flagged as a series of issues.
>
> This change augments the vhost_user_fill_msg_region API, adding a
> mmap_offset paramenter, forcing the caller to initialize mmap_offset.
>
> Fixes: ece99091c2d0aeb23734289a50ef2ff4e0a08929
> Fixes: f1aeb14b0809e313c74244d838645ed25e85ea63
> Reported-by: Coverity (CIDs 1429802, 1429803 and 1429804)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5EFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52A222400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnVLPCQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52A222400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4ls-0006T4-Dc
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4kA-0004yt-Sa
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:49:10 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:40260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4k8-0003bg-9P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:49:10 -0400
Received: by mail-ej1-x635.google.com with SMTP id z5so14275463ejw.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7SyeoWxA7MBpWtCDH8dTsDqR8vrhC9TO8Qn1lw5t9NA=;
 b=fnVLPCQQODTdDN6KhofWBXdx/2apwu9Jv0ds+LZerqpN2NouQnYNj2YRt6MTzFFqh7
 //CYCYqbmCmbbaI3eGwByY6QvxBqN3L/yTWnMk1x4SStJBUmKY+mlzKUs4JSK7jcMBvh
 RGCPqqzhlo2297wqSFkaaMkE3Xgn1swwnMthWawpYvV6rM/UN9p6IMGeSQ75z/V99WLX
 9/bc4/YF/RpwTcWOVwqmJPx+UpCS2EblJuKQlbFmhB96HR/GQ54jbXPbxEQVdDQENSEB
 C7gI34cth0Yr9NIDDK/F8RDaS6FoIRfFBg8tGKp11SQlM2jFmwbIo//vmmCSXX8dIKlR
 ThEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7SyeoWxA7MBpWtCDH8dTsDqR8vrhC9TO8Qn1lw5t9NA=;
 b=QzR+Bg2pOz+7PAGCARDkJoiZXBfBuIauTJZKZWA1sD4qb7Mhe0lhRadKrgRVyWZt0X
 tAFKDuMoUsP5TB+fgiH0pEgEDwI8A1CQjCce1fdJgdjhBw8XypXgCtKECxAiW1mcdKrP
 8Gzmd0ElmdufprtjgObbtJbXCwpqKa229WluCYdNPfWGB0EKgbzNoEyi3om50rSgK5ef
 YM6qx+RbLNep8Ghkt1vMyWoSzWH0yf+/Ein3OlpJ4FQk/e6BTAH9iuabzqceF2riM/+m
 ip+TWFPVlxXjkzj4kgt7kK1uqd+sqyQVdyuio6wIpqFD7KnNk5+wgYjzgmXaN5q+WCrB
 jL0A==
X-Gm-Message-State: AOAM533o9NyyhbUTetPbCUDrlv9D2Zo36SLcUoxSnWoseQcPQ3oISCV9
 75bt+ZM0k4c1r3sywEBUFzzJqagMIcdkPux2jClYIXctBUQ=
X-Google-Smtp-Source: ABdhPJxEGRvzf0u4umHRbi+7kX81do550cL7Tef31j2+ZBLyOrn3LgmGcWXOrywL4ZtH15xNBhvH0QkVqX/Q9xWfCVQ=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr15965584ejk.407.1603727346591; 
 Mon, 26 Oct 2020 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201026111347.252015-1-cohuck@redhat.com>
In-Reply-To: <20201026111347.252015-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 15:48:55 +0000
Message-ID: <CAFEAcA_GyCMebjuMsechjBcD-cESqrbZZU3x=9D4+6Z+AUnD=A@mail.gmail.com>
Subject: Re: [PULL 0/3] s390x updates
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 11:13, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20201026
>
> for you to fetch changes up to 3ded270a2697852a71961b45291519ae044f25e3:
>
>   s390x: pv: Fix diag318 PV fencing (2020-10-22 15:47:27 +0200)
>
> ----------------------------------------------------------------
> some s390x fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


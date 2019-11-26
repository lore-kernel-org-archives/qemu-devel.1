Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1923C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F022071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2XFDDdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F022071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZeei-0004HR-UL
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 12:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZedz-0003ku-3U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZedx-0006Qf-KP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:28:54 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZedx-00067b-Dp
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:28:53 -0500
Received: by mail-oi1-x244.google.com with SMTP id l20so17378516oie.10
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6E5Zz+nsatp7YbmGgKzLft6/AOjAeWergoVmwhS3AS4=;
 b=X2XFDDdFRYZ3m7OwYoHrPytUwSPiqLhADyZ2jeNroPU40v7FW0iiZqiE+MMjuF1s4J
 RVgMICKXon6mqtw47hM/qz0q/MkiLicgcZewE+0eDl0ZLePpGKksrXHoVh76EwkIob0l
 du4e9N75zR3vWv/LxSuMbclsgiNOyGHQI0PmnlcRW+MrgMa1RVRGgceksh3byVKM9zqK
 N76IH8g116ZkgUrpHVnPnLgpgEuIkkhVGo2ZW+KUg3OVULGTJ7sP6wO9+Ox4xlYbQmhw
 7oMox+TTH/tJYgEpTizZ3S2l9O3s8mzMcdB+f0Zmxu270VOuoGvry5pGEgRM2AjThwHG
 LWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6E5Zz+nsatp7YbmGgKzLft6/AOjAeWergoVmwhS3AS4=;
 b=Zvqn/uxpBUUMVFeEDTQgAV5D/bHG+X/uPPE3xt+xHI9FTsSluF8QMkMbaktmRDqta+
 UGFs5IEEiZVJzAp11HG1NUOxrJI2xAG613WbhNu8n0OsrJAw71eSFn3pBN5higHjqtcF
 Gv1R7qxPQivTcx5sTjd0OFFjs835ew4w02C9vAgiU+77KrLH5eWcK6bJyTUljhTvZist
 7cAR/FGsDrpce9dqgrw1/mnnQX06+52WTmkAa3mP42uW784p2RfUTTHzsXSPjFWrjw0Y
 3kAjb6cgrAaIfHX9d407dnlbKEWV5lI6EUDshkmrzHdcuYokPzUXmJcQjB700AqLoLBS
 HDOQ==
X-Gm-Message-State: APjAAAWTbClJW+jlip7bT2i+MPDtbGmZ9nvyFDJ+0zq9Qxo9q5kjBMn3
 fspde85jx+1QDJBhHOWzS2tnLj1ykJe5lvsVUCP2kw==
X-Google-Smtp-Source: APXvYqxRWh4fl51fxzNom6n6WBOYXy/ZOENpDhqmDptIx0uARzQbNvz1270rZfOJ6slLhIi2RxDtyhPv0zRfsQkEKlU=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr89260oij.163.1574789319091; 
 Tue, 26 Nov 2019 09:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 17:28:28 +0000
Message-ID: <CAFEAcA_RKRqfCbK=Ah142Hwx2VAFqMM8M52t74KadxtGdw0K0g@mail.gmail.com>
Subject: Re: [PULL 0/8] ppc-for-4.2 queue 20191126
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 at 06:01, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191126
>
> for you to fetch changes up to 59d0533b85158fdbe43bad696d4f50ec29a04c32:
>
>   ppc/spapr_events: fix potential NULL pointer dereference in rtas_event_log_dequeue (2019-11-26 10:12:58 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2019-11-26
>
> Here's the first 4.2 hard freeze pull request from me.  This has:
>
>   * A fix for some testcases that cause errors on older host kernels
>     (e.g. RHEL7), with our new default configuration of VSMT mode
>   * Changes to make VFIO devices interact properly with change of irq
>     chip caused by PAPR feature negotiation.  This is more involved
>     than I would like, but it's a problem in real use cases and I
>     can't see an easier way to handle it.
>   * Fix an error with ms6522 counters for the g3beige machine
>   * Fix a coverity warning
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


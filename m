Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF42820727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3n4KaWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF42820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWeHX-0000oO-5y
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWeGr-0000Gu-4p
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWeGp-0004eG-4q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:28:36 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:36738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWeGo-0004dl-Sq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:28:35 -0500
Received: by mail-ot1-x32f.google.com with SMTP id f10so14050906oto.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pyavKcjEa63WcrLwuhh6zmqcMhSafgE5NIvCW7eALQs=;
 b=j3n4KaWZMb0zl2xxWfbTvCEZIEas0Pq6DaJcZKAROc1GitRX04x6YVT/SV3zgfBlsC
 QKZ/FViPAdWp2tKqnnGRyM3ScQxnL0F8UHLN1/O58vrUXHvIIL/+n6YXaIebBKkLfSvn
 0B+/r++wLGSlKr+uTPsUBnDeXjudVxmdhiUeC4wTjdzeRip+DUd467IIenUN1jEGnMCh
 k5qm2XPiGTCl5c+54vmTP7louZYq6KAYSDmr1uztir9UD5T3ZCWR2qriE8dO9ISp4GGs
 X+v+isV2VH8liQ6f9FKPHfsDxhSciCbOHU471c3HxlQiHl+u9wN7tQa8XGbg6EtKPUKs
 pUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pyavKcjEa63WcrLwuhh6zmqcMhSafgE5NIvCW7eALQs=;
 b=mGp4bEqdejEExwvbeb6FK7zo41TwF0Zimohi/7BNAoi+MFz78TDWFhQOcHbacl4pYS
 ttFK+4E0WEXepF1MBEoz9OcYCahZXSkx8BrPsd/FgkrC04NbSLy9nS4/JGufhw6F2tHF
 G6ZD2RbhOJZ7vIaT4/YuWv9/Mm7uYdzEFFzTZziZS6r6Hd05iRSs5B1xX2EjvFOhdoda
 PyD216n6zohs4VjWMp+5eNTCcUnF06tmaBdKRLRHH4XMQCTpfpJ8f5CfmYOtNcACHZsJ
 KQ2awo9M8gukbt8AUtoqm9cJs8PR9Jk+QiSZzTBhhfQoa6BnHbyGbvfluNFyZ4ptUxd5
 cCUQ==
X-Gm-Message-State: APjAAAVtjIiA3zPukmiWLKU3V9PKtUo+ZorUC8IYFzrmtGt0rmC1rk++
 zAMWEyyn/28+g61tc/NI0x55EIeu9fvCgq8JUyUSKw==
X-Google-Smtp-Source: APXvYqx8Fsb+yxKsZA6HL3rPfXXSi4ipBsudrDhDhZcOT5TUi5buK4inI/x44A7Yjeg0KyKlbR98wmRJLpklQbfntC8=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr21948877otn.135.1574072913292; 
 Mon, 18 Nov 2019 02:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20191115223312.204979-1-lvivier@redhat.com>
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 10:28:22 +0000
Message-ID: <CAFEAcA_m8Ess71bubPzsur=8idBqiYpYE07chb=1atef0SMrVw@mail.gmail.com>
Subject: Re: [PULL 0/6] ppc-for-4.2 queue 2019-11-15
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 22:35, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/vivier/qemu.git tags/ppc-for-4.2-pull-request
>
> for you to fetch changes up to 140fce75367a2bd8ef50681896a15f34952d9b85:
>
>   mos6522: fix T1 and T2 timers (2019-11-03 20:09:59 +0100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-11-15
>
> Several fixes for 4.2.0-rc2:
>
> fix mos6522 performance issue,
> xive/xics issues,
> fix /chosen device-tree on reset
> and KVM default cpu-model for all machine classes
>

Hi; these seem to be missing your signed-off-by line
as the pullreq submitter ; do you want to add those and resend?

thanks
-- PMM


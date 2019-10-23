Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421CCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D019420640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKxu7RjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D019420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJ31-0001OO-2n
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNICj-0002l1-RA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNICe-00037H-JX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:05:41 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:46137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNICU-00032I-Lg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:05:30 -0400
Received: by mail-ot1-x336.google.com with SMTP id 89so17663830oth.13
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XNiqgmhgOL89Gz8fKJldV0/UjKc9EikRx8NXdu0cJWs=;
 b=oKxu7RjDvgPF3zD2jdpGa6A70N1AYfzpcmbY9NQ/d9FuBNdX9u5kwOAkjs9kDRNuhB
 KfHDTXSF2pGjMcxgKdJcHrGMBx9ST3f8aCzmltzjgNwqqy432cG3xCAIm1lev1RdCH2M
 7kxitWJGRNzToEKioK8eIW34pyNNkTlUGPFa+NyJqlPmhUD1mmMaKxAmPC5GF9OaQcnF
 bq9ynvM+ZELz222NFSa44nIqI+GxjC4ELKhBmSEZv5TLupMokklv+X9sLPsyp+7A41ep
 oMOJJ5SwtWC128pHbipQpkpyn6ENx+/zgDMKNq8vmtBTdnlbQxubHrPkfnzxeNA+iH/R
 XiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XNiqgmhgOL89Gz8fKJldV0/UjKc9EikRx8NXdu0cJWs=;
 b=Wdgm4iKdkkVHpFjqktUHUZgmTnMO1gwcVXdQjVl5k79lNCSAs0jv5NH7EfxYd/w+0O
 4zGpUuLWXwQAc/M0UKrlvp0I2W526Op6lp1GNgl9k6cu5enpctukFIPpxu6mnj6Hmb9/
 WMhWTsBvZabdIx/ZTTo3YMKXrlMegGx0qt2Pff22Kib5s/W/31WRs0YggUKR4bRKppHm
 qxknvoyYS8MemVb4qF2+xdXIolmTxeuGmk/Cz5QDzpNYv/E+a167E+a/JbnYKtcXZAVz
 kJlKSmmy0Hqircs/1HUsCJ4SuLdHkFpxUt7LImGE81KpFyotur1uYuPX2f7aEmoaTvzz
 UsPQ==
X-Gm-Message-State: APjAAAWladHVUN85fKI1DmvPjeFw8Jpixu+sU8W7epJXlczmUsEonGe0
 UCaAykyXhE/k4TfvbY4gnJMf6obV8Ueu8ECsC/xpVg==
X-Google-Smtp-Source: APXvYqwE7T9cBfx7X+QFvsl3+MthG/y1ik/rkafwuYS/wlxuWQW6n5QIIrWpQvUj7eeofd21MX4dDEBLmgMGpD90Jzs=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr7716754otj.135.1571843123786; 
 Wed, 23 Oct 2019 08:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191022150404.26112-1-armbru@redhat.com>
In-Reply-To: <20191022150404.26112-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Oct 2019 16:05:12 +0100
Message-ID: <CAFEAcA_mm+Wof6p9_KB3_pkvKR2EMuhwARKmbAUQ6CAz4u_28Q@mail.gmail.com>
Subject: Re: [PULL v3 00/12] QAPI patches for 2019-10-22
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

On Tue, 22 Oct 2019 at 16:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-22-v3
>
> for you to fetch changes up to 5f76a7aac156ca75680dad5df4a385fd0b58f6b1:
>
>   qapi: Allow introspecting fix for savevm's cooperation with blockdev (2019-10-22 13:54:14 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-10-22
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


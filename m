Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D5AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4A420717
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAcm+Qip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4A420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJH4U-0000Ve-9p
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJH33-0007Zz-8G
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:07:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:39935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJH2y-0007eT-8Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:07:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id e22so6223697edq.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h04RE1EvbprybYHxe+tyJZk9ZqiZ3OX5Lcb9Bah1dcc=;
 b=PAcm+Qipud0ztbcfl61k/4LEXW9BVP+a1AYzQbv7ixJ0La4VX7A4UJJNqIkHIhMlV4
 724buFVqKeDQsheoaz9E02wpAOKCgAcF8hrI2n1go410BIutgSOLnMqTlzah5DZ+4/LJ
 xW20jUHnNb5iuwZHqqZsE2lMrW1mPA8p1j5AbDTyH/PpVdrByc0c49+V/lvkvAWFAaW5
 bRNCJLDU3PHBjsAG7cPazRtktDn5ZOBDuyhqetub3Uf0s9p/BP87ophOTM4KG0AiW9oj
 7JvzkV1fcMpIK3fN3P+g7gvDXXuf52fuN7asDTzX9QkT7dTPs5F5lf4gXUmQE5D9kTBO
 rHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h04RE1EvbprybYHxe+tyJZk9ZqiZ3OX5Lcb9Bah1dcc=;
 b=b4JG1Ig1dRH5aYetl4MSPeTl7NbZecSSYyHqOa9Q9RDw72lcSlDjiAav4P21WEBnQH
 newIvEd/FL0Xmm93u5KEKPOK3TVtpv245lsCW6UayLwE+nNgoR3MHbGWjXauMgax4+WI
 jd7FR/sKyc8NjcIcHEVHPKeY0vWhXehYkJhxBmekoXGN9oCzzGVSJZUDSjr5BJuh5qpd
 bRLEUp0d5FjFX83dwBcFjAOxyZBSROlE9dAsQW1OyHo06maNinjLbBYT+2lq/VjkoIkj
 rV9nSzo9PbW0zzCosuNIpeyq0BJZ+Py2ot2Lbv/B9OvcQd57xUgbPZbLgl+XWqHYZffP
 6BEA==
X-Gm-Message-State: AOAM532VLzv8nO2+b/vmPIVHKRltta+RJygVlGTNYhz/17ecNy+TeHun
 XNxItNhm6QtbW9zL4hRlOUlOYmPOeRiI47cViJfVBw==
X-Google-Smtp-Source: ABdhPJwfvzuVdpx+qDMcQzzHdL86qu4hBYmmPujCY7Z3okQ149pmBCcJvUrAUZW6BEd9sn4qatQq4AIWuYeBdr+w83E=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr38044841edm.44.1600438050068; 
 Fri, 18 Sep 2020 07:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200918072703.331138-1-clg@kaod.org>
In-Reply-To: <20200918072703.331138-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 15:07:18 +0100
Message-ID: <CAFEAcA8UjpcFzVXyQtA91sMYO+FOpz+Ba2WiO_ThbQGYPfBsSA@mail.gmail.com>
Subject: Re: [PULL 0/3] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 08:27, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0b=
ac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-req=
uest' into staging (2020-09-15 14:25:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20200918
>
> for you to fetch changes up to 204dab83fe00a3e0781d93ad7899192a9409e987:
>
>   misc: aspeed_scu: Update AST2600 silicon id register (2020-09-18 09:04:=
36 +0200)
>
> ----------------------------------------------------------------
> Aspeed patches :
>
> * Couple of cleanups
> * New machine properties to define the flash models
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA2EC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DAA21850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaNh51ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DAA21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj0Vd-0000E3-8o
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37411)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj0U3-0007sS-VW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj0U2-0005Y5-UD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:05:03 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:45739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj0U2-0005Xa-Mu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:05:02 -0400
Received: by mail-oi1-x231.google.com with SMTP id m206so4728743oib.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cLDeuk442vbJ7ElCK1j5+A0MRCqCLJJZVJbvtZdOWlY=;
 b=XaNh51lltjuM20LUHFs29f80aPba6iS5h9JC/pAbaNw13dyhBrBw9Upzbt4YW1nSQ9
 wqGtK0Mz0GA2/0WwE+TebvFj1i1qLT5wcHG6M9WuFT+2RTvGTGl9xzoZdWch5CMPDEXl
 k2PhhqXQgQYV3Nz4w3rYUZS6SREoIzQ1mTB7rq0relsbzzSeTNT+rqkNk5ZpR8UEsvIj
 Brn/oDUTqt1GZfnn4unjHGoyrHJ2/j4MF7ZExYI3QvdL2ufwdQs7IPCpjKmHRHVYHLlM
 IDS/BvZZeVu+3F9o1kYYRGe1wJal+zLtCMtuNbbD7lAY2aKwFJWlL/AIplRVOlnXr+Rp
 yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cLDeuk442vbJ7ElCK1j5+A0MRCqCLJJZVJbvtZdOWlY=;
 b=J8SpHaMJenCbxOQtXEeXVzRwLHjKZ+tkuUyjBOjRWsfirVZbzEWYXyZEgwSBQxEvAW
 +x89Az1FjqMRBzYuoL7FpvliaAKsiX6H0wrgFPpQNi1UBoMhpr98ljVVOhALYMkfsqWa
 iNzERbr1QJs8HLgm2SdVlc2/hNjBJRM6rACUTdEvx7QPUdu9ccnwi7Okf9bYK3NhvmyL
 1yRsmlBYGnK1SRbfFCmSTkJRCA4vYdSZoGBmTP1nNnrVsNwh3DpBt0EsNRRW70Y7+1WW
 Zikwuvz+8J9K+FbM/vgIX6g2ONGJNxNvrxX+pVO8+7E0PLsMyPv91uleq3BrRFj8p+lN
 Dmcg==
X-Gm-Message-State: APjAAAUTGnMIKnpYpgaBn0OrCYF6YBzfMqKLCoAeQzGoi3KwBpUa5zYR
 ZfMQSStzGa83JKCr8G/RdYwiyKx38XcIxO7WATOxaw==
X-Google-Smtp-Source: APXvYqx9n51Bw3DkozO7x4clvxHz7m9OJXKjFBPHRDREA6CTUUnujSu33l5raSxHKVTlvgaGczVY7VLdBGE4KCt7sg0=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1739507oic.170.1562241901563; 
 Thu, 04 Jul 2019 05:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190701222912.4703-1-ehabkost@redhat.com>
In-Reply-To: <20190701222912.4703-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 13:04:50 +0100
Message-ID: <CAFEAcA8Jyxmmx8mEAoDcnO4Gj=abMO8Z_3rT7bTFw04_vcrk7Q@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
Subject: Re: [Qemu-devel] [PULL 0/4] Python queue, 2019-07-01
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 23:29, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to e5abf59eae5990296c243202f95f801495c52e76:
>
>   Deprecate Python 2 support (2019-07-01 19:02:10 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2019-07-01
>
> * Deprecate Python 2 support (Eduardo Habkost)
> * qemu/__init__.py refactor (John Snow)
> * make qmp-shell work with python3 (Igor Mammedov)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

(In particular we should flag up the python 2 deprecation in
the 'build information' section.)

-- PMM


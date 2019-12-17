Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E98C2D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A6624680
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6UZsbY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A6624680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihElm-0005Z8-9y
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihElA-00053z-DT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihEl8-0006uk-TX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:27:40 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:36004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihEl8-0006qG-Oq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:27:38 -0500
Received: by mail-oi1-x234.google.com with SMTP id c16so4888907oic.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xdCCfNsCVOXJc6B6aX2Y1faIl82TrW+R4iZY0KIqM5A=;
 b=o6UZsbY0LRwRPJeXgp8TdnUmTfG7AJ7DT44rLFWTPwGKmdhlJGZyydjVeJK8WR8b9i
 IyHY9Q4tl/L/G5Vz7dzs2Kp0bzSLIIvLOhwLF35aOEj96YinyaJ1Jc2fOZePUGZRKxr1
 6hg/2CwTpArPXNy0krB1ycfYs0u/gIhYo7AStZ/HkuifhEvV1ctyXlY0FX5x+cUyjoLR
 l+KKXHGrsG5Wan+cD1saoPnyjXlJCkU7lzJwyE3+rzmQ9C9vzoK13HlYNG+Yk+l8HPfb
 IvgITPfefBaO/qjWhhOp8EgH2QcM7RV0FoeTtjtrae3KpS5vyJxaEyJzFrakW41CbrtT
 Cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xdCCfNsCVOXJc6B6aX2Y1faIl82TrW+R4iZY0KIqM5A=;
 b=AtooIesm5F3ACcybTZY1cK2z+3UyccayfMQJ1m08Pag45s5jzcbcEjengoX+sdi47p
 mbqJaX3PLmO3TSD+7tyD0Rc6flbeCk+Ihpvp9CS/JBF89e3iDMqLV9woxWfBiWN+4srY
 /PGjUzh4eVns7Pje5hTnLSW2G24K9gGEZJmi0xufXMep4NlLuILF63AwEILj43KFjhGG
 FnHIdnu0SCttXrbK7Iah2jDFaemJ8UHJrcDB8/uS73gc1fhFp1LY2ZjmWJYUI4LoehGS
 2X7TB0biN7jM58efO9y45fbxzqmodbThb6WZED/nPutte1yb9JGJ5n/KZ61+UQ9HptLB
 MuXg==
X-Gm-Message-State: APjAAAXiiBf9K9/yQo3a2nkukkRq8jtzj9qMYC/xmzKzbVtgxCWgWW07
 steLjT1XeuxLMCBcrdEQNdUHy8TuB+kvCBTkifm7yA==
X-Google-Smtp-Source: APXvYqwvgJSsXWore8DUE3Dc858cKxsU8jZjE36Gj0Zl140607EVYvp0cIqs3xzC+On4cVQbNbu4dPaFHsTKOIMZvkA=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr1781871oih.163.1576596457542; 
 Tue, 17 Dec 2019 07:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20191217051521.1239-1-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 15:27:26 +0000
Message-ID: <CAFEAcA-2t7TiLjk-xY-Shp03TYizybYPns_kkL9vCXP4LufiSw@mail.gmail.com>
Subject: Re: [PULL 00/15] Python queue 2019-12-17
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 05:15, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit 856ffa6465ad38a31603223eb057a253114ceaea:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191216-1' into staging (2019-12-16 13:04:34 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to e42cb9678cee7ff7c28afe7917c1002d6d8fdc0d:
>
>   python/qemu: Remove unneeded imports in __init__ (2019-12-16 18:39:51 -0500)
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


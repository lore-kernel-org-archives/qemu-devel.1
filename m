Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199CC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6998220722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uci2xq51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6998220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFI6C-0001xC-L4
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFI5a-0001SZ-GI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFI5Z-0000e9-Dy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:53:30 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFI5Z-0000dn-53
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:53:29 -0400
Received: by mail-oi1-x22f.google.com with SMTP id y71so6504556oia.7
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FcCU72cTBFXqf6Yl2ECEu6lqS89uei8pakxbdVIQR+o=;
 b=Uci2xq51x4TwueGsBM3FOltR4K65fUQx6b5wtkqH3hnDQiyAevl1XJRdnTTccw7ra5
 ECc5uPojDWuMHzl/KI1W9b7Ajuj/NgDr/ttfySiYd7DoVKDxqnKFVUjK51Hl+Xahortk
 zuNjn7irV9Hk5wyCLKyPfBf9xLZZw6NRBni95n/Fs7S/mpqYF5k44P8Qw+61GVBGVb9/
 AewX0dNk065Zi0OwNIcWP+0rZaESDmfPslZYE7Wvisx61pAaOf58Vsm1bcWgK2EGjPHo
 +2NVGXqPNY3D1SAFa4RcVbJRAOxHVmFJcm7OCvzRB7LURjows9+4sPM4fcoQZrZA1XaN
 0OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FcCU72cTBFXqf6Yl2ECEu6lqS89uei8pakxbdVIQR+o=;
 b=DSAFMpJ437g9dQWfY+dD9ejpAA4VQEmrm36iBzLI+WMv8uySJDmT+P2YGh+v6aqEFe
 yumK/hbq4ERaNfiAs4EIJO/XsHw5MG4YbwBfNGTyYQtJKj3jCea7oDXfejtcTRVC4vfX
 adaAmFTg2EDCeLZBEjijqW4jcuL1eEQIRM5LGy+FMc8WE7gh20yVCIOq6lrorpbneYNA
 as1oei8JamFZByrenKRCxaYrxba41Ogv6u7qqwhQVKxrPo6Hh0/NQhdH0lb8GMEjSnau
 ACYmz4KljmfBSqr0K1BNS2gWhy3wPsfJxsRPaRru54NipOXWZ+DEvN219sOtKekSVysc
 oJag==
X-Gm-Message-State: ANhLgQ1gzrWVtiRqXyg43dwspNuDNRMn0Vsb8yVfHrTdjN6R2NIVq2a1
 S9XmalH7o1LzR4D5Gce0iAddbBPaR/2D9JylPU3/BQ==
X-Google-Smtp-Source: ADFU+vtrdD/qeAmIbfORmp0OaiC1e1cbItkF6+0m2qVOYxusdMyj7VKGfpdoVQ4v+sUqbGQw2o2FxFN74DvLrLDKDRM=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6187945oii.48.1584712407988; 
 Fri, 20 Mar 2020 06:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200320103551.29246-1-f4bug@amsat.org>
In-Reply-To: <20200320103551.29246-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 13:53:16 +0000
Message-ID: <CAFEAcA_C+9zAx2RhTqX1KssWZWY7n3CKemSaX_f2Ep0e3+Cvxg@mail.gmail.com>
Subject: Re: [PULL v2 00/13] target: Add the Renesas RX architecture
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 10:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> This pull request adds the architectural part of the Renesas RX
> architecture.  Richard Henderson temporarily handed it over for
> the 5.0 release.
>
> Since v1: Rebased
> - Use GByteArray in gdbstub (commit a010bdbe),
> - Use device_class_set_parent_reset (commit 781c67ca)
>
> The following changes since commit 4dd6517e369828171290b65e11f6a45aeeed15=
af:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2020-03-19 14:22:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/target_renesas_rx-20200320
>
> for you to fetch changes up to c8c35e5f51c4d54bced7aa05fbd8e2371e493182:
>
>   Add rx-softmmu (2020-03-19 17:58:05 +0100)
>
> ----------------------------------------------------------------
>
> Introduce the architectural part of the Renesas RX
> architecture emulation, developed by Yoshinori Sato.
>
> CI jobs results:
>   https://gitlab.com/philmd/qemu/pipelines/127886344
>   https://travis-ci.org/github/philmd/qemu/builds/664579420
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C31021783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ub/YGZBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C31021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMur6-0005aa-LK
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMua8-0000Ri-V0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMua7-0002x5-T3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:52:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:44013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMua7-0002wR-ON
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:52:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id t84so14185666oih.10
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TVirM9N+z9auapfxL//WdfFc5Vp5MVTgfhrL8YaxCe8=;
 b=ub/YGZBbgTMud+yLVTMWhbndQQc24tkMpF9JtiY0/l0FnnHdaU14J5d0L+uMpR4lxp
 ZLyaTiP/0QkI9K1SuR3DPs+WxJtSQZEh9j3P7ZCtLcy7JBaeet6WXUFNxGB+XwpI5s7q
 gRw3M6VWQT92F4R5Ddugc00M+BA+tAdIZxeErd+JiM2s7Ag682v8AcjOoweQuf6TUgME
 WZK0GGQXS55pNRHTfTphFfGb2RV/dEc2kBFGQy2XEYtJfBqvgMFLOZ4V+/YxtRJmWQjI
 k2WwVXO6Rk9zzarP6vcGwyYXzMo5Ane6o0OzLCgUeyMh77XkxPyGlffM7xQ4AJbYtIgm
 Y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TVirM9N+z9auapfxL//WdfFc5Vp5MVTgfhrL8YaxCe8=;
 b=Tm9PQBcvP/Si8ka5KKm++5nKFysPolrjk73w4Mg9T5bGUSQ61Ul1cLLRbEO/Pp0JDy
 EBKjX9H9yGZOR/Ww7Y2P+pmK1BX8h296KEyX4ROb4C6rjnTrWPx0D9Gi2qBjMWqONfzH
 Oel2QDysmErakyveb9SHrEJMDP4iaFr06rIA0qybZAXS0tanJU+5lfRS7mRj5cDspjAD
 HK1JcJ0RhXG7TBH2CctOiuMbxtdEASlCw97SDo349MSFH/M9ISajp4+7N6v21h9ckCsa
 Lq4R4D2nN4jI3xcT/aSmWwuAoeSc0QokLPN8ood4lbBviXbPfZ5teK+qUyebC0mNjvU/
 D7AA==
X-Gm-Message-State: APjAAAWyZ/Sk1PSt2UOhv4e9bEOyOHU11VECrGa2/wa8jIfF65FD2XuT
 dEZhLCOa/qBNujtgBA/3b67NV+QrWEeYq/jcpp37vM+pqlY=
X-Google-Smtp-Source: APXvYqxggEb137VxG4G7QMYi3vbxA7OBgAq77uThIO1FWeduXSaAMUrhG+gfsgPyo/MpGd4jmE1a5mQMRz46dKYSPCo=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr2948411oik.146.1571752334606; 
 Tue, 22 Oct 2019 06:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191022095428.20780-1-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 14:52:03 +0100
Message-ID: <CAFEAcA_GrAdAtOnn3DKqSJcdWaNM3+8FZdiWpdZOY0N-cDdnfg@mail.gmail.com>
Subject: Re: [PULL 0/9] more s390x fixes
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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

On Tue, 22 Oct 2019 at 10:54, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20191022
>
> for you to fetch changes up to de60a92ea7b7977854420c58fd98f38cb6de6de6:
>
>   s390x/kvm: Set default cpu model for all machine classes (2019-10-21 18:03:08 +0200)
>
> ----------------------------------------------------------------
> s390x fixes in tcg vector instruction handling and in the
> cpu model code
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


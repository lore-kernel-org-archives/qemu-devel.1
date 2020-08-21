Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE6020656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRMYnMN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99pu-00082C-Fi
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99pB-00070s-SN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:23:29 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:41046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99pA-0005om-59
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:23:29 -0400
Received: by mail-ed1-x529.google.com with SMTP id w17so1910786edt.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ca9jrR4FwbHzEj4HGO+Kpe07gowlw/llXBTIRd0hqQY=;
 b=HRMYnMN1b2tWft+519gYkD1kmP80vVnc+XGtg2t2Yjf9Q16iVJ0pjzF525LxGSD5sB
 Yjx8cmAALnMdaVCvL06lEHbZzQesY0Rafj25xLc5K8CwWkFX6WPwvom/5HbwruryZyi3
 ILysIbArA0Ml8+hds1nP8XK52v1AMcPew/28H4Ck6tn8funkFZ+1HIxBdaLeMD4mEUjQ
 ftFHK8KOHd1hRaV5Vz8lcTZGvVk0yJFspljMxgddrQ1DrvO3JvEFuYXAGZmqMQtL42pO
 gdKgKbeYQXI2sBfPo2tZt4gGzIhKvskPOzd5B56GNrto1cAdUWE4xglR3x6A/nisPVn2
 3a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ca9jrR4FwbHzEj4HGO+Kpe07gowlw/llXBTIRd0hqQY=;
 b=QQUlK4EABaTr9upaLvIbt2SkvraHBl7/4UE8zNqvW6iSagdKblEfz6+y5j6XVCIAgG
 YxwO4T0mjG/dl6+pWD0/OBQMmh2kmhPZCEJemaa8DUmeYBb1T7httxYEuTokKSqBnA4M
 AqWbxsgMFeSRUu1yDviTWP3ANxp08UutYCip4c5cnHpOpSo4wliMlTTRNnfhWkr1Eymf
 cy4ecDPZMvEpkKY22JTP7lD7ah65Pb1ZRlcI+DpAvkexy8jHoFf03zXv5bIHVR61LCQF
 hL+XWvkRaFn1iqfTbqgKD/2E/YJHOhtkL52jJHF2NHLfRtBz8fLKAHqlo0/HJwvKXyTU
 0Uwg==
X-Gm-Message-State: AOAM5331p063J0v3Ac74Wwu0FulmOsfTuOMntWNGW7hIi2zxrg5iE7OT
 f8OTdlWKm4IeFU9Qm3+zy4o47k9eOhGVvpgmkAuO7g==
X-Google-Smtp-Source: ABdhPJydo0BDdGm02FLsOk5N/mVOXAn7BYHcwPWrBKfOTCPeR46NqPPDVKKhTMy6EOssyeOsVKWuj6MdnxtM42b90Ws=
X-Received: by 2002:a05:6402:1218:: with SMTP id
 c24mr3521157edw.44.1598027006087; 
 Fri, 21 Aug 2020 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200813064923.263565-1-laurent@vivier.eu>
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 17:23:14 +0100
Message-ID: <CAFEAcA9NUR6jzCypJv4pC-ghvzjk2ErfFJ65j6A=r1LUbzp6cw@mail.gmail.com>
Subject: Re: [PULL 00/14] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 13 Aug 2020 at 07:51, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91=
cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to 04275cad60c8f99e0dd7f56aecda68ceac926da8:
>
>   linux-user: Fix 'utimensat()' implementation (2020-08-12 10:09:58 +0200=
)
>
> ----------------------------------------------------------------
> Add btrfs ioctls
> Add clock_getres_time64, timer_gettime64, timer_settime64,
>     timerfd_gettime64, timerfd_settime64
> Some fixes (page protection, print_fdset, timerspec, itimerspec)
>
> ----------------------------------------------------------------

Fails to compile:

../../linux-user/syscall_types.h:407:28: error:
=E2=80=98BTRFS_INO_LOOKUP_USER_PATH_MAX=E2=80=99 undeclared here (not in a =
function);
did you mean =E2=80=98BTRFS_INO_LOOKUP_PATH_MAX=E2=80=99?
        MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
                            ^

../../linux-user/syscall_types.h:451:17: error:
=E2=80=98BTRFS_MAX_ROOTREF_BUFFER_NUM=E2=80=99 undeclared here (not in a fu=
nction)
                 BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
                 ^

On PPC, even more errors, relating to not having
BTRFS_PATH_NAME_MAX, PTRFS_VOL_NAME_MAX, etc.

Not sure if this was a semantic conflict with the meson
conversion, or just an assumption of a newer btrfs.h
than some systems have.

thanks
-- PMM


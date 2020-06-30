Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7432F20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drVsLQCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7432F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCwx-0004ap-PK
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqCwJ-0003nB-QS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:52:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqCwH-0002tS-T7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:52:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q5so19446383wru.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDNR7CzmXvERlP2gCS61TUUtFQynsCcwyJZGFLksrr8=;
 b=drVsLQCdmCos/3CvKKqZvpAfjMp0KNmD5njGQPAsWeI3xYp71RgRRWHI4ZFZDcxfGb
 StwKqA7kE47HGLJg6pgZGp0ssx+Psx4isLVQlcZ9XI5hOJcj2xrt6ZOU6+AqtL158cC3
 ov/0SM3DB03BtlHOeZJKCzh+80ZfS/hPn/I0p5ZWRj3q+bx3f34V0oztZ+zUBzJTBZWe
 lb5GTOGIznt9m4pqf9NVgqkOjlacbioq5M6DjPDZdviloVu58ftl2ki5G83N2lVoG7Mb
 mQPupGhT23BPVEuBO/tY7kqTo0JWRaL6+zNn76E+/vXh1QfdS4EaeIOhm2s9cdqyH3Ev
 lFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDNR7CzmXvERlP2gCS61TUUtFQynsCcwyJZGFLksrr8=;
 b=aKoTm+g5ULf+neYk5ngi0oETd0g3jnb0vv5vFs/+NuayzGmKpCCovK6jkNpu+0KjM3
 cSPTkNiuiqB4Ji1Mjju9sX8kBkUUDb2A4X71nia6gGuKA/n/+1R0Hn/BoqELR+6Gx120
 q/crWg1aPJZrE5R9BF5/8dSroLoi+OLA1KWqjBlIOA3NGf20R7M7aBXGctVhwDGUmST2
 DA8azXtob+hCvWy3Egneq/vtZsVKLYRzENOkEYyQn3ZZA1MTew0cV7K6HWvcXiDhOqgo
 tfxpuRcVk+eMCbtW2suCbdi4sOoJvTpKc80/0hz4QBWGw5pNXuiPvYIcnu5451M04FWW
 dkhA==
X-Gm-Message-State: AOAM533JEiYiF6yrmlUS5hV0HMZLpi/CJlynCFrDRJMsOSg60sYZe01Y
 xmzb5BMO457o+LmQm4PRy/RFNl4dRppl0cyHTrY=
X-Google-Smtp-Source: ABdhPJzGZOsyP/6LXyMaTqsMRPfRWaZDL5EJGjt5jIw8y4YiamUN+6lUO24DaM0dGDhMdEJSTR/Ga3N/1beCBORaX74=
X-Received: by 2002:adf:f885:: with SMTP id u5mr20668789wrp.402.1593510748428; 
 Tue, 30 Jun 2020 02:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
 <CALTWKrVwRhQEEjMEq444fNgBp1Dv_XyJAV7suXCEmeS40raaEQ@mail.gmail.com>
 <CAHiYmc5Em7zaVZzBZdp-13Mw2MnM_-nxZ=g+_ePnDCcBiwJrRg@mail.gmail.com>
In-Reply-To: <CAHiYmc5Em7zaVZzBZdp-13Mw2MnM_-nxZ=g+_ePnDCcBiwJrRg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 11:52:16 +0200
Message-ID: <CAHiYmc6cr4_q35106ZTPdAXG5geKChu7XUiKVLkDPRVhZM3Z_A@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, luoyonggang@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> As far as I know, this is how Ahmed test bed is setup:
>
> 1) Fresh installation on Ubuntu 18.04 on an Inter 64-bit host.
> 2) Install QEMU build prerequisite packages.
> 3) Install perf (this step is not necessary for Report 2, but it is
> for Report 1).
> 4) Install vallgrind.
> 5) Install 16 gcc cross-compilers. (which, together with native
> comipler, will sum up to the 17 possible QEMU targets)
>

The following commands install cross-compilers needed for creating
table in the second part or Ahmed's Report 2:

sudo apt-get install g++
sudo apt-get install g++-aarch64-linux-gnu
sudo apt-get install g++-alpha-linux-gnu
sudo apt-get install g++-arm-linux-gnueabi
sudo apt-get install g++-hppa-linux-gnu
sudo apt-get install g++-m68k-linux-gnu
sudo apt-get install g++-mips-linux-gnu
sudo apt-get install g++-mips64-linux-gnuabi64
sudo apt-get install g++-mips64el-linux-gnuabi64
sudo apt-get install g++-mipsel-linux-gnu
sudo apt-get install g++-powerpc-linux-gnu
sudo apt-get install g++-powerpc64-linux-gnu
sudo apt-get install g++-powerpc64le-linux-gnu
sudo apt-get install g++-riscv64-linux-gnu
sudo apt-get install g++-s390x-linux-gnu
sudo apt-get install g++-sh4-linux-gnu
sudo apt-get install g++-sparc64-linux-gnu

Ahmed, I think this should be in an Appendix section of Report 2.

Sincerely,
Aleksandar

> That is all fine if Mr. Yongang is able to do the above, or if he
> already have similar system.
>
> I am fairly convinced that the setup for any Debian-based Linux
> distribution will be almost identical as described above
>
> However, let's say Mr.Yongang system is Suse-bases distribution (SUSE
> Linux Enterprise, openSUSE Leap, openSUSE Tumbleweed, Gecko). He could
> do steps 2), 3), 4) in a fairly similar manner. But, step 5) will be
> difficult. I know that support for cross-compilers is relatively poor
> for Suse-based distributions. I think Mr. Yongang could run experiment
> from the second part of Report 2 only for 5 or 6 targets, rather than
> 17 as you did.
>
> The bottom line for Report 2:
>
> I think there should be an "Appendix" note on installing
> cross-compilers. And some general note on your test bed, as well as
> some guideline for all people like Mr. Yongang who wish to repro the
> results on their own systems.
>
> Sincerely,
> Aleksandar
>
>
>
>
>
>
>
>
>
> 2)
>
>
> > Best Regards,
> > Ahmed Karaman


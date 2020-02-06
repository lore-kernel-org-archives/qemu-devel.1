Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119AF20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A9ANkQc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119AF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhAg-0001uv-0F
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izh6x-0007Aq-3N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izh6v-0004R9-OE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:22:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:45769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izh6v-0004D2-EY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580995335;
 bh=3eyX46v8N+YF0nvI36h4Lhd677TRnk4OaRKte6Z/D0Q=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=A9ANkQc758DoFmY+T9+LrdLuobr7fI/vpVUYKA/HPiaC0nhHZ+mSUrFu1Li/Cv5sU
 v0Eo2htYaxTcpZuZ+aMarqU8WXeEXVqRHSB9IjDROKDkLQDYaRnhJHMutoPaU3+fJj
 yiQtoaG5MarRot2I/mwEURcg0+GMvU111c2A59Ws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWAOW-1j2XM50tNC-00Xfkk; Thu, 06
 Feb 2020 14:22:15 +0100
Subject: Re: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: qemu-devel@nongnu.org
References: <158099477921.19404.14812857642999580348@a1bbccc8075a>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <d835601e-9995-e69f-dad0-6a4a7c8b24f6@gmx.com>
Date: Thu, 6 Feb 2020 14:21:30 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158099477921.19404.14812857642999580348@a1bbccc8075a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d2s1EpjD8wAudr+fJh2Rf9NurxozfoBOvgXT7+D4SmJkU1811eP
 TPCCPO0q/xEex+ogvxsb92fKGvsdtfAFh8Ct/0lPHhLg36N5TFz2zbydn3th4im5lkCDBdB
 f37nOZ3knv59zMXIAdcxQbhyxZ0Us/adqj5oCwmtbRe8/LeSF2+vfmmQcyeIyOZt8ijYuCJ
 foz+oD9d3AOnQvAtAVP5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxNkXAje8A8=:v7M1g2wwUt74rqRsUZinqM
 BmNul3ddB6K/lF6lY4WLsoCEc5cT8tksDCWPKm+dEA5ZR/+sFpypdpfAtbf7YrDcRr03/5QXP
 H+BuDTVDpr9eHJYb7WWO2hGigGpW+fT7o/MtArfjek+nsU6tu5uxS74QsrljAcjIB0FxG/4L0
 kxX76J4weQpEkhK73iXrcWnpkSZiiAzTIZuNkJniYT6LOVyezxypGxxCeCwXFhEYmIhif9XSu
 nXFQnjlqyz+TvvNMgtireswHt1KDkLZI/eS0HYDzm6/OKsRxZWFd82xN694W2fBnqSJGrmcbk
 eFa7hCb1rYyV3AdJnfz9QJLgfWslsDQiJTi049HczFKmcwZFcM240tczOnMXAWWxQzhEloAMr
 5nruiCvQUVD5jokrcLsIpvXGFXzt1MFDtLU+LzSiFpIEnMiFusbBIX5GYR7ybj6Y0oAYGB+mS
 Cx03gnfqpjZVdmnNVnRXJOyxstQDDp/M9g14Oxvu6KFS/MnLx9FiXCuM5XuiPnkCHo9jWlH77
 RMsLHIiS2Lk268gMEh7tDzUxj1CE+1Cycu3SFFstiNgQ52ResQkeDii6KOXEZe++j3ZUC6aNg
 6uG2wOycaWzN1OYUO9DI5IPaA/WJWn1SP5dThqOQ7RY/13w8QvGJxf7Wbrngo0kpmtNBk1w0e
 QPjAUSDK9tNH96DxvOv5oXg0JNct835FocAPsURqf4YWw2sDRGGemESo6SwR9MR5271FiD2vu
 lsIMOdeIz8R5vW45uXgsHM0TCxqqI6egaArQT5kwkO7TDeN9oUdiMwrVnRYm3atZJhnhmODmN
 /B8cgMDZWjjt15hgnvo67lShr2VpNmJcD3Cr3QjjxY34fLcJvO71SHMcMi50SUC4zCz4lLPak
 Ah6A7iuo2se+BboiSgxfZTRRQoZ+OEeo1K0bu8wee7/RvdURPef0rAjQbqs4mHLA0adyzdIHg
 rhauuGsockxIKqDZrPoorwW48r//XdcxdFSyV5q6XGcBbdz9d8OQ1PFAWFXVeLICDfnGk+uKJ
 llqw8Aq/7VVpLCj6GH1KxyC+SDoohw64BAnQjXqRJYJn0okArQaDUM0KzIPQrriZJvHxJqheF
 Czy8gStM4VMBGD8jGw9gSv7agnUtsO9aXLPvA2zD7YlNhPVamsptoZo4iETH3givNmJV3IS0a
 aNLXEx1tKJsfmvcu3SNv6Ix/Q7az6m1sjf8SRRXohvCJcDklAXPczH/THt0Ppke0d+Zjo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am I supposed to do something with this or is this an issue in a script?

On 06.02.2020 14:13, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200206115731.13552-1-n54@gmx.com=
/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below f=
or
> more information:
>
> Subject: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor ac=
celerator
> Message-id: 20200206115731.13552-1-n54@gmx.com
> Type: series
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: git fetch_pack: expected ACK/NAK, got 'ERR upload-pack: not our r=
ef 1c298dad3d820f7a2161054ff581cf2fa65ee1b4'
> fatal: The remote end hung up unexpectedly
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "patchew-tester/src/patchew-cli", line 521, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf, True)
>   File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
>     stdout=3Dlogf, stderr=3Dlogf)
>   File "/opt/rh/rh-python36/root/usr/lib64/python3.6/subprocess.py", lin=
e 291, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '=
=2D-mirror=3Dfetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://=
=67ithub.com/patchew-project/qemu']' returned non-zero exit status 1.
>
>
>
> The full log is available at
> http://patchew.org/logs/20200206115731.13552-1-n54@gmx.com/testing.check=
patch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>



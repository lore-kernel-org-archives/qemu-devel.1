Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B163C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD852227F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kay2GEme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD852227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYz7-00058H-Ka
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVYqS-0002fa-7O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:33:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:36329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVYqQ-0005fr-2O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:33:23 -0400
Received: by mail-ej1-x635.google.com with SMTP id w27so1788104ejb.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HY1RRuO42kjIT1FTEuIrdY6sp6bVFupsSGnZHU3Xd08=;
 b=Kay2GEmev+JayMkez10Jgo/MkH7yhZkxgYr1EFOERStVnStXHh17Xs6hoqr+yCpYSW
 Y8XGfKwzGG+nIK7acrWk89lVxUFr/txPySOZfiZ383t4/o7jeSJr77qIDBYPxFdKX+vT
 +oh6rP/T0dnaQ9yHF9CkEHcGDN/cDSksCCtCkm/rF0RF0eHDeYcWY0vVNACTHH6kzP3m
 f7wL9crLRBzzqleT0SF9NxWfYjj28whKRZCn822666vnXZUzfUkBNsi0NAzzrgLt3rI6
 vJS4DW+cc8D1xBg8J6HvlKJxKvIdDtJd6oSlTvVsnGzKw3c7ikClz0UJcGvzDrUMgukm
 lULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HY1RRuO42kjIT1FTEuIrdY6sp6bVFupsSGnZHU3Xd08=;
 b=cywpgJZ4q19qlkzT/1XKSRmQ6j6kE9xH6LCutIQ5DDfgpNUHmWRzzP9owG2ezfXxju
 AO5o4JPtHY4jy5A6rmi4F04/zamA5TJIAVMhxVJckWG8QWuhtjE3GN2B0vfUjKEcIKTM
 2nsK7Uu5vBEv4sMzv03FtkG7pFpiilJ+5J3b/aXbbbTt8lFg2L0QAbVwCKBzxJxGXszf
 X7tLjFJ9RfhWkhL0hXh+RUcN0WOTP26XL8mX9NPy3ppbp8/MUVwVH071duhyUxoQPGL5
 kIYwnuSOZ9XmZxdfj5WR6u/31q+TU0XmlTS7tZMZNgz12mR6nVeKFshZ5dBjMWdNEyXB
 E/ww==
X-Gm-Message-State: AOAM530ZJnL3comBwddgioK+GD30A3shm/4O6ITXl2uF11vSf4xsibKK
 6at1Nmh1I9fvc2+LQFDnmFDPkkoNpqcntignEeWp2g==
X-Google-Smtp-Source: ABdhPJzry7VcoZQ0o4G4FmuN2hppEmDIuJmA8vYqxHg+oLHqFchMgyIK8c9kaffPPKtiL4gQxa+Tp/7hP2lUxmrV5hE=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr1709294ejk.407.1603366399922; 
 Thu, 22 Oct 2020 04:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201021173450.2616910-1-f4bug@amsat.org>
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2020 12:33:08 +0100
Message-ID: <CAFEAcA9e=u0Wt0mMLo2uWixvPHt7sCX_1JCe95ZGiRPvX5Pt7Q@mail.gmail.com>
Subject: Re: [PULL 00/13] SD/MMC patches for 2020-10-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 at 18:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit ac793156f650ae2d77834932d72224175ee690=
86:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
0102=3D
> 0-1' into staging (2020-10-20 21:11:35 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/sd-next-20201021
>
> for you to fetch changes up to 84816fb63e5c57159b469a66052d1b2bc862ef77:
>
>   hw/sd/sdcard: Assert if accessing an illegal group (2020-10-21 13:34:27=
 +02=3D
> 00)
>
> ----------------------------------------------------------------
> SD/MMC patches
>
> Fix two heap-overflow reported by Alexander Bulekov while fuzzing:
> - https://bugs.launchpad.net/qemu/+bug/1892960
> - https://bugs.launchpad.net/qemu/+bug/1895310
>
> CI jobs results:
> . https://cirrus-ci.com/build/6399328187056128
> . https://gitlab.com/philmd/qemu/-/pipelines/205701966
> . https://travis-ci.org/github/philmd/qemu/builds/737708930
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


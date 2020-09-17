Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AB0C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE1B2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PydHCj7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItC6-00016A-0D
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kItAv-000855-DC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:38:09 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kItAr-0005L0-Ie
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:38:08 -0400
Received: by mail-ed1-x544.google.com with SMTP id i1so2388596edv.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/qXapW1V4fNhGT3dbUjlruU/kCQYzZed2g1ejpFVACs=;
 b=PydHCj7cB9qHkY82VUEQN/JPW3nesu/2KB4XKegqlbcfsxY1YI1QuVRMxa9EY7UQnd
 IU9BJTx8SpP6HOQqgia8Cs8BtLtlaR2LVLi11V7L/ZSrtAlXl0C9qNxaIIp9J9D98SD4
 hZ7kYeD38xi6ZEl9BXJmX2bNxDTqj2D/ZGQPmO/my3z8D+L1TZ/7qCMc94nqPY2lR0XY
 0axwTERy4MLQfKkjey/h4K8Lcz4nF1rZTNErswyDpnY7c5bqaoa3xToiYudmBuenWOaT
 xSoSkLxTc1zcYqzqxwatc+dL7sd7aX9PH+v1r4hez9b8Z+j2lygonBjRNtcis519RNk4
 Mtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/qXapW1V4fNhGT3dbUjlruU/kCQYzZed2g1ejpFVACs=;
 b=LwRn7BXv6XhfD46PD04pSIhhxf4Etu1MxJufMi0/+/1836CSl8iGxDcM579VlYmtUe
 PJhDR4UySjs7/T50aRg2FgVP2G8HxZumdnkll3Hp7r9T6f0S58dkJ7qFuVtHI2ueGB0D
 nGj8/Q930DnnzUIEVial3PhAfes6n2Hqqu1yS5DT6vabDckmd1e0Dl+coi7n/a487rJE
 vxE7jybZhhJUH/Fqfn1C4vej9hLdBBPttw7vC2ZLeiUdfDGJiK4dh6wzBNN/BXAErE2r
 v/On+wGRl2w17ry7DDmCES82hydckfZWQ6EfO/ikYcVKcyaHQ8eYZwqmW2zf4YlgBpDR
 RGng==
X-Gm-Message-State: AOAM531TWc/qnchDKniZgKUbFp2CvRoFfz24G2BMCWPWVLTnpoIVnnns
 zD7iwbmqvZlIGBNSD4k0KchcT8dHmrxcNyHczhsH1w==
X-Google-Smtp-Source: ABdhPJygSD3mHxeh3M2e+ih1Ytbjsayb81aT3udfGq+EXSj4DI9aPYYzaLGblVZ10FfuOvAg/ZTfDvSEmMevDmTx910=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr15304405edq.52.1600346281605; 
 Thu, 17 Sep 2020 05:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200916094705.2625331-1-berrange@redhat.com>
In-Reply-To: <20200916094705.2625331-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 13:37:50 +0100
Message-ID: <CAFEAcA8=YdJdL09sVg7eKkZg35Wuzf1y=Vbo9v-hKMJ7T+LPwQ@mail.gmail.com>
Subject: Re: [PULL 0/8] Block odirect patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 10:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0b=
ac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-req=
uest=3D
> ' into staging (2020-09-15 14:25:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/block-odirect-pull-request
>
> for you to fetch changes up to b18a24a9f889bcf722754046130507d744a1b0b9:
>
>   block/file: switch to use qemu_open/qemu_create for improved errors (20=
20-0=3D
> 9-16 10:33:48 +0100)
>
> ----------------------------------------------------------------
> block: improve error reporting for unsupported O_DIRECT
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=3DC3=3DA9 (8):
>   monitor: simplify functions for getting a dup'd fdset entry
>   util: split off a helper for dealing with O_CLOEXEC flag
>   util: rename qemu_open() to qemu_open_old()
>   util: refactor qemu_open_old to split off variadic args handling
>   util: add Error object for qemu_open_internal error reporting
>   util: introduce qemu_open and qemu_create with error reporting
>   util: give a specific error message when O_DIRECT doesn't work
>   block/file: switch to use qemu_open/qemu_create for improved errors


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


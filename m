Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE503C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795112063A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQs26W1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795112063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfTt-0001Ic-NR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvfT4-0000V7-Mz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:20:54 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvfT2-0004Xd-Dj
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:20:54 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 95so1149344otw.10
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AL57zQwPk0AGXFdm0v8YHvJgT1iptcCjYi4287VCBUc=;
 b=WQs26W1sR67R0xEtVDTGsDCq7wINhwLgUjFxsmvyi1WlLoToksu6t9fqq42XkB6A64
 XqSSOtML6ULJevYjfFA9WJEGeGJb8nB2Wwd1SBGNCE1gSAvuss5JZp8Zlopfnl7a6NDP
 57vZH5a6BXWzF9CWEcQDuMq89kIrUHO1j6n7LizN47I2r9gqZJ8Wy9pqRW23UpS1ulce
 BjV2zz4xIvAijR5MDKBxSyYpWgJyzDwz3VOCw8vN/iw4fz7Y6ixkbZl6Om84BlAeJiPg
 A5/NrzJGxdpa+7y6XHJ6WXNpNktDQv++Tn+jj/mNN2SskArmH23/rcMJW5MY7cA9KV/c
 S3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AL57zQwPk0AGXFdm0v8YHvJgT1iptcCjYi4287VCBUc=;
 b=b2pp5PN4bYNNp9m9uAiqNbnk/Wz9/a4L23c0a8Xc3Uiowo0EuSnny08224+7/8qVCs
 Kq1gY6vGQKiMC7BJNJ2CGhCyCPviHJYD5s2bmmLdzfQdKPzjejVt6Dk0gSpgyE7v0692
 kRKDLj30u3iU86GtnqOrnJMzR6e48jFxeigqMmAOjj4W2BZfLP6oEvrJZ4ZqdIDsFAYy
 8DrZwG4tLht0Rx8qwumQQ1wKflv0cZzdh9DiXWAausbWC/sM4IEurp4zU+LAgEz5AxEC
 hL/VMBp378lEUO429VVN+uItgecM0Um7JMrVV7Sy312GpZdIvo5LnVVqjsuCYfgiR2NO
 ktyw==
X-Gm-Message-State: AOAM5323Sd+MYKO9kK8QWpmyTkfdbhrtFepm3W9U2r0W+UWfNp+VmLHC
 9PzPDazyeI6mhDQ3prBAwxQMMws5rnSp7bi0WQ3dBg==
X-Google-Smtp-Source: ABdhPJzUcCzaW1F/klNhrJkFEpasRnAiuMlXgkMJijPG1PTCfAbwYB52kICgTbAMYPImaIEJL9FFsq8+z+bwm/sJ3To=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr8610429oto.135.1594812050626; 
 Wed, 15 Jul 2020 04:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200714135814.19910-1-f4bug@amsat.org>
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 12:20:39 +0100
Message-ID: <CAFEAcA8zr7_a8OvOptB0sUS9kKVUM3k__qDy2Z+Q9j=gBXEfNQ@mail.gmail.com>
Subject: Re: [PULL 0/9] sdcard: Fix CVE-2020-13253
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 15:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c=
46:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-r=
eque=3D
> st' into staging (2020-07-13 16:58:44 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/sdcard-CVE-2020-13253-pull-requ=
est
>
> for you to fetch changes up to 790762e5487114341cccc5bffcec4cb3c022c3cd:
>
>   hw/sd/sdcard: Do not switch to ReceivingData if address is invalid (202=
0-07=3D
> -14 15:46:14 +0200)
>
> ----------------------------------------------------------------
> Fix CVE-2020-13253
>
> By using invalidated address, guest can do out-of-bounds accesses.
> These patches fix the issue by only allowing SD card image sizes
> power of 2, and not switching to SEND_DATA state when the address
> is invalid (out of range).
>
> This issue was found using QEMU fuzzing mode (using --enable-fuzzing,
> see docs/devel/fuzzing.txt) and reported by Alexander Bulekov.
>
> Reproducer:
>   https://bugs.launchpad.net/qemu/+bug/1880822/comments/1
>
> CI jobs results:
> . https://cirrus-ci.com/build/5157142548185088
> . https://gitlab.com/philmd/qemu/-/pipelines/166381731
> . https://travis-ci.org/github/philmd/qemu/builds/707956535
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


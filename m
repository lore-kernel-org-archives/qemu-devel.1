Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F8CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDC621734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEQHY6b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDC621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTJ0-0001wt-Q8
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQTGX-0001IO-LD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQTGW-00058Y-7u
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:30:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQTGO-0004Um-FH
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:30:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id v24so2579093otp.5
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=pVbFEXRJPQmFEeUourYiKsiWufSWREg016e0mSXJHmE=;
 b=bEQHY6b3ttHOzk8lyUwW5XFeXUriP2vEzC/2YjpBAecikKKvoMRuk2wgU6F1mBPV28
 Bmruda58Pt8z51NsSOjCdn44qrCwcYokweq1jqNL5sirp46DR9iLDyPZZ6tJAqokmf5T
 9HD1nCerTvF8Ig2AlO/ojBnsZdp9YmYe9BKT74mxNu3klcMp7uTZ3BvSqSrqMkgwmVLP
 WpGGyLL9AVmoVTlrDc3wwmVBy4PL1OyoEE1v1NIdFlRZI54841PlC99W4NqQ/0i4I6Gb
 T100D2bA1diDQBQJekkTyO4p9KgYo7SIZ45LgTgLmtNthW7ggzdA74sjQTnicRNuCnnG
 wRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=pVbFEXRJPQmFEeUourYiKsiWufSWREg016e0mSXJHmE=;
 b=gKArMVF0E1gpNKReSdRlAiWK6ybtwNbToqAwfv+O5ouSL2wgWp8wwX2JMSQNUBclvk
 L7pKFgjhvhSpnR3HrfXiYOrQS3b3ziMiMg+D3Ftg1ZDMdKuXFU9GffDxzs2iiCu2Oqhs
 soHPA2Ft7z+XRjYEkubl8eysT2pDe+32BiLDjKfdZllFyWBBWCy9xKx3D5h43V9fo/1p
 DkGxbfuXUKgl/uZg5hqEUPcDXdv5W+WRz6sq3xckq1Xym0AtcgsbL0B4ICrLfrXhpQ0Y
 l5NMxDtnVxyU5e+TyARO177JJuHZPFIZ19lCRqBPz8RTrDhiS4+JYrqqsEbJbMGSgHet
 o3gg==
X-Gm-Message-State: APjAAAWbBpsKW2pHqyDcVU1KMQwOw55ZU11IOFM0Q/h0JEkOkLckXx2l
 2hZfX85iC+FiuqHLptAETQBhkUV9XdxqXz1Es1pgrYlq4ofG1wis
X-Google-Smtp-Source: APXvYqw86Mg6YUvqyvx29I88zGMnj84Fwb941JZSdYbCuJ+GgRdOwaF9OHmTZFkqANTpHt6SvfTr3w3IJEdjF1R4Eak=
X-Received: by 2002:a05:6830:c3:: with SMTP id x3mr4435003oto.91.1572600632930; 
 Fri, 01 Nov 2019 02:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191101085140.5205-1-peter.maydell@linaro.org>
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2019 09:30:21 +0000
Message-ID: <CAFEAcA-N-Fh7+NCHGPXuK-H6DUTOwjfCU6rmZGz4k8n+tkKdxw@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 Nov 2019 at 08:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue: two bug fixes, plus the KVM/SVE patchset,
> which is a new feature but one which was in my pre-softfreeze
> pullreq (it just had to be dropped due to an unexpected test failure.)
>
> thanks
> -- PMM
>
> The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191101-1
>
> for you to fetch changes up to d9ae7624b659362cb2bb2b04fee53bf50829ca56:
>
>   target/arm: Allow reading flags from FPSCR for M-profile (2019-11-01 08:49:10 +0000)

Drew, this is still failing 'make check' on the aarch32-chroot-on-aarch64 :-(

(armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm ./tests/arm-cpu-features
/arm/arm/query-cpu-model-expansion: OK
/arm/arm/kvm/query-cpu-model-expansion: qemu-system-arm: Failed to
retrieve host CPU features
Broken pipe
/home/peter.maydell/qemu/tests/libqtest.c:140: kill_qemu() tried to
terminate QEMU process but encountered exit status 1 (expected 0)
Aborted


thanks
-- PMM


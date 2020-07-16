Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7197DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C30520760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9/69pEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3CO-0004NZ-HO
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw3BY-0003mp-CN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:40:24 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:36906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw3BW-0003Ph-PK
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:40:23 -0400
Received: by mail-oi1-x233.google.com with SMTP id 12so4954458oir.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HDWN7BABhgsGPs59bQzNLZtWrHqSvkm51YqlkFTe7GI=;
 b=y9/69pEKLPAbx3lcQHcrnwQ+KW/mU9B/eI5Juk0nOa2QbL8rU3UJfDGrygEDA/xL3X
 XN2GzrbV/ejOI8hMsF0rorvt+4V9CbZxaEeLFQSvonWPryJN2FAkmB9d65bhXAR/jnv6
 t4DlyMcyCZ/ycT4ncpZoQ/mc67ivVga/7m6j/+Rgy0IcaJe3GNFiOrBYrzrFtA7Ux12l
 Cuta6DRFDu9V1Fu8uUgNwvwVGcRlLv7RDVARBVR35UFspNE/NESZR0SbkSuzU58f9Poy
 c9LjmD153ySSNY+lxYk0x5XZXzeW6F4hf4bWtTv80YjGavjnOA4n8ifDf9pHOqmCMlb8
 tD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HDWN7BABhgsGPs59bQzNLZtWrHqSvkm51YqlkFTe7GI=;
 b=EA9rHSbe9V1qeFxNiE92Zz0QSS5JePZnXKMbFvisyYuqieH0/wD3Co8UjlnEvU8iqH
 z/JcrTtKjLP+kYY0+gMaaPUCXNECmsvewMDPuZfxe5FDQ9m4QjmnNZTgw6ajJAh51ltK
 PerkHbQEWcLHd2MhQVpo+Aj7SmhVr9UpXTx+Qr4Emk/sX0RoPca4qE3pGaYRQSPBE6O8
 yPDHxVpxAGu0Wp72Yu7gJOEUaAeMMN6jJ6QCwn/FJC7zAglhgczKlMAOXai5fJOyo6wf
 oIHGum0/8MNqLaDqaVoMmIGX1+LwFnq8oUjeoGWgPPpSA5s2rqE7kmmC9gkRYk4x/a0r
 gf1w==
X-Gm-Message-State: AOAM532Y/Xzc1tu3P2WqgQkCrXmhWhqxqYh6j48UFpKzuCJA0mFAWVrA
 R+P31oDhlRPlGijNMu+yzjCCOgVnd9E8FMJZpmR2Yw==
X-Google-Smtp-Source: ABdhPJyrLVLgBnxpT8gzU6IVJ2qAggHTMz7/Qytksi97Fj+ufU2FpqpWXl6Q9YQjFd9ui4zu1eFHAkIn3Wzh59i6OMk=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3485984oii.146.1594903221149; 
 Thu, 16 Jul 2020 05:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
 <20200626102506.GD281902@stefanha-x1.localdomain>
 <cab22670-6804-9ddc-c3ee-b6dcf3a74ac4@redhat.com>
 <20200707220514.GY7276@habkost.net> <20200709150206.GC4096@linux.fritz.box>
In-Reply-To: <20200709150206.GC4096@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 13:40:10 +0100
Message-ID: <CAFEAcA9r2_O8wZQUAbEb46uwm-HkmnDD8Cv7b0fA2q-Vm7_Mag@mail.gmail.com>
Subject: Re: [PULL 00/12] Block patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:02, Kevin Wolf <kwolf@redhat.com> wrote:
>
> We can "fix" it for probably all realistic cases by lowering the speed
> of the block job significantly. It's still not fully fixed for all
> theoretical cases, but the pattern of starting a block job that is
> throttled to a low speed so it will keep running for the next part of
> the test is very common.
>
> Kevin
>
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 256b2bfbc6..31c028306b 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -243,7 +243,7 @@ class TestParallelOps(iotests.QMPTestCase):
>              node_name = 'node%d' % i
>              job_id = 'stream-%s' % node_name
>              pending_jobs.append(job_id)
> -            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=512*1024)
> +            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=1024)
>              self.assert_qmp(result, 'return', {})
>
>          for job in pending_jobs:

Any chance we could get this fix into the tree? I've just
had an unrelated mergebuild test run hit this iotest 030
failure again...

-- PMM


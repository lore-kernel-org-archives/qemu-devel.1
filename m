Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D532067D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kArTRLvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D532067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2dCs-0004Y5-En
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2dBz-0003z9-5J
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:20:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2dBx-0004k6-C2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:20:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id g8so135779wmk.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tLldRhiZuUDIQWR4Dezuv3wy8y8ie+Yklp9pb5zDPYU=;
 b=kArTRLvhvEX48jCt3FGfAjBk5q2jKd9B5OHtI2t2LNYcIwOE9g/YdRTu0Qv2/tKSjZ
 lY/8hKN+3rz/dF3zh17SF08NDzr2v5tDF/bmP2o3etZF2ZPLCzZHQcwvFYvP6duA+NJ3
 6za7Y2F5OxqbdFHHrY1qkFYEnEsvOLhqBgPImgSNCH+YWCrqy1GbmClVWNkQttM0crWO
 C4IQK3mx0BVlHvD4+D5Htf5fo+OiwQlVb3itNqCmv/ZX4igDhj4tmx5+XJdBG4sPULc7
 qxE59tZVZk2eDk6LpYf2ts74W/NPd1IpRDd0Trdw+2MgpJu1EV4Jsb0p42NlJh7mWqSo
 Hyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tLldRhiZuUDIQWR4Dezuv3wy8y8ie+Yklp9pb5zDPYU=;
 b=rLX1h4hpTjepAfNH/GMmmcFKAYhCvkwPSR1r2d6FIgjxdqfrD/4981gdPRC3cZHeId
 LqzsJ9GwcsnCFGOoJcWukJVqOWXTtXS1MaR1+UVpgEMuu9ZYUalOCwI6VGdgN66GtaA7
 b52TN7hl0hpg/hWXUOnwQwSYQgacNs0i9PtbpvKJ0xO4SzSAdZUQKadosk+bGl5wwItK
 YT919oe/M0cpqM+0cK4kuPI0tji+Jb9PBpZJPBiTfDArrH/j9UroTap5pOJ3Y3t2544C
 PkAzMo6+Yyfund6GcyhJRgtXpQ6hfrmbejmTZhmDcupHmuLViUU9qoNLDDeg8372+Cbc
 i4BA==
X-Gm-Message-State: AOAM5334Zjekrnm4t/cMakqtfZIyDBbTbpl2okaxk/JtAiBYNLIOiB/a
 RtdbGorGbWgJ7hMJRGSgUGKoRQ==
X-Google-Smtp-Source: ABdhPJwr62vqUeTs6iQr9eNHND5kn34UOVopsNwuHjXV/v7cCCABUDW1VP7TMG9bsneq4IGE55YcAg==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr56952wmh.23.1596471598552;
 Mon, 03 Aug 2020 09:19:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n24sm50772wmi.36.2020.08.03.09.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 09:19:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8FBE1FF7E;
 Mon,  3 Aug 2020 17:19:56 +0100 (BST)
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
 <87ft973d0b.fsf@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Pincus, Josh" <Josh.Pincus@windriver.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
In-reply-to: <87ft973d0b.fsf@linaro.org>
Date: Mon, 03 Aug 2020 17:19:56 +0100
Message-ID: <87wo2fn1lf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pincus, Josh <Josh.Pincus@windriver.com> writes:
>
>> Hi,
>>
>>=20=20
>>
>> We were looking into a similar enhancement for the Virt I/O MMIO transpo=
rt and came across this project.
>>
>> This enhancement would be perfect for us.
>
> So there is certainly an interest in optimising MMIO based virtio and
> the current read/ack cycle adds additional round trip time for any trap
> and emulate hypervisor. However I think there is some resistance to
> making MMIO a re-implementation of what PCI already gives us for "free".
<snip>
>
>   - Quantifying the memory foot-print difference between PCI/MMIO
>
>     PCI gives a lot for free including a discovery and IRQ model already
>     designed to handle MSI/MSI-X. There is a claim that this brings in a
>     lot of bloat but I think there was some debate around the numbers.
>     My rough initial experiment with a PCI and non-PCI build with
>     otherwise identical VIRTIO configs results in the following:
>
>     16:40:15 c.282% [alex@zen:~/l/l/builds] review/rpmb|=E2=80=A6 + ls -l=
 arm64/vmlinux arm64.nopci/vmlinux
>     -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
>     -rwxr-xr-x 1 alex alex 86368080 Jul 31 16:33 arm64/vmlinux*
>
>     which certainly implies there could be a fair amount of headroom for
>     an MMIO version to implement some features. However I don't know if
>     it's fully apples to apples as there maybe unneeded PCI bloat that a
>     virtio-only kernel doesn't need.

Just following up after cutting the Xgene and ThunderX PCI bloat from
the kernel the margin is a little smaller:

  -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
  -rwxr-xr-x 1 alex alex 85639808 Aug  3 17:12 arm64/vmlinux*

--=20
Alex Benn=C3=A9e


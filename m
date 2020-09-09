Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE6B2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfwD7T3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE6B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxiE-0000vT-Cz
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFxha-0000Qb-Iz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:51:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFxhY-0000LD-Sm
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:51:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id y15so1890443wmi.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yl71U6kcm97eXeik8Iz1rlH6MDRThYpLpOTfs02QNIw=;
 b=mfwD7T3vrRYj4fOGJBEk+ak7L+BNlfeuL+DB947vHt/XM6qOeeCdhVuVJu2qt2oDMb
 x2ZznhAqq83utb8NW1Jq1OFpGLAf14vryNFJATEBr95XpS7m3QpufXz8Y4NxchcSnxff
 /x7Mi5BxBMmJpvP8Ucu5ZYuu2dLC6w3FX5I4hMzxV315qc5ax+A5ojD7oSWm2S7MJIvg
 PCks1QSiHau4f8CwQ0swGVr+pgEZa/ZjD0UUkh+o7dJFlNzunPSxF5SEZnhv2lVawV4q
 NqsBOCZBJBq/oeTaYXhYF6n17toReVdeH1AwMQgf/mJXIWEPepdkG2gePIibyVIOotdV
 93YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yl71U6kcm97eXeik8Iz1rlH6MDRThYpLpOTfs02QNIw=;
 b=cI0kykWpuDUjGgynv/uvI7RgRMdMy0+aOzDIR6Co4g+IbhhY7IhTJZWOJFnDpxiAHj
 VRQDWwABBiq3OyGC/kF/kGo7IPYgovqyAaOnLSTxVYJfS2KOLxu1VbvkPMQsZBFn0Vz9
 MV+WLHkCz9M4jPfWi/XaBVSghq6nxLRs0HYCAOa7TpZRPyUYo3TkFJilYSp3qX2XBqXx
 DkQ6Hl5XwP+hvrRPiDr+1u2erV4DmXF2U5rs2kwZCU5JDUmVXOAXC9OtVA6b7cnDE2rz
 4RIlBCzLXZnXbA7Ncn8VPvnwBKA6saiHHvD/ITQoiOYObrjt8nD7CaLxO+Xg7sh6nc2e
 EKVw==
X-Gm-Message-State: AOAM530oFC22X+0rnn3jLQGPT/6wTK1qvJwzzfDL/zwnXLCOXuGmfRgr
 eFoyf0Y/USmwg3WM0wXc7wfTvwJTZLjucw==
X-Google-Smtp-Source: ABdhPJwbbHfG/N/F6u7ChCC5PsgbuJpx8sBxp+n8dzYWPhEFjSNk0vfZWLA1owZMK8ed2sk2dmfLKw==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr2885646wmb.94.1599648702270; 
 Wed, 09 Sep 2020 03:51:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z14sm3470048wrh.14.2020.09.09.03.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 03:51:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B3B91FF7E;
 Wed,  9 Sep 2020 11:51:40 +0100 (BST)
References: <20200908202352.298506-1-philmd@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 0/2] Acceptance Tests: update assets location and
 cancel tests if missing
In-reply-to: <20200908202352.298506-1-philmd@redhat.com>
Date: Wed, 09 Sep 2020 11:51:40 +0100
Message-ID: <87o8mfp6ir.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Cover from Cleber's v1:
>
>   To minimize the inconvenciente caused by test and job failures in the
>   future, an option is enabled that will cancel (AKA skip) tests early
>   when those assets are not available.
>
> Pavel Dovgaluk (1):
>   tests: bump avocado version
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   tests/acceptance: Add Test.fetch_asset(cancel_on_missing=3DTrue)
>
>  tests/Makefile.include                    |  2 +-
>  tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
>  tests/requirements.txt                    |  2 +-
>  3 files changed, 14 insertions(+), 2 deletions(-)

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e


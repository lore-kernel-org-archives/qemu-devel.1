Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1DC742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 07:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC1A2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 07:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOgRJL+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC1A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmCLu-0002kR-Ce
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 03:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hmCLk-0002Kt-9N
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 03:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hmCLj-0005W6-9l
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 03:21:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hmCLj-0005VL-0e
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 03:21:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so10726692wml.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kjUK6WMM5MDM53tNxMeSu7jyIivzWxMAGFXmxF0ezdo=;
 b=qOgRJL+sGgJfM5RSp1jGRSibvJUhgYyUA5kFgYKlYqL1DO2E/ZwfLuYUVr2D58jBUd
 rLTXbPzOiUYf+NERUm58FWwkxQJGepYr7l4NomYncbgCek4OkiTPiQWwf2BWtd4LUITf
 YO/oBJvlrovw5td/17WGoQup20dRkmR2R48qc8EjtHDr13fFxnvSKhvHU/5jUhPIjDP4
 Ka4c46iMPz8xxzOXygpU4YlxmJiDtHsSXPp2dCmZyjWbwSZQMLDOSdTwceyzg7EpJHE4
 cVX3tkepQPOfSWSRqjj3Juzb6ZwQVsyl6SoS5PL2pF3wfiTnvWK+QCMz3eJbTvIidON4
 E7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kjUK6WMM5MDM53tNxMeSu7jyIivzWxMAGFXmxF0ezdo=;
 b=YXqVutJkt6k2QBF536chqusy6lTZtQPx0xZkyCmqvZZHXp9juSsZCGsXPtzlTt/pOx
 E0oBRoH84GALFWTLV5M5DflQjCZG/loXo8W9POJUkpc9J4TexZloVZ2D3pZaCuorvJWB
 kPZui4DEwpZFo0W0C1J4QdhH7uxLq5OkxDohHJheVKdv3Qtb36jQRJ1QN1fDo+6xinNr
 K8CDWAZqvOp20r2/c6ld2xlsPeWFTy6dCt94CxXq806SgiSp404ku4Go7Rt4ooi3H2bj
 O2OvnO9a85U5ZcL2lk5gcLMv9Npebm02QlVjSORndJlbBGkoIhVpnJJ+z50Yxbotqvww
 hn+g==
X-Gm-Message-State: APjAAAVDPTaq+hYMbb+OGsHSAHyvJU0yzZuRb8ec31rSsW4g8VXH3416
 2vn9toGiLAOHVbOGQOIPUW7myw==
X-Google-Smtp-Source: APXvYqxW7HRIc0JfgzphUEE/Dm0dHDm2sZx20NuJTLr0IsoX/cYto3f7OgjpO07Mso08OfOfq5wpRA==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr14173293wmf.0.1563002497423; 
 Sat, 13 Jul 2019 00:21:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 91sm18712403wrp.3.2019.07.13.00.21.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 13 Jul 2019 00:21:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 869BC1FF87;
 Sat, 13 Jul 2019 08:21:36 +0100 (BST)
References: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
Date: Sat, 13 Jul 2019 08:21:36 +0100
Message-ID: <87h87q4cxr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [BUG] nanoMIPS support problem related to extract2
 support for i386 TCG target
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> Hello, Richard, Peter, and others.
>
> As a part of activities before 4.1 release, I tested nanoMIPS support
> in QEMU (which was officially fully integrated in 4.0, is currently
> limited to system mode only, and was tested in a similar fashion right
> prior to 4.0).
>
> This support appears to be broken now. Following command line works in
> 4.0, but results in kernel panic for the current tip of the tree:
>
> ~/Build/qemu-test-revert-c6fb8c0cf704/mipsel-softmmu/qemu-system-mipsel
> -cpu I7200 -kernel generic_nano32r6el_page4k -M malta -serial stdio -m
> 1G -hda nanomips32r6_le_sf_2017.05-03-59-gf5595d6.ext4 -append
> "mem=3D256m@0x0 rw console=3DttyS0 vga=3Dcirrus vesa=3D0x111 root=3D/dev/=
sda"
>
> (kernel and rootfs image files used in this commend line can be
> downloaded from the locations mentioned in our user guide)
>
> The quick bisect points to the commit:
>
> commit c6fb8c0cf704c4a1a48c3e99e995ad4c58150dab
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Feb 25 11:42:35 2019 -0800
>
>     tcg/i386: Support INDEX_op_extract2_{i32,i64}
>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Please advise on further actions.

Please see the fix:

  Subject: [PATCH for-4.1] tcg: Fix constant folding of INDEX_op_extract2_i=
32
  Date: Tue,  9 Jul 2019 14:19:00 +0200
  Message-Id: <20190709121900.25644-1-richard.henderson@linaro.org>

>
> Yours,
> Aleksandar


--
Alex Benn=C3=A9e


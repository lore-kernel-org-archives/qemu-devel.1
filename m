Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9CC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAFB206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyikJJ7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAFB206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCKcc-0005Wu-2H
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jCKbv-00058G-H4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jCKbu-0004Vk-11
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:58:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jCKbt-0004Uq-PQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:58:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id h83so1961097wmf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gbSZ9mOdwfgbvfFOPtxe7QuKMHGchSz65fWq7bDZzpE=;
 b=WyikJJ7MxGVHsp60KIsB0VkU9ugZm0rWtyYdsodCXWrTP0YTwIi4+8ruRWG5DDeXqp
 o3OwKTs6ENmsbb/P6jai9OuxjsIbPpmoDgAJSSpYWQNRVL0lH2LfNQVyGaBGV0MuZb1c
 I3STIJ+GAJxPxQ1LGo5u4KG5BuR49DEGK2JBQYIQitLm09oh67MRrtOKGmwzqrkCI+1g
 bIh6GZ9dQ4o3dEf8+jdrZc8QQXfB6FaH0ftfMp7c6WYInzYb2YSjqqTHUJCcvgKXyHe+
 mNG7C2hnO+eNDpEeFnMuRbE4SwPD364riil6ybLL/efMQn+oOD+irNkKgs5ypO55CmOc
 O5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gbSZ9mOdwfgbvfFOPtxe7QuKMHGchSz65fWq7bDZzpE=;
 b=L6vUvX/rG/q7trckPn8gB2ToxpEAW6q1EVBk+6V7/peoLdA7wjE5Vc0n+1j/t/4kgV
 IXIypin77qanaMv2FtzR3SmL2rcZ7F3Li3aD8OrQhLLXbSY+ekiYb5ZmkaLVdR07hCGn
 EqYjDpHQD/IN/GSYXGh3RbN0udQP3ISnAZecO7LznOu4TeixZ0xrspsgZDm90UXB7nGI
 GuGd6DjwgFAUcMZ7DFLgdi7uiz8kM40C9UAm054QGE46zlLLopgBi79hj8EN9V/Eb1AT
 PoxDIzQsLq6mvcN/hSyMn/RNcm2VThFxyYUXbGTmanoMB7nXVKBUXKmqPXxF8Lsi8ixv
 n7Kw==
X-Gm-Message-State: ANhLgQ2OmuUltpY4dbrmFD6n6KEORlzOy1sVrOSoELJYeQoPxI/cCT5k
 JHpmtIb6HroNLengEmGio64qgAQoKho=
X-Google-Smtp-Source: ADFU+vsVMNZc7P+Y9XEsnPaKDZpQ51az5ir8YFbMeNEsl5QcQDnrATFIooJB8+rzv1g6rSO/ge1ZQg==
X-Received: by 2002:a05:600c:22c6:: with SMTP id
 6mr316773wmg.161.1584007115416; 
 Thu, 12 Mar 2020 02:58:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 12sm11848778wmo.30.2020.03.12.02.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 02:58:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D7001FF7E;
 Thu, 12 Mar 2020 09:58:33 +0000 (GMT)
References: <1581603905-21565-1-git-send-email-Filip.Bozuta@rt-rk.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Subject: Re: [PATCH v2 0/2] tests/tcg/multiarch: Add tests for implemented real
In-reply-to: <1581603905-21565-1-git-send-email-Filip.Bozuta@rt-rk.com>
Date: Thu, 12 Mar 2020 09:58:33 +0000
Message-ID: <87d09hgaie.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Filip Bozuta <Filip.Bozuta@rt-rk.com> writes:

> This series covers tests for implemented rtc and alsa timer ioctls. The n=
ames
> of ioctls that are covered by these tests can be found in patch descripti=
ons.
> The functionalities of each ioctl that is tested can be found in patches =
that
> implement them.
>
> Some of the features that are accessible through these ioctls are not sup=
ported
> on all test host pc's. These tests were written so that the implemented i=
octls
> can be properly tested on pc's that support all of their features.
>
> Both rtc and alsa timer test folders have separate files for manually wri=
tten
> and remotely obtained tests. Tests that were obtained remotely run multip=
le ioctl
> tests at once, while the manually written tests can be used to run both i=
ndividual=20
> and multiple ioctl tests based on the command specified when running the =
test.
>
> Filip Bozuta (2):
>   tests/tcg/multiarch: Add tests for implemented rtc ioctls
>   tests/tcg/multiarch: Add tests for implemented alsa sound timer ioctls
>
>  .../manual-test/alsa-timer-ioctl-manual-test.c     | 294 +++++++++++++++=
++
>  .../alsa-timer-ioctl-tests/remote-test/timer.c     | 158 +++++++++
>  .../manual-test/rtc-ioctl-manual-test.c            | 352 +++++++++++++++=
++++++
>  .../rtc-ioctl-tests/remote-test/rtc-test.c         | 226
>  +++++++++++++

Because of the placement of the files these tests don't get built and
run when running check-tcg. Please integrate them properly into the
build system.

While we do have some manual only tests they are really only
placeholders until we can figure out how to plumb them in properly. You
can skip them by using a special run-% rule, eg. the semihosting tests:

  run-semiconsole: semiconsole
          $(call skip-test, $<, "MANUAL ONLY")

>  4 files changed, 1030 insertions(+)
>  create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-tes=
t/alsa-timer-ioctl-manual-test.c
>  create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-tes=
t/timer.c
>  create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-i=
octl-manual-test.c
>  create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-t=
est.c


--=20
Alex Benn=C3=A9e


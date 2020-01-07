Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69452C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BF32073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLqCYP6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BF32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorPa-0003ye-AD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iorOy-0003Xr-WE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iorOx-0001RI-Rx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:08:16 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iorOx-0001Qu-ME
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:08:15 -0500
Received: by mail-oi1-x230.google.com with SMTP id n16so14034751oie.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=0saChhg4qrhZ46e1NiOXLlVi1TRckAWKj+w9jP0rvMo=;
 b=XLqCYP6w0oLrbweoKm1J3LAcW6kTlsAMddR8HGu1dIak/S85niMEE3JZXfSHgwgbVS
 ujMBf4pnQMeb9MA+bg1vOWodJOo0k276HT0jvn83ugsGOvBQDXKtcqJlbCAZJ3XjUQBn
 cueVFmmbpW2mcVh9v740d6eo7OZKswYJCf5nynfPqtKQ4O+19r9b6GyJlFb4bSIYOqdI
 9aQwTitImsm/SkiKxLpDLR2J2fgC9XqYXjVeLF0Xw1rHncTvE/DCcq9VC0lpcD+3NO0a
 k6wEfZ/7dXqUJqpTS+HOYShNCAj54h9pFdP6PKIgJymDxLi4Esa1K6a7opO8NydIJ4FT
 vKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=0saChhg4qrhZ46e1NiOXLlVi1TRckAWKj+w9jP0rvMo=;
 b=UptBGuytDfYUx9lD3F9ht8UdkJhk+ivbgsq6bxK4yrEnJ/4aC+qjSzHlbPWbft5xi2
 a4qI5G1/lH0DWH5UGjY89lQ9NGr3/OC5qolHwfdA4BcGoBhvEZVL2PznIaO0zqf1cqMi
 BjYBDQYuG3M+loXVt9r7f1cYjjkJ/XA4f22frgLPVXoBY/ioPJrgVq8ZOvNpN7qDjPFG
 CnTfUt4yVlK8NixF/oVYGbxGT1UrAUevDSZkJareHG4ncswYpyXo0eWDAUYe28GFsu+0
 QdVredyhHmG3+SLsC6HHyfGXZnBPNjQGqcBim84pOlLiIhxN5XLWDn7uD/jPdlAgN42J
 Ss2A==
X-Gm-Message-State: APjAAAXdpY7HGcPzHPYn//pJM3GhNaobWOsCXIspK/+baqbwMFDfm3mU
 4DhNs2tdQrurbpK5ALi4qqHsqAmHcLP6L79mlZ3bns4D/GI=
X-Google-Smtp-Source: APXvYqzgTmv+JDlsbqD+C1CXHMzPMb9sZQmy1hFpj0c98m+k9ttMN7npRjALrKxQ0ORkf2/G/a8p4XvWaeO2V22nKXk=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr301046oid.98.1578413294576;
 Tue, 07 Jan 2020 08:08:14 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 16:08:03 +0000
Message-ID: <CAFEAcA-U1JqzH8m2AWV7KuJKm0WfczDKK+ddzPs44y9usujB2Q@mail.gmail.com>
Subject: race condition in tests/fp/Makefile
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've just spotted this issue with tests/fp/Makefile which I think
is causing my tests/vm/netbsd builds to fail:

tests/Makefile.include has some rules that invoke a fresh make
process on tests/fp/Makefile:

tests/fp/%:
        $(MAKE) -C $(dir $@) $(notdir $@)

tests/fp/Makefile has some rules that invoke a fresh make process
in the parent build directory:

BUILD_DIR := $(CURDIR)/../..
$(LIBQEMUUTIL):
        $(MAKE) -C $(BUILD_DIR) libqemuutil.a

$(BUILD_DIR)/config-host.h:
        $(MAKE) -C $(BUILD_DIR) config-host.h

This means that we can end up with two 'make' processes
(the original top level one, and the one invoked by the
rules in tests/fp/Makefile) both trying to build things in
the top level build dir simultaneously. They then step on
each others toes and the build can fail.

In the most usual case where "make" and "make check"
run as separate steps, this doesn't happen, because
libqemuutil.a and config-host.h will both be built by
the "make" step, and then the second make invoked in
"make check" will fairly harmlessly see it has nothing
to do. But the tests/vm scripts all directly run
"make check" without a preceding "make", so they can
hit this.

I guess the best fix here is to move the dependencies
on libqemuutil.a and config-host.h into tests/Makefile.include
(though then you wouldn't be able to stand-alone run
tests/fp/Makefile -- does anybody do that?)

Also, should we change tests/vm to separately invoke
'make' and 'make check' ? I think that doing a single
'make check' is a bit fragile because we don't
really test it and there's no rule that says
"check depends on all" or similar AFAIK.

thanks
-- PMM


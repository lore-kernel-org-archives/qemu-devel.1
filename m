Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D7C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FEF20780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI2F9z5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FEF20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy4R-0004o3-G2
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZxUJ-0003OP-HE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:40:43 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:32936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZxUG-0000D2-Hm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:40:43 -0500
Received: by mail-ej1-x62c.google.com with SMTP id 7so24473113ejm.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Uvy/IRiXB6+4yVVLpuaK04e+lQGaUXQngNHwxb3om4I=;
 b=nI2F9z5Zh/YchWYnqJ8eqWeft+mW2ehY5YKkLpNirPr4yaX3oPI+dA39dsKRTY6usz
 p92ojfm0wv2ox1nXdkli8vcX30PoS3QSC+TtcQetyHQgIa1JqpGeqVNiR/2bpYWzFprB
 DUNg+LqvPK2J7iZqaDrGuiYa4xqM2mVlRGijtFN+cLBvXQcMm64IlSamwqR150D000BT
 9DQJQ8TE1v9AkXymJOORb0w23KkHsMqabZLRkR8SpnLkVOfaqJFhsRkFs3LsYd/sJKMv
 fehQqlLSwL4d0RgM86CmtsobunmDH4J/hHMokff5cTMO6lxBSopfQr8AmUb04uMtDHfM
 LZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uvy/IRiXB6+4yVVLpuaK04e+lQGaUXQngNHwxb3om4I=;
 b=YVANmgc0LQrdyQhuS0rKJfbW55vXoOLEIJhs3nQn0+h8RrG58b+jXbrTkDnCV3iu38
 Qn4IygIn1c3faqfHDCf0u+SpHZ0qQEiD3sb2YGDiz3AsMvLfuxpAWb49SL4YWYYYBb5j
 oydejts5ekS6Zvmgz4o3AHFkEM6ZuUdonm+Nbn2CTbXxgW/lSijpUnufgzamkbwAxpNI
 T0/d1ZAPAlTT31AdoP/PsfIuUg0+v24GAncKcptaKHA/U1O51NF4mLyZdmyAyg5KEjg0
 76Us23wCj+4Lb/BRDtc9ecIerLY8jDBlimKvV+9xk7mKPpwIBaQ0aAxJOsBIxUEZUc7b
 48zA==
X-Gm-Message-State: AOAM5331AFkEegZTS+UTGH2LbY9CM8Av+X46MNx5Pitjx/9SBDOxu3L7
 nnftpu54P9rATpR88kB5IfwxHmmfVrBa8JxJPanxNA==
X-Google-Smtp-Source: ABdhPJyWOYSQaE9bs0Q7Mjxm0p3wNF8K/h6B6DdePMtDfILgkBxYtW3okJW0iL9Ume6iLcpSvO08d6WjoInI3Wg22gI=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr20357852ejd.250.1604414438456; 
 Tue, 03 Nov 2020 06:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20201103024343.894221-1-michael.roth@amd.com>
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 14:40:27 +0000
Message-ID: <CAFEAcA-7FQd-ONSnsnK5nRs5wqpc47Dfqa8MRKEJXvt_5cxcsg@mail.gmail.com>
Subject: Re: [PULL v3 00/12] qemu-ga patch queue for soft-freeze
To: Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 02:44, Michael Roth <michael.roth@amd.com> wrote:
>
> Hi Peter,
>
> Sorry to get these out so late, for some inexplicable reason my email
> client decided to flag all responses v1 as spam and I didn't notice
> until I double-checked the archives this morning.
>
> I've fixed the gcc-on-BSD and clang-on-linux issues you pointed out
> (PATCH 6) and added proper test coverage for both.
>
> Also, the qga-ssh-test unit test introduced in this series triggers a
> failure in Gitlab CI build-oss-fuzz test. This seems to be due to a
> memory leak in GLib itself when G_TEST_OPTION_ISOLATE_DIRS option is
> passed to g_test_init(). I verified the unit test doesn't introduce any
> leaks when run without g_test* harness. Since G_TEST_OPTION_ISOLATE_DIRS
> is currently needed to safely run the qga-ssh-test, I've disabled it for
> now (PATCH 9 and 12) until we figure out solution.
>
> And finally (hopefully), I addressed the checkpatch warning regarding
> disallowed use of various g_assert_* macros. I previously thought they
> were just noise until Markus pointed out commit 6e9389563e.
>
> Sorry for all the noise,
>
> Mike
>
> The following changes since commit 2c6605389c1f76973d92b69b85d40d94b8f1092c:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20201101.0' into staging (2020-11-02 09:54:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-v3-tag
>
> for you to fetch changes up to cad97c08a1c17830d77a46780088bc0199df89d1:
>
>   qga: add ssh-get-authorized-keys (2020-11-02 20:04:13 -0600)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
>
> * add guest-get-disks for w32/linux
> * add guest-{add,remove,get}-authorized-keys
> * fix API violations and schema documentation inconsistencies with
>   recently-added guest-get-devices
>
> v3:
> - fix checkpatch errors regarding disallowed usages of g_assert*
>   macros and other warnings
>
> v2:
> - fix BSD build error due to missing stub for guest_get_disks
> - fix clang build error on linux due to unused variable
> - disable qga-ssh-test for now due to a memory leak within GLib when
>   G_TEST_OPTION_ISOLATE_DIRS is passed to g_test_init() since it
>   break Gitlab CI build-oss-fuzz test
> - rebased and re-tested on master
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


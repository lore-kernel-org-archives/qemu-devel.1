Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2185C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A0F20878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOOj0yrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A0F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsm7-0006oW-Ll
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLskZ-0006Du-8Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:47:19 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:40774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLskX-0000OY-J1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:47:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id p15so4404995ejm.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2CrUYvsvO1dJNMRiPVkQsdbkPEE5YJhAUOJR7I2oqOE=;
 b=rOOj0yrRaSHaEfP3Q5Y5BSZ5ESVGDBp08r5cF5od6Amgln+lCBH34stDXswekHs10x
 832wtcGydb5CgGsIYxGAZKxLJGjt8Zdqn0LKfu50K/ngUQ05CK/PRI0/ylgG8qItSdAS
 3DzdgOyscLzD/8e2UeeXuT1189LrevjhVKbsAjriXJVdCOy9cg6okeTteRoUx85SEBK4
 NqneqUmAW2zG4cZXi7amY0pkcI0SO14/aMKmnrlbEEoS5Dylvn7M56bOXoUETdE198mh
 CpU0SSUwrvId0eBvJto8SbMr2hRhgv4ulAg/AOes0QpcACZyIcJHynQbVdX/kf80BNfg
 ewMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2CrUYvsvO1dJNMRiPVkQsdbkPEE5YJhAUOJR7I2oqOE=;
 b=N7pMIJBaMqhMm1HxECCCZpqgOl4TqQj1ms6dShbp4JuhFVMQnDQmGb4Z6Pk/tsvAbr
 3zOZf0r8vAArUeSpQlysT59LHuQp1SfJdBJpzhyE7Cbh1uWtwWJQO/3vjHh+hj6mVh9a
 WOnCa8kaulieXeqzAW9etJli6L1kpcNom/jgp3iszQrHD+6tEmsnU6/y4x+CyL069c+P
 KQSwxEure95PsERGTgC6XaR/9P5zMx7TOWME+lPHAmJ2/Nj9ot3PRXH7RFYGGzIkIPzV
 abJgMvUpHngSolBeK6PD89dP5V9K4IZ4MfOH+x+w86ryT+pYqPxGF/XOmuZ8yRXkkEEd
 ON5w==
X-Gm-Message-State: AOAM532Co3ICVd4QRN32ejuh/S6OaK31LuRk/ONDmDd/Vw+K3gA+WfGu
 AexXPwQvKQcv2JR2frtXVHz7IEJH34JLY4XfTfI0Vg==
X-Google-Smtp-Source: ABdhPJzQcPqPpXa618kLoW2VN8P9voMnFyjETOrFvSDm2nl4WNP3hHoN94l2sC2/lqPHGzUniqeJ5t8Fj5LLdhhy5OE=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr3903584ejb.382.1601059636088; 
 Fri, 25 Sep 2020 11:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200916122648.17468-1-alex.bennee@linaro.org>
 <20200916122648.17468-8-alex.bennee@linaro.org>
 <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
 <87imcdzwh7.fsf@linaro.org> <d04bee00-624f-c48c-89a1-d5e6cbbddb76@amsat.org>
 <CAFEAcA8PioiyU2t9bqJW5_HiQQKrhOScTQFBd+a7BY-fH802sQ@mail.gmail.com>
 <20693fff-9b29-3bf2-2d36-444d2724982e@linaro.org>
In-Reply-To: <20693fff-9b29-3bf2-2d36-444d2724982e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 19:47:05 +0100
Message-ID: <CAFEAcA_v+b=AckQb6pZ5ifia7NWTuOmSkoSQymSvbynZueP3+A@mail.gmail.com>
Subject: Re: [PULL 7/8] gitlab: create a build-deprecated target
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 at 19:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/25/20 8:54 AM, Peter Maydell wrote:
> > On Wed, 16 Sep 2020 at 14:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >> Should we stop building the ppc64abi32 target instead?
> >>
> >> From c609274b853 ("docs/system/deprecated: mark
> >> ppc64abi32-linux-user for deprecation"):
> >>
> >>  The ppc64abi32 architecture has a number of issues which regularly
> >>  trip up our CI testing and is suspected to be quite broken. For that
> >>  reason the maintainers strongly suspect no one actually uses it.
> >
> > It still builds fine and it also runs the 'ls' binary in
> > the linux-user-test collection (ie the 32-bit PPC binary).
>
> But signal handling is completely wrong

That is also true for sparc linux-user (RT signal frames
completely unimplemented)...

Anyway, my point was mostly that there is a class of programs
which do run OK on it, so we should continue to build and test
it to the level we do today until the deprecation period runs
out. It is not so badly broken as to be a candidate for dropping
immediately.

thanks
-- PMM


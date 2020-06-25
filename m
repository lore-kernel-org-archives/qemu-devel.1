Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB31E206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDUthEO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB31E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQs0-0005UQ-PX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joQrP-0004xl-Dk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:20:07 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:36068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joQrN-0001QH-Cs
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:20:07 -0400
Received: by mail-ot1-x32a.google.com with SMTP id 72so5038992otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xDGSQWdBUeKrjncZoF9HjXvaA8WUE/gScSOUHRa0bc8=;
 b=UDUthEO/xX2DvSYuuIFNIMrANfVRQwZG/PH3UiKxeLQP3sLxr+MW1API8NrSJ45B0q
 P8i+0W7wXqAZIU6+v98pSQMDY+Uoj7cgKJrztF1Wm/CxLVuLZWDf8c7elh9hbLhTCv81
 U7j4m8wUM2Nubt8sAyqJWGWtEKcO+dVNQ9+Qm6uHiKwFufwZbwCQk+HBv620sH6KRNZL
 j9fNtVe+hQGJIwnVj9xKu6RtZkaTDaz2L4XvHRvKNCo2rYYLQXrV/BUPsVNOrfKZ2LSQ
 r/0RMTiK6e5rDUFtowX2bhgXZyD3GVmXlI4ZHTLbuiq3n4FdAERWDo6iAPxA9v3r9Z4/
 6uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xDGSQWdBUeKrjncZoF9HjXvaA8WUE/gScSOUHRa0bc8=;
 b=pPu8ICmtQymxs3im6QWxv4MgxWNT05JC/l0WUSgXbUoHV73Ho0k2dE/PqiO5jEHItk
 5orl8+VjrXGPKIVjE8an0rKJoQzBRCfpbr/nfp+8ODPWc33ckPkVA/BATlIFjGa6UYZI
 wUyb1dTv+UTOfdjKtPKwYrFSGy7idPR1URK8mYsRqMbdt+PcmijSsg87KLSyv1fm0+S/
 gPHdlMATm5GWXA9DEXkYr7GUxzA6dI74hQSJUFsFmb19C2YGV+MkpIHANLcCNCN63oZk
 QutFIhIDLdOKshc198zmfuVoXwM8GL0nZvBfrNzjtspP0crM4rsmk+3h7BDDHCUqUEqK
 V9xQ==
X-Gm-Message-State: AOAM5331JAkLuQz2xEgRZmCd5x8Qmn2fypCyeYeAKZNoRApJqKfaCWXd
 zeti5lCgEr2lisTCJ7j7CtoogtjQsaJ3KxidjZOFgA==
X-Google-Smtp-Source: ABdhPJz+gozGZLA12iQ870NeavYDpTC5s7uo0oSh3TzMOdsX6l2LOsmg20y4Yd2PE80b+FwYWOx2x2hqt7x0iMRMocU=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr12633326oth.135.1593087603610; 
 Thu, 25 Jun 2020 05:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
 <b0ed03f2-55b9-43a9-32fb-acd6637114cd@redhat.com>
In-Reply-To: <b0ed03f2-55b9-43a9-32fb-acd6637114cd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:19:52 +0100
Message-ID: <CAFEAcA8v+QUGq9QE8GhivqZUJixumNOM7AgOMAK-e5VzAAFNhg@mail.gmail.com>
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
>
> On 25/06/2020 11.25, Peter Maydell wrote:
> > Here execution can fall through but there is no 'break' or '/* fallthrough */'.
>
> Should we maybe start compiling with -Wimplicit-fallthrough if the
> compiler supports it, so that we do not always catch these problems
> after they have been merged?

Yes. There have definitely been patches on list to do that,
I'm not sure what their status is.

-- PMM


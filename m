Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55542C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EC9206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulhpvin0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EC9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWD2-0000E7-Al
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWBV-0007V3-DZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:59:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWBU-0007rK-Gd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:59:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id m12so1510826wmc.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8z2i2yHEU8ksNYTgmhtWSxb3EtXJqKvtbYb6kEBRDT8=;
 b=ulhpvin0ZHm+xYWvLL1+xvojotqr3ktsqrR8tM498tBV/jgGYPHoTMATgHAqfZU2uv
 UuF/9+DpkYZI6pfmDV9UWvu14QI0pX2DIwX34jb3egyOIGhD9PsvNuys6CgaVyOmZlpX
 Y1hhSSSHqCvCb2+Ak9l17dnIGF5r1e01xF3jCV5I55PmrcAb2mbgcjj9SRCcoqofiHya
 6+NEdYQIWi80zdqiDxUTiDLbgXk5Gasa8KC5HdAOodQuYr7lZ20kokoR9TRCQbbq4TyK
 3Pgs6lmL3MjP7HL4o1PjeLUFrf22cSdVWL3X2/v3Lz3yQljOH8XEaOfpjr50IXrp9MSN
 zu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8z2i2yHEU8ksNYTgmhtWSxb3EtXJqKvtbYb6kEBRDT8=;
 b=WY69PljfEIKqjSbki+NVcqebCpwk2tjKEgky0+hTlwJ73mR+Z4KTBXArXFqRHOq9GU
 4y/LxJPPNkjHx/miT3WYNwaKwlK+lZUuyljmEwZtx/LUqPk3uEgeNW7ALxvsDESZ4x+4
 9NpFX1qPWPgJC5CXmM8/cY7dCnbOSuhclTbbYtoEtXN/8ww62BWzYVNwSwvbpugr5RIc
 IesSgQf8Xip4bx5Xf50TquLFfDauhdoTzuAZc0jAOYBR9JlTDuQKfXjvoM9JmU/boMTl
 c5PF1jXqVm4991+kdeOOu0JaImHUSc/7vM6GKeruJe+dgz0+/gXsmjwMz4oQFHoZBpsp
 Tf7A==
X-Gm-Message-State: AOAM533koUWfziYXEsm2KZHdrAwx938vUCC0jbPtT/McjLG4TQz3jyPI
 K4TmCRMoKGl1hTfx++h8rqo/5mBcxhA=
X-Google-Smtp-Source: ABdhPJx8dMW9EMIzmntj5YzcSKZBzgbFTNe4L30DSri4hXhVYfYLT4UBk9rPy1i65wgKQbdF8SD5Gw==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr2988983wmc.137.1589533150987; 
 Fri, 15 May 2020 01:59:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z22sm2332585wma.20.2020.05.15.01.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 01:59:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C1E01FF7E;
 Fri, 15 May 2020 09:59:09 +0100 (BST)
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 1/5] target/i386: implement special cases for fxtract
In-reply-to: <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
Date: Fri, 15 May 2020 09:59:09 +0100
Message-ID: <87sgg1d15u.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> The implementation of the fxtract instruction treats all nonzero
> operands as normal numbers, so yielding incorrect results for invalid
> formats, infinities, NaNs and subnormal and pseudo-denormal operands.
> Implement appropriate handling of all those cases.
>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  target/i386/fpu_helper.c           |  25 +++++-
>  tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/i386/test-i386-fxtract.c
>

For test tests:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


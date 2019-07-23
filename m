Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40742C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3C920823
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKpyhoLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxYU-0005ch-89
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpxYK-0005Ca-PV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpxYJ-0005sZ-PX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:22:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpxYJ-0005qF-GF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:22:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so43812003wrf.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xr6yWqjT8XGH8dPPITKN+aYf96+48XugMiZ1OG+mBJA=;
 b=IKpyhoLb7jhrag2f07YTNujhcSlHPctdODvX2hct1qGNCEi5AOjflNgsbhketGsBq/
 Tzj8em0N/+wnxzzdvssyXfUe0ZDcl0GVKdcJ1mh4b3h8EJeM94Rus8T73PNNF/M9ZbaJ
 3ywYL4xBYdNEBBQGVgKYORJpCsV7d0Co43qWEH5QeWMlo6TiWEi/AYM1ZnHdaisdjW5H
 uXPgqiFotuNSVJpwDXRfh+nmbdKc35ccX362S1Oax7gMtdJT2tCsREXEQy7DV7Spp+u7
 jwbt4JUDSKVPNnyxa7P6NKxBDGciHm0zYNT9zRkVJ1lRX/AOxy+S8KiIJPxW4tKYf0hV
 8xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xr6yWqjT8XGH8dPPITKN+aYf96+48XugMiZ1OG+mBJA=;
 b=OvtRh1XJzhjFb8rfRPXJlWwcVm6a11ZA9mbSusRC8JyMvWT5NBh0XNbqBF4ZRKNAtv
 s7Gn3Gadiz0pbxxWHsON1tQA2iXBDflUvAiVaGFGRk+1dowkKDBy6fZq689j0wuDXCaQ
 4A2RE6RGteyMvFiFHpi4U18uZMDDWqJDDHb3oxc7EhEj0a+Osr5qpvQ0maHo/AT/QWDe
 emTFFcQ0Hekj77sMiVSqKMDRnCMOocNXKmEjbphiOgdQXS5VMkW0NxGrX4Oc40CLnle6
 xTJylbJC5EWxokUH+qDhKkfxj2gjrAA0V0ARQXpuK5igyhW7A4LL0p5GmeFCyy11GE4m
 7xCQ==
X-Gm-Message-State: APjAAAUxfsMVMGwsI1hbJwhZ1aQ2hHpyt28ep1hQQswtiHDLUbgyEMB2
 XXZWviiJio0ZyCLXx8Q+cc7Zjg==
X-Google-Smtp-Source: APXvYqxEdCwm9sXLDLzGNiWobI6YOSQGqafozsoHd/AjvV5alWJceg7zi9WsnXJCy06663EjwmJiEQ==
X-Received: by 2002:adf:e343:: with SMTP id n3mr42148471wrj.103.1563898929932; 
 Tue, 23 Jul 2019 09:22:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e19sm58208964wra.71.2019.07.23.09.22.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 09:22:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08F521FF87;
 Tue, 23 Jul 2019 17:22:09 +0100 (BST)
References: <20190723153730.1808-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
In-reply-to: <20190723153730.1808-1-alex.bennee@linaro.org>
Date: Tue, 23 Jul 2019 17:22:08 +0100
Message-ID: <87ef2g2027.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL v3 for 4.1 00/23] testing updates
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The following changes since commit 4da6c0f9ebbdaaf4315c71ccd288d02b9087f8=
af:
>
>   Merge remote-tracking branch 'remotes/amarkovic2/tags/mips-queue-jul-23=
-2019' into staging (2019-07-23 12:49:39 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-3

scratch that, I missed a line continuation when manually applying the
apt-update patch to the debian windows image, v4 incoming.

--
Alex Benn=C3=A9e


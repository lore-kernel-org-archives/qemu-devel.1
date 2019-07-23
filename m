Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39293C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065A121670
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoC7DsLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065A121670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuN9-00063c-BS
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpuMy-0005fC-V6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpuMx-0004dZ-VO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:58:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpuMx-0004cu-PJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:58:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so38431844wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KuCZ3j6/LkBN+3wxvLKw9aEKdFta6SJvI9iP+60HM6U=;
 b=RoC7DsLBwnkHmLgqP8d5s7vurY33PibIsMwNVRJYchar9wt+wx7lABY/JzKCWloFv6
 z1t9BsKNQxIB93Mgj4AjRBsGTbZhtxjWb6+0T8gZhpPNjaifBrpkDeb0hzA3rVFpF84f
 N0zUJ1TvXLxr2IUSxulSqotGJt2pegCXNikAioDkV6DqyECwrl2rF3L8WAEEQFYfsWNu
 O1AwK06GIp3Yg6SYgXXtp73eB6xjlzl/jZkGVliEjwdoGyNf7yJOKRTM1eOoCX65yqK8
 qKLyxw0aJ1JNI+cDlF0eILmYFfQiwbuZykKuoVuhBa83lfwN+5aO6YFcHJU8/6RN22CX
 17Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KuCZ3j6/LkBN+3wxvLKw9aEKdFta6SJvI9iP+60HM6U=;
 b=PreZKP4gBacD3ieyjOCKEnA6mskiUAk4tRLeYtHJyYC4+gKG8ZPGvFcVpWRPfbPg7X
 W8vLyLrrZUUmswfDv9RDHYg+syEeK95ioiNbHl5p5rfHjgLLa1V2Oweo0fvGT8TuP7H5
 qOwXmY2Ze9Jss6tr8aMDGlYSX+RyaKBJaRL963TfuHd/RGFqAAo8Jf4XLeatoKSvVRMA
 hcthb+Rca5/u0F+r+o6IXfvpNd71zBCuiSYzQ58KDrSpulqbKpgyLnNsYnOVD9OFOGWt
 Uobahi08CnEWEPCybDOnqVo+zd3uI40C5ZkZu3ZhTCbAvwUwiZtYgDbkjkkLF1YSW5m/
 A9yQ==
X-Gm-Message-State: APjAAAXMYmvr1Idw8lpNfSuukM3IEH+ZyfnuzJ/WdZC4rfpHupK0tFYG
 7RQl4odnCCTKgcosRg6J5TYP4g==
X-Google-Smtp-Source: APXvYqzAaX/cENq3igCtS3v543rI3KiipsGKou9ejX/npatmsJ67toHCREGwnF5+XAXDTwr/EtG1XA==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr19160441wmf.35.1563886694526; 
 Tue, 23 Jul 2019 05:58:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t63sm35869287wmt.6.2019.07.23.05.58.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 05:58:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B37DA1FF87;
 Tue, 23 Jul 2019 13:58:13 +0100 (BST)
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
 <87imrt0y9a.fsf@linaro.org>
 <451b91c6-3a4d-afb4-30f1-595fcc7e5f65@redhat.com>
 <CAFEAcA_O4kegKUsSfzQhBp_AnV_uD1S=F4pm0V0nG6XQ2Dyseg@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_O4kegKUsSfzQhBp_AnV_uD1S=F4pm0V0nG6XQ2Dyseg@mail.gmail.com>
Date: Tue, 23 Jul 2019 13:58:13 +0100
Message-ID: <87ftmw29i2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green
 CI!)
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 23 Jul 2019 at 13:16, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 7/23/19 1:46 PM, Alex Benn=C3=A9e wrote:
>> >> I see Thomas Huth has a patch on-list for that, but this
>> >> didn't manifest as a problem before this pullreq.
>> >
>> > OK, I'll add it and rebuild the PR.
>>
>> But Thomas got another error later...
>
> If we're not sure what all the needed fixes are we
> should probably just drop the change that starts
> running the iotests under 'make check'. Otherwise this
> pullreq is going to miss rc2, and it's too big to go into rc3.

I'm just double checking now - it does seem OpenBSD is very slow even
with 18 cores assigned.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e


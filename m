Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C1C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrHXjY+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C1C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYx2-0000Hb-Mr
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUYwO-0008I3-ER
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUYwM-0005Yk-VI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:22:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUYwM-0005TS-Kc
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:22:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id 8so3642780wmo.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UBXjsqQUcqNUyCDlLi0zZZgtyo1Pm4NLb9ARW1ugJ6Y=;
 b=CrHXjY+ts7UF6+YccSiujin/iLExIS43RvKfdekNkZCIMXjvEHG3w8QUNORF37Yg+A
 bfvtZeCMNZv94xePNLKtjZmXmMWFtG2/C5T0ytxkFu6VvqTsWbAzlhUUIlw8X+MkEXnM
 66McNvfIQYlzI6m05/cM9/9JWcbShqr012BqgDuBVJtSUXCPtNTNEX82s4VN8Kcm90jn
 3g8PzmuLy8t9l0CNfucmp+bSqv6Cz0bzNMwtFrxJfEEs3SiuqEYgtiZg+SgVs5KOoCUA
 nqMRpibltrhVA2p9+m4Z6Rx89bT1f/dxjr/L+GWMj5aAF+Ga7XeRBqQeSgUh7v7Fx6De
 rJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UBXjsqQUcqNUyCDlLi0zZZgtyo1Pm4NLb9ARW1ugJ6Y=;
 b=KAOiw67DRNfTk4d6FAsaPgCwYYIDdNz2A6NSJ/sp2gS5Uvh+LTFKSSQCNTqAWlITNe
 1xBSWKO0uFeNt9TCMVUbnE4PqHFXd5592URniWBrb02pgR+uV5UC1kuDpg/jSUOAn5Ol
 GUasF8zzCRubTx2acR3wE5uuRpHAgwhey7fRURPZYpbHqc2sB/k1go7Zjky+UTzXoWhS
 QMrhVW7Nza27XVHEWirZ3I/fV70HtY8qZ9OvfBdoHCLciaYWTNltn/oO5Jqf3F3AgCBV
 H569n4AVdBaAoQJYm7Eh8cm0ubxtpWh+1+eNxd+CVe9rab87jNuZqQGElsSIOg5s/W+v
 YlLA==
X-Gm-Message-State: APjAAAULRntFRkl9FOs9NvI4pc+6Ar8QVO8hUKi51L4E5GJ5Dzu0sLq2
 7Yhrb5kHTIlc7U5VECHQ0xmO5A==
X-Google-Smtp-Source: APXvYqzBl0GJ1aMN6fcMAMy2AEf4ls+byXnOAgZQ544zpjhF+c+mknrWyAZaO8mRXpJ1OSedTlawfQ==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr4923348wma.111.1573575769063; 
 Tue, 12 Nov 2019 08:22:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y78sm5400567wmd.32.2019.11.12.08.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:22:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2487B1FF87;
 Tue, 12 Nov 2019 16:22:47 +0000 (GMT)
References: <20191112145028.26386-1-alex.bennee@linaro.org>
 <CAFEAcA_9AwoTE9zaKbiF6DkpN+O8LaEKGOct-m5S3yvFBHGK1g@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/8] testing and tcg plugin api ver
In-reply-to: <CAFEAcA_9AwoTE9zaKbiF6DkpN+O8LaEKGOct-m5S3yvFBHGK1g@mail.gmail.com>
Date: Tue, 12 Nov 2019 16:22:47 +0000
Message-ID: <87woc583oo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 12 Nov 2019 at 14:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 039e285e095c20a88e623b927654b161aaf9d=
914:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull=
-request' into staging (2019-11-12 12:09:19 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-and-tcg-121119-1
>>
>> for you to fetch changes up to 3fb356cc86461a14450802e14fa79e8436dbbf31:
>>
>>   tcg plugins: expose an API version concept (2019-11-12 14:32:55 +0000)
>>
>> ----------------------------------------------------------------
>> Testing and plugins for rc1
>>
>>   - add plugin API versioning
>>   - tests/vm add netbsd autoinstall
>>   - disable ipmi-bt-test for non-Linux
>>   - single-thread make check
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
> for any user-visible changes.

Yes.. I'll cook something up.

>
> PS: just noticed, but shouldn't the plugin-version change
> have needed an update to the docs ?
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e


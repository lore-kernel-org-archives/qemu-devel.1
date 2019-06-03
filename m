Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1839C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF4E2817F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyIS9gaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF4E2817F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXlaQ-0003nI-Su
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 07:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXlZd-0003LV-1T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXlZb-0007Yc-3Z
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:56:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXlZX-0007Kj-Ei
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:56:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id o12so4611598wrj.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=7r6ln4AhkJvg2I0Oa4Y+f04Ym4+FLx2AavSDsnH02uY=;
	b=wyIS9gaqVuNtAg7x5a5hKmZTAm42Oe6lI3SqgHbse5EjEy9T2YbiohjxLyO5Xany/h
	ssu+CEza+gqGvT1FNKK/sb9/xBoDq1c15HE2SG8BZ7blcnqWwX0IMKrod3oSYPVTjSqe
	F5zX3BuVVcwM1O5HgbOlsKmGZC0tbqccgr2pcWhSQH0g07TLe7us0kEJt4yYLdKvhenK
	GeRLhtG42wUDfs9/hHF+2ZGmFDIEPJDSCVMp1DAHUNNwqs3Hqv/+yTt3T5N8eLgoS3Ve
	a1evb2MX5L+Ctzlfrlyzoj/8QE5uQiaWBZEvS/eoEEsrwmgvtLAQHDa06O+4RDpu1Y4m
	f1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=7r6ln4AhkJvg2I0Oa4Y+f04Ym4+FLx2AavSDsnH02uY=;
	b=JVLJNZM/Pxa3EosKZhqfLH3OgHRKW+/6ypPxKRcNAknOoIHjOkg9I+sFzGrjv0UoL+
	XIMSmsICxM5g+/L07UI35WcWMh87/r/6ZaQ7Q2TnHvETcKf70/KOD1C9DP598OQUmAyf
	urFYGZwSI+ksswWG6U9SD49pSd1bG2ZMoSxW/JKg635xZYaT2Z2NmtB/PbpO49hafOH9
	tRgLbH8RObcL+reGYgj/jeqMQ+4FsUQCmJHgDLEbrGIvy0eTjtotIKFxl2Sj1gXIrhFK
	GsxnC3GKj0pKGlDiAJ3Qvr5Ow5yGFMLjqzMGcFR6EM6GusKlMZDDVrvZWlkkDu9d9OzB
	20+A==
X-Gm-Message-State: APjAAAVWGwFxtkRmjCZeoiofgI4yHNJA3yar45SHco/iUcLo3XMjE6Hd
	D5+UZZwScPkmH04v/dAagPwGQPg70lY=
X-Google-Smtp-Source: APXvYqzMCYFyKxxcSUns+0mFvZ5YZwmpleUY4YwFpJlWToYSm0rYceMdTIX6XDqPd4YfOSYQc0E5Vg==
X-Received: by 2002:adf:ed44:: with SMTP id u4mr2395011wro.242.1559562972618; 
	Mon, 03 Jun 2019 04:56:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n7sm11695191wrw.64.2019.06.03.04.56.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 04:56:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9E5FC1FF87;
	Mon,  3 Jun 2019 12:56:11 +0100 (BST)
References: <155912118291.12579.8926874795813611531.malonedeb@soybean.canonical.com>
	<155947076950.12691.8450256339566609756.malone@soybean.canonical.com>
	<875zpodsi2.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1830872 <1830872@bugs.launchpad.net>
In-reply-to: <875zpodsi2.fsf@zen.linaroharston>
Date: Mon, 03 Jun 2019 12:56:11 +0100
Message-ID: <874l56c278.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Bug 1830872] Re: AARCH64 to ARMv7 mistranslation
 in TCG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Laszlo Ersek (Red Hat) <lersek@redhat.com> writes:
>
>> Possibly related:
>> [Qemu-devel] "accel/tcg: demacro cputlb" break qemu-system-x86_64
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07362.html
>>
>> (qemu-system-x86_64 fails to boot 64-bit kernel under TCG accel when
>> QEMU is built for i686)
>>
>> Note to self: try to reprodouce the present issue with QEMU built at
>> eed5664238ea^ -- this LP has originally been filed about the tree at
>> a4f667b67149, and that commit contains eed5664238ea. So checking at
>> eed5664238ea^ might reveal a difference.
>
> Oops. Looks like tests/tcg/multiarch/system/memory.c didn't cover enough
> cases.

Actually I do see something with i386 host running the aarch64 memory
test (although so far not with a armv7 host):

  ./qemu-system-aarch64  -monitor none -display none -M virt -cpu max -disp=
lay none -semihosting -kernel tests/memory

Gives:

  Reading u64 from 0x40213004 (offset 4):....Error 0, 0, 0, 0, 250, 249, 24=
8, 255Test complete: FAILED

--
Alex Benn=C3=A9e


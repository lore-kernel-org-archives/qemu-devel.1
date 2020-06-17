Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F0AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1692920890
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjuJFxC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1692920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jla64-0006bR-DY
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jla5J-00067q-Kx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:34:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jla5H-0002iX-Ta
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:34:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so2796141wrs.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7H8TsmGJlaqcVcsvh13+bvDQjPCiTEy5FuW5B0YjCv4=;
 b=HjuJFxC64AMiNNeThNPYcEzPKWPW4uVgn4vS2MZAS3kfciQtE40bPjqS2iTyy1V7GB
 VBQpcOGbytG549JKH9w2rB5L8DL2ss7odyzoPp0L+15wh2JV9fSsC6jrrJmyHfHCCUaA
 aFzVFqoa1XOkQXqQU3ylh5/yCkCBEdAfRvs29LISlYPJwlJHGQ4xylcikBywTXGuxVmt
 /QqOePMi/9qwAy870UQHovh5qMMx3W/u6EyLnTdu8jiVeD5QaDSoZssufsixue/eIAoL
 1BysnEtWhryNH5v0hmyNa7P59DigIpefEsGAjH/zEpEFilV2Fy8yhbAsyutYxcantOR6
 PEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7H8TsmGJlaqcVcsvh13+bvDQjPCiTEy5FuW5B0YjCv4=;
 b=KFp+aHeL5ZFQZPfHIstcHb1rIUrlAOekVHPsxFh/gqZH/W5c6sHptrCZvvdv3KiwPl
 tn/eHWqRrtsKQAkgB/9bZ6Pdy6Vl36HE74o22JBH0efTvKOdFYavyI11fpk+K7PqdVA5
 Be78eFwejpwfXlhuvt3BXFEOsZUekVFbv0RaBnV2p8PTdW8TANu48DupuWlC4cK8T65P
 ckBnCdnLd+I8djBFYjMszpg7Mti1rtLyZIpFN/H+iGtGfnTJhLObdWAhr051scZejjiE
 Ekh8kM5Yd9FKUvvpQorhS2xOxLI2cqYpDhOOz+22p6Pfs2qLSjpN+ciHuZlZWZZtgBMr
 UyVg==
X-Gm-Message-State: AOAM532rv8WUlipKNZZHPUBVaCQUrUIh8O+Nb1cAW/T48CqlsOolrrxx
 6C1NlStBlm5Mw5T3/J8omQkKKw==
X-Google-Smtp-Source: ABdhPJzcSHkYBYCuBrYK+SZRluxNucZV0tj97sLgwff2aiZ+XlAtKv3YB4yE7t0cZceWoB/ZCUimkQ==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr8715881wrs.234.1592408078393; 
 Wed, 17 Jun 2020 08:34:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 138sm147435wma.23.2020.06.17.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:34:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 679DF1FF7E;
 Wed, 17 Jun 2020 16:34:36 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
In-reply-to: <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
Date: Wed, 17 Jun 2020 16:34:36 +0100
Message-ID: <87mu51wvsj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, aleksandar.qemu.devel@gmail.com,
 crosa@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eric Blake <eblake@redhat.com> writes:

> On 6/16/20 6:12 PM, Ahmed Karaman wrote:
>> Greetings,
>>=20
>> As a part of the TCG Continous Benchmarking project for GSoC this
>> year, detailed reports discussing different performance measurement
>> methodologies and analysis results will be sent here on the mailing
>> list.
>>=20
>> The project's first report is currently being revised and will be
>> posted on the mailing list in the next few days.
>> A section in this report will deal with measuring the top 25 executed
>> functions when running QEMU. It includes two Python scripts that
>> automatically perform this task.
>>=20
>> This series adds these two scripts to a new performance directory
>> created under the scripts directory. It also adds a new
>> "Miscellaneous" section to the end of the MAINTAINERS file with a
>> "Performance Tools and Tests" subsection.
>>=20
>> Best regards,
>> Ahmed Karaman
>>=20
>> Ahmed Karaman (3):
>>    MAINTAINERS: Add 'Miscellaneous' section
>>    scripts/performance: Add callgrind_top_25.py script
>>    scripts/performance: Add perf_top_25.py script
>>=20
>>   MAINTAINERS                             |  7 ++
>>   scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
>>   scripts/performance/perf_top_25.py      | 82 +++++++++++++++++++++
>>   3 files changed, 184 insertions(+)
>>   create mode 100644 scripts/performance/callgrind_top_25.py
>>   create mode 100644 scripts/performance/perf_top_25.py
>
> Are the new scripts supposed to have executable permissions, or are they=
=20
> always invoked as 'python path/to/script.py' where the executable bit is=
=20
> less important?

I would assume +x for directly invocable scripts - certainly we have a
lot of those in the scripts directory.=20

--=20
Alex Benn=C3=A9e


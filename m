Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F585C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CD4206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNZCLoQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CD4206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqOB-0002bl-7l
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDqNM-00029W-06
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:38:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDqNK-0000j4-12
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:38:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id c19so5507996wmd.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CtpIr4hz8fcxs0SKhTlETflSwz0TKcminOTaPtueDZs=;
 b=FNZCLoQFLkpC/YASiN8VWaGXzIfH5fPF/tdli4dJyI0osAsH0MyprCZDcDVCaZKHdm
 Sz2W87z4t4FL6X4PLbxWI24g7j6TySeKUzSJzzQ8yT3UXgXAYCB4eCtcTlON58EZFsMl
 yqyBk32S4d4/ZoZAqSYWS0r0IP0EhLop1s9I/jp5rDtzZD+MiGyeU23+umfDu4ufr8Q3
 22H0x1f9z5aygjBV800MYKopwLlit9oPR3GRo3wltkLbuR+C07CQuxPpwTl1xPaQCZBq
 d/yuUoz0SfgcrP9oiCUsAGJLiO2PbSopRjd7Hw5X3jnc0ENiK+B/iRaxDBh7aOKO5sfZ
 Kw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CtpIr4hz8fcxs0SKhTlETflSwz0TKcminOTaPtueDZs=;
 b=dacY3XDOqPZA74QDPTDxYwOzMy+WjF1NeG3j7Jz3hGBCijIE3xf+EVXajuK1Z7+eBu
 kMxHJrSueN5PX9RHv5VKa0FuFw9NyTDCs4GLM4vNZuOKptY9CC80fPn+tULAuqHTMB57
 SmSR0kia82owKVH8wcjBCVhRZ47cojf19ltX325AM5QWhhyXHSl3kKP9EG55mMp1ukVv
 xwWgHML1kxLW7dBfheFycA+0W4wiJCmhXLjiyHn6WPEVYMUA3aWcN5DJyt9jW26lmfW8
 ixR5sYPnhSiGMXJxPUsgkB0K2TfzLON7VtJpbmjKDg96nWoJQUiWSPhNfPcZizC7S+EK
 Sciw==
X-Gm-Message-State: AOAM533QqHH4nU4zStciOzzCZ5m+IIKNANwBpenlt17mFaavtJQrvCUQ
 jwHl2dCCH0+jVpiHE9ZkvLFKCA==
X-Google-Smtp-Source: ABdhPJwE3pT12j6F1gHBJhxLk3WMTuAgBMX/7g0p+w77yr4ETSKPmAaSxPbveKTGuS4iaTN8jq12kg==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr2797523wmg.122.1599143883781; 
 Thu, 03 Sep 2020 07:38:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w2sm2459576wmc.21.2020.09.03.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 07:38:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B97561FF7E;
 Thu,  3 Sep 2020 15:38:01 +0100 (BST)
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903113437.GQ441291@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH  v1 0/8] some testing and CI updates (re-greening)
In-reply-to: <20200903113437.GQ441291@redhat.com>
Date: Thu, 03 Sep 2020 15:38:01 +0100
Message-ID: <87imcv3oza.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 03, 2020 at 12:20:59PM +0100, Alex Benn=C3=A9e wrote:
>> Hi,
>>=20
>> My first series after a holiday is a bunch of clean-ups for testing.
>> Currently they all apply on top of Thomas' pull-request-2020-09-02 tag
>> which is currently in flight. The fixes to shippable won't become
>> apparent until the main registry has been updates with the new images
>> but I have tested them locally.
>>=20
>> The migration and mips fixes where just quick band-aids so I would
>> appreciate the appropriate maintainers having a closer look.
>>=20
>> With these we get back to a mostly green state although there seem to
>> be some acceptance tests that need updating.
>>=20
>> Alex Benn=C3=A9e (5):
>>   CODING_STYLE.rst: flesh out our naming conventions.
>>   tests/docker: add python3-setuptools the docker images
>>   tests/meson.build: fp tests don't need CONFIG_TCG
>>   target/mips: simplify gen_compute_imm_branch logic
>>   migration: use pstrcpy to copy run state
>>=20
>> Daniel P. Berrang=C3=A9 (1):
>>   crypto: fix build with gcrypt enabled
>
> Any reason you only picked 1 of the two pathces in that series.
> The second patch adds CI to validate that the first patch is
> actually correct
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00279.html

Oops, i got dropped when I re-based on Thomas' tree and I erroneously
thought it was because it conflicted with itself rather than another
change. I'll include it in v2.

>
>>=20
>> Gerd Hoffmann (1):
>>   usb-host: restrict workaround to new libusb versions
>>=20
>> Paolo Bonzini (1):
>>   qemu-iotests: move check-block back to Makefiles
>>=20
>>  CODING_STYLE.rst                         | 31 +++++++++++++++--
>>  configure                                |  2 ++
>>  hw/usb/host-libusb.c                     |  2 +-
>>  migration/global_state.c                 |  4 +--
>>  target/mips/translate.c                  | 12 ++-----
>>  .travis.yml                              |  2 +-
>>  crypto/meson.build                       | 42 +++++++++++++++++-------
>>  meson.build                              |  7 ++--
>>  tests/Makefile.include                   | 15 +++++++--
>>  tests/docker/dockerfiles/debian10.docker |  1 +
>>  tests/docker/dockerfiles/debian9.docker  |  1 +
>>  tests/meson.build                        |  3 +-
>>  tests/qemu-iotests/meson.build           |  4 ---
>>  13 files changed, 89 insertions(+), 37 deletions(-)
>>=20
>> --=20
>> 2.20.1
>>=20
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e


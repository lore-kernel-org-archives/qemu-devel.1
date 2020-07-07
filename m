Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E88C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246D206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfhYITud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstAv-0003Bu-Ub
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jstAC-0002lP-Vs
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:21:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jstAA-0004WO-Er
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:21:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id j18so305632wmi.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+UPksFEtj0BfztmjkHTlNTGEc53bcz2OT1EGm/FHc78=;
 b=jfhYITud1QS4YbTRmetWx7wvaLe3GUUe2YoACHHIpsJ/YODni2X8JFEQnVBQIPGP3r
 TejpkMeHRshJrzc32C5ZUv/U2zmQJ2UUE/T/q0YhLs1eGWyNEqg4lcZCbWPI5bCX5XGL
 IlxveWYHLB57UPiokQe+c1E19XzyjLFiycK5XhOMOyXjgldW3iJREb7A6LDo+0pEz0ay
 RzcLZE4T8/b9CAI8Qt71XJBQFN6IvQ2XXjCH2uSNnfBCyyqWi4SuAJQSj6ckFY8jq1kt
 CDxhnPWjukQKocrGnv1SNW+odZVPgAOYNG+Hu2DV+47Rcp7siAtFQv3jTuxWDsMUx7Yy
 LXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+UPksFEtj0BfztmjkHTlNTGEc53bcz2OT1EGm/FHc78=;
 b=lUMbY7rfz0c7yS5Tx2qMh6OHzemq3bCisrOwjUOvoicEYf0/0RebMXBJ25OQ2NNjfz
 AmDAP07vCXiwx3asLxeyqYQFB1LKVXEca0VQy76si5OIEF094j+xpAfdLIzqkbtIyWlN
 o0TqWmLTICPXkeqkIpj0n9/dkx/cUvyT2FVcXRF0XW+p8BojVGJuqI5lTSJWMJYIWOJw
 ToufyBNdb38RmX1k9VhwlA2PU2VJBM737ZLiDWnN7zBqqG58YDggGv6hhbXRmj2u5iDU
 rw7npEtQPIVyLwPpiSrCCux/rqMslDlWSOrBRgVIhO/55ZqBYQDDK9mbIWLdhixI4GQC
 k1Vw==
X-Gm-Message-State: AOAM530P0nOlfnCbJBV/xB3Bu0lQVUbkIPfq0VNEPGNkcE3PF+Zh+9CF
 9ZepFs2yz5T/XojZP5wOpNuMfQ==
X-Google-Smtp-Source: ABdhPJxKKkcNbV+SIhPn1P+s+DdGwXY6cVDqhXlKxZwuIpINveglwMTMjOG3c1Go5tLHXC1DEm/LHA==
X-Received: by 2002:a1c:acc3:: with SMTP id v186mr5951926wme.79.1594149712498; 
 Tue, 07 Jul 2020 12:21:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm2463561wmy.0.2020.07.07.12.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 12:21:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66FA71FF7E;
 Tue,  7 Jul 2020 20:21:50 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <87pn97o93a.fsf@linaro.org>
 <CAMo8BfLH2jVLjbdMMWCCuhmh+i40NyHQFK-=bAUw3sSoAxwPww@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 00/21] target/xtensa: implement double precision FPU
In-reply-to: <CAMo8BfLH2jVLjbdMMWCCuhmh+i40NyHQFK-=bAUw3sSoAxwPww@mail.gmail.com>
Date: Tue, 07 Jul 2020 20:21:50 +0100
Message-ID: <873663nnap.fsf@linaro.org>
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> On Tue, Jul 7, 2020 at 4:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> I've only looked at the softfloat bits as I'm not familiar with xtensa
>
> Thanks for taking a look!
>
>> at all. However you can have a vague:
>>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> for the series - congratulations you pass your own tests ;-)
>
> Unless you've built toolchains for the newly added cores and
> run the tests on these cores it only means that new tests are
> properly disabled for the cores without FPU/DFPU. I'll
> take it as an independent build test (:

Well it ran some xtensa tests thanks to the docker cross compiler
support. Do you know what toolchains we need?

Currently we have the following:

  ENV CPU_LIST csp dc232b dc233c
  ENV TOOLCHAIN_RELEASE 2018.02

  RUN for cpu in $CPU_LIST; do \
          curl -#SL http://github.com/foss-xtensa/toolchain/releases/downlo=
ad/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
          | tar -xzC /opt; \
      done

  ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCH=
AIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin

--=20
Alex Benn=C3=A9e


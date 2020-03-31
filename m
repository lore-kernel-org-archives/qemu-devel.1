Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926FA208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx4JTihO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926FA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJE0G-0003QC-Pp
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJDzd-0002xv-SE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJDzc-00072T-Hd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:19:37 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJDzc-00071P-BA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:19:36 -0400
Received: by mail-ot1-x333.google.com with SMTP id x11so21467363otp.6
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V0NU77FEAWlQEiJEj+nmPGmkQbLu4cxytoELdaIkJwQ=;
 b=tx4JTihOsWc9BvN2hsC4OaKLfHiT8yk6t+CgRbJ7CGYg50p2aKTGI+X6nacdrm6NNJ
 PNzar1akh530j+AXwnYAxliIC/aJp1i8o4+QEIi2fKWRZVIOEgWbvBa42G6/2lAtmI6F
 XqRk9pmmIYsJcixvzeu0OtSGRDHLaJpwVAzfEnT+TRgrBgSr4RYWzsqApQhq54gDQyfG
 xMx2ABe5gLHaqrN403aFUqoG+vFQXQSbEzsDZoJbkObmnzNZVfutU3XQfqFj7r2c32dx
 pAQIgokFglHkfJSyukY088JzWUy6zJw5dTIHU5E9FLrlnJHkypMrwQSDKaq+wTq6fuBI
 xktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V0NU77FEAWlQEiJEj+nmPGmkQbLu4cxytoELdaIkJwQ=;
 b=j2gSGj7kXXxm/cZBK/CtTP1bElHKfbnAMWKP8Ioe6HC/PYOZdeIJO74G0aM99WqmYz
 uuk9yUquAhDQHJE5bSRI7fiSdOs794Jw7iMqJxwDcuztPekusie6DL+3b7JAGcPdIPu5
 VgozEppHcKupqwcThtPVbEqTKB2eR1od1xgGBtlpdFyWjIsQoEu5LwCK79wbCoPbQtsz
 MQ3wp2UDxZXDiDwr1epRlykgDZLfCrUOQ3Jpeqg1nzcJOZz4XyB6JLobqsJ/6Gcy8L3p
 +cA7+tf1n8i6Ku03LQm64AQFEw8hhsiSPRdBzRMVLvSc6NDogFvrxl2BKgIN0LDf9EFo
 y+Rg==
X-Gm-Message-State: ANhLgQ3GRK/J/sXeeWPmAcsaWMKJ31ZLYTrA/t0dqzSlnP18puwnjzTN
 JJaK3xA2Nd6oQmttI4Ff0uF08GeUOgM2HZwmlJWpaA==
X-Google-Smtp-Source: ADFU+vvXuEcvu0envWkELJAHhaJaL5xRCNWbFHzp+eVif2zXpACviATp/MJXwNRHlV+U5+XvU9fIzyXSgIckHAiknbc=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr12830761oor.63.1585649975053; 
 Tue, 31 Mar 2020 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
In-Reply-To: <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 11:19:23 +0100
Message-ID: <CAFEAcA-KKd0bjE17MPPFv45=S+x3jUj9uA6_UQmb7ts-yu5Ong@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 at 10:20, Liviu Ionescu <ilg@livius.net> wrote:
> > On 31 Mar 2020, at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Serious question: why is automatic directly creation more convenient for
> > developers?
>
> For my use case it isn't, automatic creation will break my folder structure and I'll not be able to use the common source folder and multiple target build folders structure that I use now.

I think that's a setup that a lot of us use, and we don't plan to
change it. The proposed "automatic" directory creation would only
happen for people who run 'configure' and 'make' directly in the
source tree (which currently does an in-tree build) -- the behaviour
if they're run from some other (manually created) build directory
would remain as it is today.

thanks
-- PMM


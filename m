Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B16C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55EB20828
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpcMcnsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55EB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j995R-0001qi-UC
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j994q-0001Ie-AY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j994p-0000pm-1r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:03:20 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:38934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j994o-0000pN-OI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:03:19 -0500
Received: by mail-lf1-x12e.google.com with SMTP id n30so3035125lfh.6
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0OlikP/gfyOWUgTKsGeJ4rG+ob+jO4X9wVM2lFBUt0g=;
 b=PpcMcnsb8r7+UiUh/vaVXU266RcMb+4iZJz4J/vFsU0fag95UvSUsmvqY5nKzhxZ4o
 KGSGmrUGXqCN03ka/qu/1iWeqX27JQPMNUSLlX22g6x3P9AjrS/80tsXB904kW2qKKDI
 ofUbohNQeXDpMPhofesNUlEMyKcYvvz9P2mtIXT+EUwQQDHqdKUroH10EEbMg/1AfGnl
 sgUkoC5LUMYXXy4+I81G/GYNhbIKUZB4FMSRj6Tk4JquWA4CU5ZakZKroZpVa+pV+bJV
 sbc3YgUl5cNCG4WDp/5bEofQIOCIHMD1R3i/g7Bt5TUrCZ79sRevYXqfHFBVym+GsTvJ
 14nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0OlikP/gfyOWUgTKsGeJ4rG+ob+jO4X9wVM2lFBUt0g=;
 b=lQLnwzBqcxreGKIQb+UTp8GKg8x2lK/V0jw4uXMEpFkuJZ61GRWWFlWBRGx7EVpXHm
 RKj7bTH1qhSnjWG2wUyCX7te7vor/kCZTm7hxX9ySqNUZXyYY/lZ1Kw7+xvSEB4eKRhw
 AMFdtlK/r/Q/IRY8hX1Amh79IQzn+dWLlQiLCK6g7SQgxg3ibpEvnLJ6+xulSRjKGzH6
 XNNaNBxRzRRCBadofCrd8QlAi5shLX7rST0OG9ru5JQ52cu1t4y2jwwU645GaE2KuwZu
 4enp4FDiVgRQ2EWkYHH2Ti52hXlq1kuVHdtuloS9TLYaSbunSB5rK4Jnc8zJ4ihuNpk2
 FO3A==
X-Gm-Message-State: ANhLgQ12VJCoYv8PT4KFJdHVjakbQ8zlQDVAsVKkNRmtkOFjacyvlJJT
 q6sczsVQ1oEPrtj/XzfdQRjAY4Jf3PKdOjKiCt2JyA==
X-Google-Smtp-Source: ADFU+vtDZKhda/TbsUUGO3txYykw789FBuTGCaSSqjDja1n/69y4Hp64xQthM2jkMK/bOa2s93gHraBrPSU26u75reM=
X-Received: by 2002:a19:6445:: with SMTP id b5mr2996452lfj.187.1583247797022; 
 Tue, 03 Mar 2020 07:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20200219163537.22098-1-robert.foley@linaro.org>
 <87fteq90fi.fsf@linaro.org>
 <CAEyhzFt=KsNn_rdJegbzJ_PgNVb6oAVL3aDvaO2VdkrFQ1-Gvw@mail.gmail.com>
 <871rq991nk.fsf@linaro.org>
In-Reply-To: <871rq991nk.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 3 Mar 2020 10:02:42 -0500
Message-ID: <CAEyhzFvuk+_dJOyPNh_jub_D2bbov7T91PQry4ya9r43yZX9TQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] tests/vm: Add support for aarch64 VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12e
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 05:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

> > We are happy to make any adjustments here.  Our first set of
> > refactoring here was
> > aimed at making it more pythonic.  Is this where the concerns are?
>
> I'm just worried about the fragility of multiple steps in the chain of
> io we are snooping on. That said Phillipe made a reasonable point that
> other tools could be used - QMP for example would be the way to check
> the status of the network connection before we trigger ssh rather than
> the current busy-timeout approach. However that would result in more
> complexity so if what works is stable...*shrug*

OK.  Makes sense.  Thanks for explaining.

>
> >> However I ran into problems testing on my aarch64 box
> >> because of a missing gen-iso-image which makes me think we need to add
> >> some gating via configure for tools and libraries we need.
> >
> > Should we error out in configure if the tools and libraries needed to b=
uild the
> > VMs are not there?
> > Or maybe tolerate these dependencies not being there at configure time =
and
> > provide an error later when someone tries to vm-build these VMs?
>
> We currently do both ;-)
>
> When we can detect at configure time and skip in make we do - see
> tests/docker/Makefile.include and the compiler tests for tests/tcg.
> However the acceptance tests current use runtime decorators in python to
> detect as we go - but that test framework prints a summary and doesn't
> exit -1 to the rest of make if it skips something.
>
> > Just curious which approach we should pursue here.
>
> Have a look at:
>
>   Subject: [PATCH  v1 00/10] testing/next updates (tweaks and re-greening=
)
>   Date: Mon,  2 Mar 2020 18:18:57 +0000
>   Message-Id: <20200302181907.32110-1-alex.bennee@linaro.org>
>
> and see what you think.

Thanks for the details.
It seems we should be able to use a similar approach of detecting in
configure and then skip and inform in make, for the aarch64 VM dependencies=
,
as well as the yaml python dependency.  Will look into adding these.

Thanks & Regards,
-Rob


Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE1C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A003D214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EILo39Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A003D214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94ow-0002NP-RX
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j94j7-0001jr-Jq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j94j5-00049h-69
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:24:36 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j94j4-00049J-Sj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:24:35 -0500
Received: by mail-wm1-x342.google.com with SMTP id a25so2007070wmm.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tHtRY0fLjHTW8nT+ApXBe9/Nj10FFstSLzTXUdjD/V0=;
 b=EILo39AjZc9s+wGtd1zF34FRgqywWhW6zYCOrDD/EVCAdiaJQHHWYkIZrEUgQKILMP
 5N9pCLMxY8ph96bL+QzCKFFxc3bI63IUliaxamz91Bzg1gYe9RkRDEDfBfZtLjuo0syz
 bgvADJ3ZSpXrCeeZmmRvVEzdUWuziru48YybVLm1OiVMfGvanq1TDck8MucxIyg0y/v9
 ziuw3sb4pU9l7wP/zJpcKzsPkL01zTZ7kncQvgFP3ZON0VWxE9mryPCpyaCLpEKxPBSk
 WWqRsJPZs7gqAT658EM4Wams70Xc81XojSuiT7iFisbDbdhWLTt5ZOcUyC6THbmqirEl
 tg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tHtRY0fLjHTW8nT+ApXBe9/Nj10FFstSLzTXUdjD/V0=;
 b=REbDIS9PtUy07IgE9MbTwg/Fa+GwgyV3UtPF1dNK4Zz8jedGF3XMSzpBkjUja04gxB
 eEMJj7NcTRzK7jR6rfMH4WC044o3jKFcj4q5Z75v1zIwishcfo+aqOMeXpHya0nY8kSo
 kMxtU/RpyUo9eBOhH5Hc3YSGxT+tZva3ehgu24P3Vq4hULfZkQS82Oh4WuwA3YREI/Jo
 w9nM9KSPkfe8ik4JFO6gIgfkuk7OiHgAVzeCGPuuldzimvsylztV6GDV/Vs3iD9Oqzj4
 sQIwUZyIjdOkY8zQi7lGX7bJUG50ADfFzm7Amk0NEiAccLnF8Vd2UjFS0qZJLX5hrQSI
 gRRQ==
X-Gm-Message-State: ANhLgQ0Lu0iGl0L+YeixogdXrfpvylJL2xlvnKi+w0KN70WFFICQQR7Z
 z5m0h7tQBr1ZF2V1i2JHJcsHUw==
X-Google-Smtp-Source: ADFU+vsEe7ktfjK87rG0sb9QIhcY/ra/5Jfq83lrubQfD+yXf2m3vFlpWj3qJrHMgy96UFPBrlathg==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr3733865wmf.142.1583231073536; 
 Tue, 03 Mar 2020 02:24:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q12sm34799617wrg.71.2020.03.03.02.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 02:24:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E39051FF87;
 Tue,  3 Mar 2020 10:24:31 +0000 (GMT)
References: <20200219163537.22098-1-robert.foley@linaro.org>
 <87fteq90fi.fsf@linaro.org>
 <CAEyhzFt=KsNn_rdJegbzJ_PgNVb6oAVL3aDvaO2VdkrFQ1-Gvw@mail.gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 00/14] tests/vm: Add support for aarch64 VMs
In-reply-to: <CAEyhzFt=KsNn_rdJegbzJ_PgNVb6oAVL3aDvaO2VdkrFQ1-Gvw@mail.gmail.com>
Date: Tue, 03 Mar 2020 10:24:31 +0000
Message-ID: <871rq991nk.fsf@linaro.org>
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> On Mon, 2 Mar 2020 at 11:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Robert Foley <robert.foley@linaro.org> writes:
>>
>> > This is version 2 of the patch series to
>> > add support for aarch64 VMs.
>> >  - Ubuntu 18.04 aarch64 VM
>> >  - CentOS 8 aarch64 VM
>>
>> For now I've pulled the first 5 patches into testing/next as they are
>> obvious clean-ups.
>>
>> >   tests/vm: Add workaround to consume console
>>
>> I still have concerns about this approach but I'm going to give it some
>> more testing.
>
> We are happy to make any adjustments here.  Our first set of
> refactoring here was
> aimed at making it more pythonic.  Is this where the concerns are?

I'm just worried about the fragility of multiple steps in the chain of
io we are snooping on. That said Phillipe made a reasonable point that
other tools could be used - QMP for example would be the way to check
the status of the network connection before we trigger ssh rather than
the current busy-timeout approach. However that would result in more
complexity so if what works is stable...*shrug*

>> However I ran into problems testing on my aarch64 box
>> because of a missing gen-iso-image which makes me think we need to add
>> some gating via configure for tools and libraries we need.
>
> Should we error out in configure if the tools and libraries needed to bui=
ld the
> VMs are not there?
> Or maybe tolerate these dependencies not being there at configure time and
> provide an error later when someone tries to vm-build these VMs?

We currently do both ;-)

When we can detect at configure time and skip in make we do - see
tests/docker/Makefile.include and the compiler tests for tests/tcg.
However the acceptance tests current use runtime decorators in python to
detect as we go - but that test framework prints a summary and doesn't
exit -1 to the rest of make if it skips something.=20

> Just curious which approach we should pursue here.

Have a look at:

  Subject: [PATCH  v1 00/10] testing/next updates (tweaks and re-greening)
  Date: Mon,  2 Mar 2020 18:18:57 +0000
  Message-Id: <20200302181907.32110-1-alex.bennee@linaro.org>

and see what you think.

>
>
> Thanks & Regards,
> -Rob


--=20
Alex Benn=C3=A9e


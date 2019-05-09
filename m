Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F9C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B092053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMCRkWwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B092053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkEZ-0004WP-20
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:41:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOkDk-0003RT-Dk
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOkDj-00016p-HX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:40:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOkDj-000126-DE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:40:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id s19so2504482otq.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=NS0oocDVqszWMblfeVAOtOTHAJZ0x43pJylXCCWxUMs=;
	b=oMCRkWwLhVXttRfTl7Cexjrv2RuoyWI9ilxK2W8enqhNq8s4eWBC9Jl+NP08drAzoS
	C/35lkOnLAy2LVaY6lo7tuutQLiLFAeDIQ5ejhVVxXoevXT/2QRS+pQAHgAZpUyuqD46
	kqSZ28tW3qtJSm2t5YF8t16o/NEKnCGL6XPPFtWbLbbZFduKj5GnSs2DWqsSE+4bOraq
	SMuqdBvrSK9BHaxBAzrjWuLFgNHe/HQgfOhX0OyCQCEIz9zEYhmyTNNnf5hGZtbcD3Fx
	LMTt2uAcYHfv8xlvbDcg8Q0KAerFa2qetMbIHnk45sao3bjyeDIw/jUJhCxU7WfCuvrM
	mJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=NS0oocDVqszWMblfeVAOtOTHAJZ0x43pJylXCCWxUMs=;
	b=LK37XHjg0MAh6+kXJGHK76dRF0Lb5YBjp+yK54TqZVkCN9K11LtrtrWkPC5XY1Z/Jy
	wurvEzwsz1LuhUMs1KojKRl2Mu7zhhiPEr9s/CXK3IezZ28wiKSdGVNwU1TKu9/zXKiw
	y4AHNFJok7HbjMnNScicDMfLwsUFVBn/t1CWLt8F4Pukf+6zXh/avLwLB0kLtHcqC+z/
	Nsf1ZRiXRoYhHRXel2v/PzX1qnhcTCoX0zgCpSUdqoD1MDtRismds20hPB4CvP0FCCcH
	ZWumAEpuGu2XK6h0rIjdKv+1tVpBU/3Deqz28E5/N9bKnQk/JL2q/gCrn2dTKGcxB7kL
	nADQ==
X-Gm-Message-State: APjAAAWeQ6x8HBnyNEqeqx2zS1Xs+MwOnHtejX67OOfHU8U016Ou5Ryq
	zzPAfUUj8SWHmoN45pfn2ZgXQtumm365CdYSY9rlPQ==
X-Google-Smtp-Source: APXvYqx3cSuROVBuTMk3gHYFh7DHNqlYuBDDniqx5zeSt/J2DaJR6EQiHfhJ3lc9BSb0Uxp9cUewkld2pTsQDqo+FN0=
X-Received: by 2002:a05:6830:1258:: with SMTP id
	s24mr2796575otp.238.1557412826444; 
	Thu, 09 May 2019 07:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9rTL_4co1JvHrpJcqJqdrBsOiHo8sZS6wKWJOWphCCSA@mail.gmail.com>
	<CAHmQWvAM3Jj_49Kq45jUgHnLmN-p3Yn-+GPQChpfTo1BS5hUJg@mail.gmail.com>
	<20190509162736.133418f9@Igors-MacBook-Pro>
In-Reply-To: <20190509162736.133418f9@Igors-MacBook-Pro>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 15:40:15 +0100
Message-ID: <CAFEAcA9wQwpWuh+12c13QYYkL6s7gUqGzfyMhh_0hxNGZqjjjg@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v7 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>,
	Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 15:27, Igor Mammedov <imammedo@redhat.com> wrote:

> It should be possible to add nvdimm and memory hotplug later.
> (I don't see big issues here, as long as it would be possible
> to carve out continuous range in address space for it.
>
> Considering ABI to guest, one could reuse QEMU's notification/enumeration
> code for that or implement their own.
>
> PS:
> However there will be the same issues that we've had with Seabios when
> ACPI tables were generated there (i.e. cease-less invention of interfaces
> to to pass information from QEMU to firmware). But if I recall correctly,
> it seems that it's intentional design decision for this board,
> where user supplies/builds in firmware a board description (acpi/dt/...)
> manually.

This board is supposed to be very close to real hardware,
where the firmware knows what it's running on and very
little is configurable from the command line, yes.

thanks
-- PMM


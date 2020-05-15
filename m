Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A326E206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfvZAMVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A326E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZW5t-0000Ec-Ir
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZW4U-0006bt-TX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:51:58 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZW4U-0004o6-5W
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:51:58 -0400
Received: by mail-ot1-x329.google.com with SMTP id z17so1334335oto.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pEKYNjBvhN8dZ13AWVM5QCFsoEWkc60iA2BrV/kjtvQ=;
 b=DfvZAMVwODmMg9gqSLHqOGO5DyC4SLy6qLLMwN1X5n1pVmSO9HEeELVKi/1D+uMQkc
 Q1vuZeCqZNsoxEUcBRayI41Vn/Q3YfDFgM2WXSD4wsCX1xod5a4clKeVAxT2eAhyqbWc
 +JAJXzPuPj6K727LLJ/R5Tf9IcIbjyt919ZBDX6h48UPyG4poEagRC8kxRdw2EeQI3JV
 3dX+ZQMFL4metsmnGZBN7x3l74/a5QD3rcztDytBRHgd3RvTwBoQl1CR4vL0RqUGP9IT
 fqPF+yp9guDCxaEjv4wI1+FnwaTC1hRHC8RWmVwCZ//TAb67irtFuJzAOuL8cv70O7V4
 LjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pEKYNjBvhN8dZ13AWVM5QCFsoEWkc60iA2BrV/kjtvQ=;
 b=MfjCYzNjOtWsBIQprsLvPRX3kpEp2V66H0tyOqyBT7ilDw17vr+NRyaLKrEDKkC0mX
 fzheSHoL7+TSNBtW36Vhe9Y0rXvjWh058qtQGheV5uOwKyMknt3rn/YsFzU3tgVb219d
 0ZDv0wSXQQXKrkZURYlr+SQG2DgD3U1cuetbeaSBEbOUD44EgdxWnpH/0TEUDyVNS186
 xIyjzahIi0ysFZpm6uhWj9tClrhFAYcWBgKyKOrWV5u4PeKP4/H+0p1Sri3JFsrz/5dX
 e2ibibvjDfj8mzQD1QKf5z/Xft0r5Xok9I9gputpLLJmAxPPVdwWUiD0cuQiTOYF6+gy
 pWNQ==
X-Gm-Message-State: AOAM530FYi3nhfvRUMyOMIj4sAEKsLeXdzvd582i7fz3P0Uz9JWhh3/m
 OrSmGY0JQGhYr4Y2zEDuGgWW5lYnI4JGuDR/Qj3+WQ==
X-Google-Smtp-Source: ABdhPJz/OBC1mrARz4FVn42qWQ3TsApGgxospgZjbWyNLLabPojfN6d5Dndt2WVD9JoCMmbXViuCeWzPA9uz0SFfcVQ=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr1439365otj.91.1589532716615; 
 Fri, 15 May 2020 01:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
 <567755c6-3bb1-b16e-af26-431dec4616ba@redhat.com>
In-Reply-To: <567755c6-3bb1-b16e-af26-431dec4616ba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 09:51:45 +0100
Message-ID: <CAFEAcA-67uGcwSu7mJ+w26xYqpTm4C0t3Yrr8gWCsA1VtHeaLg@mail.gmail.com>
Subject: Re: [PATCH 0/5] docs/system: Document some arm board models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 09:03, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> However I'd rather see the board documentation in the source code, and
> extract it when building. It'd be harder to miss updating the
> documentation when modifying the code.

I definitely agree in principle; but for the moment at least
we can have some documentation...

> Another way (rather than using external program to extract from source
> code) can be to add a method/field to MachineClass, and once a build is
> finished, we could run 'qemu-system-arch -M gendoc' which go thru all
> machines and display the documentation properly formatted.

The documentation needs to include all machines, not just
the ones that got compiled into a particular binary, so
I'm not sure this will work. I also would prefer it if
we avoided having the docs build depend on doing a full
binary build -- places like readthedocs will just do a docs
build by invoking Sphinx directly, and we'd like the machine
docs to be visible there.

thanks
-- PMM


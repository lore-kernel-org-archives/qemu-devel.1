Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A808C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675B42077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztZKGDWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675B42077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfi0o-0000lB-LT
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfi01-0000KW-KZ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:48:57 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:46532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfi00-0005pi-RT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:48:57 -0400
Received: by mail-oi1-x230.google.com with SMTP id b3so8475023oib.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hmGKkyU99zjXKsxKtVZar4ITSeZUPvZsMWw/ZHaHrJs=;
 b=ztZKGDWoLbdq0oriPVUiwhTglf5O3L8YjYvgtmdqBrLpF65jJ7Prn5uzfvwSLV65zI
 NE7MzyPFxMwn5gcA3gPeReeCoG3EV4w07rbnyScAvMW6st3cF5lnlCugZN0BeyUPUsNg
 z4ZQQxB189fWvv7a6JkLAYGvCkvxnYd4B7tmQY6LAlRAohL69cvbIaKNewGGulHkKGlB
 AxMc+3tbkx2WBL63mzXvc2/7VDp6uemTQsYHbCV7caa59+nL9gw6uSvSbT2Q7DFgimOP
 y20An+wmgJfcgA7I7Ekqa5q7Lh2WGDtc9QFMbNZIcMhzKVBmYaFoOiNAPpY4BrhQCI8V
 g9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hmGKkyU99zjXKsxKtVZar4ITSeZUPvZsMWw/ZHaHrJs=;
 b=Yilar3bTmRU9qgty60zC1F9lNkzA0oaCJQ11Z9dbzX+tFXWZyh54akGa0OrWt4Dq6e
 syDqt2+shp7lK9by4SyNcLTH7wwjJGEyxsIZ30C0AVXrYWy14xUZU/Qic7TpnBnL+HIw
 76cs8gjoeGmxIHZN2ITqEACWrni46MfM03n4oHwHuVi2iMsVc+YO+OLs7NTTZtRAZpPY
 OnTrpBxZFLGTLDE6BmOHG81zP6wRYOdGVW4hpWOqynUNmUCRtr56Hlile3PvWetbmutK
 kxnV0E7Cfx9wECDDN/oJ1gRswVso28dvOkKvUfnh8E9biUEI19VxrdIwj4wle1/SanCK
 vqsQ==
X-Gm-Message-State: AOAM531JVmR1CFWHy95Mt1nrdiYQhIRiWgzJ9ip4lOoj45mw+ABePMU4
 W+zpiRdBr4KXcuO1mmxseUveexJJaMO3Z2WTqZw4tQg3/VA=
X-Google-Smtp-Source: ABdhPJwGmnIa46OuSalBQPErTsM+jj4scXywKqWBPiihhCvktOTIFey7lARQQvGT9iI0ixwESZumFGp1nrHXnVjV9oA=
X-Received: by 2002:a54:469a:: with SMTP id k26mr13809726oic.163.1591008535514; 
 Mon, 01 Jun 2020 03:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200601092057.10555-1-f4bug@amsat.org>
 <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
 <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
 <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
In-Reply-To: <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 11:48:44 +0100
Message-ID: <CAFEAcA8ZcGLafvUybVRmiYMH_5pKVsogFisBr-DYn3EqedNNVw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jun 2020 at 11:34, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> You add the utter confusion to a clear thing.
>
> "Renesas" is not the same as "sh4". We had "sh4" as a target since
> forever, and now you suddenly want to change "sh4 hardware" to
> "Renesas hardware"??

Hi Aleksandar; you seem to be being excessively combative in this
thread -- can you tone it down, please?

thanks
-- PMM


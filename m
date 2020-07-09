Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF78220772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIg7MLZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF78220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWoM-0001oM-3d
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtWnU-0000kG-Pv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:41:08 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtWnS-0004lB-Rd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:41:08 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c4so352686oou.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0cc+pvM4yPgo0naNrbwOO3SjzstSINRidB0LVaTtmx0=;
 b=WIg7MLZX5pCmn319ehfWbrwIk1nhJOFd8zJn40jff+vhMLqGXESj8UVsQnrdNTgttQ
 CVR67TXDepoTKOEwSqV2J0Q/vAMshGY3iyXociitQGPQi9CxBS9P91VKjYRbiJyoT+Kn
 aa9f+rNdhNkgNRZBTroOyb0L+SLzhkqRwzGZGD/dqe6qK/5orMik2vU9bduWIWB/a2aN
 OS9tNQBAG4xMKGfXi7xu/3dAYQJpLJUowcc3VOAFvbqAm4916wXLsL3xHVv70mCsjNoZ
 mKrw9iMQ0Wp1GUvP/69bQrltl0FyWfa8P1RTZJKvh5OqsGqLJ0Uypqrc8atU/CmMqz47
 q2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0cc+pvM4yPgo0naNrbwOO3SjzstSINRidB0LVaTtmx0=;
 b=CGN/nmXhOhPZz++27cS2Jx+I0u5yBAVmj/+KV1bWiwgcMNMHHkFew2WY7L8+6YACey
 0InObB7RDXcM9NexDlFr69tcGB9V7ZUJnaSSJvi06/83niqiJmLbqyHSqEnv4cwNAmjq
 mrYV19Wu6ZFrsUngh3HCx1AukoYu1YCtIh0MnfqGexmhYoBSNf9DsCL0d1H/Cdw1wNqq
 zP/pDa4/eJEvN8B87s1U2Nzwab5yDKvUlEthr4vdccyetLOiCLyluX92Tct7msNDER5J
 a96r1YjwbXGSvq7EqqUaXVFlzYtAA390Q06n+YTwUsHnFmptGYFrRMsYECJkKZHfgI7h
 uFMA==
X-Gm-Message-State: AOAM531057kT0OITFCO2OXaw2iMuo+5LtYgE5uqKmzD0KqRgMK6Di8b/
 8w/9gk4SZpBACy2lhj5tscSX77D3Pre0rb/03XaH7g==
X-Google-Smtp-Source: ABdhPJyF9tjVyfJ4nnmZS+Jvl17mxcL4J+cAURgFpRX5yuZvKDLk07YPoEdmDYzrhsDgp31Ww44II4GT2jtZ5QXvt1U=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr32661106ooi.85.1594302064337; 
 Thu, 09 Jul 2020 06:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
 <20200708213900.GD780932@habkost.net>
 <714621e2-4585-e6ee-5812-f3a45aa09267@redhat.com>
 <20200709115413.722d4feb@bahia.lan>
 <69e8f708-4fa7-6240-1484-febae0246ae6@redhat.com>
 <20200709125525.29d28d6a@bahia.lan>
 <9951d4cb-7aba-bc65-91be-1fe57393d68e@redhat.com>
 <20200709151320.720fb0f0@bahia.lan>
In-Reply-To: <20200709151320.720fb0f0@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 14:40:53 +0100
Message-ID: <CAFEAcA-w8zdi6uauxWpAAUXE=0qhUEJqmyMWLEhwYm+LQGP_yw@mail.gmail.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 14:13, Greg Kurz <groug@kaod.org> wrote:
> On Thu, 9 Jul 2020 14:21:04 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > The machine simply has to set the 'start-powered-off' flag on
> > all vCPUS except the 1st one.
> >
>
> We only want the first vCPU to start when the platform is
> fully configured, so I'd rather put 'start-powered-off' on
> every body and explicitly power on the first one during
> machine reset as we do now.

Nothing should ever be able to run before the first
machine reset has completed: that would be a pretty bad bug.

thanks
-- PMM


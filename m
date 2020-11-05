Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EE520724
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBE5qr1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EE520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kam28-0000a0-DC
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 15:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kam0j-0008Ml-Jx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 15:37:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kam0e-0008E1-A9
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 15:37:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id c9so2875638wml.5
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 12:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xCIhabTLUBg9b2F7/G8U0+TS+Nq9BOCBDpSUH7XtqwY=;
 b=KBE5qr1UhhrswhyHfQ6vtOYVXFs1KGKOPX25nan6brCgJYgxzjkW09oZVJrvpctyjn
 Drrb2eqxjlXIyDP/kRl3HjnU/U1h4EP03hpmRVgtq1/xqonlGDj94/VB/W1adVQgYrIn
 9uTcKOmXip6V1J8LvNRa5z+XGDtZrGR92qz6VRlTM/QbmEqSRUfW5sD6TGlw5rKJrUse
 sDur0pTP5GofhWSwemHt+b55vgirR4C7N5ix9zugTm13U0FyfTS2/fLaopk1u2kiT3gD
 Hu6TrNcTl8P3aPaKfJU3V5+xD4E132O3LgPS8DyoKbU65a26byTSHih1ZJd2ebnHnVze
 IEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xCIhabTLUBg9b2F7/G8U0+TS+Nq9BOCBDpSUH7XtqwY=;
 b=d3WSbPeqI9uMLnOTlbk2WRFp8osYxcfE5A2EgEhyj17MCv/sdMJZ14gE0zzUZCkoGD
 B55D0vkVjj4/Rb8YVrGZmvdrhIDQEyd1vGDcT42lvwcQXaHLJ4QVeYoP93YKLb7WHnE3
 UU6rSJGnU50eLvPb+Unq3kqDCJ4bB+fyHq++2iz4gtvG5hZScIJgMu4Lagsb562e3Xev
 kXn4qi3/9h8gpWm8LU5LiHENdVslbc3t29+gRD7RTIAEPY7EGmcBGLbPk1Rv/4lqL6NA
 tfjT0n7KUmR/KzDqVBVeJperiU/f9sGryZ+qr2Gc+gWcdSejycyRunQuhqV4K3cxzusO
 YTWw==
X-Gm-Message-State: AOAM532mfmUpbmg/YkA0WLvFr31ewMG68Oh6x5opFCHCxI2KeOwYgaIo
 Ic7ZBfh3A0WbHUcTqS7xtnJPmw==
X-Google-Smtp-Source: ABdhPJyrhdJG5TQk0EnkvwpqiSSIs7D7IQ5Qp0yhcGm9QCg+4/jWTTn3vNTxVwE3NM8zbtmJev2tzg==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr4679164wmb.150.1604608646741; 
 Thu, 05 Nov 2020 12:37:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x81sm4272751wmg.5.2020.11.05.12.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 12:37:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C416F1FF7E;
 Thu,  5 Nov 2020 20:37:24 +0000 (GMT)
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-2-alex.bennee@linaro.org>
 <ea13af19-9ec7-3d91-e7b8-b4f59aa4cf1d@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 01/15] hw/board: promote fdt from ARM
 VirtMachineState to MachineState
In-reply-to: <ea13af19-9ec7-3d91-e7b8-b4f59aa4cf1d@redhat.com>
Date: Thu, 05 Nov 2020 20:37:24 +0000
Message-ID: <877dqzbkvv.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, julien@xen.org,
 Eduardo Habkost <ehabkost@redhat.com>, masami.hiramatsu@linaro.org,
 andre.przywara@arm.com, stefano.stabellini@linaro.org, qemu-devel@nongnu.org,
 takahiro.akashi@linaro.org, "open
 list:Virt" <qemu-arm@nongnu.org>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 11/5/20 6:51 PM, Alex Benn=C3=A9e wrote:
>> The use of FDT's is quite common across our various platforms. To
>> allow the generic loader to tweak it we need to make it available in
>> the generic state. This creates the field and migrates the initial
>> user to use the generic field. Other boards will be updated in later
>> patches.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20201021170842.25762-2-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Two S-o-b better than one!

Hmm I wonder what happened there? I'm sure b4 applied that patches for
me.

>
>> ---
>>  include/hw/arm/virt.h |   1 -
>>  include/hw/boards.h   |   1 +
>>  hw/arm/virt.c         | 322 ++++++++++++++++++++++--------------------
>>  3 files changed, 170 insertions(+), 154 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


--=20
Alex Benn=C3=A9e


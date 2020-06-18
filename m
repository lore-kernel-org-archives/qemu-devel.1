Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C779C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47906206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCqpBd7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47906206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlslT-0007Qh-FA
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlskY-0006DQ-AG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:30:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlskW-0001J5-NJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:30:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id t18so5675215wru.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PJQ2DsSnuk18MugYbkWmnrj1sv/fTWU6NUII3bphy9M=;
 b=zCqpBd7iPiinZUenHoqI/VQ9VztdpGW67rdnCbsbxDn38dtu/zax6IdTeB5HfJO3If
 1OgJXp0FaVHI/Qspc8j++nyN5yJQwDmsMVSAT1XtR2GfuXUttE+t1wRf+Gx4GZHpnEd+
 7WXBC/FN3hngUUNUDtbb+xbIeaIFwfTnKLs1Etqw4uPJOGxiFqbvcOb/R8JyNYq0QXbL
 HRyljk9Rivs+o4SWzHZsdU3MvStrvz+FAgLoZ1OqgKWXfaNK9rRuvSOLTOXbwiFzEJGE
 MQn930GeLMEMeYq+7rrJm+eL6vP1POX/x/rNdZkkrwBt2WCh0+k1eCqHndPoonn3xdOa
 rLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PJQ2DsSnuk18MugYbkWmnrj1sv/fTWU6NUII3bphy9M=;
 b=mPOiHhnNVewGPI7hzQk7UlWiTHfR2d6vP9pcuvy8GJFUX9JpbzeVxvUvXB+nto2BM4
 /tIa4+KtnohOhVbtQr1WwWwSQyP+LPsp7PfHAEQk0JMsoSP8cqh8MbMAU2KJGMcoY4xd
 4zfM5qNaV/QYTri+V+SXJ/G/XTsaL6ERNFH4vBk6w+J9Uf1R4dr3moIe431SdfIDWlSz
 /v06DA18om/AzT9J8dM9XaN+yj73VdweEcEepGAr3GnoFnxJaLwXHRH+lbrSv6Sh05vQ
 gf4B/JoYVMomivJpAyOhkkXuheob/tzK1Jkyk4oZvbsEwWwRjoWdOhCLrKhzPOTdpa7e
 b61Q==
X-Gm-Message-State: AOAM532dzx4hYR1vxmqWVZx8zKHylAv5OEvd8jqlPxZuEPwIo8yBb/8x
 1DErsNTyks4fV/Kn0tnNhxBrsycBi90=
X-Google-Smtp-Source: ABdhPJzlN1rX5L4JR0dImyBk2kdxVvVqwAQxfNneyPeABYgt7MPuVPzpLB2JpCACdwdzUQdCvzKXpQ==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr4372339wru.182.1592479826148; 
 Thu, 18 Jun 2020 04:30:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm3264635wrm.62.2020.06.18.04.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 04:30:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E2051FF7E;
 Thu, 18 Jun 2020 12:30:24 +0100 (BST)
References: <1D26F746-92AA-4BA4-BF92-A498DA2C67C9@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christophe de Dinechin <cdupontd@redhat.com>
Subject: Re: Understanding initialization order for spice in qemu
In-reply-to: <1D26F746-92AA-4BA4-BF92-A498DA2C67C9@redhat.com>
Date: Thu, 18 Jun 2020 12:30:24 +0100
Message-ID: <87v9jovcfj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christophe de Dinechin <cdupontd@redhat.com> writes:

> Hi Gerd,
>
>
> When I build qemu on master with moduels enabled, and run with spice, I o=
ccasionally see:
>
>  qemu-system-x86_64: util/module.c:136: module_load_file: Assertion `QTAI=
LQ_EMPTY(&dso_init_list)' failed.
>
> Interestingly, I seem to have seen that only on master, but not on my
> own branch. Have you ever seen the same problem? Could there be a race
> condition here explaining why I sometimes see it, sometimes not? Or do
> you think it's more likely to be a missing build dependency? Asking
> because I don't recall ever seeing that on a clean build.

Have you switched the config in your build directory? This is one reason
to have multiple build directories outside of the source tree.

>
> Command line:
> % qemu-system-x86_64  -display spice-app /data/VMs/deb9.qcow2
>
>
>
> Thanks
> Christophe


--=20
Alex Benn=C3=A9e


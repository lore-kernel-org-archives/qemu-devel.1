Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C15207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pON2kVrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C15207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZMw-0005WU-64
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtZMI-00051Y-II
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:25:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtZMG-0004HG-P2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:25:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id f139so2472727wmf.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BsGMHkdlEFUmFELR2iMJngClnIMJVvatYImx3EV/rbs=;
 b=pON2kVrF/Qo92ORmR3NyhHnMItN6Y3ATUXDvfR9TlrEjOGSZs0qID5T5W+h8H/8/C9
 A6ll8POJ7UMTxSxxDMeQE9c3NzUbUmH99/fGn0rcL6MHWJOlOGBwBv+eDkXsMsreXB6b
 SEsjo7cenfVXYroXsBsQpsCzMobnnLic04jQu3sLgulOp3nV4lpCsSGXbf22IUQlGW/Z
 pBKpoTMg2cgBhpi1zMc0Hr1XVfDXFWh1Ijgt2EHBZoFhi1QCbZF7tbPvegQp8Xu5Dk37
 RC6i2MBqTr8WMgPEG9XyfNQD29BZhYd6Szj6UiW8gtPWIYSs6Ek6MWNvdeo32/uHX2hP
 NqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BsGMHkdlEFUmFELR2iMJngClnIMJVvatYImx3EV/rbs=;
 b=fN2knkozgZ3y39fSj/Fpp87tyW6dN9LSmkcJ+YcGZJw1cvk/fhID4x/46X3dTPMdVO
 JQqvvH7mrXWQG/NHiamADP9MPXrQXKV0BqibbbF6Cvds9xwLuI5cy2wWgfgKCYuXk7bq
 GKyAU5gYONOBtNUspWzxllRp0pNwhOh+b3m9eV9/PZfZmVGX7XP+VBO3p1Uxqoq7+M0T
 0z611HaoEfxhEgJSqO3hrMxoUkJrh+xgHfKgkC0KJHvUkBbHt25ALtHy5Y+ayeiK+pbi
 Klg8ChTpuZHbDCMZQjCG81MggCSs7iCh1YxtcYcuuXrHENp1WWpJ2YAaI9KEnB4DWUIE
 OW2Q==
X-Gm-Message-State: AOAM532d9qAtz/BsiInKuNqkoYt36Bo4I7gL84PKvtweY8dgZrg0nvvc
 XsU9cRomhGH3nI6eF/b2/5Y2KA==
X-Google-Smtp-Source: ABdhPJzhmEX0XhphfdkSApkNdLt/RbPqAF2LL/VjuOf925ctYl+hIjKFCiMWizIbX4c5VS/U4w5ZdQ==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr733247wmd.157.1594311911218; 
 Thu, 09 Jul 2020 09:25:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h84sm5843276wme.22.2020.07.09.09.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 09:25:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53B401FF7E;
 Thu,  9 Jul 2020 17:25:09 +0100 (BST)
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
 <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
 <874kqgn0vj.fsf@linaro.org>
 <CAFEAcA_nk_EjsR59BGkBzYo_Gvkuqi_3AyODOxBm1Ec2gfxKww@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Is VXHS actually maintained?
In-reply-to: <CAFEAcA_nk_EjsR59BGkBzYo_Gvkuqi_3AyODOxBm1Ec2gfxKww@mail.gmail.com>
Date: Thu, 09 Jul 2020 17:25:09 +0100
Message-ID: <87y2nslkpm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 Jul 2020 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> That looks more like it got missed in a clean-up series because we don't
>> have coverage in our typical builds and CI?
>
> Yes, very likely. But there's no point in fixing and then adding CI
> for a config that our users have demonstrated that they do not use;
> better to just remove it.

Fair enough. It can always be restored from the history if someone
cares.

--=20
Alex Benn=C3=A9e


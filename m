Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D1220767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiiSf2hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D1220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtc0Y-0008Ni-SN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbzx-0007hQ-Be
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:14:21 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbzv-00053S-Ge
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:14:20 -0400
Received: by mail-oi1-x241.google.com with SMTP id x83so2760096oif.10
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3tmiRfBlz6AR5ERL/X2E9qzH0gGmzWuAAimpyQmTUSg=;
 b=ZiiSf2hyZ9pxd/Vb0cO7sutu44m9AB/YFoqXZr9b2ihtLoV0uIZcjnIlK/8nN4EHi7
 fUOq85oxzu9AWnUKAPUg3e3zhY8SuPjNOmceFZVhl2uO+HLGXlHFxK/NWETJ4jrpjA0o
 2pQXLFMknpqs2urmXAauynbh04v80ZE+1lscFPzUE+q7KVzT7k2RoVXeWWL6bHr5yg2+
 o4uAOEgqHirczvQLUGQBb4hI2iy3H2M4rv66zZKBzHDG22HUpz4gWd3ssmAtMUMCqk/J
 jZk3dSfvy0XelxaWz6AdKe+zutme3RD0vRWBO/5yNtMwWzQM+YvVKj9HrOn9tclSJ9Qx
 nAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3tmiRfBlz6AR5ERL/X2E9qzH0gGmzWuAAimpyQmTUSg=;
 b=rcvYMjI2zRBuoRyrVhLkh1yaE17K4lHYpbIQvK7lOl/VVP5KL35RCmKOizlX6U7GpM
 pslozsH5zSMv7jt0pXcBkp2kkBkhNwmYchP9R3P3kYW7at2P20G23x4L8juUJ91f42kY
 ebGztxycJrVFub6w+ORlwfCt4ZcecY83e3YtVWFrQgs2jqUDrWK1kiDrdZxOp0lXVoaR
 K5fSLyCzaRRKrZ+ktVkDaQ1djn5HX+indGmSWemnSF05a4T29adLhhhHEndtfLEy5U7R
 EaTHIwopSyI8aIJ58J1X9MiQJk1BwtJIAgfTVP1iBF27kbi/pWvEg42yLW/JQl0TTEAY
 c1sw==
X-Gm-Message-State: AOAM531Ue/qg9vOMm1cfhfGfAVrEJEn+kEXpzDySh3RTyMosbUVN/u6E
 qdWB48il/BSojCxzs24cm98Zs+oKYxEKCe6ExMHGYQ==
X-Google-Smtp-Source: ABdhPJyRLvthYFvora3F8m8aDgpJALw3IT020DXRrPtPCELfvbjKYXqBC90IHmi3GTURDz3Xtd2a9IymngKqvYEMIjI=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr1375678oib.163.1594322058138; 
 Thu, 09 Jul 2020 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200703201911.26573-1-f4bug@amsat.org>
 <20200703201911.26573-19-f4bug@amsat.org>
In-Reply-To: <20200703201911.26573-19-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 20:14:07 +0100
Message-ID: <CAFEAcA98Wz2URx3Pt0YfaoQSPnnMT4wg6HBfzdDO4Zq+4fgT5g@mail.gmail.com>
Subject: Re: [RFC PATCH 18/18] hw/core/qdev: Display warning for devices
 missing migration state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 21:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> When built with --enable-qdev-debug, QEMU displays warnings
> listing devices missing migration state:
>
>   $ qemu-system-arm -S -M spitz
>   qemu-system-arm: warning: missing migration state for type: 'pxa270-c0-=
arm-cpu'
>   qemu-system-arm: warning: missing migration state for type: 'serial'
>   qemu-system-arm: warning: missing migration state for type: 'pxa2xx-pcm=
cia'
>   qemu-system-arm: warning: missing migration state for type: 'pxa2xx-pcm=
cia'
>   qemu-system-arm: warning: missing migration state for type: 'pxa2xx-i2c=
-slave'
>   qemu-system-arm: warning: missing migration state for type: 'pxa2xx-i2c=
-slave'
>   qemu-system-arm: warning: missing migration state for type: 'ads7846'
>   qemu-system-arm: warning: missing migration state for type: 'max1111'
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because there might be something simpler than --enable-qdev-debug.

I think where we'd like to get to is installing a migration
blocker if the machine has any devices which don't have a vmsd.
But for that we'd need to be pretty sure we'd got all the devices
on machines where we care about migration, and we're clearly a
fair way from that (eg we need to do something about the
devices like the CPU which don't have a vmsd but handle their
migration some other way so they don't trigger the condition
for warning/migration-blocker).

I don't have a strong objection to this --enable-qdev-debug, I guess.
Another option halfway between this and a full migration-blocker
would be do a warn_report() for the relevant devices when savevm
tries to migrate them.

thanks
-- PMM


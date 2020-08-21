Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B35820656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EIlqTsgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B35820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99rT-00026t-Ov
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k99qI-0000qO-2D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:24:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k99qF-0005yC-IP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:24:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id t14so2399315wmi.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PHfRZX3prAYtPK3l2FA0/Cvl6nMMk2xejrvYxhSyBlo=;
 b=EIlqTsgv/wtEMwZzZU9aIR1RV+WiW9HVgpT/8fBVfKpxAXxqOrpCEuCnohlnF8Rdwa
 OjqTYa/kaqRkzCKGB1oHMeE7acusUMx/bowpHgxy7G1ne+HLCHormsf8qKvu+Brso8Cy
 zZ2mQ1pp8D0IQXMoJAhPGn9dV3MsuuV9T661o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PHfRZX3prAYtPK3l2FA0/Cvl6nMMk2xejrvYxhSyBlo=;
 b=L5gaO8X90A8kOTGphJqK4wRzpq1/Yebcn5NI9ClodVJvGTZfMPm3jXtGptLq3blWGH
 U1q+kubMa3SkkNWJd/f1wAemZJY0ZSQUJKCGadrQfLvqpa2Toug9cVqkipB4zUSwtDQO
 FOztc7vRwyY5ClTiTbbvY4/jLBaLdqtLTzZUYLguNGrMLldyLw0mdecErxye27oAq44h
 u2ozsG55y6rLPonqCA1Yi2Gl0M5Y+QyKomnzly9Szm9CObEiYRJ/xBbNKXeahziBSqvx
 fTpl7rzKUAPUb6fKxoYCsoHSfM88dXKCbPBZVyV9dLbg2RrERMnVtsFQY1dDr4TP4igW
 jRgg==
X-Gm-Message-State: AOAM533Mvru1405AVZJuRAy2YPh5wrn4lqmbPioNKSzBrcqov5Jz/yMI
 DyWNMQFC34uDBJ856aaqYTthOJavTjPjRCpZJPZvjA==
X-Google-Smtp-Source: ABdhPJyL8DAp12lOxui74JNb3/FIpSncMpLLUmVJ4FtuDMUBI+Om99Zd+2/h3gyMSaWB48z/VVfIkc2wBWJXiYCJUNI=
X-Received: by 2002:a1c:2646:: with SMTP id m67mr4814746wmm.137.1598027072870; 
 Fri, 21 Aug 2020 09:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200812152149.260163-1-michael@amarulasolutions.com>
 <20200817064701.o3q3plnjhzyz3s42@sirius.home.kraxel.org>
 <CAOf5uwn94gZPZXChFDXWZ-1w0jOY_SxRqzF4Mk8hrtLq-r3yCg@mail.gmail.com>
 <20200817072841.lvbco4k7hzzimxsb@sirius.home.kraxel.org>
 <CAOf5uwn2KAajFo7oXYkZg5q3jbJyRC50hJafcoWCVzrdvkqXMw@mail.gmail.com>
 <20200818060214.z2irps623upmbe2w@sirius.home.kraxel.org>
 <CAOf5uwmKuRGf1F6SouBXcGTmErgCL=CL2RwL=CBbK0SkvOSH2Q@mail.gmail.com>
 <20200819055211.bo4xim6cai7qzf2j@sirius.home.kraxel.org>
In-Reply-To: <20200819055211.bo4xim6cai7qzf2j@sirius.home.kraxel.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 21 Aug 2020 18:24:21 +0200
Message-ID: <CAOf5uw=OH0VY==sru_J3er3kFTGKYh0Pnu_QW0RHfbda=8sPbg@mail.gmail.com>
Subject: Re: [PATCH] hw: dev-wacom: Support wacom tablet emulation in linux
 qemu
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=michael@amarulasolutions.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi


On Wed, Aug 19, 2020 at 7:52 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > Have another small question. Do you know how force show cursor working
> > > > in this case?
> > >
> > > Which display and which vga do you use?
> >
> > -vga std \
>
> So stdvga (has no hardware cursor support).
>
> display not specified, so it is the default.
> i.e. gtk or sdl depending on what configure finds.
>
> > But I need to use the framebuffer. So what happens for instance in
> > software like ts_calibrate you can not see the cursor
>
> Does -vga virtio work better?

pen("/dev/fb0", O_RDWR|O_LARGEFILE)    = 5
ioctl(5, FBIOGET_FSCREENINFO, 0x8055e40) = 0
ioctl(5, FBIOGET_VSCREENINFO, 0x8055da0) = 0
mmap2(NULL, 0, PROT_READ|PROT_WRITE, MAP_SHARED, 5, 0) = -1 EINVAL
(Invalid argument)
write(2, "mmap framebuffer", 16mmap framebuffer)        = 16
write(2, ": ", 2: )                       = 2
write(2, "Invalid argument", 16Invalid argument)        = 16
write(2, "\n", 1
)                       = 1

Michael

>
> take care,
>   Gerd
>


--
Michael Nazzareno Trimarchi
Amarula Solutions BV
COO Co-Founder
Cruquiuskade 47 Amsterdam 1018 AM NL
T. +31(0)851119172
M. +39(0)3479132170
[`as] https://www.amarulasolutions.com


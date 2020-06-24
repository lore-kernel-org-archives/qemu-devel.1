Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9354DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E21220707
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNrg8PWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E21220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnw6n-0005fv-LO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 23:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnw5y-00057L-CN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:29:06 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:41430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnw5w-0001NQ-Lj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:29:06 -0400
Received: by mail-lj1-x22c.google.com with SMTP id 9so944775ljc.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jI17LQTN3+z4SiRVh3azK7/wsTn408ncZ2KjazB86gg=;
 b=PNrg8PWQ+ZG3a4BhsUtOd4Sq7oWFs3cxNHl0dA62wM+U8y4vm8wPgPzUH+gB5sH6h5
 nX63MvzOgmV1Dm+eTjbFUVpLAnSkKc/c9kk4alc0Xe6e3FCjE5nNOXfMWZqKp2ebRil0
 b3GuBQXYLsrEBy+7CsroblcxwHiSXzYD0hoUToAGL8eovfH3majYR7b6D0pk1+q+u8z0
 NHfShoouJRtLTPNex1QYKFsEHIJHTwNkFiYtzfwfCkYKvsYkRgiP8oXVImlO0mgNw1JT
 h7kF6ZctSSLpcPE5YvDOx+7pbENUP0ySTZtA+qn+5POIinXib6Km0V5qtgh8kpRYr4LH
 lj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jI17LQTN3+z4SiRVh3azK7/wsTn408ncZ2KjazB86gg=;
 b=OAgFzJ7dbkhvjNdVtc65apqFx+up2zhPlHMpOTbAo3tcCxKpeVAPf1Pb0dpLVpcMA4
 W5ObYOSwPRT7LQqkPV0ltPTssKmCrlm2Lw9H094FxzdJOT+35NFl7DgT0gm0OC0Gjjb1
 5yfGYInyniEiUbsYon4yhQbl2KWjBjRCDY4TdG3Ju/VMNwJZYmhCHgWFzkL+uSZmvEum
 HwgBlEQp2CcJfzzeCMh1D4dw23R394w/neFFabEST1PLFoyQ+EI7LVS4Jg5gWdoTJ3BF
 CNWYSnjMzoGL8NCV0Xz2BuUTu6t3vVKqGDrqU6FPGZi6ZZibaIUy2KRuVbRv46h7irJi
 Qrhg==
X-Gm-Message-State: AOAM531svg8UIuMo4oajvmBLRKeHCswPF9b2VUDRuFsrIUHX+WPvXMYE
 J84cBXhJHyUrpx5ZyYCaBNeyVDFUl9VD5qw0lIrESg==
X-Google-Smtp-Source: ABdhPJyu1IksiHVFvTZLBipIeEqb+aQHEsVhvlrZa7kDEIWUxIvXB4tVHZ7iiQxaNvxnksFjwjNt5Jn4fyup9CPF4RM=
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr13583203ljj.114.1592969342938; 
 Tue, 23 Jun 2020 20:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
 <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
 <CAKf6xpvs6mNowsiAzbfQGLGp0aY0zKgUD=DVpSorWHycm--J8g@mail.gmail.com>
 <87k0zykwdl.fsf@dusky.pond.sub.org>
 <CAKf6xpuWfw7HEyfaH4jk02LUkt5b6eqdOdXhddqEX=iuPTbCTA@mail.gmail.com>
 <000101d64961$681c0350$385409f0$@xen.org>
In-Reply-To: <000101d64961$681c0350$385409f0$@xen.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 23 Jun 2020 23:28:51 -0400
Message-ID: <CAKf6xpuZAjDvSxUjRfgy9KAmHHpEKq5OTYNTO1iJnvmSyKXX6Q@mail.gmail.com>
Subject: Re: sysbus failed assert for xen_sysdev
To: Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 9:22 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Jason Andryuk <jandryuk@gmail.com>
> > Sent: 23 June 2020 13:57
> > To: Markus Armbruster <armbru@redhat.com>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>; Anthony PERARD <anthony.perard@citrix.com>; xen-
> > devel <xen-devel@lists.xenproject.org>; Paul Durrant <paul@xen.org>; QEMU <qemu-devel@nongnu.org>
> > Subject: Re: sysbus failed assert for xen_sysdev

> >
> > Thanks for your response, Markus.
> >
> > I didn't write it, but my understanding is as follows.  TYPE_XENSYSDEV
> > is a device on the system bus that provides the TYPE_XENSYSBUS bus.
> > TYPE_XENBACKEND devices can then attach to TYPE_XENSYSBUS.
> >
> > That would make the qom-tree something like:
> >   /TYPE_XENSYSDEV
> >     /TYPE_XENSYSBUX
> >       /TYPE_XENBACKEND
> >
> > (I think today the TYPE_XENBACKEND devices ends up attached to the System bus.)
> >
> > I think TYPE_XENSYSDEV is correct - it is a device on the system bus.
> > static const TypeInfo xensysdev_info = {
> > .name = TYPE_XENSYSDEV,
> > .parent = TYPE_SYS_BUS_DEVICE,
> > ...
> > }
> >
> > TYPE_XENSYSBUS is the xen-specific bus - provided by TYPE_XENSYSDEV -
> > for attaching xendev.
> > static const TypeInfo xensysbus_info = {
> > .name = TYPE_XENSYSBUS,
> > .parent = TYPE_BUS,
> > ...
> > }
> >
> > TYPE_XENBACKEND is a generic Xen device and it plugs into
> > TYPE_XENSYSBUS.  Maybe the .parent here is wrong and it should just be
> > TYPE_DEVICE?
>
> Yes, I think that is the problem leading to the assert. See the equivalent (non-legacy) code in xen-bus.c.

Yes, xen-bus.c looks correct, but the important change seems to be
removing `dc->bus_type = TYPE_XENSYSBUS;` from xen_sysdev_class_init()
and adding it to xendev_class_init().  That let QEMU get to the
cfi.pflash01 assertion failure.

Regards,
Jason

>   Paul
>
> > static const TypeInfo xendev_type_info = {
> > .name = TYPE_XENBACKEND,
> > .parent = TYPE_XENSYSDEV,
> > ...
> > }
> >
> > So removing `bus_type = TYPE_XENSYSBUS` from TYPE_XENSYSDEV class_init
> > and adding it to TYPE_XENBACKEND seems correct to me.


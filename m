Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636AF2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Qh+igW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636AF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniUo-0006iR-ML
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jniU0-0005lA-JL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:57:01 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jniTx-0000Oa-Cj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:57:00 -0400
Received: by mail-lj1-x244.google.com with SMTP id h19so2159990ljg.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tmgHnnSd2AhlWUZqE+7+CsDcN51ZUIEGo1aJK/n/Weo=;
 b=l7Qh+igWjhF19vtDMdlg9w4aaLAglXbIa7Oora5BImo+Vclc+QT/p19Xhx2JL7C375
 XDzBg1zGQn7YSEGbPvFAkAV++t1YXqPZhfFZitCY52h6flQcm+dQLNM2kPYl7HcYhxDW
 RnQBYQ26uPFiNr4Qz7JBcYdoFgVSuNa+pciaq+nvHRkHXLgwYFSJXjTJ+rw0vsT31vES
 AfrEZKWpQ0dU47hE0u4FF2wGabGlsaYL8l5dsWYcoOpR5Mzll3SoA2p/iLk+OhpAgZNR
 9WdzGJ47zAk+3bpuahmY/smlElabvUu+q7Wnt0zsrxpNZHGx0Zqs+LMZqkp4UziBbfjg
 noAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tmgHnnSd2AhlWUZqE+7+CsDcN51ZUIEGo1aJK/n/Weo=;
 b=AFqHXqBGHOr8dM89rOKSWP1Pm28o8kND0H2bdDTsxbEqMv5TvU7xekJ4vX14GJVxFq
 VgR5vdmGOmKS3T6GSsLcqox/L9dmCvs5trx4DADNfc9/kf7y8Q55jTgRJjUOtV/YH+U0
 FeVUP5Gx/cfTlXDr4N1LVxN/GgiMDF08iSBAEVtT12qjHjLjxoe8gw4vbTzCy5Amj888
 vtTVS6mbTGHjiZzBoYY6kwl/HYDCdJ0rRVTYRnU8RwU5Y+gdYy4zVe85kLuY8jzOk/mX
 vMzHPl4GMmpxGnrG4ogKOFDJqSO+mChUV39xArIHmhyTKfoErncqiWZPdhNdqIqKq9GO
 TMLQ==
X-Gm-Message-State: AOAM530/JFDAD/JpiC5HDPq6IDXp+nNkEv+1zxPcr5K2iq5xZnE2/1Jo
 +dMwftDPODb8+1f9ud6/GW5As1cR3nn2XYEeyfU=
X-Google-Smtp-Source: ABdhPJwIJTA5lJ4uvW7bRBluKVm8y8/7TchRhkHlA0g7a+1ldYD4TNrBKwSb0bL81yRwHF10467WzDyTPFQIMefqCOY=
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr11869856ljj.114.1592917015188; 
 Tue, 23 Jun 2020 05:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
 <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
 <CAKf6xpvs6mNowsiAzbfQGLGp0aY0zKgUD=DVpSorWHycm--J8g@mail.gmail.com>
 <87k0zykwdl.fsf@dusky.pond.sub.org>
In-Reply-To: <87k0zykwdl.fsf@dusky.pond.sub.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 23 Jun 2020 08:56:43 -0400
Message-ID: <CAKf6xpuWfw7HEyfaH4jk02LUkt5b6eqdOdXhddqEX=iuPTbCTA@mail.gmail.com>
Subject: Re: sysbus failed assert for xen_sysdev
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x244.google.com
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 4:41 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Jason Andryuk <jandryuk@gmail.com> writes:
>
> > On Mon, Jun 22, 2020 at 5:17 PM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> On 22/06/2020 21:33, Jason Andryuk wrote:
> >>
> >> > Hi,
> >> >
> >> > Running qemu devel for a Xen VM is failing an assert after the recent
> >> > "qdev: Rework how we plug into the parent bus" sysbus changes.
> >> >
> >> > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> >> > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> >> > failed.
> >> >
> >> > dc->bus_type is "xen-sysbus" and it's the
> >> > `object_dynamic_cast(OBJECT(bus), dc->bus_type)` portion that fails
> >> > the assert.  bus seems to be "main-system-bus", I think:
> >> > (gdb) p *bus
> >> > $3 = {obj = {class = 0x55555636d780, free = 0x7ffff7c40db0 <g_free>,
> >> > properties = 0x5555563f7180, ref = 3, parent = 0x5555563fe980}, parent
> >> > = 0x0, name = 0x5555563fec60 "main-system-bus", ...
> >> >
> >> > The call comes from hw/xen/xen-legacy-backend.c:706
> >> > sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
> >> >
> >> > Any pointers on what needs to be fixed?
> >>
> >> Hi Jason,
> >>
> >> My understanding is that the assert() is telling you that you're plugging a
> >> TYPE_SYS_BUS_DEVICE into a bus that isn't derived from TYPE_SYSTEM_BUS.
> >> TYPE_SYS_BUS_DEVICE into a bus that isn't derived from TYPE_SYSTEM_BUS. A quick look
>
> Correct.  Let's review the assertion:
>
>     assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));
>
> Context: we're supposted to plug @dev into @bus, and @dc is @dev's
> DeviceClass.
>
> The assertion checks that
>
> 1. @dev plugs into a bus: dc->bus_type
>
> 2. @bus is an instance of the type of bus @dev plugs into:
>    object_dynamic_cast(OBJECT(bus), dc->bus_type)
>
> >> at the file in question suggests that you could try changing the parent class of
> >> TYPE_XENSYSBUS from TYPE_BUS to TYPE_SYSTEM_BUS to see if that helps?
> >
> > Hi, Mark.
> >
> > Thanks, but unfortunately changing xensysbus_info .parent does not
> > stop the assert.  But it kinda pointed me in the right direction.
> >
> > xen-sysdev overrode the bus_type which was breaking sysbus_realize.
> > So drop that:
> >
> > --- a/hw/xen/xen-legacy-backend.c
> > +++ b/hw/xen/xen-legacy-backend.c
> > @@ -824,7 +825,7 @@ static void xen_sysdev_class_init(ObjectClass
> > *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >
> >      device_class_set_props(dc, xen_sysdev_properties);
> > -    dc->bus_type = TYPE_XENSYSBUS;
> > +    //dc->bus_type = TYPE_XENSYSBUS;
> >  }
>
> Uff!
>
> Let me explain how things are supposed to work.
>
> Say we have FOO bus (QOM type TYPE_FOO_BUS), with FOO devices plugging
> into it (abstract QOM type TYPE_FOO_DEVICE).  One of them is SOME_FOO
> (concrete QOM type TYPE_SOME_FOO).  Code ties them together like this:
>
>     static const TypeInfo pci_bus_info = {
>         .name = TYPE_PCI_BUS,
>         .parent = TYPE_BUS,
>         ...
>     };
>
>     static const TypeInfo foo_device_info = {
>         .name = TYPE_FOO_DEVICE,
>         .parent = TYPE_DEVICE,
>         .abstract = true,
>         .class_init = foo_device_class_init,
>         ...
>     };
>
>     static void foo_device_class_init(ObjectClass *oc, void *data)
>     {
>         DeviceClass *dc = DEVICE_CLASS(oc);
>
>         dc->bus_type = TYPE_FOO_BUS;
>         ...
>     }
>
>     static const TypeInfo some_foo_info = {
>         .name = TYPE_SOME_FOO,
>         .parent = TYPE_FOO_DEVICE,
>         ...
>     };
>
> When you plug an instance of TYPE_SOME_FOO into a bus, the assertion
> checks that the bus is an instance of TYPE_FOO_BUS.
>
> Note that subtypes of TYPE_FOO_DEVICE do not mess with dc->bus_type!
>
> TYPE_XENSYSDEV does mess with it:
>
>     static void xen_sysdev_class_init(ObjectClass *klass, void *data)
>     {
>         DeviceClass *dc = DEVICE_CLASS(klass);
>
>         device_class_set_props(dc, xen_sysdev_properties);
>         dc->bus_type = TYPE_XENSYSBUS;
>     }
>
>     static const TypeInfo xensysdev_info = {
>         .name          = TYPE_XENSYSDEV,
>         .parent        = TYPE_SYS_BUS_DEVICE,
>         .instance_size = sizeof(SysBusDevice),
>         .class_init    = xen_sysdev_class_init,
>     };
>
> On the one hand, xensysdev_info.parent claims TYPE_XENSYSDEV is a
> TYPE_SYS_BUS_DEVICE (and therefore should plug into a TYPE_SYSTEM_BUS).
> On the other hand, its dc->bus_type is a TYPE_XENSYSBUS, which is *not*
> a subtype of TYPE_SYSTEM_BUS:
>
>     static const TypeInfo xensysbus_info = {
>         .name       = TYPE_XENSYSBUS,
> --->    .parent     = TYPE_BUS,
>         .class_init = xen_sysbus_class_init,
>         .interfaces = (InterfaceInfo[]) {
>             { TYPE_HOTPLUG_HANDLER },
>             { }
>         }
>     };
>
> This is an inconsistent mess.
>
> Are TYPE_XENSYSDEV and TYPE_XENSYSBUS related to TYPE_SYS_BUS_DEVICE and
> TYPE_SYSTEM_BUS?
>
> If no, then xensysbus_info.parent should not be TYPE_SYS_BUS_DEVICE, and
> you must not pass instances of one kind to functions expecting the other
> kind.
>
> If yes, how?  If the former are specializations of the latter, consider
> making the former subtypes of the latter.  Both of them.  Then a
> TYPE_XENSYSDEV device can plug into a TYPE_XENSYSBUS bus, but not into a
> TYPE_SYSTEM_BUS bus.
>
> A TYPE_SYS_BUS_DEVICE could still plug into TYPE_XENSYSBUS, because the
> latter is also an instance of TYPE_SYSTEM_BUS.

Thanks for your response, Markus.

I didn't write it, but my understanding is as follows.  TYPE_XENSYSDEV
is a device on the system bus that provides the TYPE_XENSYSBUS bus.
TYPE_XENBACKEND devices can then attach to TYPE_XENSYSBUS.

That would make the qom-tree something like:
  /TYPE_XENSYSDEV
    /TYPE_XENSYSBUX
      /TYPE_XENBACKEND

(I think today the TYPE_XENBACKEND devices ends up attached to the System bus.)

I think TYPE_XENSYSDEV is correct - it is a device on the system bus.
static const TypeInfo xensysdev_info = {
.name = TYPE_XENSYSDEV,
.parent = TYPE_SYS_BUS_DEVICE,
...
}

TYPE_XENSYSBUS is the xen-specific bus - provided by TYPE_XENSYSDEV -
for attaching xendev.
static const TypeInfo xensysbus_info = {
.name = TYPE_XENSYSBUS,
.parent = TYPE_BUS,
...
}

TYPE_XENBACKEND is a generic Xen device and it plugs into
TYPE_XENSYSBUS.  Maybe the .parent here is wrong and it should just be
TYPE_DEVICE?
static const TypeInfo xendev_type_info = {
.name = TYPE_XENBACKEND,
.parent = TYPE_XENSYSDEV,
...
}

So removing `bus_type = TYPE_XENSYSBUS` from TYPE_XENSYSDEV class_init
and adding it to TYPE_XENBACKEND seems correct to me.

Regards,
Jason

> Questions?
>
> >
> >  static const TypeInfo xensysdev_info = {
> >
> > Then I had a different instance of the failed assert trying to attach
> > xen-console-0 to xen-sysbus.  So I made this change:
> > --- a/hw/xen/xen-legacy-backend.c
> > +++ b/hw/xen/xen-legacy-backend.c
> > @@ -789,6 +789,7 @@ static void xendev_class_init(ObjectClass *klass,
> > void *data)
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >      /* xen-backend devices can be plugged/unplugged dynamically */
> >      dc->user_creatable = true;
> > +    dc->bus_type = TYPE_XENSYSBUS;
> >  }
> >
> >  static const TypeInfo xendev_type_info = {
> >
> > Then it gets farther... until
> > qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
> > Assertion `dev->realized' failed.
> >
> > dev->id is NULL. The failing device is:
> > (gdb) p *dev.parent_obj.class.type
> > $12 = {name = 0x555556207770 "cfi.pflash01",
> >
> > Is that right?
> >
> > I'm going to have to take a break from this now.
> >
> > Regards,
> > Jason
>


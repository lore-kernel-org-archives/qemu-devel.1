Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 03:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0868B206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 03:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkO5PKTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnZov-0001Uw-Ao
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 23:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnZo6-00013h-Bf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 23:41:10 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:39230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnZo4-0001x1-Mm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 23:41:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id a9so21728684ljn.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g780v6WnLYQ1QZQRWq+6mQKK2XsAf/u1xfSFw0Z6JFs=;
 b=nkO5PKTHb8KutOobp7Hgg+WgOCYi/XoTF9/3Vxe5VfF8NFti+41Pbu/33yI+D8AQsq
 Ky9jOYjaj1wJff8Skb2LVhjnLwjyOwRsnOUvotHAXYRKjTCiHmIX9wn4jCAksbtjIdTI
 58vdQCHRAVYOmMvccfsH9inZ2nczLKA7q2rbGBJXGFqkrkecCToCo25wfPFefpORLBl6
 JS3sRSuX6u/92iF1QgVsQwiWvLFpR5rX4wdzG/TcZ8fL2fKLgyEkNx5UrTPAYTC00oNx
 Iede+FD2k91tVb53kUAVjYO9dajw6a5TtNiTIfbLa8tBAMCeQE+vMbS567v9CzUXNNtX
 MnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g780v6WnLYQ1QZQRWq+6mQKK2XsAf/u1xfSFw0Z6JFs=;
 b=VLRtv9D3cfgWHyf3r4stXlsgU615V3GTW5oo7DsMI4YQCb0YR3fe/U4fCplvXBeu1Z
 MP8tymwDKsgMep+xDKXTSSWaWI7B5CPVnmCfNS43Zgssn0eFnKBSAmXYi2AjfYxteG6j
 He+lhS8EsQyd5Vmn8nBZEDKyAiOmD8u0BE7c5vbOW9F7/ZYMMz4G9eJPQDRiA37YzlJK
 Xq6e2tTCLpgLpE79uU+V0s43skmo6Yav9d3BXA3tFcrpab+RV3Kldfy9fzDjlLg+gmXk
 XgzIEM85KfC/sTRL0ShU6NOKvzFPNqv7+HCmc3KL+7+96GooAco4IQWIyTRmuPZFe2jO
 y/2A==
X-Gm-Message-State: AOAM533A2tJ+5wWYoKElarKQQQQCCJBm+8ZUv9pxvPJUo/y+aFk0Uurh
 NYHigV3Re8uGRvZVhjokDAMFN/zjnivJ7cCVJgg=
X-Google-Smtp-Source: ABdhPJyBZV5fmqperXCFj6v08Ebo6e6nCRkDfnitOFhxpl87pM0Cj79N1j1ptSWGuTMvlschI12cqgk9yx9AUkKiFyY=
X-Received: by 2002:a2e:9141:: with SMTP id q1mr9666796ljg.196.1592883666790; 
 Mon, 22 Jun 2020 20:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
 <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
In-Reply-To: <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 22 Jun 2020 23:40:55 -0400
Message-ID: <CAKf6xpvs6mNowsiAzbfQGLGp0aY0zKgUD=DVpSorWHycm--J8g@mail.gmail.com>
Subject: Re: sysbus failed assert for xen_sysdev
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x233.google.com
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
 xen-devel <xen-devel@lists.xenproject.org>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 5:17 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 22/06/2020 21:33, Jason Andryuk wrote:
>
> > Hi,
> >
> > Running qemu devel for a Xen VM is failing an assert after the recent
> > "qdev: Rework how we plug into the parent bus" sysbus changes.
> >
> > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> > failed.
> >
> > dc->bus_type is "xen-sysbus" and it's the
> > `object_dynamic_cast(OBJECT(bus), dc->bus_type)` portion that fails
> > the assert.  bus seems to be "main-system-bus", I think:
> > (gdb) p *bus
> > $3 = {obj = {class = 0x55555636d780, free = 0x7ffff7c40db0 <g_free>,
> > properties = 0x5555563f7180, ref = 3, parent = 0x5555563fe980}, parent
> > = 0x0, name = 0x5555563fec60 "main-system-bus", ...
> >
> > The call comes from hw/xen/xen-legacy-backend.c:706
> > sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
> >
> > Any pointers on what needs to be fixed?
>
> Hi Jason,
>
> My understanding is that the assert() is telling you that you're plugging a
> TYPE_SYS_BUS_DEVICE into a bus that isn't derived from TYPE_SYSTEM_BUS. A quick look
> at the file in question suggests that you could try changing the parent class of
> TYPE_XENSYSBUS from TYPE_BUS to TYPE_SYSTEM_BUS to see if that helps?

Hi, Mark.

Thanks, but unfortunately changing xensysbus_info .parent does not
stop the assert.  But it kinda pointed me in the right direction.

xen-sysdev overrode the bus_type which was breaking sysbus_realize.
So drop that:

--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -824,7 +825,7 @@ static void xen_sysdev_class_init(ObjectClass
*klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);

     device_class_set_props(dc, xen_sysdev_properties);
-    dc->bus_type = TYPE_XENSYSBUS;
+    //dc->bus_type = TYPE_XENSYSBUS;
 }

 static const TypeInfo xensysdev_info = {

Then I had a different instance of the failed assert trying to attach
xen-console-0 to xen-sysbus.  So I made this change:
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -789,6 +789,7 @@ static void xendev_class_init(ObjectClass *klass,
void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* xen-backend devices can be plugged/unplugged dynamically */
     dc->user_creatable = true;
+    dc->bus_type = TYPE_XENSYSBUS;
 }

 static const TypeInfo xendev_type_info = {

Then it gets farther... until
qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
Assertion `dev->realized' failed.

dev->id is NULL. The failing device is:
(gdb) p *dev.parent_obj.class.type
$12 = {name = 0x555556207770 "cfi.pflash01",

Is that right?

I'm going to have to take a break from this now.

Regards,
Jason


Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11667C2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02F42072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="J4L9SJ1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02F42072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMR9y-0001Tz-Ss
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 02:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jMR9K-00010r-Rp
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jMR9J-0000uU-Fk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:58:54 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:34402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jMR9J-0000u0-82
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:58:53 -0400
Received: by mail-vk1-xa43.google.com with SMTP id p123so2516580vkg.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UOH+4sElY97Kn/fu2C6ks2/6LZaOAtgdKCvQI2y2+fA=;
 b=J4L9SJ1ArKQEfGSiMFfwm+KV8YoYQoN2mmrnJKtMWEM3GVXlcz9QXGVYOXRY9EZ70t
 0vqQeY0zdnicGyb3w+Ehg9yh9bFkLPJxzmL6C9D9mpFolounLTTwnPBqKdNN43u3m3/K
 ZDECZ0Rce7mCErjgo9T8F8yu8jfHsAROiThnaTsztqykitKFhsT7otiuGEZF+EA5v0WM
 csa535xfLJ75SUY/Cn0UK2dcgpb9j9K39G3fah2aWkHaGHwLrs3zLKt8f8OLerZxzg2A
 IV8vqHcL6/hnskMmV96InLDxx21tgVp9qUpkstC935c/c68J+HvpUsyxwADs95dEojvQ
 NrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UOH+4sElY97Kn/fu2C6ks2/6LZaOAtgdKCvQI2y2+fA=;
 b=qln3UpkXWqWFGWsNIACi1TrnJKsUM6f09jeS0HemGrevas4aoTjhUkUIJLcbXsHoSd
 j9baB+DkmEewOOHCY003eEeOw8Etz0XtfulB1opqeaRBXnC3D47Y2AzoDQfuiD+rdZsh
 b3BxBK4pP2KBW85kLryXuR4QpQfu9s8O3151sXJR4yOCKa/aZ/UetCbgoJR5IzmrkJdS
 wKTSuJ9MhWQuD8dkNr8ucFJwwCphWrCt947CWqmDPUNIsQE4Ad2AYpcfylyFhrt73jTn
 Q9mdD8Tj2W4GyGm18JfZ/Y+WhWr9hj8gcC5zSBjHJQ0uIpIIM8nL2U81YPLHyIQg69bw
 85qw==
X-Gm-Message-State: AGi0PubVnauj1+vw8MI5KynmXLps1ycn+dkMUAV6k78CKwk5pUnRjAAx
 hMq/Oeck5qGgUqZhu7xID3eLeMadLddV/n3+CzJEv+9HCeo1glfpJsG7AjZin049oebkJDKyKSK
 vH7O2srXDmkAU7tRjBZlvOutf
X-Google-Smtp-Source: APiQypJ2qjxC5BVeyr/RoX7MUgyi29dP3xrpuEdvwztCwipoWDBXi2gKB9DCV0blhhmFDUqKDspt4UmS5mo9dur50TU=
X-Received: by 2002:a1f:b48c:: with SMTP id d134mr7975225vkf.76.1586415531389; 
 Wed, 08 Apr 2020 23:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
 <20200408124035.41c1d242@redhat.com>
In-Reply-To: <20200408124035.41c1d242@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Thu, 9 Apr 2020 14:58:40 +0800
Message-ID: <CAHckoCzWgEr+u1UZVtF7YEZcD57hMvEH85YXgLfnvKHQ2KtAxA@mail.gmail.com>
Subject: Re: hotplug issue of vhost-user-blk
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 raphael.norwitz@nutanix.com, Kyle Zhang <kyle@smartx.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks!
After waiting some seconds after device_del:
(qemu) device_del spdk_vhost_blk2
sleep 5
(qemu) chardev-remove spdk_vhost_blk2
Error: Chardev 'spdk_vhost_blk2' is busy

It works. However, I find some crashes about the vhost-user-blk.
I will send out the patches after all tests.

Thanks,

Feng Li

Igor Mammedov <imammedo@redhat.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 8 Apr 2020 10:25:42 +0800
> Li Feng <fengli@smartx.com> wrote:
>
> > Hi all,
> >
> > Hotplug of vhost-user-blk doesn't not work in qemu master branch and
> > all previous version.
> >
> > The action I insert a vhost-user-blk disk is:
> > (qemu) chardev-add socket,id=3Dspdk_vhost_blk2,path=3D/vhost-blk.0,reco=
nnect=3D1
> > (qemu) device_add
> > vhost-user-blk-pci,chardev=3Dspdk_vhost_blk2,id=3Dspdk_vhost_blk2,num-q=
ueues=3D4
> >
> > Until here, it's well.
> >
> > Then I unplug it from qemu:
> > (qemu) device_del spdk_vhost_blk2
> > (qemu) chardev-remove spdk_vhost_blk2
> > Error: Chardev 'spdk_vhost_blk2' is busy
> >
> > The related code is here:
> > qmp_chardev_remove
> >     -> qemu_chr_is_busy
> >     -> object_unparent(OBJECT(chr));
> >
> >  330 static bool qemu_chr_is_busy(Chardev *s)
> >  331 {
> >  332     if (CHARDEV_IS_MUX(s)) {
> >  333         MuxChardev *d =3D MUX_CHARDEV(s);
> >  334         return d->mux_cnt >=3D 0;
> >  335     } else {
> >  336         return s->be !=3D NULL;
> >  337     }
> >  338 }
> >
> > My question is:
> > 1. s->be is set to NULL when qemu_chr_fe_deinit is called.
> > However, the qmp_chardev_remove is blocked at qemu_chr_is_busy check,
> > then the object_unparent will not be called.
> > 2. Is there a path that device_del will trigger the s->be that been set=
 to NULL?
>
> device_del is request for guest to eject device and once it's done backen=
d
> could be removed.
>
> what's you command line? (so I could point out entry point where ejection=
 happens
> for you to troubleshoot it further)
>
> >
> > How should I fix this issue?
> > I have tested that comment the qemu_chr_is_busy works well.
> >
> > Thanks in advance.
> >
> > Feng Li
> >
>

--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=E6=
=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=BC=
=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=AC=
=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=E5=
=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=E5=
=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=98=
=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.




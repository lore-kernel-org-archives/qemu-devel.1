Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21245C2D0EF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 10:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C1321D79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 10:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI2EcO4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C1321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPkx4-0006a3-1i
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ni.xun.intel@gmail.com>) id 1jPkwO-0006B5-UM
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 06:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ni.xun.intel@gmail.com>) id 1jPkwM-0005wg-Cg
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 06:43:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ni.xun.intel@gmail.com>)
 id 1jPkwM-0005wA-5y
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 06:43:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id k9so4421007oia.8
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OkTEu7fUCgrZaOZg3wfRMqhq5vIS2c6t4D8ryZz4wKU=;
 b=qI2EcO4GekLKngoCMU76+XWEYU5zL+yca68fFEB21ennPemObalruNaelFdwRVZACt
 ItOhLORno8TTbUU9Q1EEliTIr1d+QOZVc+ZIH0DTc8e1Fis85NxDK10sNZX87I0Io0Qr
 fzsiV4Z4fFUCuSABvaYtTM7+L1D1xN19GdFcRG9dxKXPyvAIitoYZKl04gxoQd3uQQdO
 lFGC0KKIb2BRBttUvZAr/iDmj4SD9DhPDe4e6ztmayhl2opngY91+j0Ne9ng5gUYmkZj
 A51VnU0lKW5TW0VN4GmR2XFFTM4HqMxALGL0EePXPQ8EFWp9+EEu/PoH3yLZ9PAAdBL7
 Y3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OkTEu7fUCgrZaOZg3wfRMqhq5vIS2c6t4D8ryZz4wKU=;
 b=tvxNM19GqS6xm7qcq+3cllpBQCP/CiNIR6l6jofDUvSDhuHGtLFy1+z6A+Qx/I8R6S
 CeHDbxKZOk7lqTY998VKprPNqB7Mz6n+6YindmgCrbPDG/Yjpbiw235NNfuFbx/tEMXh
 eUSiA0WbHVowBx1k5kjTOOQjdGIr0yHF6DijbCF+ZAF5s5KcDtypF8et3isq8bxF3SYn
 VtR2dhTRe3ypq6LHt0apqUAC8DHmFf6DDSlDkoEQ7oyhNuD03kqZHnjdCMjXPF5B/299
 oI0+HLASXmaDyhjRlyCdE1iF0jXtl8IDkUyUFI6lvqscOHMajiVJ2gNv6GV/w48L2ELJ
 Q+1Q==
X-Gm-Message-State: AGi0PuZ5HX2GNFI7DWF5B8/WozBhBsMCKDCerWIufrBWLb6OcNOZvnW+
 JRxJiSBdeFq7iYB0Mq48d+SYdVFWMoRrfZnfD1Y=
X-Google-Smtp-Source: APiQypKGSLj3dERdJIViPcQ1v5VOfHZdSk9NZ7lf6OEHtKvpFAxdJ4CqZOB1ReAR3lGMpP5bTEYJYiXGrMAEo9IC2V4=
X-Received: by 2002:aca:d06:: with SMTP id 6mr4731915oin.78.1587206592802;
 Sat, 18 Apr 2020 03:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200417051400.30398-1-richardni@tencent.com>
 <20200414100208.GA14282@localhost.localdomain>
In-Reply-To: <20200414100208.GA14282@localhost.localdomain>
From: xun ni <ni.xun.intel@gmail.com>
Date: Sat, 18 Apr 2020 18:42:40 +0800
Message-ID: <CANLX1YEPH=NRve+k=ygvvR0ALr=tXZoHT+BMAVUgqeRRQQCj6w@mail.gmail.com>
Subject: Re: [PATCH] resend slave fd to vhost when reconnect to vhost
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: mst@redhat.com, Yan Miao <leomyan@tencent.com>,
 lucascye <lucascye@tencent.com>, Ni Xun <richardni@tencent.com>,
 qemu-devel@nongnu.org, Lu Zhigang <tonnylu@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

oh, yes, there is some mis-config here, thanks for  pointing that out.
looks like the upstream has fixed it.

Thanks,
Xun

Raphael Norwitz <raphael.norwitz@nutanix.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:46=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Apr 17, 2020 at 01:14:00PM +0800, ni.xun.intel@gmail.com wrote:
> >
> > From: Ni Xun <richardni@tencent.com>
> >
> > when reconnecting to vhost server, it doesn't send slave fd to vhost
> > as the slave fd is only sent in vhost_user_init. also resend the slave =
fd
> > in vhost reconnect.
> >
>
> I don=E2=80=99t think that=E2=80=99s correct. See vhost_user_init() here:
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/virtio/vhost-user.c;h=
=3D08e7e63790e5bcfae6cd31bf9ccd32c3a7347f4e;hb=3DHEAD#l1898
>
> Rather, vhost_setup_slave_channel() is called by vhost_user_backend_init(=
),
> which is called on every reconnect inside vhost_dev_init().
>
> see vhost_user_blk_connect(): https://git.qemu.org/?p=3Dqemu.git;a=3Dblob=
;f=3Dhw/block/vhost-user-blk.c;h=3D17df5338e77c684175a86e882b508849c246e78a=
;hb=3DHEAD#l297
> and vhost_dev_init():https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/v=
irtio/vhost.c;h=3D01ebe12f28e9d7e3150375dda6f55b6b8f04a42a;hb=3DHEAD#l1224
>
> Note that the dev->vq_index is also set to 0 right before the
> vhost_dev_init() call.
>
> I tested myself and saw a VHOST_USER_SET_SLAVE_REQ_FD message sent on eac=
h
> reconnect with the vhost-user-blk sample.
>
> Are you seeing different behavior? If so, please provide more details on
> your setup?
>
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 17df5338e7..59650a570b 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -138,6 +138,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev=
)
> >              error_report("Error get inflight: %d", -ret);
> >              goto err_guest_notifiers;
> >          }
>
> What's the justification for sending the slave fd here? Please elaborate.
>
> > +    } else {
> > +        ret =3D vhost_setup_slave_channel(&s->dev);
> > +        if (ret < 0) {
> > +            error_report("Error setting vhost slave channel: %d", -ret=
);
> > +            return ret;
> > +        }
> >      }
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..cad60ad521 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
>
> Why expose this through vhost.h? This is vhost-user specific.
>
> > @@ -100,6 +100,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev);
> >  void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev);
> >  int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *v=
dev);
> >  void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice =
*vdev);
> > +int vhost_setup_slave_channel(struct vhost_dev *hdev);
> >
> >  /* Test and clear masked event pending status.
> >   * Should be called after unmask to avoid losing events.
> > --
> > 2.24.1 (Apple Git-126)
> >
> >


Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E7C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C4422228
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Kvgh4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C4422228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPSD-0006Jb-FD
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPPo-0004ma-CQ; Fri, 30 Oct 2020 04:05:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:44052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPPm-0008OA-F8; Fri, 30 Oct 2020 04:05:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id w1so4533947edv.11;
 Fri, 30 Oct 2020 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+W8Syh9vDrLxoDxx3JbwPAyYgekK9oE44RncrvpEX1E=;
 b=H7Kvgh4A71Iou9ViSAqjmbvaEh2Xohe1FbjT8oYVIfSr+/2jhwib63AROFHMJVi36w
 H1e7hfNXNmvLqKP0FLoU0nXpKcbP58eKa6f+H+q/VHJi1SgMqyEbTEQXu9db9zlx49Xw
 3QYWg4zRtHnp0JXW6512Byo71YUBZMxZQb7SpdZZtoX2QhC0F/fx4jvGO6JZtbn/tdb8
 UOa2y5jmBV9zi6nmpMAT/8h1/DRWFtAcTcArGS1zob97KEbwC7uoc4j2q0uhTwADbT3w
 Kd2fVAfoS/KtDBRJvhHBvTjspS5Kd63/0RMsb+dCCtkRlD3e98V4CSm5wpr5YJKoNbAh
 u/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+W8Syh9vDrLxoDxx3JbwPAyYgekK9oE44RncrvpEX1E=;
 b=YE6a6NlVujpHpwFwljus024FOkFSCYSjXp8NWVZ56DzSFRU8CI8JBZbcOu7Sh5YmL3
 fJ9rdKk7Qm/WxG4hNh6j8x934Jcb+5qvfnMd5r1UI6ul+TXe/RBrxO3MFAUDrYlt6Wq9
 I2c9b+Qz1A+9jFSLHyaCNb1zHk1LSgzJ+8ziCU0uhIdMKRPBp79YOD9FS2QavRtONExV
 eaGGBCBkablRuIDNMKXqGpro76SMjsdtagAShDtRmqpCSCaBSz/V/GL/1r8D06QeK3lh
 AV1M9j/g4+FIh+mnddzqYqu7QNWsCYXh3w+KdpMWZ8UB//eb7kD9jNUVJbiaoGyWGgkb
 2bqw==
X-Gm-Message-State: AOAM5314nqzuDVxrgG3wr3V62nn0TfV6j4dhka2bfpgniWXoEgkey82M
 RKtB3vZFm9J/KI0w0w2FGFpSR4z8YaJ4FuCFKZ0=
X-Google-Smtp-Source: ABdhPJwAzHJL/B15MxhX4Scz95CdufOBBB/pgX/hI7IUh5HrGvbAVvyFTs9OP8Zyv5YfMRK7pRXf/vq+wy4ae/8OsKY=
X-Received: by 2002:aa7:dd42:: with SMTP id o2mr998428edw.53.1604045134553;
 Fri, 30 Oct 2020 01:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-15-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-15-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 12:05:23 +0400
Message-ID: <CAJ+F1CKZD5V8BJ1GHvt_GZ53Ytdtz-6Ja4h+L_wWZ_YW_x6dcQ@mail.gmail.com>
Subject: Re: [PATCH 14/36] qdev: Move dev->realized check to
 qdev_property_set()
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000072e65e05b2dedc08"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Qemu-s390x list <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000072e65e05b2dedc08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:10 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Every single qdev property setter function manually checks
> dev->realized.  We can just check dev->realized inside
> qdev_property_set() instead.
>
> The check is being added as a separate function
> (qdev_prop_allow_set()) because it will become a callback later.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

nice
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000072e65e05b2dedc08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:10 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ev=
ery single qdev property setter function manually checks<br>
dev-&gt;realized.=C2=A0 We can just check dev-&gt;realized inside<br>
qdev_property_set() instead.<br>
<br>
The check is being added as a separate function<br>
(qdev_prop_allow_set()) because it will become a callback later.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>nice<br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D=
"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=
=A0 <br></div></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">M=
arc-Andr=C3=A9 Lureau<br></div></div>

--00000000000072e65e05b2dedc08--


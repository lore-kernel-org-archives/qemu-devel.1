Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6330C4725B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 04:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BF220721
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 04:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7sdfS+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BF220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWBkD-0000XH-Ji
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 00:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jWBj4-0008Vm-Cs
 for qemu-devel@nongnu.org; Wed, 06 May 2020 00:32:06 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:35606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jWBj3-0003Bo-Co
 for qemu-devel@nongnu.org; Wed, 06 May 2020 00:32:06 -0400
Received: by mail-lf1-x136.google.com with SMTP id x73so168549lfa.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=SH+YGo+vbFmojRVb6WhaAQBtiXqHFTbEbY+x4HVvko4=;
 b=E7sdfS+U+KO3fYSHSrhUSEjf032Q5/wzmQtQlIAwuuU19TMt2dLb5TUOo56bAdpxmL
 FeBQZGBqMY/qsLnSHAomHWjNDFrjmlVjXfu0v39kRVbekxxwk10OKrqtItYkv5eJHZDH
 W4M0GFKyrs31ghhzsSnudS83VdRjUl137yUXgXU0/zhQawfonngiGXxqEc6R04Xq2FD3
 GQ2Z/JIEQtW5Tj5mRcR1NMeGPvRbLmmCgT/IjW1Urw8FB00GeWocyUdQRApOa0cMus1w
 KwmyMc3Ds7cMtCe7BeyOfHUGsWdEqtXFxc4YE2tnM5Lmh9SXnR8d6kbrC5JLm1Q7yNE9
 5U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=SH+YGo+vbFmojRVb6WhaAQBtiXqHFTbEbY+x4HVvko4=;
 b=eW7+3dl4AfElzeEYeMMY2YwtR9cY5M0RRMaOruEiTBBz+o02yWoJbgBZgSfd2G9G1g
 urjxlyLlISOyaYrSO6ddSfORx82mDbpGCR5YXwNI2a7M/zJJTIaOwlPD1td7QJl2ilyK
 ShVOkYvthCHQqFai9S8gZ3v7/kxIa6ruPL2EM7X6gpEtk8IG5c8jioR01QNuzeHxefKs
 WGbFJDA3o1/521jrIgO7wGeWinsoEcXlNlcf4QASjSBdnSGook8o6eLY///6kvZRuY11
 yOzo7ZvKeMwVBjxnp/Wa9495JxWuLXZOOFHK4z8T2W97HRmosTJzNSwPniK2VNMoXRAE
 /WvA==
X-Gm-Message-State: AGi0PuZ6f/3e1hNnZ7UvGwreCk9fkJGKtFR2YUFGoB5idGpzAp2EsgiE
 30vuVbyrKfZMIsmTzyQNeJybUeUBdBDHThU4XGQ=
X-Google-Smtp-Source: APiQypKXWwbRwQJQHJNw/Os1/mF8uymeTrdYLq8bq+faoyoTi8SvVI85UGYkI478l94YaiHaaBBCBDWr84pdA9qkwCM=
X-Received: by 2002:a19:d55:: with SMTP id 82mr3799852lfn.89.1588739522549;
 Tue, 05 May 2020 21:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <158873300816.14142.15664636500998863138.malonedeb@gac.canonical.com>
In-Reply-To: <158873300816.14142.15664636500998863138.malonedeb@gac.canonical.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 6 May 2020 12:31:51 +0800
Message-ID: <CAE2XoE8tLwbUPWXbGFxf_kZ2S5X-hrmQuqEM_difn8=gcJQbwg@mail.gmail.com>
Subject: Re: [Bug 1877015] [NEW] virtio only support packed ring size power of
 2 between 256 and 1024
To: Bug 1877015 <1877015@bugs.launchpad.net>
Content-Type: multipart/alternative; boundary="000000000000e1dc3705a4f33e5b"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x136.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e1dc3705a4f33e5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe the virtio need to be revised?

On Wed, May 6, 2020 at 10:51 AM xuan <1877015@bugs.launchpad.net> wrote:

> Public bug reported:
>
> Issue discription=EF=BC=9A
> When QEMU starts with "-device
> virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3D=
false,mrg_rxbuf=3Don,rx_queue_size=3D1025,tx_queue_size=3D1025,mq=3Don,vect=
ors=3D15,packed=3Don"
>
> It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2
> between 256 and 1024
>
> Analysis:
> According to virtio1.1 spec, the packed queue size value does not have to
> be a power of 2.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1877015
>
> Title:
>   virtio only support packed ring size power of 2 between 256 and 1024
>
> Status in QEMU:
>   New
>
> Bug description:
>   Issue discription=EF=BC=9A
>   When QEMU starts with "-device
> virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3D=
false,mrg_rxbuf=3Don,rx_queue_size=3D1025,tx_queue_size=3D1025,mq=3Don,vect=
ors=3D15,packed=3Don"
>
>   It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2
>   between 256 and 1024
>
>   Analysis:
>   According to virtio1.1 spec, the packed queue size value does not have
> to be a power of 2.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1877015/+subscriptions
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000e1dc3705a4f33e5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Maybe the virtio need to be revised?</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 6, 2020 =
at 10:51 AM xuan &lt;<a href=3D"mailto:1877015@bugs.launchpad.net">1877015@=
bugs.launchpad.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Public bug reported:<br>
<br>
Issue discription=EF=BC=9A<br>
When QEMU starts with &quot;-device virtio-net-pci,netdev=3Dnetdev0,mac=3D5=
2:54:00:00:00:01,disable-modern=3Dfalse,mrg_rxbuf=3Don,rx_queue_size=3D1025=
,tx_queue_size=3D1025,mq=3Don,vectors=3D15,packed=3Don&quot;<br>
<br>
It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2<br>
between 256 and 1024<br>
<br>
Analysis:<br>
According to virtio1.1 spec, the packed queue size value does not have to b=
e a power of 2.<br>
<br>
** Affects: qemu<br>
=C2=A0 =C2=A0 =C2=A0Importance: Undecided<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Status: New<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1877015" rel=3D"noreferrer" targ=
et=3D"_blank">https://bugs.launchpad.net/bugs/1877015</a><br>
<br>
Title:<br>
=C2=A0 virtio only support packed ring size power of 2 between 256 and 1024=
<br>
<br>
Status in QEMU:<br>
=C2=A0 New<br>
<br>
Bug description:<br>
=C2=A0 Issue discription=EF=BC=9A<br>
=C2=A0 When QEMU starts with &quot;-device virtio-net-pci,netdev=3Dnetdev0,=
mac=3D52:54:00:00:00:01,disable-modern=3Dfalse,mrg_rxbuf=3Don,rx_queue_size=
=3D1025,tx_queue_size=3D1025,mq=3Don,vectors=3D15,packed=3Don&quot;<br>
<br>
=C2=A0 It raises error: Invalid rx_queue_size (=3D 1025), must be a power o=
f 2<br>
=C2=A0 between 256 and 1024<br>
<br>
=C2=A0 Analysis:<br>
=C2=A0 According to virtio1.1 spec, the packed queue size value does not ha=
ve to be a power of 2.<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1877015/+subscriptions" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1877=
015/+subscriptions</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000e1dc3705a4f33e5b--


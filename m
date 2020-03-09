Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C399AC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 03:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAD9206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 03:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDY7mbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAD9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB94M-0006gI-QH
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 23:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jB93e-0006Ha-82
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 23:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1jB93d-00041C-94
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 23:26:22 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:45262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1jB93d-00040g-04
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 23:26:21 -0400
Received: by mail-lj1-x236.google.com with SMTP id e18so8347592ljn.12
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=NS60aXzDVhMSbGT+RmfClkaIWOkvAqTTLV9axQjinfM=;
 b=azDY7mbIK4KVrULooVSPT1cyCWFMzdwUVB4i6NTbE8p3mXMWX31LJKF08fHWHOcq6d
 nytOX1qt54b8s0O0tQ8cDPvDRy88JW7u1+tdYumSdobm7W73lhSddbjyPZGlvm+BgRvQ
 QAZ1ka3FWib4ngrwwvqMmNsF9RQxqMkbo7dsezt1+cPn9XK8nQMtYwuwckGHI+PF6/Gy
 naNBK+88VeLtxZhg7A0uP28NJ3EWFNJx1QPsv8qgiiSD3nvLEAebv3yT5G/Wo9aSQb6w
 BeRNMCwfvdkIo7zvybwcwqGCe9UHSCSIY1G5WNfUIXyuMlSDYUIPfWOXL5hfnorCnzFm
 94Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=NS60aXzDVhMSbGT+RmfClkaIWOkvAqTTLV9axQjinfM=;
 b=WNGP0oIYR6wrlrAHkD45y+E4uROiWMqwOYdcVkhOYUK3Kfy5gz1YxhjV6J0++sMEkz
 +yHtH6/I+LvJO6CiMDp8H41qhsJmYuDve34sBDGz4Gb7Z51mLj3V4Ob/4Z2oDJJg57fi
 e/vBPtdTsUSenvDtuizGXbEfFNEw7A17X5M/kpc2zbPA3vtvCjdlSQ502tDT7fAUb9J/
 ueleuHjGIrklbrXhtM8puHzVtpeXfpTm9GX3UmPcU2PMmZXjZw9Q+S999sWC6PaVitFx
 G7vIG+pcHfAeNIrMXpq2KVnMeX4KuWxmyQJjHfeG4V4UZEqV2VF3oeMvSFhqelFJ8oUx
 LODg==
X-Gm-Message-State: ANhLgQ1y+0LuLoxAS4tjlHxzaNly2BUuh/VKSBlDvJ+BMhWvV1igAs9U
 nuR2lorGEGwcbAEcTMmLtjE9hRQZba+JssHuEznMm7Za
X-Google-Smtp-Source: ADFU+vuot+KFv+0/eE5KijGe+cOcxnmTl+wrheezSVaONu7psxyX/j2z1mFEed3Htwi3XN4MD06mLHHZ7mon1gMaqDw=
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr8282773ljn.118.1583724378847; 
 Sun, 08 Mar 2020 20:26:18 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 9 Mar 2020 11:26:07 +0800
Message-ID: <CAE2XoE-XeFmmPHsy6KT-zHtRcZqZnuWzaXR+SkMP60cCL2jx0w@mail.gmail.com>
Subject: I am trying to fixes a issue with QEMU with VxWorks.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000005fcbb05a0639182"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::236
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000005fcbb05a0639182
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I am running QEMU to simulating PowerPC.
And after running the following powerpc code:
00e2b5dc <intUnlock>:
intUnlock():
  e2b5dc: 54 63 04 20 rlwinm r3,r3,0,16,16
  e2b5e0: 7c 80 00 a6 mfmsr r4
  e2b5e4: 7c 83 1b 78 or r3,r4,r3
  e2b5e8: 7c 60 01 24 mtmsr r3
  e2b5ec: 4c 00 01 2c isync
  e2b5f0: 4e 80 00 20 blr

The QEMU are getting stuck and can not running the following instructions,
What I need to do to inspect which instruction are getting stuck and how to
fix it?
Any means to debugging that.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000005fcbb05a0639182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When I am running QEMU to simulating PowerPC.<div>And afte=
r running the following powerpc code:</div><div>00e2b5dc &lt;intUnlock&gt;:=
<br>intUnlock():<br>=C2=A0 e2b5dc:	54 63 04 20 	rlwinm	r3,r3,0,16,16<br>=C2=
=A0 e2b5e0:	7c 80 00 a6 	mfmsr	r4<br>=C2=A0 e2b5e4:	7c 83 1b 78 	or	r3,r4,r=
3<br>=C2=A0 e2b5e8:	7c 60 01 24 	mtmsr	r3<br>=C2=A0 e2b5ec:	4c 00 01 2c 	is=
ync<br>=C2=A0 e2b5f0:	4e 80 00 20 	blr<br clear=3D"all"><div><br></div><div=
>The QEMU are getting stuck and can not running the following instructions,=
</div><div>What I need to do to inspect which instruction are getting stuck=
 and how to fix it?</div><div>Any means to debugging that.</div><div><br></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div></div></div>

--00000000000005fcbb05a0639182--


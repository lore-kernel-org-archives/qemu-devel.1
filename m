Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D55C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DB1206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBwFeVcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DB1206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrQC-0003Ej-DM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kDrOw-0001Xp-92
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:43:50 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:55730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kDrOs-00034G-Nf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:43:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id 2so1725460pjx.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=b+IBS1yV3+qu9wE2DcKzmPx4WdEHqrkU5Mm+auiGAyM=;
 b=eBwFeVczD/Kq4PEnhAXJnZZl/3KXAYF6EBLJcIsPC+psDgnC4Wzai93C7cotR6ZyVm
 CxsjNHGrawJbQ5AXkJ4t3RWO0ERZdSV9pM9Hm41IruDnhxZHin0jPPyyWz8yHDAAr/0a
 6+BC884MidaNRSlRuQBA4/xJPXUxGPyZsA2CazK5/0jXn8pHFd4us5TGs8R4aFrdxo+T
 EUwsnwbreuTajOBgmaHNhXhI4yBHFPkEKPUoW8PsbXF11C15wKiuxNT9Y0O3I8u0mj9F
 +HS0PvZduKpSlciyvm5v4RymhE6yup9EVhkfO1RkPt4b3O8MXcZ+sNN3mB/E24EDwTEq
 1trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=b+IBS1yV3+qu9wE2DcKzmPx4WdEHqrkU5Mm+auiGAyM=;
 b=Kv33PtYQ2aVIabOfNgEoW3/dVdoBDBFm8/uFitu7bHgyJbNU2KUmh3FjweZ/agO8OU
 icwCYlrTX1D5Xw/TjqsQbtE5eWBUqLaiQbpjBbK0jkCtfGGAfjGE2+02igruhl56xcDR
 sRj1BY9jWwVc95P0JyDmve+CS/8AqriqK9bzrzokJs93pklI3fhLf+fpi+WBUkIvJlGY
 k4tecLneH1HyzBrBwmb70NeciSIR26XZtCoSumfILGeD6ctDJ2TwkyS15Shr85FUaD7r
 Rg2LiqxIyrS9lTjqT1xH6IlrlIkX2A51CfyfBkYPLRtYIDzjj8Y/0+3ji0Bmb9iE5Xmr
 8iNg==
X-Gm-Message-State: AOAM532QiFw8i0LK4zM23He5xolhe4AQ6h0PcSl+jJqhRZNcIPmpX3Z9
 ybC6F3mDMCXlcY8RLy2XH/FZgzz9yeKoZU/zbXqCkcz3wFg=
X-Google-Smtp-Source: ABdhPJxSFgbo+R7zlBf3CIMgStenT3qMVxhAd/PivcREdjMAqusAen6JFV304edwyZlCrFIwFxTir3qrbW5SCr5K5wg=
X-Received: by 2002:a17:90a:5283:: with SMTP id
 w3mr3885430pjh.201.1599147824574; 
 Thu, 03 Sep 2020 08:43:44 -0700 (PDT)
MIME-Version: 1.0
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Thu, 3 Sep 2020 11:43:33 -0400
Message-ID: <CA+Ai=tAqoCp5mMD3u7wA-CS+mPjksep8N5zw+q4f3Kf2VGhynw@mail.gmail.com>
Subject: QEMU - Contributing to SCSI Adapter Emulation (BusLogic BT-958 SCSI
 adapter)
To: QEMU Developers <qemu-devel@nongnu.org>, pbonzini@redhat.com,
 fam@euphon.net, Denis.Dmitriev@ispras.ru, Pavel.Dovgaluk@ispras.ru
Content-Type: multipart/alternative; boundary="00000000000006f58805ae6a9ec2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000006f58805ae6a9ec2
Content-Type: text/plain; charset="UTF-8"

Hello,

I am interested in contributing to the implementation of the BusLogic
adapter. I saw on the doc pages of QEMU that it is an incomplete adaptation
and I would like to take it further and complete it.

Before I take it up however, I wanted to check in and see if it wasn't
already being worked on by somebody else.

I have a couple of starting points ready before I start, but if there are
any other resources that could help me out, I would be glad to consider it.

Thanks,
Rohit.

--00000000000006f58805ae6a9ec2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am interested in contributing =
to the implementation of the BusLogic adapter. I saw on the doc pages of QE=
MU that it is an incomplete adaptation and I would like to take it further =
and complete it.</div><div><br></div><div>Before I take it up however, I wa=
nted to check in and see if it wasn&#39;t already=C2=A0being worked on by s=
omebody else.=C2=A0</div><div><br></div><div>I have a couple of starting po=
ints ready before I start, but if there are any other resources that could =
help me out, I would be glad to consider it.</div><div><br></div><div>Thank=
s,</div><div>Rohit.</div></div>

--00000000000006f58805ae6a9ec2--


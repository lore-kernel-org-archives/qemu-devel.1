Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34802C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10E3204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o51wmgSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10E3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OPS-0001BG-5E
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudha.kurhade@gmail.com>)
 id 1k8OK9-0006TE-PK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:40:17 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anirudha.kurhade@gmail.com>)
 id 1k8OK8-0002DL-4t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:40:17 -0400
Received: by mail-io1-xd41.google.com with SMTP id a5so24618855ioa.13
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=rL/lZhroxmapL3mODB1ihRXEdQI1cFuD52qaRgJ05Tc=;
 b=o51wmgSSW5eTnjvYiHtWUiiAxNbwQIs2KCe2K27XX0pJ/ELdjStcFXBlk5wZxJvdPw
 eDGDKb9dMlHcCHT2VQLM8NXyguiZzy/5U1HsKjpHsF2CPHyuWLmJ+o+ZWu9cS9dQfEQh
 WvUf1vSkKazMTcTzTeecVafTZySLEo6zR2rnnFQBUDdzhsopkjmiuZH/0kZDlcmMQYU/
 sG0rPkx7r5AIEoX3ifqtYLXgsCZsGYx9ENF5x6ZfeMxJ3BZl00tNO4YpRwa+w6D7+JJb
 Pf/RXEaL1OEV+aEgeRM/Gqd154L73Xc6+MQcY0vyx4EtdppMMUqxqOPtbLhJhlJhnY3N
 kurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=rL/lZhroxmapL3mODB1ihRXEdQI1cFuD52qaRgJ05Tc=;
 b=Gi9B0yTTfsDMGZQNbGSxXcRM6IEuqFXuAqZ5S7+lTIOC15TBBFHQwQLpGK9NPVkS7n
 z99ModjdgjX7abUNt0JaNwUC1ekqTRPv1q8XrQ0ugZt+lUeQoWLLVHygOmC0P1kI24p1
 AVltaj/54vOkSes/NhcTWJNG7jTZ4/BBcrY6KeLWQhrRGEsXwKwh6AJKiaOZZN93BzYG
 q47kBtGvAN6lOcnxo4PuQS7lF2YVxaApox5Xv5LBBHw77/LCF2buhNEblPVBdBQow7lg
 PCBTAfObI/laMwePw5LWweW3VryjlAfsA4taBcUpLHmeHv8+e/WAzPpDoOVNHnNev83X
 Sv/Q==
X-Gm-Message-State: AOAM531dU9ZQ47VmfU8vHQ/9BwFm2CmgiJRU3ptDyHZJfCMAAOGDNS7W
 pdGQvHt6vge2pbLH+FBq9cHpdDbVep6WwIWVTDIUCyp82Ko=
X-Google-Smtp-Source: ABdhPJzKcHKdTkwKNfM5HK52lcXSaOBv+scZZBucdnO8SuCWXOaIt/mQtx1c84xEAfzm02ulhgKW/uj8eaKeZ6p/kL0=
X-Received: by 2002:a02:730b:: with SMTP id y11mr24429216jab.126.1597844413929; 
 Wed, 19 Aug 2020 06:40:13 -0700 (PDT)
MIME-Version: 1.0
From: Anirudha Kurhade <anirudha.kurhade@gmail.com>
Date: Wed, 19 Aug 2020 19:10:00 +0530
Message-ID: <CA+NSA_s=yOkRTvt+2GiAvPiTKH=jMJFErEdm7FcrHOJc5ZD=iQ@mail.gmail.com>
Subject: How to access structure elements of another Qdev device
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b2ddcb05ad3b24b2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=anirudha.kurhade@gmail.com; helo=mail-io1-xd41.google.com
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
X-Mailman-Approved-At: Wed, 19 Aug 2020 09:44:49 -0400
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

--000000000000b2ddcb05ad3b24b2
Content-Type: text/plain; charset="UTF-8"

Hello,

I have two qdev devices: controlDev and uart. Both these devices have an
MMIO and corresponding .read and .write callback functions. The enableBit
for uart is located in the controlDev device, so I need to check the enable
bit before I write anything from the uart tx function.

However, I am not able to figure out how to access the enableBit, which is
a structure element of the controlDev. Will you please help me understand
how to access elements of another qdev (controlDev) device which is
attached to the same parent bus (i.e. SysBus) from the qdev device within
current scope (uart).

Thanks and Regards,
Anirudha

--000000000000b2ddcb05ad3b24b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I have two qdev devices: control=
Dev and uart. Both these devices have an MMIO and corresponding .read and .=
write callback functions. The enableBit for uart is located in the controlD=
ev device, so I need to check the enable bit before I write anything from t=
he uart tx function.</div><div><br></div><div>However, I am not able to fig=
ure out how to access the enableBit, which is a structure element of the co=
ntrolDev. Will you please help me understand how to access elements of anot=
her qdev (controlDev) device which is attached to the same parent bus (i.e.=
 SysBus) from the qdev device within current scope (uart).</div><div><div><=
br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div dir=3D"ltr"><div><div><div>Thanks and Regards,<br></div>Anirudha</div=
></div><div><br></div><br></div></div></div></div></div></div></div></div><=
/div>

--000000000000b2ddcb05ad3b24b2--


Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D92C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D85620767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+73qUkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D85620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVQU-0006wO-Ni
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jEVPr-0006Sc-Ih
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jEVPq-0000ZS-Ky
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:55:11 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jEVPq-0000Tz-DU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:55:10 -0400
Received: by mail-lf1-x141.google.com with SMTP id n13so17966409lfh.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=l4m0mp+UODG1k7iEiEr31Us/2TlbcAhTH+8vyEETJ5Q=;
 b=X+73qUkS0MhwII9mq+hmBDYoxH+tJFIUFG0sSNpBgCldUSlwOXCQEvi4HMkfgCrJCF
 OszUBSkGcfmaOA4cW5qF5Sdayty+7KXhlnL6PF+cifG4NqqFIjshhjvubaYtlPwLoxRk
 lFkqRjgqZiLT2NWiLhgx4s3ckPfKYVoiiM0uGxsdtAv4c/+HhuYonVMX9lF8xTO2fEIb
 ncsuEAAEmhHZEfS+/C7Tn25X2hq7ebb+BVZ8FOVkcQh5j+5zdV4djWET1MpDCkpyhOU8
 IqQTsb9mPCg2ElwebKW4OK9TX7rXZHn/6nnSEvTHuNXSkNVqml0AEHSrCa6DhqVlmcLO
 DMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=l4m0mp+UODG1k7iEiEr31Us/2TlbcAhTH+8vyEETJ5Q=;
 b=KCoBJ3zgs67EAyit1GMTuHsutwbZz6amUevGChs+wwC5Posiv5wsOXsjeiChJag1CS
 YskS7Tza36ZHPUbwmEe2+8H2P/BVjKSHdB30dd6wsS6POHzfOvlHCfPTEO4joh3CdT4/
 9h+dTSHdt4T+11YggjWBNi/H7E4ETQvBgWMAJRwxHb2KWV9VrrtjVg/YhwWyWEt463Dp
 LUJPNiNSz2x5XiuTvcdC5ik2voUt9yjyn+ncYvB4NmsLLWeEWYu5KhjtIlcy1/ZZc9Bf
 xCie565zwTihf5Rv2DJjd9i5l8vwbRMughC19NSdESI7XWXNiqGUT79v0rLK5Kes9heo
 a6VQ==
X-Gm-Message-State: ANhLgQ2v1GDdlFw2d5GSPrTEo1r8p25Jf+MHDBmwn1VCUDYbUW5W4NBi
 eqG509+0DWhdW5rWfilDWbGj0qcnIlylFFMkiCgi6sz+
X-Google-Smtp-Source: ADFU+vutOklszpuxZslD9FXZEVSY1OdiqdCsG1T67YZISI9hkni9FiyN8yQGsirByy5rpeWnZPV+fxSwrcv2ZyoiPKE=
X-Received: by 2002:a19:ed16:: with SMTP id y22mr2510982lfy.78.1584525308140; 
 Wed, 18 Mar 2020 02:55:08 -0700 (PDT)
MIME-Version: 1.0
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Wed, 18 Mar 2020 15:24:57 +0530
Message-ID: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
Subject: Qemu API documentation
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000021269405a11e0ca9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

--00000000000021269405a11e0ca9
Content-Type: text/plain; charset="UTF-8"

Hello developer community,

I am working on implementing a custom device in Qemu, so to implement it I
need documentation of functions which are used to emulate a hardware model
in Qemu.

What are the references to get it ?

Thanks,
Priyamvad

--00000000000021269405a11e0ca9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello developer community,</div><div><br></div><div>I=
 am working on implementing a custom device in Qemu, so to implement it I n=
eed documentation of functions which are used to emulate a hardware model i=
n Qemu.</div><div><br></div><div>What are the references to get it ?</div><=
div><br></div><div>Thanks,</div><div>Priyamvad<br></div></div>

--00000000000021269405a11e0ca9--


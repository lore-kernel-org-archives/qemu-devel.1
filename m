Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 17:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1188220828
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmJJ9Scz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1188220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAza8-0001gw-4L
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 13:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tirthankar.saha@gmail.com>) id 1jAzA5-0003pp-G1
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 12:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tirthankar.saha@gmail.com>) id 1jAzA4-0000py-Cx
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 12:52:21 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:35948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tirthankar.saha@gmail.com>)
 id 1jAzA2-0000nq-JZ; Sun, 08 Mar 2020 12:52:18 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d9so3606116pgu.3;
 Sun, 08 Mar 2020 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wKidzYq0iKh1ddsgeKUKFXECYrntZSd4Xkv2bK4Ozig=;
 b=AmJJ9SczI/2j+g4CQNHsoILvLgWje2v2SpaZ51Gwi7cCw8CCrqxDtyGvzBbXgFThtt
 idiMsDavy7bJTh3OHlJzbp+1bozRvnnYOyyZpS6n5CkADKBjqxRcAXSHwd46V0Wqe/eW
 JnDyeLJEOjDWmt0244mcTDtaNfeQJzFJntFoXR5aMFNjw5qGOWFz9SGnP6Err+b6eMFC
 1Tm8BuFJsHNoyPwIQHJ3DBILD1mH+zLR++8uq6D1WROg9bEL7JwHkMvaA1a1g/U+yBRj
 LpRTKvqx85g7D+2kjpy4GFYMoEo3Kc8sb6DGv/KlMhp/jQrYC1uFog5nihNNtbXHc4qk
 IFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wKidzYq0iKh1ddsgeKUKFXECYrntZSd4Xkv2bK4Ozig=;
 b=N8wH9yj/p9/QWblEwOyNMHWHro9RcB+7ROURUwJqArlM8mwvQgnsOIcBSGil672Tz7
 UqP/9ZiwN6SGeHknAD+P5B8y7/UJ1DzdJs/UY3ir6L979ask50Pi1kUyC0k94lZ3/8Gd
 +q27AAvlY3BGC9ZAjTBO1ad+Qx2VmgQv5CHbQiN9Yc2w17A6dK1Hi8MmioFEpANHEh5J
 ETpjqVOgsqMClK6DhRTAuEJ2X+r6rF1hUKlAky7gcgX9ZztM6aXk5luzUtDBJV95d0wF
 wPD0OujHVfNHzzOfb6mUceFikfDPo09XrXLH0Xd665cwTxbFPkmXE2/OSybHwnlW1DqX
 Z+8g==
X-Gm-Message-State: ANhLgQ0n0W05eN8nCMx2WzRk7wnhG9gsckiq1h/2B4qr+Dwi9xpINab9
 eAJ5PnE0i4moXIRd9OW/yO9j5UsByrL5Ck+ARA==
X-Google-Smtp-Source: ADFU+vsJw6/is19JGuu/4rs30soaHXK6w7+giqoIQ9u4l1aulbbARRiUhWRTRCPaLiCwj3KSX9xET0GhlSrWyaWy1+0=
X-Received: by 2002:a62:8202:: with SMTP id w2mr13124947pfd.117.1583686336165; 
 Sun, 08 Mar 2020 09:52:16 -0700 (PDT)
MIME-Version: 1.0
From: Tirthankar Saha <tirthankar.saha@gmail.com>
Date: Sun, 8 Mar 2020 22:22:05 +0530
Message-ID: <CAPohS2SoTcyb-MCex7MxC59oB_VTp6F0GjvU-7xauv7ffJi6-Q@mail.gmail.com>
Subject: Regarding SESparse support in QEMU
To: sameid@google.com, mreitz@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080bb4305a05ab5f9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
X-Mailman-Approved-At: Sun, 08 Mar 2020 13:18:40 -0400
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

--00000000000080bb4305a05ab5f9
Content-Type: text/plain; charset="UTF-8"

Hi Sam,

Can you please share any notes that you have regarding the structure of the
SESparse journal? This will help in adding "read-write" support for
SESparse snapshots.

Thanks,

Tirthankar

--00000000000080bb4305a05ab5f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Sam,</div><div><br></div><div>Can you please share=
 any notes that you have regarding the structure of the SESparse journal? T=
his will help in adding &quot;read-write&quot; support for SESparse snapsho=
ts.</div><div><br></div><div>Thanks,</div><div><br></div><div>Tirthankar<br=
></div></div>

--00000000000080bb4305a05ab5f9--


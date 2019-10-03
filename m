Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2827C4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31132133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8VRYRPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31132133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG55o-0006mW-Vr
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <up.mauricio.g@gmail.com>) id 1iG3iu-0002lx-Hp
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <up.mauricio.g@gmail.com>) id 1iG3it-0001kg-Je
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:13:00 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:33897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <up.mauricio.g@gmail.com>)
 id 1iG3it-0001js-Fe
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:12:59 -0400
Received: by mail-qt1-x82d.google.com with SMTP id 3so4405956qta.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=IgGSZKO63xj4PNMuM1wH2xGvi8mQxy2LKwgbGBGvM/c=;
 b=Z8VRYRPRYksqHB0ADstLpH/guseZ2vWn+2mtTUO4XCnfH2HVu+JuTFZeIxFXn8Pfgn
 aRPbNoCCiA9/wjhPah/v+uJudckWzwFHBfZJpR+v5mWCngg/SXFhCAmsZDDINNgz0FmG
 B6pqAbedSG7K6LA3zZUP+Wy61VtsVq27O9h2GREYmxqjK7fMxOgpUX1U56rMxS5OpqL1
 +D9uDNqUiLU9YSIVOrrUd3EDuRX+JRFZkyBN/gdQ0oOzC5MIzxsp8GmrI4XcagUvFmnH
 8yQ6d2O5QTf62J9p6Z0/VP/ef5kFaH30WEwg77NRG0YrL83rA+dfCg/3zng+aSpytwRn
 fBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=IgGSZKO63xj4PNMuM1wH2xGvi8mQxy2LKwgbGBGvM/c=;
 b=QWr2odYBybdDHaLK970pJUGJO8ousVjBG5OyG40XnlzUHqX1tYBCaTFcdrz5k9p78M
 CKXWESOpkr/2yQyz+tMpuvaNJLnkFDiaKACOUx81jMQT1nG+5MZDShh8YuyImIDo+1SQ
 6Xcoo6dMrjVsDptOF5HTKm/7fThaURUpPcYrCsgB7tN3qK5FQdtRx7Kpcbvt/ZOEevvQ
 BR5E4Wm5/rRvEw8MfJWcQnJ7olSBr359HN07navD2wFhtEorvEEfSsmSUNFx+AKx0tqd
 oIroqcEsoshI5HfGTMZP5NJUciETDuOdB6TvrNASVFxaa6PdDD1zl/i8GoYZmxpqsUsw
 V0Mw==
X-Gm-Message-State: APjAAAWJI32GnayxXLg7BRecw3IlwfJVaN6lBGRWauW+e5A0f6Pb/apu
 eyrZrq/rfibBKs2bWdomV8MPYCUc6/k8PALN4Wy6vg==
X-Google-Smtp-Source: APXvYqyjbbyj2OUfg/o72Nm8pxSyMbTkHqcc0QE9l/QFzYsPT37QiPMHb7YiS1PCG8WeIwXkUe/rlLZ0z5lbP6uO/hA=
X-Received: by 2002:a0c:e7cc:: with SMTP id c12mr6039966qvo.251.1570119177559; 
 Thu, 03 Oct 2019 09:12:57 -0700 (PDT)
MIME-Version: 1.0
From: Mauricio Galindo <up.mauricio.g@gmail.com>
Date: Thu, 3 Oct 2019 09:12:46 -0700
Message-ID: <CAOx2=+fECU91FE5wZY_ee02YHhM=OWW9O0d_RNw+0khoL9snLQ@mail.gmail.com>
Subject: QEMU user mode execve
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d563db059403dbd9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
X-Mailman-Approved-At: Thu, 03 Oct 2019 13:39:56 -0400
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

--000000000000d563db059403dbd9
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm running QEMU in user mode and I'm running into issues when trying to
exec binaries within the emulated process given that binaries are
expected to run in the native architecture. Would it be useful to have an
option to rewrite execve(/bin/some_binary, ...) to
execve(qemu-$arch-static, [/bin/some_binary, ...], ...)?

--000000000000d563db059403dbd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m running QEMU in user mode a=
nd I&#39;m running into issues when trying to exec binaries within the emul=
ated process given that binaries are expected=C2=A0to run in the native arc=
hitecture. Would it be useful to have an option to rewrite execve(/bin/some=
_binary, ...) to execve(qemu-$arch-static, [/bin/some_binary, ...], ...)?</=
div></div>

--000000000000d563db059403dbd9--


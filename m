Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFFC3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FD5208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmu6NYn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FD5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Cjy-00061y-Ln
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j5CjR-0005a0-Bm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j5CjQ-0002t8-EZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:08:57 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j5CjQ-0002rJ-A7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:08:56 -0500
Received: by mail-ot1-x334.google.com with SMTP id j16so2832483otl.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/Lnjnk9mdbOeywVUYDmK+HA9/MJwcc9HKDCm25uINkM=;
 b=Wmu6NYn17PJyCwdew9B3T6JkMdVGERKM1SpNT/OQdjqVwFYVs75EJ0YLjDv1+/Abga
 z+ZNvO4MmpEwbb1eGRLQf4oUDSuTNUwilpwqn6SquREycuMU+T1MybBz+fCyW6KyCHHu
 wHtNynyRTxDEFIT2XLrO0685v6iEX8npm4TpNgEfdmllvO/Cow7XyRNgx3C6VBfg2EHe
 u7XvmSfQ+Q+qBuvqOqRUD8Qjguor8waoU9qCOqJnww1iy4hFgpCjCyilY5QlU8MSpsBh
 KQ+RDpOEni+GW1cB9R29bOd5yfW1oMnRhnlDxyCKplqY9E05pKkZAzoLqdwqa+Xq6yEg
 /k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/Lnjnk9mdbOeywVUYDmK+HA9/MJwcc9HKDCm25uINkM=;
 b=kNCm83Ro+NybTrBp/vHgvpAzi8Wunodpgo7sOgVVicVFR7xnEErWY7khUDl+hyDr+m
 irtLOSaAl94Vmr33/mIKas7SOb3C46PTKb/jS1YxhR1CKFK3XtAhAsQrP1cwGWDB2ZMy
 0yp/NLbjsXi7RRk/2dSP+WYtB/jKw7F4ZLSDfoYHn9nvZOCPsuKcv0wZUUeKvXDtt4xN
 jaGz3qHRBPYDEW1vyHBdb+K0Qu+WojD4I6Ufa8+GQtWJeVmKXuIohcM6+AvS537IsVUb
 hYx8lZmrnYrqWCHE8111IxSFeNvxeAkV9UArUsYXh+1rrTC8v9h1jxMXYux42UzkgV/P
 KbNw==
X-Gm-Message-State: APjAAAUwhl5h4pFD9B1ju/iwO65isIxwUPDazepCvgae+mKOc/SmJHNx
 FedRB4mZPSHDArfr3liJFtoxDWiHCppJlw8xyMUc1Q==
X-Google-Smtp-Source: APXvYqw+/8ouBj83QANNZqmaB5zlHAZx+jWhd6thh/u8UPFFqi4jWL002alLY+HF00Wj0p1ES/2/YqcfcIX0R7jbRNo=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr30231938otq.341.1582308534992; 
 Fri, 21 Feb 2020 10:08:54 -0800 (PST)
MIME-Version: 1.0
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 21 Feb 2020 19:08:44 +0100
Message-ID: <CAL1e-=gKNaF80c2mKc+4ftPjiUayvOGbb=ZsqsCrVRh5E8-B6g@mail.gmail.com>
Subject: [QUESTION] Clang as QEMU compiler - two questions
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

Hello, all

I have two questions:

1) Is ./configure --cc=clang the correct way to enable clang
compilation of QEMU? Any other gotchas?

2) Did somebody compare QEMU compiled by gcc vs. QEMU compiled with
clang (in any sense: executable size, performance, etc.)?

Thanks in advance,
Aleksandar


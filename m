Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E587C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED45E2072C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T4W+Klir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED45E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1tQ-0007E1-36
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jason@zx2c4.com>) id 1in1sk-0006me-Px
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jason@zx2c4.com>) id 1in1sj-0007HV-Oz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:26 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:47975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jason@zx2c4.com>) id 1in1sj-0007HB-Ih
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:25 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 29babb62
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :from:date:message-id:subject:to:cc:content-type; s=mail; bh=dyO
 6Xh/IVGP9540dVMxI8zwbkGs=; b=T4W+Klir5BBaGMD3meXAJfmfmL6HVkgPfBS
 3hfloqcaChRn5yeXO0HlOIwQRpLmvmIYHMuoCauOCpgWxTqvEQB7vnzfYNFt0S7Q
 XQwCPcIlOm7zawkZlxsRsVLYJn3WkxrHO+3CassCl9DBBIH31N0ob0OQeMUOB2Ix
 051SKWO+VBF84wfUC2QMkvEKj9S07mtgftxovp1yaxdLQld1U6FWJcDxuNLjqYUz
 N+a7nXfG2uM+6i5yKwF4u/HgPWyZpC6WDBHoMEUmBDOHeQseK+xG61/J4Xqi5ik9
 9PwOL1v4NK90zh/y5yEwPTra83+eKNyEtQCDPfMyPd5ifOFZFnQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c07c68dd
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 13:56:53 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id w21so49600345otj.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:55:23 -0800 (PST)
X-Gm-Message-State: APjAAAX2gBSmjL/+IdIscPCUzVxs1+X1Suzrh+cF3q8I4inQ34gcfTuT
 D4mM8s++j3guphxISUY05o0fxF9vq7NraIaRuxc=
X-Google-Smtp-Source: APXvYqx/owVFPOL0hY+m2rThLQaWTX1MS5wQ0/IUnbpb00rakcIY12BtuRlYnVeGjm61MevtcwZw0hkWTJgYEE4dLic=
X-Received: by 2002:a9d:1e88:: with SMTP id n8mr94460910otn.369.1577976922693; 
 Thu, 02 Jan 2020 06:55:22 -0800 (PST)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 2 Jan 2020 15:55:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9pBFvcm7F=-Sxc5apU6JuE=1X=Omza_eMKL5qyuisTJ3g@mail.gmail.com>
Message-ID: <CAHmME9pBFvcm7F=-Sxc5apU6JuE=1X=Omza_eMKL5qyuisTJ3g@mail.gmail.com>
Subject: CONFIG_JUMP_LABEL=y on 32-bit x86 leads to intermittent qemu crashes
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.95.5.64
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here's an interesting crash I've seen pop up since enabling CONFIG_JUMP_LABEL=y:

[    4.716238] EIP: secure_tcp_seq+0x1e/0xa0^M
[    4.716238] Code: c1 e8 46 90 fb ff eb a2 8d 74 26 00 55 89 e5 83
ec 18 89 75 f8 89 c6 0f b7 45 08 89 5d f4 0f b7 d9 89 7d fc 89 d7 89
45 ec 3e <8d> 74 26 00 8b 4d
ec c1 e3 10 89 fa c7 04 24 d0 e3 36 c1 89 f0 09^M
[    4.716238] EAX: 000090bc EBX: 00005114 ECX: 00005114 EDX: 01f1a8c0^M
[    4.716238] ESI: 02f1a8c0 EDI: 01f1a8c0 EBP: c010bb88 ESP: c010bb70^M
[    4.716238] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000282^M
[    4.716238] CR0: 80050033 CR2: bfcd7fb0 CR3: 00380000 CR4: 00000690^M
[    4.716238] Call Trace:^M
[    4.716238]  <SOFTIRQ>^M
[    4.716238]  tcp_v4_init_seq+0x3d/0x50^M
[    4.716238]  tcp_conn_request+0x35d/0x926^M
[    4.716238]  ? fib6_table_lookup+0xb5/0x210^M
[    4.716238]  ? ip_route_input_slow+0x864/0x900^M
...

It looks like this is:
secure_tcp_seq ->
  net_secret_init->
    net_get_random_once(&net_secret, sizeof(net_secret))
        get_random_once(&net_secret, sizeof(net_secret))
          DO_ONCE(get_random_bytes(&net_secret, sizeof(net_secret)))

Which then expands to the usual static_key logic.

I was only able to reproduce this when the host system running
`qemu-system-i386 -m 256M -smp 4 -cpu coreduo -machine q35` is under
considerable load.

Is there a TCG issue with how it handles the dynamic patching debug
instructions?

Jason


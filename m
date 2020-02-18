Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A03C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED15206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Br3DjvyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED15206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zRZ-0003Tz-Pc
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQJ-00010O-93
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQI-0005nE-4V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQI-0005my-1R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j/EdDI2CtMVN9fdl6+h7xbjhrRwwWIt4TPFM6oFFcSc=;
 b=Br3DjvySAem+1FlSZNLSdvb3J+sUn+oRng2hwCQq0Ttcpn6vjyqvVRhQ/eFep0iuXzhKza
 a9AtLWaZLYCfQ+xi0fAlD3yEz0ALINfnhZG/yprjJwHnTl3d26jvRdJOFalzPquWksm/i0
 5HWFEpdkkvS34Ak346/Ro8o4GuifB98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-lJxr_yQANUOErB3tFEggmg-1; Tue, 18 Feb 2020 04:44:07 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so785002wmi.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d11KEHy00cHcmoOZmfkiJiWUsKxIDwvg0E/JJImsCd0=;
 b=j3uo+Nhr9mW11iTcrnXkUcpwwPHW33V8qC7+zhTHX8f/MFgH2/rp0QZgWabl0FyYfx
 LC1qGK8oVUvBVuOJdmj3ebI17dzvvTtUxCMy+a0B/q0ypYqEvKAS5Do0WVwAZAzpEy1C
 Qsqry2NnkZfl3e9MTwBbfSYgdSMUEGvIiUWoPi3yCTmPBeA6ONF4Ymjxl6ZTzTcZ0+BW
 GaM1YfAQvJIP9jJaxhJwnHmVRmDxU4xTYOudOn77w9fpO/uWVQdUqx4UuWrYOhl1ODk7
 SmdnK1anyDNl6zRzs4jOwVabNHbc5CsnIJR700SCiNW+Sh98pAYlxvIfNqQSJ1beDs9o
 g79g==
X-Gm-Message-State: APjAAAUkcSf+2R+XI87ZDPUO7Iyg70nhNboDNNGmhgyIeo9Em4VXyKma
 PkOKh3Ld0eEJRMWtbnNO4yetcS4d9pTJNykmADhUBKHOY5gsDODVYWUaE9cM6UsD9sSIN1U+vkn
 jMbRtF7h2SoSp+do=
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr2144545wmg.151.1582019045924; 
 Tue, 18 Feb 2020 01:44:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLgsh5LNMyikPjX/FLArT4rWgBdq3dbcvVm+2uT8w2tbshpyIEEFwkWdPllurI1KHIdPBk0A==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr2144493wmg.151.1582019045623; 
 Tue, 18 Feb 2020 01:44:05 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 00/13] trivial: Detect and remove superfluous
 semicolons in C code
Date: Tue, 18 Feb 2020 10:43:49 +0100
Message-Id: <20200218094402.26625-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: lJxr_yQANUOErB3tFEggmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Luc noticed a superfluous trailing semicolon:
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04593.html

Prevent that by modifying checkpatch.pl and clean the codebase.

Philippe Mathieu-Daud=C3=A9 (13):
  scripts/checkpatch.pl: Detect superfluous semicolon in C code
  audio/alsaaudio: Remove superfluous semicolons
  block: Remove superfluous semicolons
  block/io_uring: Remove superfluous semicolon
  hw/arm/xlnx-versal: Remove superfluous semicolon
  hw/m68k/next-cube: Remove superfluous semicolon
  hw/scsi/esp: Remove superfluous semicolon
  hw/vfio/display: Remove superfluous semicolon
  migration/multifd: Remove superfluous semicolon
  ui/input-barrier: Remove superfluous semicolon
  target/i386/whpx: Remove superfluous semicolon
  tests/qtest/libqos/qgraph: Remove superfluous semicolons
  contrib/rdmacm-mux: Remove superfluous semicolon

 audio/alsaaudio.c           | 4 ++--
 block.c                     | 4 ++--
 block/io_uring.c            | 2 +-
 contrib/rdmacm-mux/main.c   | 2 +-
 hw/arm/xlnx-versal-virt.c   | 2 +-
 hw/m68k/next-cube.c         | 2 +-
 hw/scsi/esp.c               | 2 +-
 hw/vfio/display.c           | 2 +-
 migration/multifd.c         | 2 +-
 target/i386/whpx-all.c      | 2 +-
 tests/qtest/libqos/qgraph.c | 4 ++--
 ui/input-barrier.c          | 2 +-
 scripts/checkpatch.pl       | 5 +++++
 13 files changed, 20 insertions(+), 15 deletions(-)

--=20
2.21.1



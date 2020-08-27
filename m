Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49542C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185212078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv0CFgC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185212078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9rd-0003iN-7v
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9qx-0002gJ-NF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:42585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9qw-0003gC-6R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 17so2526897pfw.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T9/LRO7zs4o6nPW1yspDQXlHiJnUjoTK1K/OWRpCTE4=;
 b=Xv0CFgC/yx0neW27nxRJRVIIoWxkBeZ6pBXWAUYq3VUcCE7ucZ8muvp1ee7BXn3xFf
 vIohJ8PrwRZaLPRWvgCI+NY2HgsNM3llMvkluomppeJG3bMi0gvcgBentOYwh/lxDqk3
 4+aC/0+9UwI4QCE00dh1d87THxAZol+bMKRsLEzfD5Br1eps6Vxl9T8LttHZ57bOI1ab
 kao0B9rMEz50rsF3/Z4A4EqcbbKcifkhawgCj0apydLaOiM1LKMUUxqiy4VOABxsNnOR
 VnO+XuWfYXFUJD9JQq3k0pb9vyzDKE4rGy8/O4CxidzIqYEV7yjbSmlgnfXRZcBvYPMr
 qgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T9/LRO7zs4o6nPW1yspDQXlHiJnUjoTK1K/OWRpCTE4=;
 b=MdPc58fPN9cZIOtrlNzY1BOI2jAnyGKY25GrcY7odqXFaeJczAGlTn3FeODXgMicAX
 OQALDs9hEouxH9AabpPB+NnVQZ3QcJGoO7bC0LQNxsTXNnjuY3ZvMNBSEOqaXcKaL09Q
 EOqa8AgudbjOHZgkvrp6KaeOhL5KwFP/ka0Poclf9taTb7Mi+ntkE4u1MS/8+3NPyWZi
 TUzNMtYekEXzcaRPg2be5+Pg3yciJa+LDvxdOmeZzRTI+9l2tkIs+fZPJ50JRIfYWdY9
 Kt2yeMlxJld9g+giDQpZ/6nQnQ/zYAX/HKh6bjim0knf9hJQqdAzhFSdhQh83Miuk7QL
 FiKg==
X-Gm-Message-State: AOAM533VcUcjgriLgGHXuzcjdrUwpeayHirc4eDvOVOt0oFZTIYsuDyW
 hSwj0B+nggzUM/28IpkfE4tgtrWMYTNqsE+4uiw=
X-Google-Smtp-Source: ABdhPJygy7vK6QY3RxiGsRCMj87CZBXALix/PBozR11JEjMAzO0dXtH7/YprHTx7wrTwCJ0bQTwdzw==
X-Received: by 2002:a17:902:a503:: with SMTP id
 s3mr14807195plq.190.1598503771967; 
 Wed, 26 Aug 2020 21:49:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:31 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] *** Fixes msys2 building after the meson convert ***
Date: Thu, 27 Aug 2020 12:49:11 +0800
Message-Id: <20200827044917.1356-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>=0D

msys2 environment=0D
=0D
*** BLURB HERE ***=0D
=0D
Yonggang Luo (6):=0D
  meson: Fixes the ninjatool issue that E$$: are generated in=0D
    Makefile.ninja=0D
  meson: fixes relpath may fail on win32.=0D
  meson: Mingw64 gcc doesn't recognize system include_type for sdl2=0D
  configure: Fix include and linkage issue on msys2=0D
  meson: Fixes ninjatool can not be recognized as script under=0D
    Window/MSYS2=0D
  meson: Convert undefsym.sh to undefsym.py=0D
=0D
 configure             | 28 ++++++++++++++-------=0D
 meson.build           |  5 ++--=0D
 scripts/mtest2make.py | 11 +++++++--=0D
 scripts/ninjatool.py  |  2 +-=0D
 scripts/undefsym.py   | 57 +++++++++++++++++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh   | 20 ---------------=0D
 6 files changed, 88 insertions(+), 35 deletions(-)=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.27.0.windows.1=0D
=0D


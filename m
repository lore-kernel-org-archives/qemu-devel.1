Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF94C3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B562084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQm0d9rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B562084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9eiJ-0007YH-FM
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ehC-0005yv-H5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ehB-0002uD-F4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ehB-0002sl-A1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583369340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SWKNQmVdwUEuUvOigyGAZ1SnibrdAq4SlTjBU4pTvo0=;
 b=AQm0d9rCF9zYHv2FC/alVuWeXwvs+uJn9HFU0gz/d1ag6hQgBZR1rJ8owxm9LeGb+W5Lpe
 EGCeB4FYTVs35T4me9yFd3epgnJkKGQ9d9AbLDR3IV/SKCXEZUHmt9eoIAIWzJ9HCZ1gU1
 0k3SF7JSQcC352oJRLcwdu2hFEeKMfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-qKCFVeuFPmiXlc3o3MQoow-1; Wed, 04 Mar 2020 19:48:58 -0500
X-MC-Unique: qKCFVeuFPmiXlc3o3MQoow-1
Received: by mail-wr1-f69.google.com with SMTP id m13so1618815wrw.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 16:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZC0MGU7nsZI/4XmjuBi8tbNohuM2/2iE0Kp45pIfhLQ=;
 b=OfyvAc4sFRGqAMzxBVK1xsFKC/6g2aFHEL77kN4ybg9eAmn1RE1VzIonIK8iF0WIfc
 j2boq4wwDrL41U1/yhyJZmjduK3mXXHzA3/czHzfp2MOrGRezqAQCPRkI5hZJOdqNs0o
 eITdK0dbdJYX31PJZAZGQlq78vPbR10sfTNlibO2j3qHC0AAREkYezp1dTNx+FK5DdeX
 jc3K3iL7sNrtaBR52JiHRkD3D4MrXsC0D+pn+S0WSSBRMK0kWEYFDNl8gbedukrAVyH9
 UGymMEuKVVXtZnR1Io5BBnMrzUsXm/XE+HDt0+REh6RLBmKhHhyypuM6UHoSYLuFiJFY
 TAYg==
X-Gm-Message-State: ANhLgQ1HK0EtOKHCbaA9En9RXkv68xZ3x8t1UXolfd0eChYQVP4mhIes
 u3ykkHU3OKhYs+2M6Gkgt4ix78+Iwz+qpAvvdq32X3ZkVgcVjScPzmlZESgSxMjFfYS/5sbXfOZ
 4YbtjrewkpGoOLZA=
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr7017376wrw.326.1583369337603; 
 Wed, 04 Mar 2020 16:48:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvqrD5jcDEaHoABlPfOyfoxFFjqF/4Qcq1KS0d6Zcf7fXQ/OSoEsmTYFWMbiCL4a0NaD6AaMQ==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr7017361wrw.326.1583369337343; 
 Wed, 04 Mar 2020 16:48:57 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d17sm6500874wmb.36.2020.03.04.16.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 16:48:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Makefile: Re-indent 'help' target and list tools
Date: Thu,  5 Mar 2020 01:48:53 +0100
Message-Id: <20200305004855.9665-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series improves the 'make help' output:
- re-indent current output
- list tools targets:

    $ make help
    [...]

    Architecture specific targets:
      x86_64-softmmu/all             - Build for x86_64-softmmu

    Tools targets:
      qemu-ga                        - Build qemu-ga tool
      qemu-keymap                    - Build qemu-keymap tool
      elf2dmp                        - Build elf2dmp tool
      ivshmem-client                 - Build ivshmem-client tool
      ivshmem-server                 - Build ivshmem-server tool
      qemu-nbd                       - Build qemu-nbd tool
      qemu-img                       - Build qemu-img tool
      qemu-io                        - Build qemu-io tool
      qemu-edid                      - Build qemu-edid tool
      fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper tool
      scsi/qemu-pr-helper            - Build qemu-pr-helper tool

    Cleaning targets:
      clean                          - Remove most generated files but keep=
 t=3D
he config
      distclean                      - Remove all generated files
      dist                           - Build a distributable tarball

Philippe Mathieu-Daud=3DC3=3DA9 (2):
  Makefile: Align 'help' target output
  Makefile: Let the 'help' target list the tools targets

 Makefile | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

--=3D20
2.21.1



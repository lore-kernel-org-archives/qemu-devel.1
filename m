Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD49EC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8657B2465D
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmH+Xwrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8657B2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ycX-0006X6-Ki
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ybM-0005Rv-HJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ybK-0001S0-Pd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ybK-0001Rf-Lb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=25/jMn0ELf5DzpfXOOzlOd80mogSf4C9FhirpHRVIlk=;
 b=gmH+XwrjtdirK4QqxPxIjVGMZLbHvJJh6AuTL1zYyEt21+Ksd7CXBOhsP4NDnMbfl0EI4/
 XTiwCsG6lpdV1xCFRbgMKOv5jnVyaU5tfKXY3NnhSxkJJUgt6unN2pixcuzylRgabhqTvy
 5ih/BVp9KYCDB5onkNqLqexOi/xf5vM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-i1DkE3ArOCiM_Ap6WYXaEg-1; Wed, 12 Feb 2020 15:27:12 -0500
Received: by mail-wm1-f69.google.com with SMTP id w12so1211127wmc.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tp7IhM5UsnJxYm1KSDvk5FTelaHI5dmr97kFOZu6jkY=;
 b=N7Hxq7zQ5+kIrgvWv+Eh+xNWzZRCZpRlzgdp9JLE9ujX7aZ0JHjwfejBtqBd88UL3Q
 Q6HWL2kV5EAj+k+w34d5niIL6vf00HzfPTj3+SyMck7o20W7l7dcnutIMMA/JBef20BW
 isjD47c9PLW3iu9aNuSqBqn9WIi4GqOHn6jSznwd4vOWMvAWhv67vKpAr7loUkR11YwC
 S3NHYxh/TJMS3U4k+MZA1k0sa/GAb6LzMbtXAL+PkVPEy5yi+6zzZNNTValL1XSz9kwo
 Fx5XW4iJGgemysrFrq9no3JG5pbORIBqZuGJzjGH30sOXAJ1qTXK9tORRPbsru6Bzjn7
 7JWA==
X-Gm-Message-State: APjAAAXy7A4uKfhNLTQ/n33mP6SRst7eRC8Hnm9WTorcEAHG4TyzXpLk
 MHUdoGQ9NIoDVbcgYU24VgQyQnqbIjtR54cZ5IpHWofq6fUot4s4awqpuRUFj5R4ww9Gza7iyzS
 LGiQP4rx4rPlrEQg=
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr16484226wrs.424.1581539230810; 
 Wed, 12 Feb 2020 12:27:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+8ZJyPNvbR3JlE51PwE33ZHVITGZsR0F6WHLtIpm/Xt+AFArU+AK/HBduDY94VsZRCirtWw==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr16484206wrs.424.1581539230579; 
 Wed, 12 Feb 2020 12:27:10 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x14sm1957035wmj.42.2020.02.12.12.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:27:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tests/docker: Fix linking with VirGL
Date: Wed, 12 Feb 2020 21:27:06 +0100
Message-Id: <20200212202709.12665-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: i1DkE3ArOCiM_Ap6WYXaEg-1
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dave Airlie <airlied@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We link with VirGL in our debian-amd64 (cross-host) docker image.

This series includes few fixes to keep testing it.

Philippe Mathieu-Daud=C3=A9 (3):
  tests/docker: Update VirGL git repository URL
  tests/docker: Remove obsolete VirGL --with-glx configure option
  tests/docker: Update VirGL to v0.8.0

 tests/docker/dockerfiles/debian-amd64.docker | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--=20
2.21.1



Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C02CC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A8520674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlinAfFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A8520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdAV-0006Nd-7m
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAd9k-0005ek-8H
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAd9i-00054l-OM
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAd9i-000506-In
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o8WoIkGnXk0R5NbrEE4EorPny9zlFYxVqzvhFeq5r5E=;
 b=FlinAfFHHxKmeZ9vhf2qoKpezKt+jcGstVKC8gGT/kzaoC2GAxnvVxPrd+Py+Vmn/v6b8I
 OPKUYrwqu9dR4VOIgPcDgtQOTvlicmqWClrY0MJ2wlufvLHBQVQcxfMi1K3PeO4yYhtTJ1
 goKDudRXipH2UTxBKQAPmy273xrqjaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-m1OXS4GrOxefgrr5HIKqcw-1; Sat, 07 Mar 2020 12:22:25 -0500
X-MC-Unique: m1OXS4GrOxefgrr5HIKqcw-1
Received: by mail-wr1-f70.google.com with SMTP id 72so2611380wrc.6
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BgLI1K1q1VHZMtscS4j9sYne8y2nGGkx2My4wUx5XkI=;
 b=Ip+PEMvOluUdbfq1ZHNZZcjpU7rDNs45NcEf/Bzij3ca/JxFRUYVYXErx7zDXhzOW3
 589aaXu8hYRqDxz22f1pAPt+56XnFJzyNJwDxo90TUcqvutBO6rIsD6cOP8QmCc7dc+G
 iWSH2hidbZCXO5ZxYLD6yMjSdDMbU7WnQmJiPj0dpNHb7XTHvklzbiyoHp9aCMIuxYWS
 Cb48TlbIxWw5R4Arzw8A2zvKp1gUUWWek7PVgEeOOYxX5tF1PtuGUtUgv2bx+iKe81I/
 qGSAhOoR7mVl4Qu3Vry6T7uW+G/IapQZmjZN8bEJ0EQ432vwKUQ2p6M3B1bCRVPDRM95
 XEYA==
X-Gm-Message-State: ANhLgQ1FPzebkodMqzdw+k7nH5+EaPLdwFcCCpozbKcxvidN+W5amC1m
 jM5WcR0HVAqT5FJNAuWhFshgDeml34rE6ko8jYLl5j6QzeZJ30YSfGEqMBxYJr4yW6A6RMQmfiG
 gIXXwu6PyYJiZFFQ=
X-Received: by 2002:adf:f607:: with SMTP id t7mr10217451wrp.36.1583601744525; 
 Sat, 07 Mar 2020 09:22:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuG25+04603RvtvMdB+F3l0re8ENMvDiTdkENZCDvIqIHid9MGzOciYXQTbVCCsJ4t6gOeVAg==
X-Received: by 2002:adf:f607:: with SMTP id t7mr10217431wrp.36.1583601744277; 
 Sat, 07 Mar 2020 09:22:24 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u21sm12176817wmm.48.2020.03.07.09.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 09:22:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] buildsys: Fix building with SASL on Windows
Date: Sat,  7 Mar 2020 18:22:19 +0100
Message-Id: <20200307172222.14764-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a bug reported by Youry few months ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg625606.html

The Fedora docker image already uses the libsasl since commit
8ea5962f286. Add the similar package to the Debian (host) image.

Philippe Mathieu-Daud=C3=A9 (3):
  configure: Check for <sys/uio.h> header before external libraries
  configure: Fix building with SASL on Windows
  tests/docker: Install SASL library to extend code coverage on amd64

 configure                                    | 60 +++++++++++---------
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 2 files changed, 34 insertions(+), 27 deletions(-)

--=20
2.21.1



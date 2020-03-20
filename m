Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A7C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750BA20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9Di1bpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750BA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMyw-0006Pa-L7
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFMy1-00058I-Ns
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFMy0-0000KB-SP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFMy0-0000Jg-Ow
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584731159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AJPA3sicl59GFFT+DtkRckJZBFmmGM02jORRCub06VU=;
 b=Z9Di1bpGRAZ6EZ+Xw+jp3WLwc8nxVv/u0nLmPNCgjsdxg4xBT2X/5W0zvYYqe0pp/KvNRq
 r2SlKbkyKbBKGieuKbFGM9JdoB8hFv0DpqPftRNrI2/Ez5CUczS0J14A+Uczsx/YS46ozt
 JvNKkamIpIQvr9lUZiai63JPhD17LEg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-2hkEfgNNPrGa5I8bMp-sWA-1; Fri, 20 Mar 2020 15:05:58 -0400
X-MC-Unique: 2hkEfgNNPrGa5I8bMp-sWA-1
Received: by mail-wr1-f70.google.com with SMTP id q18so3069495wrw.5
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 12:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TtDAuncxsUcVVjmgEQ5I5VwFnwQRbVxP/Idn847+DZQ=;
 b=ZWTKjR/XNWhfs7siuvYiu8Q7o7bkdhNanoawcwN0OmPpIOvS/QwB5JH8CR3QtgMmSL
 7aO/+jrISMzA0R2pyoHev2ruFgpoMy505B3oqooxZ7TpvJg8/fYT1ORsFNSI2TvuEycJ
 o0jwX+2K3Opyi13PFcIjzMG9m3MGPHjLpcPvmxy0nBPJ03oWl0oUkepsHQ5vgKkkgK8t
 Dh6wEvyYgX0vwHCk74JD1tFNKOsGbI8sXaj3F3cHVOqXII2leggX3h8ZKDgq8MzsCsnX
 kPWbn5X1aRQHC8SsbylYO4jKoiSMv1KYS3zFsQBwHBlCnMekSzkTxXtS+isao0Ok9ce+
 o9yA==
X-Gm-Message-State: ANhLgQ3BTNfxk5Q7NFtr5cXlK/cGTDoSBp6Cjg4dEI0f/bYBExVyYYK+
 4AGAsjwlyRQuMxY60YwiqL/wLpfv2NB9NG02BgyIEoIDYLHx9Nw5yirlMPiqjT1/tJR54AkV2NG
 Yldijn8NUoossex8=
X-Received: by 2002:adf:82f7:: with SMTP id 110mr12644893wrc.373.1584731156710; 
 Fri, 20 Mar 2020 12:05:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs0UjiWFFU9acR3A20IS+bEbh7psjUhNq3/rb3meZHT9gM3CmM+jekilbwYFcEu4EgPagzA/w==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr12644863wrc.373.1584731156422; 
 Fri, 20 Mar 2020 12:05:56 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id w12sm8765622wru.40.2020.03.20.12.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 12:05:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 0/4] tests/docker: Fixes for 5.0
Date: Fri, 20 Mar 2020 20:05:49 +0100
Message-Id: <20200320190553.9363-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Easy fixes for our Docker images.

Philippe Mathieu-Daud=C3=A9 (4):
  tests/docker: Keep package list sorted
  tests/docker: Install gcrypt devel package in Debian image
  tests/docker: Use Python3 PyYAML in the Fedora image
  tests/docker: Add libepoxy and libudev packages to the Fedora image

 tests/docker/dockerfiles/centos7.docker      |  6 ++++--
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 tests/docker/dockerfiles/fedora.docker       | 10 +++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

--=20
2.21.1



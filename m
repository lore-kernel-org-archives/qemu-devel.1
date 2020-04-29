Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF38EC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6CB208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQEJr7C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6CB208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTqc6-0000UV-PR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 13:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTqay-0007cG-IJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTqaw-0006VK-N1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTqaw-0006V9-6k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588181640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DBULYZXUQb4SR0SnlyrTu0O9/z+u7VWP2VOtPodayeQ=;
 b=cQEJr7C8v4nz+n0EPDuOkVDrEyTyujKDC3ySpeOibWuV7kIXSk3qmJB+5/usZUETGSghHS
 T/yYcnlWB+IrnB5I0a097Pyk1+If9ZGIoaTSl5SFxzLLARj6gkX2RslGEJHzIEBAT9mMCg
 cco2dikHx7kQui/fKmU4e+kgKN8dZy4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-2ZLaDdnCPpaOXWeDoJ7K9Q-1; Wed, 29 Apr 2020 13:33:55 -0400
X-MC-Unique: 2ZLaDdnCPpaOXWeDoJ7K9Q-1
Received: by mail-wr1-f71.google.com with SMTP id a3so2116908wro.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 10:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cdAraLO9PK1O6OjrZg7BIJhiEDLboUwjWt5ZPw3bDHM=;
 b=Za5lJsrwekgaEpG6X80ZAdy/aqRYDqgrw6zkV9aTuZsNvoi2ajEEWpFG5QZZhENThM
 L6oU4tlRfcvYXHnXnzw+WkLx+XLLwnlPEvxz6QhJPdmx7GIeFv/nLJ9VU6YxIqHl0E4J
 JGqSESJ71KLXjU5QKxTiUrGypfNmYOsrXnJvz1/rLwoukgboRnu8ZOou2GFskHurPsuU
 F4a/pmPuoefuW80fBxazolDFi2kP3QS1yRxEHUqzL3b8x670f/pcjlbV2/V+5ohJKLuZ
 N1gZv5Ws4UHeMZCcQXk8ktja6KFZABVtuiyuROMrxXngAwXJMoM4EfLn3cFNDji1puy1
 s0rg==
X-Gm-Message-State: AGi0Pua0Mcy4IUMTkHcoUZlFN/n3FGEcQnIQoCdQNU5ft99daGSn+z3G
 wS1/ydHvROkOu3m+AwVj60aD5AfNrBeiNidZTnoU70PmQMuya9o75ydgBhLRwo2WXe2yFlfjO9C
 A/5m1WPs/p9U6dYM=
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr4178436wme.115.1588181634355; 
 Wed, 29 Apr 2020 10:33:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypK8nX3DyILPvrU5gTkphPnYw6lAE7a3sXH8IkOarWa/dedc18zOnYP6JCGUKyjvSXjaisx5eg==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr4178410wme.115.1588181633989; 
 Wed, 29 Apr 2020 10:33:53 -0700 (PDT)
Received: from x1w.redhat.com (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id s24sm9116244wmj.28.2020.04.29.10.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 10:33:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 0/1] hw/audio: Make 'soundhw' command line option a QOM
 interface
Date: Wed, 29 Apr 2020 19:33:51 +0200
Message-Id: <20200429173352.29442-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After looking at Gerd's "audio: deprecate -soundhw":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg698818.html
I updated a patch I started some time ago.
It is unfinished due to problem with hda-intel and pcspk. I have
some idea how to fix pcspk, but it invasive. I haven't looked at
hda-intel yet.
Looking at Gerd series, fixing these issue might be trivial for
him, so I send this patch as it, in case it helps.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (1):
  hw/audio: Make 'soundhw' command line option a QOM interface

 include/hw/audio/soundhw.h |  20 +++-
 hw/audio/ac97.c            |  10 +-
 hw/audio/adlib.c           |  13 ++-
 hw/audio/cs4231a.c         |  13 ++-
 hw/audio/es1370.c          |  10 +-
 hw/audio/gus.c             |  13 ++-
 hw/audio/intel-hda.c       |  13 ++-
 hw/audio/pcspk.c           |  14 ++-
 hw/audio/sb16.c            |  13 ++-
 hw/audio/soundhw.c         | 203 ++++++++++++++++++++-----------------
 10 files changed, 178 insertions(+), 144 deletions(-)

--=20
2.21.1



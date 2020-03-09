Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA217C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767BC21655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC0dq13D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767BC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJev-0006uo-LE
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJdS-0005Y2-Lg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJdR-0005MJ-NX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJdR-0005Lc-Jq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TLihVsKSdk/8oF9tHYF3U4CMlyHCeJGn5UZnYNl9B8g=;
 b=EC0dq13DRXEYZl0tcjIYQkacqzwR0emq7wH00jmO9EcdUlO0+geKUFD2cAxB4NnD3H4uBY
 qetsJ0yBzfwENhIpxYcYmsocdmtDk3fQt/AJBnLQNXYjQ+yjOzwsPXCe+1S9Uq1EZF6Y/6
 bDxxdnV7QR+aMSgqxk5+sUg7fXVY2qU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-yxONDQCSP5SBrqSJTuVEAw-1; Mon, 09 Mar 2020 10:43:58 -0400
X-MC-Unique: yxONDQCSP5SBrqSJTuVEAw-1
Received: by mail-wm1-f71.google.com with SMTP id i16so2590116wmd.9
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4jDfR9gbwGBzB0ZR4xb8ddJpILYpYP3XxO21zy6Pd3w=;
 b=s1Lnz8Ez0XQMZ8OCKUEGmFtXjhqzFnblESH62Zc1/vx8VqG+CrCWGoPboARWHUtwCO
 GSjtJxq7ubbzN2n4AMIPxmV6GjoBba6FbZFojqfZZO2YxbZTtZll3fsxpN7++xVwWlht
 TS+FzoB5T6av9vXs0kuIHPt6Z85orwKVP2be48KGrLmwluqC/+woUFldQM/ag7NhhVNU
 pO5yp5THdytInvDAJBlsd8bWAWVVrwPYCF6EuT2B0Dc5xZkj7ztzHj9FBKCkwPTEobI3
 2FCD61fT+22aoupNcsnNnjIhC/U9GBtPzVDKN8ZoA5E5VNRejZHB/QgbCz2DCRslwM7t
 0Pnw==
X-Gm-Message-State: ANhLgQ0koHtJ28UpHNqvSygl1rAhg8orambtpFZzKxOwhQgNMfkPPFml
 JoSDBC1GXdKg5XXRWhamsoYSomXdktAT1DQwP9iFgutruzRcBC9op0d5/YwSeG8zfBpkbxVyGZM
 pTW5hv6V+nOeRA/0=
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr19730040wme.125.1583765037144; 
 Mon, 09 Mar 2020 07:43:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsfRpggo24J6BIcQH8PArvP2fBxn6rVjGnyKF9APFTRhi+ZVMcZng8E1lnl7kY9ri/AJUee0Q==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr19730018wme.125.1583765036936; 
 Mon, 09 Mar 2020 07:43:56 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f6sm25024365wmh.29.2020.03.09.07.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:43:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/core/loader: Prohibit loading ROMs bigger than memory
 region
Date: Mon,  9 Mar 2020 15:43:48 +0100
Message-Id: <20200309144353.26457-1-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes a bug where an user can load ROMs bigger
than the expected size. The bug is delayed after a reset where
rom_reset() can overflow the underlying memory regions.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/sparc64/niagara: Pass available memory region size to
    add_rom_or_fail
  hw/core/loader: Prohibit loading ROMs bigger than memory region
  hw/core/loader: Provide rom_add_file() a 'max_size' argument
  hw/core/loader: Restrict rom_add_file_mr() to available region size
  hw/core/loader: Provide rom_add_file_fixed() a 'max_size' argument

 include/hw/loader.h  | 12 ++++++------
 hw/core/loader.c     | 24 +++++++++++++++++-------
 hw/i386/x86.c        |  2 +-
 hw/ppc/sam460ex.c    |  2 +-
 hw/sparc64/niagara.c | 22 +++++++++++++---------
 5 files changed, 38 insertions(+), 24 deletions(-)

--=20
2.21.1



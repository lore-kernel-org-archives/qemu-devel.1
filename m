Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA7C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D67420714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Nox1Jhqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCK8x-0006Dc-Jd
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7W-000541-F2
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:30 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7U-00041l-IW
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:30 -0400
Received: by mail-pl1-x643.google.com with SMTP id y6so1665856plt.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=eKO6pzeX5+S1HnwzlrwouNcbF1YcL1+KIS58fIOliqs=;
 b=Nox1JhqhtBkGfn2zuOyMIiZCgUUxQrx0mhYim6+sK3lf/HOoK3DSYGG6GAJ6cvnE6Z
 LI8KWnLt5zEL9wfji8jNCnVLY2E4wnaEfQyyWqP7pmb6ji2k6WgCh3nD4saSYfDvkIJq
 Nbaas+15VOmLDKYhZ2anHnUhtMoZYwhpS/MSvRLXzXmcUBKPxDrXfmtg5Q9oypVh9Tvp
 LifX+Jaqu9DdPvXmOlLrGCbvOTsLsKHmlGZEiK7bok2PCzXaMPOQ2aGrhgRs/nz6xvut
 aMGFyoYtgl2+XqQOJpGkBHLAHQ9lvGqP4uPVTOcZwSQH3jeLOlLyASyzvKutgR3kasUA
 7IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eKO6pzeX5+S1HnwzlrwouNcbF1YcL1+KIS58fIOliqs=;
 b=sOVRXT2jABJ/ftDLVqaaLlAnRH7sehWHouPee/7Xra1P6O/b6Q9Dk1oWwe5ThUVYwo
 m4tbKrWJ0ywu78Uw3b/k1vZV8QdrCy4XEvFWY7PbeDYZ4L3Hm8/XrP1Us+1fDMrawKdY
 7RpoFhgWBYh9g1ffVXEcktvw1nkhS36SE1RRZzpnX+mGOpi7idgDhjpDmPSReGa0Gyck
 nzO5957ZxV50rvunUOm9zsoXHb5YfzVmQy88+872qJkJkAZxyyQD0z5kwwVuDJ0LYCoF
 WZqXcnIIm9//1vBxTqi40vuzR8s33mJlq3amqM9xF5rNU7wlwavVVUwmkJpff24IFzkA
 aQOg==
X-Gm-Message-State: AOAM532ANvxEr7N91Tv0gdnC10xZWkGN7elVWJZqdXkbQuuyB9T01kWt
 EAXE6qz1ed8ae4YkzObogN+eLhHTJ/00eQ==
X-Google-Smtp-Source: ABdhPJwO/jZGzTwAms+DDAX+SSuOoCsV4jb0YcvmvDEH74vQR5q1CZQaJkqZCxf80axFk9YjGTig3Q==
X-Received: by 2002:a17:90a:1546:: with SMTP id
 y6mr5887237pja.93.1598781566164; 
 Sun, 30 Aug 2020 02:59:26 -0700 (PDT)
Received: from localhost.localdomain ([115.96.143.103])
 by smtp.googlemail.com with ESMTPSA id c143sm4773722pfb.84.2020.08.30.02.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 02:59:25 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] i440fx: unit tests for testing flag that enables/disables
 pci root hotplug
Date: Sun, 30 Aug 2020 15:29:11 +0530
Message-Id: <20200830095915.14402-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following set of patches have been generated according to the guidelines provided in the
header comment in the file tests/qtest/bios-tables-test.c.

The first patch documents that a new ACPI table binary blob has been added. The new file is
listed in file tests/qtest/bios-tables-test-allowed-diff.h.

The second patch is the actual unit test.

The third patch actually adds the new ACPI table blob and then clears the file
tests/qtest/bios-tables-test-allowed-diff.h.

The unit test has been tested on the top of upstream master qemu tree  v5.1.0 tag. I have not
tested this patch on the latest upstream master branch HEAD because there seems to be an issue
with the latest upstream tip with qemu crashing consistently.

Thanks to Igor for pushing on this.

--Ani

Ani Sinha (3):
  tests/acpi: document addition of table DSDT.roothp for unit testing
    root pci hotplug on/off
  tests/acpi: add a new unit test to test hotplug off/on feature on the
    root pci bus
  tests/acpi: add a new ACPI table in order to test root pci hotplug
    on/off

 tests/data/acpi/pc/DSDT.roothp | Bin 0 -> 3215 bytes
 tests/qtest/bios-tables-test.c |  14 ++++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

-- 
2.17.1



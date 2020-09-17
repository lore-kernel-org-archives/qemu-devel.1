Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A480C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C6E22246
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcvFw7d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C6E22246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuTc-0001IW-VR
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMQ-0000Bp-NU
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMA-00086K-FI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KCenPeUzK5ZyBxIuzmFituXr7VoUzx6fBMypE+JXJg=;
 b=NcvFw7d73Ous6n47XaHx8KvG4Il7d53hw//5togpdqaRFkrBpVW3JAXOwiXAMf07WUHAWQ
 6dPZgWiJ5SL9vlEMeUCMYUbMqOarRj+9lO6YvXoxsp2zpWBxiwpPmySPG3mk8XNWHrGnPc
 wHLgf8++uqXO+mqC647eCbs9G6ZOnsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-3by9eunCMjCavdpMxwMqQQ-1; Thu, 17 Sep 2020 09:53:47 -0400
X-MC-Unique: 3by9eunCMjCavdpMxwMqQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 215381084C81;
 Thu, 17 Sep 2020 13:53:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D30EB7881B;
 Thu, 17 Sep 2020 13:53:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 792A731FC7; Thu, 17 Sep 2020 15:53:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] tests/acpi: update expected data files for microvm
Date: Thu, 17 Sep 2020 15:53:22 +0200
Message-Id: <20200917135323.18022-21-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also clear tests/qtest/bios-tables-test-allowed-diff.h

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200915120909.20838-21-kraxel@redhat.com
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/microvm/APIC                | Bin 0 -> 70 bytes
 tests/data/acpi/microvm/DSDT                | Bin 0 -> 365 bytes
 tests/data/acpi/microvm/FACP                | Bin 0 -> 268 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 97c3fa621b7f..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/microvm/APIC",
-"tests/data/acpi/microvm/DSDT",
-"tests/data/acpi/microvm/FACP",
diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/microvm/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7472c7e830b6c7139720e93dd544d4441556661d 100644
GIT binary patch
literal 70
zcmZ<^@N{-#U|?Xp?&R<65v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jnsGfW!{`1CcCj
H|A7Jk<Z=uF

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/microvm/DSDT b/tests/data/acpi/microvm/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b43f427a222a933d3f34aceab6224a2c6115c365 100644
GIT binary patch
literal 365
zcmX9(%SyvQ6upy2n@pNIKA<QF#Sf5arMONe(=?DaG1G?-VTyaft+=UO6kPiQ{RBV7
z&*`dor`gOs_nbMLa}$-!-w1&98W&=s`tfrq66BBqgUw{=rB<=7xA)_f7<+n>CE=5t
zE;#2y@U)soH1M>j)Okp0N|?)B()oaTI~2uqaQfeg{#@eeMV8=e3}=mj(J&<k`(T52
z$G~{<Rw@(SghZmuI3GM<2s%R)5Sg4V4Zd4o6Cc~5X(KC{LI+@fq)z=6m{mw6^ZwPX
zmdm;SZkF|){d}&e1=QM=t170OdV6g^6IRYjF1Tp2ut@AIEB@GM`K&7N+EF9YHntEE
jUShi3(B94m0^Q#uSOD0Iklv{mV=rh>BYn|!sEgD;a<EMS

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/microvm/FACP b/tests/data/acpi/microvm/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0ba5795d622349e1521138e4123544637b4ab9af 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME*ebMklg2v%^42yk`-iUEZfKx`0ARlp*^z`()4z{IrRAIMxMsv1tD
QVL<yCp!S2@!U$yp0N^VO0RR91

literal 0
HcmV?d00001

-- 
2.27.0



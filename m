Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0843320672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtCiRz1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0843320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr6Ad-00072x-8Q
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 16:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr698-0004P2-Ti
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr694-0003Y6-8n
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593722961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=MNTlxHdwoZD1i7fR0/VxIsjSfZdUtlBEEDJL/FTCXj8=;
 b=NtCiRz1HmWgycH9bfp1YO3tbsgb5spIME+RUQa90ew2RiVsH+yYqhssIzqrOqpDzlPvA1S
 sRt2cwbPQjptBDlsHF957zzBVVtX1aR6yWRdBVYYLNIUu3p/HejrtpDCX8XC7cZWgPJC82
 a2JZhJcXut6Gi8WSL16e7eai5g4IR3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-GxZjK5W8P_SgcZHHIHy8qQ-1; Thu, 02 Jul 2020 16:49:20 -0400
X-MC-Unique: GxZjK5W8P_SgcZHHIHy8qQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EC88018A4;
 Thu,  2 Jul 2020 20:49:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50A981A928;
 Thu,  2 Jul 2020 20:49:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B2D3231F14; Thu,  2 Jul 2020 22:49:00 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/21] tests/acpi: update expected data files for microvm
Date: Thu,  2 Jul 2020 22:48:59 +0200
Message-Id: <20200702204859.9876-22-kraxel@redhat.com>
In-Reply-To: <20200702204859.9876-1-kraxel@redhat.com>
References: <20200702204859.9876-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b7297dfe9a34bede2ad0d65281f0bc7497bbd358 100644
GIT binary patch
literal 365
zcmX9(%WA?v6uqN~#;dW@2S^JA=?9e2B3&nwF$SVZGd>C_j6YE5wz#n_gs%GoenLN`
zpW{k;$86@Fd(Irrxsi_M?+m~-VJ0WKAHL=?B917q*iIf_8y%W*_c&h3v1cYp<iDut
zLI^Pg&**u8ZO_O;U;2nK<1Tku=M&1^P-fG?`F|()bD3urNkp$TTvP^*e$0;bV;#H)
z4%U-4VilPxB#?O`#NdfS$mx?n$mVph{oQ~%Yf(EgZB?OS=l~o}=#*b=yGo^1+P}Fs
zYB_Ix*kyg-Kbtky0BievRfM=LcefT)Vfic<QphTciiFOx5YLsC&Wen#9aSPWsf7&a
j65Hhtd;1nJ=>DFd20*<S>z#XX{ze8pGFMFpU84R0a<feV

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/microvm/FACP b/tests/data/acpi/microvm/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..e52b16d24ac4f7b95a7d11a5f2ad801c0cb87147 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME*eb@F%i2v%^42yk`-iUEZfKx`0ARlp*^z`()4z{IrRAIMxM1_r8I
SLD0QG`x&72gWSRhWdi`;u?ztK

literal 0
HcmV?d00001

-- 
2.18.4



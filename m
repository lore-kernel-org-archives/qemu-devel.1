Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F672C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4DA20780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfOfFYNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4DA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNu1W-00029M-KF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxY-0005w4-97
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxT-0002Ll-TH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601540939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVMcRRphqLATFdXrbVOHne+0E5XTAVDj3f+GRgBbNV4=;
 b=SfOfFYNy0gJ8E7tVR+F5FL31Iv1BXqQ6cgA5oc/AXh8N9BOmgpB2LIX0G13dJe34zagLoS
 T3cep9mLT3K5M+20ivKgxHhPQ/lYzNXHAgIN+OgtGnOhDOOSqP3lEL9dV71DFBJtWE7Jca
 zj9GY69ERBEa6VoNjaRzQdrrJfM1DBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-wiL7PxryMviJvvG7yPdkVQ-1; Thu, 01 Oct 2020 04:28:58 -0400
X-MC-Unique: wiL7PxryMviJvvG7yPdkVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7024100648D;
 Thu,  1 Oct 2020 08:28:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C44D75120;
 Thu,  1 Oct 2020 08:28:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 340BB31FCE; Thu,  1 Oct 2020 10:28:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] tests/acpi: update expected data files
Date: Thu,  1 Oct 2020 10:28:34 +0200
Message-Id: <20201001082834.15821-10-kraxel@redhat.com>
In-Reply-To: <20201001082834.15821-1-kraxel@redhat.com>
References: <20201001082834.15821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/microvm/DSDT.rtc            | Bin 0 -> 404 bytes
 tests/data/acpi/microvm/DSDT.usb            | Bin 0 -> 414 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index afd6b04a475a..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/microvm/DSDT.usb",
-"tests/data/acpi/microvm/DSDT.rtc",
diff --git a/tests/data/acpi/microvm/DSDT.rtc b/tests/data/acpi/microvm/DSDT.rtc
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..5960d6929a2f88d76aaa324b88b80908ff0698dc 100644
GIT binary patch
literal 404
zcmXv~%TB^T6ur|@C{v1~(GX2c2#H%WV2JB>I+P{_YNvonO@>ckYuq3U64&|xe1f0i
z=ddE)p}Lv-I_KVVCQ?!HMF1=w&cs-C!{<yy*uxf>+(b6L(kj&D_I|V!BUg`;$bXWP
zIp=%;u2w}rJy(ldo%@u=ggMM1tyd_w12LQQPxw~w;}BQRlL%i!II9SZ`Y}1!2OHcT
z1H-w?3!(ox9<DcgPp~ztfw(;&2A0-i8C5tx5Lv=`{{g{xz{kNKtxdg;I@qL%CXlp|
zxs0I&us_mT`R<ugNF~$m<*k;BqPaH3YR^93R@4G&?XqPa(oMO&Hc4eXn`T^aQQblz
zVQrD~$7+^N^BI21uo}_^iWdPIHWqGZXV(M*?e8O40H}+Q&Pf+zFGx^BebJ~<2V1|a
Cp;Z9@

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/microvm/DSDT.usb b/tests/data/acpi/microvm/DSDT.usb
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..14423381ea235ed42f6f0f7d98e793c271a4e7c1 100644
GIT binary patch
literal 414
zcmY+A%}T>S6ov1kO`A@eI*M2ngyI9}v{KxfOr}YoKQZYaM3_E;bSG|V76o^Ld+8(i
zC_YYC#XB8cxS6^4-1#`?PLKtYPXb`A{IQ6#w!cV3fEr4mYkjlmOl7{xi|hVe^c@w&
zf%_nbQ_gu89F<KxT6dI4vtyUikT9Fsr11=S(G}xi=kUJaecQxQ(>TCW14jm6)D6k5
zv@3yg#XvKIN+<(mOgxdqoOf=~1W6YMSZSXot-n>EL~580p|wn92n~Sko|g01x^9Kc
z<e+_espM=@d(zEv%RXL~)B<X4l6mUWbzYq7!k8tagbOZ=7Y6amvy|VN*<h58aoe65
z(kiA99&VzuT+r601_YX4d$0g77a=W^tGHQ2BL4dTm;DFeeGm7)06hSVJ)%R_Qzz9j
HwNd&31|3%c

literal 0
HcmV?d00001

-- 
2.27.0



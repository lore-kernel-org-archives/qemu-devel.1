Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB8FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68519206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5PZPBtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68519206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNln-0003LV-FI
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNk3-00022K-Ht
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:59:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNk1-00028Q-Ho
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591883976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PdlnoNVDrASWbt68U3vZNn5gg5Q8N3H+DkunE9Q69co=;
 b=b5PZPBtv8W872BlbrQWs5dtNfqZU0Pl88Sx7wcbIK5FzL0t2xV+Xs5onDH25V76/IQPPPU
 iILV2q6ho4BzRksX5uGaY7vUFr3L/CHHfE3N/HwZqZVZRZD2xn3bILWrDoyTu9sRskJ/m0
 trMnxZdmaY8WhKKOb1sZ7bUL46u3FeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-FiHmqIyePB--zXv0rGSYOA-1; Thu, 11 Jun 2020 09:59:34 -0400
X-MC-Unique: FiHmqIyePB--zXv0rGSYOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFC5835B51;
 Thu, 11 Jun 2020 13:59:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2405D9DC;
 Thu, 11 Jun 2020 13:59:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [PATCH v4 0/5] vTPM/aarch64 ACPI support
Date: Thu, 11 Jun 2020 15:59:12 +0200
Message-Id: <20200611135917.18300-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those patches bring MMIO TPM TIS ACPI support in machvirt.
The TPM2 build function is converted to build_append style.
Then the code is moved to the generic part.

On ARM, the TPM2 table is added when the TPM TIS sysbus
device is dynamically instantiated in machvirt.

Also the TPM2 device object is described in the DSDT.

Many thanks to Ard for his support.

Tested with LUKS partition automatic decryption. Also
tested with new bios-tables-test dedicated tests,
sent separately.

Depends on "acpi: tpm: Do not build TCPA table for TPM 2"

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.0-tpm-acpi-v4
(includes the related DSDT and TPM2 ACPI table tests)

History:
v3 -> v4:
- some rework in build_tpm2() as suggested by Igor
- Restored tpm presence check in acpi_dsdt_add_tpm()
- add the doc related patch

v2 -> v3:
- Rebase on top of Stefan's
  "acpi: tpm: Do not build TCPA table for TPM 2"
- brings conversion to build_append

v1 -> v2:
- move build_tpm2() in the generic code (Michael)
- collect Stefan's R-b on 3/3

Eric Auger (5):
  acpi: Convert build_tpm2() to build_append* API
  acpi: Move build_tpm2() in the generic part
  arm/acpi: TPM2 ACPI table support
  arm/acpi: Add the TPM2.0 device under the DSDT
  docs/specs/tpm: ACPI boot now supported for TPM/ARM

 docs/specs/tpm.rst          |  2 --
 include/hw/acpi/aml-build.h |  2 ++
 include/sysemu/tpm.h        |  2 ++
 hw/acpi/aml-build.c         | 52 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 41 +++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 34 ------------------------
 6 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.20.1



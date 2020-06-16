Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6C52074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1nZ6TNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6C52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl81T-0002Ko-2x
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jl804-0000Ja-Av
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jl7zy-0000Ca-Ph
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592300117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BtsUXgTaNuj5DtbHPFZ7tgT3J979kECMfnjX+vflDxA=;
 b=P1nZ6TNC3bG2yDlsklrsVWG6+DpX87FLoB51IpmPLZEe33BE4fUuOdWSQL+l4SmB4wL97D
 MpEo+/Ok6/Wk44ed6MJK10SAz1DcfhB7Yl7J1EowMuIeZr6nu9mzLwiYShktaOKy6GjqQa
 4oCqTR7Ebsm6vZ1Ql6MRK4lGmfZsD8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-pEkxmc8EPfuso3oepktafA-1; Tue, 16 Jun 2020 05:35:15 -0400
X-MC-Unique: pEkxmc8EPfuso3oepktafA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B9F1010890;
 Tue, 16 Jun 2020 09:35:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42C235C1BD;
 Tue, 16 Jun 2020 09:35:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com
Subject: [PATCH v5 0/3] vTPM/aarch64 ACPI support
Date: Tue, 16 Jun 2020 11:34:54 +0200
Message-Id: <20200616093457.24709-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: thuth@redhat.com, lersek@redhat.com, drjones@redhat.com,
 shannon.zhaosl@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those patches bring MMIO TPM TIS ACPI support in machvirt.

On ARM, the TPM2 table is added when the TPM TIS sysbus
device is dynamically instantiated in machvirt.

Also the TPM2 device object is described in the DSDT.

Many thanks to Ard for his support.

Tested with LUKS partition automatic decryption. Also
tested with new bios-tables-test dedicated tests,
sent separately.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.0-tpm-acpi-v5

History:
v4 -> v5:
- Move of build_tpm2() in the generic acpi code was upstreamed
  but this does not correspond to latest proposed version.
- Rebase on top of edfcb1f21a

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

Eric Auger (3):
  acpi: Some build_tpm2() code reshape
  arm/acpi: Add the TPM2.0 device under the DSDT
  docs/specs/tpm: ACPI boot now supported for TPM/ARM

 docs/specs/tpm.rst       |  2 --
 hw/acpi/aml-build.c      | 45 +++++++++++++++++++++++-----------------
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 21 deletions(-)

-- 
2.20.1



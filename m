Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5541B206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk3SVTys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5541B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg5LH-0004YA-Lz
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jg5Jw-0003Wm-SN
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:43:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jg5Jw-0006al-3E
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591098183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrq5KfIhNGvGl6ZemBOLCxmolhBSiAc2aKkOSd624f0=;
 b=gk3SVTysmr4kFk93UO728avob5RtpoE0AIlsZmghk9GWkYnzhT/e4hkEOBi/pTXyrTHajq
 pW5sSBaUnUKxQdb5f3vac2RZKRT9Z2EiUvkZify76t+sPplSL1GYiVTjDMH9YncxhbE3p2
 WNSVRu/JX8iKz/MS81kFJ2ArIv5Vt7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-xXTpwXs-P8qUv32f3XyhAA-1; Tue, 02 Jun 2020 07:43:00 -0400
X-MC-Unique: xXTpwXs-P8qUv32f3XyhAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DFE619200C0;
 Tue,  2 Jun 2020 11:42:58 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAA37A8C1;
 Tue,  2 Jun 2020 11:42:50 +0000 (UTC)
Subject: Re: [RFC 0/6] TPM-TIS bios-tables-test
To: eric.auger.pro@gmail.com, stefanb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200601102113.1207-1-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7028063b-c082-a40d-bd4d-0997fb0ff6ff@redhat.com>
Date: Tue, 2 Jun 2020 13:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200601102113.1207-1-eric.auger@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Hi,

On 6/1/20 12:21 PM, Eric Auger wrote:
> This series adds the test of the TPM2 and DSDT tables when the
> TPM-TIS device gets instantiated.
> 
> The series also allows to validate changes in the TPM2 table
> generation done in "[PATCH v3 0/4] vTPM/aarch64 ACPI support",
> sent separately.
> 
> This depends on Stefan's "acpi: tpm: Do not build TCPA table
> for TPM 2".
> 
> This is in RFC state because I am not very familiar with the
> table generation process docommented in bios-tables-test.c.
> 
> I don't know how to get rid of the checkpatch errors:
> "ERROR: Does not appear to be a unified-diff format patch"
> 
> Surprisingly, checkpatch argues when void tables are added in
> the same time as bios-tables-test-allowed-diff.h changes.
Both issues reported above were resolved by Michael's
[PATCH] checkpatch: reversed logic with acpi test checks

Thank you for fixing that

Eric

> 
> Most importantly, to be able to reuse tpm-emu code, I was forced
> to remove the TPM2_ST_NO_SESSIONS assert. I would be grateful
> if I could get some advises on the best way to address the issue.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v5.0-tpm-acpi-tests-v1
> 
> 
> Eric Auger (6):
>   test/tpm-emu: include sockets and channel headers in tpm-emu header
>   tests/acpi: Add void tables for Q35/TPM-TIS bios-tables-test
>   tests/acpi: Ignore TPM2.tis and DSDT.tis
>   tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
>   bios-tables-test: Add Q35/TPM-TIS test
>   bios-tables-test: Generate reference tables for Q35/TPM-TIS
> 
>  tests/qtest/tpm-emu.h          |   3 ++
>  tests/qtest/bios-tables-test.c |  60 +++++++++++++++++++++++++++++++++
>  tests/qtest/tpm-emu.c          |   1 -
>  tests/data/acpi/q35/DSDT.tis   | Bin 0 -> 8468 bytes
>  tests/data/acpi/q35/TPM2.tis   | Bin 0 -> 76 bytes
>  tests/qtest/Makefile.include   |   1 +
>  6 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100644 tests/data/acpi/q35/DSDT.tis
>  create mode 100644 tests/data/acpi/q35/TPM2.tis
> 



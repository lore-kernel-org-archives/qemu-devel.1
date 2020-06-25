Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3EA2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn7Q8yeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3EA2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKlF-00038m-9h
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joKjt-0001HB-BW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:47:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joKjq-0004d6-Ne
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593064073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yltWr9m7PQsc55IuLqoYh3lku7RKrI2HuyQ7nFk1wmM=;
 b=Tn7Q8yeFxXwe2MXKJAgu+WStD6ligg1ZtK/Q4rH7Bi1LWGwkgqsjT5yRbP1OE12FjCFmrA
 JqNSLAW21klTDFCdgytGABwMQJOgQGRPNwB4U6Ot6Agop3y+qTy94TVKDPPZfxzjH2z4we
 2+kONHKtW29tB76K8fJdgnm1tjRAALk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-mEYcsFWVMQuqEDlAvqgWNA-1; Thu, 25 Jun 2020 01:47:47 -0400
X-MC-Unique: mEYcsFWVMQuqEDlAvqgWNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0A97805EE3;
 Thu, 25 Jun 2020 05:47:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C8A35D9C5;
 Thu, 25 Jun 2020 05:47:43 +0000 (UTC)
Subject: Re: [PULL 00/19] virtio,acpi,pci: fixes, cleanups, tools.
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200624230609.703104-1-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <041fe41e-e9b5-77dd-d69c-0afdcbfd638c@redhat.com>
Date: Thu, 25 Jun 2020 07:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/2020 01.06, Michael S. Tsirkin wrote:
> The following changes since commit d4b78317b7cf8c0c635b70086503813f79ff21ec:
> 
>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200623' into staging (2020-06-23 18:57:05 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to f6f746db6bae1ba74967fd7bea2bb5e169502948:
> 
>    tests: disassemble-asm.sh: generate AML in readable format (2020-06-24 19:03:57 -0400)
> 
> ----------------------------------------------------------------
> virtio,acpi,pci: fixes, cleanups, tools.
> 
> Fixes, cleanups in ACPI, PCI, virtio.
> A handy script for testing ACPI.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Ani Sinha (1):
>        Rename use_acpi_pci_hotplug to more appropriate use_acpi_hotplug_bridge
> 
> Eric Auger (3):
>        acpi: Some build_tpm2() code reshape
>        arm/acpi: Add the TPM2.0 device under the DSDT
>        docs/specs/tpm: ACPI boot now supported for TPM/ARM
> 
> Gerd Hoffmann (12):
>        qtest: allow DSDT acpi table changes
>        acpi: bios-tables-test: show more context on asl diffs
>        acpi: move aml builder code for floppy device
>        floppy: make isa_fdc_get_drive_max_chs static
>        floppy: move cmos_get_fd_drive_type() from pc
>        acpi: move aml builder code for i8042 (kbd+mouse) device
>        acpi: factor out fw_cfg_add_acpi_dsdt()
>        acpi: simplify build_isa_devices_aml()
>        acpi: drop serial/parallel enable bits from dsdt
>        acpi: drop build_piix4_pm()
>        acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
>        tests/acpi: update expected data files
> 
> Michael S. Tsirkin (1):
>        tests: disassemble-asm.sh: generate AML in readable format
> 
> Raphael Norwitz (1):
>        Stop vhost-user sending uninitialized mmap_offsets
> 
> Thomas Huth (1):
>        tests/qtest/bios-tables: Only run the TPM test with CONFIG_TPM enabled

  Hi Michael!

Please drop my patch from your pull request - the issue has already been 
solved by Eric's patch that already got merged:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=55b9757c7e58092

  Thanks,
   Thomas



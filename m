Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA91C35257
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE00C21924
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+6rYJyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00C21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kInQB-0003PX-Ux
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 02:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kInLu-0007UN-4n
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kInLr-0002yB-86
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600323902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He57pHJ6NfeUrlVC7h7do/i8PAhdCj+i2kd0H5if+8M=;
 b=F+6rYJyC6SpvmsbXoxHG2/hvqiR7xQqAfK5IeaqLDbFBoRutpVnyQtgvUv9ZFPe+i/Mzm2
 ktBlFoiAcAXbGre18MfOrpWTWB5AnSTfETF1Fsc2j/G1ByGD0rdsbWJM0gb6Wngd9WHoSi
 k17WczdwgSdCbhs4N/LAC0MRC9ggGg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-MWZejdhTMtCNSQ2Ot7tmtw-1; Thu, 17 Sep 2020 02:24:56 -0400
X-MC-Unique: MWZejdhTMtCNSQ2Ot7tmtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F2B218B9EEA;
 Thu, 17 Sep 2020 06:24:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABC1B78804;
 Thu, 17 Sep 2020 06:24:47 +0000 (UTC)
Date: Thu, 17 Sep 2020 08:24:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v5 00/11] i440fx/acpi: addition of feature and bug fixes.
Message-ID: <20200917082446.5e142d5b@redhat.com>
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 13:48:59 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> In v5, I have tried to address all the latest review comments in commit logs
> and in patches. Also added "Reviewed-by" and "Acked-by" tags when a particular
> patch was already reviewed.

points that weren't addressed in this version across whole series:

(1)
s/amls/ACPI code/
(2)
make commit message fit in 80crl/line limit (modulo diffs).

so pls fix that before re-spinning (including already acked patches)

> Unit tests pass when the patch series is applied on top of the latest qemu master
> branch.
> 
> Disassembly of DSDT table is here:  https://pastebin.ubuntu.com/p/WvpYYjpPN8/
> when pci hotplug is turned off globally.
> 
> 
> Ani Sinha (11):
>   tests/acpi: document addition of table DSDT.roothp for unit testing
>     root pci hotplug on/off
>   tests/acpi: add a new unit test to test hotplug off/on feature on the
>     root pci bus
>   tests/acpi: add a new ACPI table in order to test root pci hotplug
>     on/off
>   Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
>     non-hotpluggable bus
>   i440fx/acpi: do not add hotplug related amls for cold plugged bridges
>   tests/acpi: list added acpi table binary file for pci bridge hotplug
>     test
>   tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
>     bridge flag
>   tests/acpi: add newly added acpi DSDT table blob for pci bridge
>     hotplug flag
>   piix4: don't reserve hw resources when hotplug is off globally
>   tests/acpi: unit test exercising hotplug off for pci root bus & bridge
>     in i440fx
>   tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx
>     hotplug
> 
>  hw/acpi/pcihp.c                   |  15 +++++++++
>  hw/acpi/piix4.c                   |   6 ++--
>  hw/i386/acpi-build.c              |  37 ++++++++++++++--------
>  tests/data/acpi/pc/DSDT.hpbridge  | Bin 0 -> 4895 bytes
>  tests/data/acpi/pc/DSDT.hpbrroot  | Bin 0 -> 2953 bytes
>  tests/data/acpi/pc/DSDT.roothp    | Bin 0 -> 5130 bytes
>  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7670 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 8994 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7688 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8133 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9323 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7745 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9029 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8801 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7676 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8276 bytes
>  tests/qtest/bios-tables-test.c    |  49 ++++++++++++++++++++++++++++++
>  17 files changed, 92 insertions(+), 15 deletions(-)
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot
>  create mode 100644 tests/data/acpi/pc/DSDT.roothp
> 



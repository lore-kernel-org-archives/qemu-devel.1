Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82535C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E7420EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwYzEgYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E7420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKId-0005an-5H
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKKGt-0003tV-PY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKKGr-0002rx-L4
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600688772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njt5GKwNwD3br/ho+W/vjGBbfFj+3zSgM3djLXGwuH8=;
 b=gwYzEgYdwcqAbEfeISwaNtFtRvbUlfiAJf8TwCknRE5LX1xHL2pRSRm/zK70YDUpoGtX3Z
 vmYqKDu0KD1C2Z86CVvlQwCUpztFcmEqH2xwlW7ooBttyHE1rNCh67YIlM2r/2TmApxSZI
 v7QATxULeibVqYyN8FJ0L65ZOUtrujI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Tl660fxoNx-PeF0qVNjBeA-1; Mon, 21 Sep 2020 07:46:08 -0400
X-MC-Unique: Tl660fxoNx-PeF0qVNjBeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67EF281C478;
 Mon, 21 Sep 2020 11:46:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3153073688;
 Mon, 21 Sep 2020 11:46:03 +0000 (UTC)
Date: Mon, 21 Sep 2020 13:46:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/10] x86: fix cpu hotplug with secure boot
Message-ID: <20200921134601.55d12fdc@redhat.com>
In-Reply-To: <20200907112348.530921-1-imammedo@redhat.com>
References: <20200907112348.530921-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  7 Sep 2020 07:23:38 -0400
Igor Mammedov <imammedo@redhat.com> wrote:

> v5:
>   - fix hotplug on Windows when there is more than 256 possible CPUs
>     (Windows isn't able to handle VarPackage over 255 elements
>      so process CPUs in batches)
>   - fix off-by-one in package length (Laszlo)
>   - fix not selecting CPU before clearing insert event (Laszlo)
>   - use aml_lgreater() instead of aml_lnot(aml_equal(num_added_cpus, zero) (Laszlo)
>   - split 'x68: acpi: trigger SMI before sending hotplug Notify event to OSPM'
>     in samller chunks (Laszlo)
>   - fix comment to match spec (Laszlo)
>   - reorder aml_lor() and aml_land() in header (Laszlo)
> v4:
>   - fix 5.2 machine types so they won't apply pc_compat_5_1 (Laszlo)
> v3:
>   - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
>     so apply that before this patch
> v2:
>   - AML: clean is_inserted flag only after SMI callback
>   - make x-smi-cpu-hotunplug false by default
>   - massage error hint on not supported unplug
> v1:
>   - fix typos and some phrases (Laszlo)
>   - add unplug check (Laszlo)
>   - redo AML scan logic to avoid race when adding multiple CPUs

Michael,

just saw your pull request which missed this series.
Is there any plans to queue it for the next pull request?



> CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
> of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
> locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
> its own SMI handler and OVMF added initial CPU hotplug support.
> 
> This series is QEMU part of that support which lets QMVF tell QEMU that
> CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
> to prevent hotplug in case it's not supported and trigger SMI on hotplug when
> it's necessary.
> 
> Igor Mammedov (10):
>   x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
>   x86: cpuhp: prevent guest crash on CPU hotplug when broadcast SMI is
>     in use
>   x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
>   acpi: add aml_land() and aml_break() primitives
>   tests: acpi: mark to be changed tables in
>     bios-tables-test-allowed-diff
>   x86: ich9: expose "smi_negotiated_features" as a QOM property
>   x86: acpi: introduce AcpiPmInfo::smi_on_cpuhp
>   x86: acpi: introduce the PCI0.SMI0 ACPI device
>   x68: acpi: trigger SMI before sending hotplug Notify event to OSPM
>   tests: acpi: update acpi blobs with new AML
> 
>  include/hw/acpi/aml-build.h       |   2 +
>  include/hw/acpi/cpu.h             |   1 +
>  include/hw/i386/ich9.h            |   4 +
>  hw/acpi/aml-build.c               |  16 +++
>  hw/acpi/cpu.c                     | 156 ++++++++++++++++++++++++------
>  hw/acpi/ich9.c                    |  24 ++++-
>  hw/i386/acpi-build.c              |  35 ++++++-
>  hw/i386/pc.c                      |  15 ++-
>  hw/isa/lpc_ich9.c                 |  16 +++
>  tests/data/acpi/pc/DSDT           | Bin 4934 -> 5060 bytes
>  tests/data/acpi/pc/DSDT.acpihmat  | Bin 6258 -> 6385 bytes
>  tests/data/acpi/pc/DSDT.bridge    | Bin 6793 -> 6919 bytes
>  tests/data/acpi/pc/DSDT.cphp      | Bin 5397 -> 5524 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6587 -> 6714 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5006 -> 5132 bytes
>  tests/data/acpi/pc/DSDT.memhp     | Bin 6293 -> 6419 bytes
>  tests/data/acpi/pc/DSDT.numamem   | Bin 4940 -> 5066 bytes
>  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7804 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9129 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7821 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8268 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9458 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7879 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9163 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8934 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7810 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8409 bytes
>  27 files changed, 239 insertions(+), 30 deletions(-)
> 



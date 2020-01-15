Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF065C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C06E2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOmcBgFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C06E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56203 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irl2m-0000dT-TG
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKx-0000o9-O5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKv-0000PS-Pv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKv-0000Ng-Ik
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SYNha3X1HhMzztypPP7ZFvfrMyQgCZMN+0y5jbOdVU=;
 b=HOmcBgFuH54zJ+9ay2+quxsRpJlWEkB3yKDFQjk6c7Rw1RimkAU7gSyg0K6vMNtM3WZRk8
 2nbmG/RYSVI7g1HqtPHg0sDR9o9/3+61Mn00qJ2BRc9hnZaBWsJuajepnJlIMKYgSHLZW1
 LxKElmssHhPhH61kDr36JB+i8CNZxYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-gZgL6WPnOWKH43eLdsTxpA-1; Wed, 15 Jan 2020 10:11:57 -0500
X-MC-Unique: gZgL6WPnOWKH43eLdsTxpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70597109E3FA;
 Wed, 15 Jan 2020 15:11:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E56CB5D9C9;
 Wed, 15 Jan 2020 15:11:50 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:11:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v22 2/9] docs: APEI GHES generation and CPER record
 description
Message-ID: <20200115161149.19481a4a@redhat.com>
In-Reply-To: <1578483143-14905-3-git-send-email-gengdongjiu@huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-3-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 19:32:16 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> Add APEI/GHES detailed design document
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/specs/acpi_hest_ghes.rst | 110 ++++++++++++++++++++++++++++++++++++++++++
>  docs/specs/index.rst          |   1 +
>  2 files changed, 111 insertions(+)
>  create mode 100644 docs/specs/acpi_hest_ghes.rst
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> new file mode 100644
> index 0000000..7a1aa90
> --- /dev/null
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -0,0 +1,110 @@
> +APEI tables generating and CPER record
> +======================================
> +
> +..
> +   Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
> +
> +   This work is licensed under the terms of the GNU GPL, version 2 or later.
> +   See the COPYING file in the top-level directory.
> +
> +Design Details
> +--------------
> +
> +::
> +
> +         etc/acpi/tables                           etc/hardware_errors
> +      ====================                   ===============================
> +  + +--------------------------+            +----------------------------+
> +  | | HEST                     | +--------->|    error_block_address1    |------+
> +  | +--------------------------+ |          +----------------------------+      |
> +  | | GHES1                    | | +------->|    error_block_address2    |------+-+
> +  | +--------------------------+ | |        +----------------------------+      | |
> +  | | .................        | | |        |      ..............        |      | |
> +  | | error_status_address-----+-+ |        -----------------------------+      | |
> +  | | .................        |   |   +--->|    error_block_addressN    |------+-+---+
> +  | | read_ack_register--------+-+ |   |    +----------------------------+      | |   |
> +  | | read_ack_preserve        | +-+---+--->|     read_ack_register1     |      | |   |
> +  | | read_ack_write           |   |   |    +----------------------------+      | |   |
> +  + +--------------------------+   | +-+--->|     read_ack_register2     |      | |   |
> +  | | GHES2                    |   | | |    +----------------------------+      | |   |
> +  + +--------------------------+   | | |    |       .............        |      | |   |
> +  | | .................        |   | | |    +----------------------------+      | |   |
> +  | | error_status_address-----+---+ | | +->|     read_ack_registerN     |      | |   |
> +  | | .................        |     | | |  +----------------------------+      | |   |
> +  | | read_ack_register--------+-----+ | |  |Generic Error Status Block 1|<-----+ |   |
> +  | | read_ack_preserve        |       | |  |-+------------------------+-+        |   |
> +  | | read_ack_write           |       | |  | |          CPER          | |        |   |
> +  + +--------------------------|       | |  | |          CPER          | |        |   |
> +  | | ...............          |       | |  | |          ....          | |        |   |
> +  + +--------------------------+       | |  | |          CPER          | |        |   |
> +  | | GHESN                    |       | |  |-+------------------------+-|        |   |
> +  + +--------------------------+       | |  |Generic Error Status Block 2|<-------+   |
> +  | | .................        |       | |  |-+------------------------+-+            |
> +  | | error_status_address-----+-------+ |  | |           CPER         | |            |
> +  | | .................        |         |  | |           CPER         | |            |
> +  | | read_ack_register--------+---------+  | |           ....         | |            |
> +  | | read_ack_preserve        |            | |           CPER         | |            |
> +  | | read_ack_write           |            +-+------------------------+-+            |
> +  + +--------------------------+            |         ..........         |            |
> +                                            |----------------------------+            |
> +                                            |Generic Error Status Block N |<----------+
> +                                            |-+-------------------------+-+
> +                                            | |          CPER           | |
> +                                            | |          CPER           | |
> +                                            | |          ....           | |
> +                                            | |          CPER           | |
> +                                            +-+-------------------------+-+
> +
> +
> +(1) QEMU generates the ACPI HEST table. This table goes in the current
> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
> +    notification types.
> +
> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
> +    also needs to populate this blob. The "etc/hardware_errors" fw_cfg blob
> +    contains an address registers table and an Error Status Data Block table.
> +
> +(3) The address registers table contains N Error Block Address entries
> +    and N Read Ack Register entries. The size for each entry is 8-byte.
> +    The Error Status Data Block table contains N Error Status Data Block
> +    entries. The size for each entry is 4096(0x1000) bytes. The total size
> +    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
> +    N is the number of the kinds of hardware error sources.
> +
> +(4) QEMU generates the ACPI linker/loader script for the firmware. The
> +    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
> +    and copies blob contents there.
> +
> +(5) QEMU generates N ADD_POINTER commands, which patch addresses in the
> +    "error_status_address" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in the "etc/hardware_errors" blob.
> +
> +(6) QEMU generates N ADD_POINTER commands, which patch addresses in the
> +    "read_ack_register" fields of the HEST table with a pointer to the
> +    corresponding "read_ack_register" within the "etc/hardware_errors" blob.
> +
> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
> +    addresses in the "error_block_address" fields with a pointer to the
> +    respective "Error Status Data Block" in the "etc/hardware_errors" blob.
> +
> +(8) QEMU defines a third and write-only fw_cfg blob which is called
> +    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> +    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> +    for the firmware. The firmware will write back the start address of
> +    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +
> +(9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
> +    "Error Status Data Block", guest memory, and then injects platform specific
> +    interrupt (in case of arm/virt machine it's Synchronous External Abort) as a
> +    notification which is necessary for notifying the guest.
> +
> +(10) This notification (in virtual hardware) will be handled by the guest
> +     kernel, on receiving notification, guest APEI driver could read the CPER error
> +     and take appropriate action.
> +
> +(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> +     find out "Error Status Data Block" entry corresponding to error source. So supported
> +     source_id values should be assigned here and not be changed afterwards to make sure
> +     that guest will write error into expected "Error Status Data Block" even if guest was
> +     migrated to a newer QEMU.
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 984ba44..3019b9c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -13,3 +13,4 @@ Contents:
>     ppc-xive
>     ppc-spapr-xive
>     acpi_hw_reduced_hotplug
> +   acpi_hest_ghes



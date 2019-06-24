Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE98C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E449020674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNN5-0008RP-5n
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hfNJo-0006PF-6Z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hfNJm-0000rb-RI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:39:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hfNJh-0000h5-9t; Mon, 24 Jun 2019 07:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB4353082B46;
 Mon, 24 Jun 2019 11:39:19 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31715608D0;
 Mon, 24 Jun 2019 11:39:13 +0000 (UTC)
Date: Mon, 24 Jun 2019 13:39:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190624133908.635ff763@redhat.com>
In-Reply-To: <1557832703-42620-7-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-7-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 11:39:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 06/10] docs: APEI GHES generation and
 CPER record description
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 04:18:19 -0700
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> Add APEI/GHES detailed design document
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  docs/specs/acpi_hest_ghes.txt | 97 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 docs/specs/acpi_hest_ghes.txt
> 
> diff --git a/docs/specs/acpi_hest_ghes.txt b/docs/specs/acpi_hest_ghes.txt
> new file mode 100644
> index 0000000..fbfc787
> --- /dev/null
> +++ b/docs/specs/acpi_hest_ghes.txt
> @@ -0,0 +1,97 @@
> +APEI tables generating and CPER record
> +=============================
> +
> +Copyright (C) 2017 HuaWei Corporation.
> +
> +Design Details:
> +-------------------
> +
> +       etc/acpi/tables                                 etc/hardware_errors
> +    ====================                      ==========================================
> ++ +--------------------------+            +-----------------------+
> +| | HEST                     |            |    address            |            +--------------+
> +| +--------------------------+            |    registers          |            | Error Status |
> +| | GHES1                    |            | +---------------------+            | Data Block 1 |
> +| +--------------------------+ +--------->| |error_block_address1 |----------->| +------------+
> +| | .................        | |          | +---------------------+            | |  CPER      |
> +| | error_status_address-----+-+ +------->| |error_block_address2 |--------+   | |  CPER      |
> +| | .................        |   |        | +---------------------+        |   | |  ....      |
> +| | read_ack_register--------+-+ |        | |    ..............   |        |   | |  CPER      |
> +| | read_ack_preserve        | | |        +-----------------------+        |   | +------------+
> +| | read_ack_write           | | | +----->| |error_block_addressN |------+ |   | Error Status |
> ++ +--------------------------+ | | |      | +---------------------+      | |   | Data Block 2 |
> +| | GHES2                    | +-+-+----->| |read_ack_register1   |      | +-->| +------------+
> ++ +--------------------------+   | |      | +---------------------+      |     | |  CPER      |
> +| | .................        |   | | +--->| |read_ack_register2   |      |     | |  CPER      |
> +| | error_status_address-----+---+ | |    | +---------------------+      |     | |  ....      |
> +| | .................        |     | |    | |  .............      |      |     | |  CPER      |
> +| | read_ack_register--------+-----+-+    | +---------------------+      |     +-+------------+
> +| | read_ack_preserve        |     |   +->| |read_ack_registerN   |      |     | |..........  |
> +| | read_ack_write           |     |   |  | +---------------------+      |     | +------------+
> ++ +--------------------------|     |   |                                 |     | Error Status |
> +| | ...............          |     |   |                                 |     | Data Block N |
> ++ +--------------------------+     |   |                                 +---->| +------------+
> +| | GHESN                    |     |   |                                       | |  CPER      |
> ++ +--------------------------+     |   |                                       | |  CPER      |
> +| | .................        |     |   |                                       | |  ....      |
> +| | error_status_address-----+-----+   |                                       | |  CPER      |
> +| | .................        |         |                                       +-+------------+
> +| | read_ack_register--------+---------+
> +| | read_ack_preserve        |
> +| | read_ack_write           |
> ++ +--------------------------+
> +
> +(1) QEMU generates the ACPI HEST table. This table goes in the current
> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
> +    notification type.
> +
> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
> +    also need to populate this blob. The "etc/hardwre_errors" fw_cfg blob
> +    contains one address registers table and one Error Status Data Block

s/one/a/
in both cases

> +    table, all of which are pre-allocated.

drop /, all of which are pre-allocated./

> +
> +(3) The address registers table contains N Error Block Address entries
> +    and N Read Ack Address entries, the size for each entry is 8-byte.
> +    The Error Status Data Block table contains N Error Status Data Block
> +    entries, the size for each entry is 4096(0x1000) bytes. The total size
> +    for "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
where 'N' is specified?

> +
> +(4) QEMU generates the ACPI linker/loader script for the firmware
> +
> +(4a) The HEST table is part of "etc/acpi/tables", the firmware already
> +    allocates the memory for it, because QEMU already generates an ALLOCATE
> +    linker/loader command for it
> +
> +(4b) QEMU creates another ALLOCATE command for the "etc/hardware_errors"
> +    blob. The firmware allocates memory for this blob and downloads it.
may be merge both points, like:

    the firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
    and copies blobs content there.

> +
> +(5) QEMU generates N ADD_POINTER commands, which patch address in the
> +    "error_status_address" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in the downloaded "etc/hardware_errors"
> +    blob.

s/the downloaded//
the same applies to to other similar occurrences below

> +
> +(6) QEMU generates N ADD_POINTER commands, which patch address in the
> +    "read_ack_register" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in the downloaded "etc/hardware_errors" blob.
> +
> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
> +    address in the " error_block_address" fields with a pointer to the
> +    respective "Error Status Data Block" in the downloaded "etc/hardware_errors"
> +    blob.
> +
> +(8) QEMU Defines a third and write-only fw_cfg blob which is called
> +    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> +    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER commands
> +    for the firmware, the firmware will write back the start address of
> +    "etc/hardware_errors" blob to fw_cfg file "etc/hardware_errors_addr". 

> Then
> +    Qemu will know the Error Status Data Block for every error source. Each of
> +    Error Status Data Block has fixed size which is 4096(0x1000).

this probably is not necessary.

> +
> +(9) When QEMU gets SIGBUS from the kernel, QEMU formats the CPER right into
> +    guest memory, and then injects whatever interrupt (or assert whatever GPIO line)
> +    as a notification which is necessary for notifying the guest.
> +
> +(10) This notification (in virtual hardware) will be handled by guest kernel,
> +    guest APEI driver will read the CPER which is recorded by QEMU and do the
> +    recovery.



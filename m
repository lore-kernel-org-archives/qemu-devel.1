Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E6B20740
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCI5Ty86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E6B20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVYB8-0007UA-UU
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 04:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iVYAG-0006nb-80
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iVYAE-00065y-5K
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:45:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iVYAD-00064r-2a
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573811111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDa6afp9hueO2vBvDtK/Ls/QJ8tHZ/QehiNQvbDMUPw=;
 b=bCI5Ty86psHuPqpjr+ZIU9WNlBLEsmMfAdRkOOhF9QTLvVhbMSIJRIagkwlAQRql6kNFrt
 8rgu7GKS/TRPsnrizgtPlG+AIecwnlTBgd7bHjFEM/EeQPTCoRqHJqeNrInYaHukVvXIyD
 8Zta+sDauGgLoXtmMl/XEZmz/KxVTYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-bYq3-kLhNziTdAeIcPm87w-1; Fri, 15 Nov 2019 04:45:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D61DBAD;
 Fri, 15 Nov 2019 09:45:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82D431001DE1;
 Fri, 15 Nov 2019 09:45:00 +0000 (UTC)
Date: Fri, 15 Nov 2019 10:44:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [RESEND PATCH v21 2/6] docs: APEI GHES generation and CPER
 record description
Message-ID: <20191115104458.200a6231@redhat.com>
In-Reply-To: <20191111014048.21296-3-zhengxiang9@huawei.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-3-zhengxiang9@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bYq3-kLhNziTdAeIcPm87w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 09:40:44 +0800
Xiang Zheng <zhengxiang9@huawei.com> wrote:

> From: Dongjiu Geng <gengdongjiu@huawei.com>
>=20
> Add APEI/GHES detailed design document
>=20
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  docs/specs/acpi_hest_ghes.rst | 95 +++++++++++++++++++++++++++++++++++
>  docs/specs/index.rst          |  1 +
>  2 files changed, 96 insertions(+)
>  create mode 100644 docs/specs/acpi_hest_ghes.rst
>=20
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rs=
t
> new file mode 100644
> index 0000000000..348825f9d3
> --- /dev/null
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -0,0 +1,95 @@
> +APEI tables generating and CPER record
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +..
> +   Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
> +
> +   This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> +   See the COPYING file in the top-level directory.
> +
> +Design Details
> +--------------
> +
> +::
> +
> +         etc/acpi/tables                                 etc/hardware_er=
rors
> +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  + +--------------------------+            +-----------------------+
> +  | | HEST                     |            |    address            |   =
         +--------------+
> +  | +--------------------------+            |    registers          |   =
         | Error Status |
> +  | | GHES1                    |            | +---------------------+   =
         | Data Block 1 |
> +  | +--------------------------+ +--------->| |error_block_address1 |---=
-------->| +------------+
> +  | | .................        | |          | +---------------------+   =
         | |  CPER      |
> +  | | error_status_address-----+-+ +------->| |error_block_address2 |---=
-----+   | |  CPER      |
> +  | | .................        |   |        | +---------------------+   =
     |   | |  ....      |
> +  | | read_ack_register--------+-+ |        | |    ..............   |   =
     |   | |  CPER      |
> +  | | read_ack_preserve        | | |        +-----------------------+   =
     |   | +------------+
> +  | | read_ack_write           | | | +----->| |error_block_addressN |---=
---+ |   | Error Status |
> +  + +--------------------------+ | | |      | +---------------------+   =
   | |   | Data Block 2 |
> +  | | GHES2                    | +-+-+----->| |read_ack_register1   |   =
   | +-->| +------------+
> +  + +--------------------------+   | |      | +---------------------+   =
   |     | |  CPER      |
> +  | | .................        |   | | +--->| |read_ack_register2   |   =
   |     | |  CPER      |
> +  | | error_status_address-----+---+ | |    | +---------------------+   =
   |     | |  ....      |
> +  | | .................        |     | |    | |  .............      |   =
   |     | |  CPER      |
> +  | | read_ack_register--------+-----+-+    | +---------------------+   =
   |     +-+------------+
> +  | | read_ack_preserve        |     |   +->| |read_ack_registerN   |   =
   |     | |..........  |
> +  | | read_ack_write           |     |   |  | +---------------------+   =
   |     | +------------+
> +  + +--------------------------|     |   |                              =
   |     | Error Status |
> +  | | ...............          |     |   |                              =
   |     | Data Block N |
> +  + +--------------------------+     |   |                              =
   +---->| +------------+
> +  | | GHESN                    |     |   |                              =
         | |  CPER      |
> +  + +--------------------------+     |   |                              =
         | |  CPER      |
> +  | | .................        |     |   |                              =
         | |  ....      |
> +  | | error_status_address-----+-----+   |                              =
         | |  CPER      |
> +  | | .................        |         |                              =
         +-+------------+
> +  | | read_ack_register--------+---------+
> +  | | read_ack_preserve        |
> +  | | read_ack_write           |
> +  + +--------------------------+

I'd merge "Error Status Data Block" with "address registers", so it would b=
e
clear that "Error Status Data Block" is located after "read_ack_registerN"

> +
> +(1) QEMU generates the ACPI HEST table. This table goes in the current
> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
> +    notification types.
> +
> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
> +    also needs to populate this blob. The "etc/hardware_errors" fw_cfg b=
lob
> +    contains an address registers table and an Error Status Data Block t=
able.
> +
> +(3) The address registers table contains N Error Block Address entries
> +    and N Read Ack Register entries. The size for each entry is 8-byte.
> +    The Error Status Data Block table contains N Error Status Data Block
> +    entries. The size for each entry is 4096(0x1000) bytes. The total si=
ze
> +    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) =
bytes.
> +    N is the number of the kinds of hardware error sources.
> +
> +(4) QEMU generates the ACPI linker/loader script for the firmware. The
> +    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_e=
rrors"
> +    and copies blob contents there.
> +
> +(5) QEMU generates N ADD_POINTER commands, which patch addresses in the
> +    "error_status_address" fields of the HEST table with a pointer to th=
e
> +    corresponding "address registers" in the "etc/hardware_errors" blob.
> +
> +(6) QEMU generates N ADD_POINTER commands, which patch addresses in the
> +    "read_ack_register" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in the "etc/hardware_errors" blob.

s/"address registers" in/"read_ack_register" within/

> +
> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
> +    addresses in the "error_block_address" fields with a pointer to the
> +    respective "Error Status Data Block" in the "etc/hardware_errors" bl=
ob.
> +
> +(8) QEMU defines a third and write-only fw_cfg blob which is called
> +    "etc/hardware_errors_addr". Through that blob, the firmware can send=
 back
> +    the guest-side allocation addresses to QEMU. The "etc/hardware_error=
s_addr"
> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER =
command
> +    for the firmware. The firmware will write back the start address of
> +    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_a=
ddr".
> +

> +(9) When QEMU gets a SIGBUS from the kernel, QEMU formats the CPER right=
 into
> +    guest memory,=20

s/
QEMU formats the CPER right into guest memory
/
QEMU writes CPER into corresponding "Error Status Data Block"
/

> and then injects platform specific interrupt (in case of
> +    arm/virt machine it's Synchronous External Abort) as a notification =
which
> +    is necessary for notifying the guest.


> +
> +(10) This notification (in virtual hardware) will be handled by the gues=
t
> +     kernel, guest APEI driver will read the CPER which is recorded by Q=
EMU and
> +     do the recovery.
Maybe better would be to say:
"
On receiving notification, guest APEI driver cold read the CPER error
and take appropriate action
"


also in HEST patches there is implicit ABI, which probably should be docume=
nted here.
More specifically kvm_arch_on_sigbus_vcpu() error injection
uses source_id as index in "etc/hardware_errors" to find out "Error Status =
Data Block"
entry corresponding to error source. So supported source_id values should b=
e assigned
here and not be changed afterwards to make sure that guest will write error=
 into
expected "Error Status Data Block" even if guest was migrated to a newer QE=
MU.


> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 984ba44029..3019b9c976 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -13,3 +13,4 @@ Contents:
>     ppc-xive
>     ppc-spapr-xive
>     acpi_hw_reduced_hotplug
> +   acpi_hest_ghes



Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37981C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B63F2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B63F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwyr-0006BL-5X
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hNwxd-0005UD-Qp
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hNwxW-00063N-71
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hNwxV-00062D-Vx
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFEFE3082E24;
	Tue,  7 May 2019 10:04:23 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.184])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3972D60BEC;
	Tue,  7 May 2019 10:04:14 +0000 (UTC)
Date: Tue, 7 May 2019 12:04:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190507120408.32b49e99@Igors-MacBook-Pro>
In-Reply-To: <20190505012745.GD20071@richard>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-6-git-send-email-imammedo@redhat.com>
	<20190505012745.GD20071@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 10:04:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 05/15] tests: acpi: fetch X_DSDT if
 pointer to DSDT is 0
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?UTF-8?Q?Mathieu-Daud?= =?UTF-8?Q?=C3=A9?=
	<philmd@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linuxarm@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Gonglei <arei.gonglei@huawei.com>, xuwei5@hisilicon.com,
	xuwei5@huawei.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 May 2019 09:27:45 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, May 02, 2019 at 04:51:53PM +0200, Igor Mammedov wrote:
> >that way it would be possible to test a DSDT pointed by
> >64bit X_DSDT field in FADT.
> >
> >PS:
> >it will allow to enable testing arm/virt board, which sets
> >only newer X_DSDT field.
> >
> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >---
> >v4:
> > * dropping Reviewed-bys due to acpi_fetch_table() change
> >   introduced by earlier patch:
> >   "tests: acpi: make acpi_fetch_table() take size of fetched table poin=
ter"
> >v2:
> >  add 'val =3D le32_to_cpu(val)' even if it doesn't necessary
> >  it works as reminder that value copied from table is in
> >  little-endian format (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> >---
> > tests/bios-tables-test.c | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >
> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> >index a164d27..d165a1b 100644
> >--- a/tests/bios-tables-test.c
> >+++ b/tests/bios-tables-test.c
> >@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
> >     AcpiSdtTable table =3D g_array_index(data->tables, typeof(table), 0=
);
> >     uint8_t *fadt_aml =3D table.aml;
> >     uint32_t fadt_len =3D table.aml_len;
> >+    uint32_t val;
> >+    int dsdt_offset =3D 40 /* DSDT */;
> >+    int dsdt_entry_size =3D 4;
> >=20
> >     g_assert(compare_signature(&table, "FACP"));
> >=20
> >@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
> >                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", fals=
e);
> >     g_array_append_val(data->tables, table);
> >=20
> >+    memcpy(&val, fadt_aml + dsdt_offset, 4);
> >+    val =3D le32_to_cpu(val);
> >+    if (!val) {
> >+        dsdt_offset =3D 140 /* X_DSDT */;
>=20
> In case we can point out where we get it, e.g. ACPI 5, Table 5-34 FADT Fo=
rmat.
>=20
> This may be more helpful for reviewing and maintaining.

for fields we typically use only verbatim field name, so it would be easy
to find by searching for it in spec. In this case it is obvious about which
table it applies to, so reference to spec for a field probably excessive.

Complete reference necessary for tables and API functions that implement
ACPI primitive.

>=20
> Do you think so?
>=20
> >+        dsdt_entry_size =3D 8;
> >+    }
> >     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> >-                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
> >+                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", t=
rue);
> >     g_array_append_val(data->tables, table);
> >=20
> >     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
> >--=20
> >2.7.4
>=20



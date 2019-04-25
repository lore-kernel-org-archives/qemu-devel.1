Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3540C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BDF20811
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BDF20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJc0o-0004hv-SR
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 06:53:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJbyw-0003JP-OY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJblh-0001np-Pa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJblf-0001kp-QS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:38:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 457453003B45;
	Thu, 25 Apr 2019 10:38:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0638D600C5;
	Thu, 25 Apr 2019 10:38:07 +0000 (UTC)
Date: Thu, 25 Apr 2019 12:38:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425123803.00bbb86d@redhat.com>
In-Reply-To: <20190425073142.GA24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-4-git-send-email-imammedo@redhat.com>
	<20190425073142.GA24829@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 25 Apr 2019 10:38:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 03/13] tests: acpi: make pointer to RSDP
 64bit
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
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425103803.BGGl-yK8Y-Fss-dajWh6nGJlfZCs7FUmd4qSjYFTiYQ@z>

On Thu, 25 Apr 2019 15:31:42 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, Apr 25, 2019 at 07:34:39AM +0200, Igor Mammedov wrote:
> >In case of UEFI, RSDP doesn't have to be located in lowmem,
> >it could be placed at any address. Make sure that test won't
> >break if it is placed above the first 4Gb of address space.
> >
> >PS:
> >While at it cleanup some local variables as we don't really
> >need them.
> >
> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >---
> >v2:
> >  - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com=
>)
> >---
> > tests/bios-tables-test.c | 10 ++++------
> > 1 file changed, 4 insertions(+), 6 deletions(-)
> >
> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> >index 2ee044c..c29dcf4 100644
> >--- a/tests/bios-tables-test.c
> >+++ b/tests/bios-tables-test.c
> >@@ -26,7 +26,7 @@
> > typedef struct {
> >     const char *machine;
> >     const char *variant;
> >-    uint32_t rsdp_addr;
> >+    uint64_t rsdp_addr;
> >     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
> >     GArray *tables;
> >     uint32_t smbios_ep_addr;
> >@@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
> >=20
> > static void test_acpi_rsdp_table(test_data *data)
> > {
> >-    uint8_t *rsdp_table =3D data->rsdp_table, revision;
> >-    uint32_t addr =3D data->rsdp_addr;
> >+    uint8_t *rsdp_table =3D data->rsdp_table;
> >=20
> >-    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
> >-    revision =3D rsdp_table[15 /* Revision offset */];
> >+    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table); =20
>=20
> Ok, I think this is the reason you change the second parameter from uint3=
2_t
> to uint64_t in 1st patch.
>=20
> Maybe we need to move that on to this one?
Sure.
There is one additional path to make 64-bit table pointers support a bit mo=
re complete.
I'll respin series once travis build passes.

=20
> >=20
> >-    switch (revision) {
> >+    switch (rsdp_table[15 /* Revision offset */]) {
> >     case 0: /* ACPI 1.0 RSDP */
> >         /* With rev 1, checksum is only for the first 20 bytes */
> >         g_assert(!acpi_calc_checksum(rsdp_table,  20));
> >--=20
> >2.7.4 =20
>=20



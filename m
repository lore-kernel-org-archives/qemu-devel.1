Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578C1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A58206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A58206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXjX-0000OC-CZ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:56:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXij-0008VZ-7b
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXii-0007yo-4M
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXih-0007yO-TA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:56:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D5E92E95B1;
	Fri, 17 May 2019 07:55:42 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A3F2611D0;
	Fri, 17 May 2019 07:55:35 +0000 (UTC)
Date: Fri, 17 May 2019 09:55:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190517095528.45405c7e@Igors-MacBook-Pro>
In-Reply-To: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<1556808723-226478-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 17 May 2019 07:55:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 23/37] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?UTF-8?Q?Mathieu-Daud?= =?UTF-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 08:20:15 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: Igor Mammedov <imammedo@redhat.com>
>=20
> so name would reflect what the function does
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Michael,
My mail client doesn't do proper threading since something wrong with Messa=
ge-Ids in this pull req,

for example this patch in V4 I've posted has message id
  Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
and the same patch (modified with your SoB) here also has the same Message-=
Id
  Message-ID: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
which to me look broken=20


> ---
>  tests/acpi-utils.h       | 2 +-
>  tests/acpi-utils.c       | 2 +-
>  tests/bios-tables-test.c | 2 +-
>  tests/vmgenid-test.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index ef388bbf12..4cd5553586 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -47,7 +47,7 @@ typedef struct {
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
>  uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table);
> +void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index cc33b460ab..633d8f513d 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -63,7 +63,7 @@ uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
>      return le64_to_cpu(xsdt_physical_address);
>  }
> =20
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table)
> +void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table)
>  {
>      uint8_t revision;
> =20
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index a506dcbb29..6a678bf761 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
>      uint8_t *rsdp_table =3D data->rsdp_table, revision;
>      uint32_t addr =3D data->rsdp_addr;
> =20
> -    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
> +    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
>      revision =3D rsdp_table[15 /* Revision offset */];
> =20
>      switch (revision) {
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index ae38ee5ac0..f400184268 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>      g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
> =20
> =20
> -    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
> +    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
>      acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddres=
s */],
>                       "RSDT", true);
> =20



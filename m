Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB8FC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2998215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNLrWiw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2998215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5d1-0008Dj-52
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT5cK-0007lw-Rt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT5cG-0005xs-Mp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT5cG-0005xe-JX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573224719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSrtBdqsZCJ2ZmxXF7f1wcoDJ6RojzjaEd3a3FwYmtU=;
 b=CNLrWiw++FNcAo9Ai4Rn9ruO3OkDRMO7tCX1xMKzWVKt7NMn47PfnydJkrDrQOvqfdMaMb
 xMT80rWXaw/nLqSLnKsjlQwfOWfsM40nx91iMQiczTJVsyTpPvxsxAEnz4Lonncn0CjP+j
 YpvMWA5qLoLrToAhPqu6MRmdAr/foL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-gZQdrMsfPL-K4AS84LW-bA-1; Fri, 08 Nov 2019 09:51:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E6A1005500;
 Fri,  8 Nov 2019 14:51:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 420245D6AE;
 Fri,  8 Nov 2019 14:51:49 +0000 (UTC)
Date: Fri, 8 Nov 2019 15:51:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 12/12] tests/bios-tables-test: add test cases for
 ACPI HMAT
Message-ID: <20191108155147.7d64663b@redhat.com>
In-Reply-To: <20191107074511.14304-13-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-13-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gZQdrMsfPL-K4AS84LW-bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, Daniel Black <daniel@linux.ibm.com>,
 armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  7 Nov 2019 15:45:11 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
> Heterogeneous Memory with boot option '-numa node'.
>=20
> Add test cases on PC and Q35 machines with 2 numa nodes.
> Because HMAT is generated when system enable numa, the
> following tables need to be added for this test:
>     tests/data/acpi/pc/APIC.acpihmat
>     tests/data/acpi/pc/SRAT.acpihmat
>     tests/data/acpi/pc/HMAT.acpihmat
>     tests/data/acpi/pc/DSDT.acpihmat
>     tests/data/acpi/q35/APIC.acpihmat
>     tests/data/acpi/q35/SRAT.acpihmat
>     tests/data/acpi/q35/HMAT.acpihmat
>     tests/data/acpi/q35/DSDT.acpihmat

on top of this we need to check that configuring via
QAPI works as well.

Add an extra test as a separate patch on top,
building the same topology (so we could reuse the same reference tables)
using set-numa-node/--preconfig.

See pc_dynamic_cpu_cfg() and for example how to use set-numa-node
over QMP.

> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v15:
>     - Make tests without breaking CI (Michael)
>=20
> Changes in v13:
>     - Use decimal notation with appropriate suffix for cache size
> ---
>  tests/bios-tables-test-allowed-diff.h |  8 +++++
>  tests/bios-tables-test.c              | 44 +++++++++++++++++++++++++++
>  tests/data/acpi/pc/APIC.acpihmat      |  0
>  tests/data/acpi/pc/DSDT.acpihmat      |  0
>  tests/data/acpi/pc/HMAT.acpihmat      |  0
>  tests/data/acpi/pc/SRAT.acpihmat      |  0
>  tests/data/acpi/q35/APIC.acpihmat     |  0
>  tests/data/acpi/q35/DSDT.acpihmat     |  0
>  tests/data/acpi/q35/HMAT.acpihmat     |  0
>  tests/data/acpi/q35/SRAT.acpihmat     |  0
>  10 files changed, 52 insertions(+)
>  create mode 100644 tests/data/acpi/pc/APIC.acpihmat
>  create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat
>=20
> diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-te=
st-allowed-diff.h
> index dfb8523c8b..3c9e0c979b 100644
> --- a/tests/bios-tables-test-allowed-diff.h
> +++ b/tests/bios-tables-test-allowed-diff.h
> @@ -1 +1,9 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/pc/APIC.acpihmat",
> +"tests/data/acpi/pc/SRAT.acpihmat",
> +"tests/data/acpi/pc/HMAT.acpihmat",
> +"tests/data/acpi/pc/DSDT.acpihmat",
> +"tests/data/acpi/q35/APIC.acpihmat",
> +"tests/data/acpi/q35/SRAT.acpihmat",
> +"tests/data/acpi/q35/HMAT.acpihmat",
> +"tests/data/acpi/q35/DSDT.acpihmat",
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0b33fb265f..96803c1f20 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -947,6 +947,48 @@ static void test_acpi_virt_tcg_numamem(void)
> =20
>  }
> =20
> +static void test_acpi_tcg_acpi_hmat(const char *machine)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine =3D machine;
> +    data.variant =3D ".acpihmat";
> +    test_acpi_one(" -machine hmat=3Don"
> +                  " -smp 2,sockets=3D2"
> +                  " -m 128M,slots=3D2,maxmem=3D1G"
> +                  " -object memory-backend-ram,size=3D64M,id=3Dm0"
> +                  " -object memory-backend-ram,size=3D64M,id=3Dm1"
> +                  " -numa node,nodeid=3D0,memdev=3Dm0"
> +                  " -numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0"
> +                  " -numa cpu,node-id=3D0,socket-id=3D0"
> +                  " -numa cpu,node-id=3D0,socket-id=3D1"
> +                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-latency,latency=3D5ns"
> +                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-bandwidth,bandwidth=3D500M"
> +                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-latency,latency=3D10ns"
> +                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-bandwidth,bandwidth=3D100M"
> +                  " -numa hmat-cache,node-id=3D0,size=3D10K,level=3D1,as=
soc=3Ddirect,"
> +                  "policy=3Dwrite-back,line=3D8"
> +                  " -numa hmat-cache,node-id=3D1,size=3D10K,level=3D1,as=
soc=3Ddirect,"
> +                  "policy=3Dwrite-back,line=3D8",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
> +}
> +
> +static void test_acpi_piix4_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_PC);
> +}
> +
>  static void test_acpi_virt_tcg(void)
>  {
>      test_data data =3D {
> @@ -991,6 +1033,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_px=
m);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_h=
mat);
> +        qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat)=
;
>      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>          qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
> diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.a=
cpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.a=
cpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/pc/HMAT.a=
cpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/pc/SRAT.a=
cpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC=
.acpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT=
.acpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/q35/HMAT=
.acpihmat
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/q35/SRAT=
.acpihmat
> new file mode 100644
> index 0000000000..e69de29bb2



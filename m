Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3704C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70B520665
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70B520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOWZ-0006kV-13
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 22:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jingqi.liu@intel.com>) id 1hpOWO-0006MB-4U
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1hpOWM-0007Yg-Rp
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:57:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:23220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1hpOWM-0007Ud-Ij
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:57:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jul 2019 19:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; d="scan'208";a="367885877"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2019 19:57:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 19:57:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 21 Jul 2019 19:57:42 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 21 Jul 2019 19:57:41 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.109]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.240]) with mapi id 14.03.0439.000;
 Mon, 22 Jul 2019 10:57:40 +0800
From: "Liu, Jingqi" <jingqi.liu@intel.com>
To: "Xu, Tao3" <tao3.xu@intel.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Thread-Topic: [PATCH v7 11/11] tests/bios-tables-test: add test cases for
 ACPI HMAT
Thread-Index: AQHVO+ZsmeL8Onici0m+5OS9RveOEKbV+ADw
Date: Mon, 22 Jul 2019 02:57:39 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3529A87A9@SHSMSX103.ccr.corp.intel.com>
References: <20190716145121.19578-1-tao3.xu@intel.com>
 <20190716145121.19578-12-tao3.xu@intel.com>
In-Reply-To: <20190716145121.19578-12-tao3.xu@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDA0MmIyYTktN2ZhMS00NTE2LThhNzEtYTQxYWRmZGM2ODM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWlRWdEhCUTRlUGpETmhybzZJKzdBXC9rVUpEMHhReDVRS3d4VkpzYzRLUUVNUjV1UVVNYkFsXC9iVEZPTVdZalI2In0=
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v7 11/11] tests/bios-tables-test: add test
 cases for ACPI HMAT
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
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Xu, Tao3
> Sent: Tuesday, July 16, 2019 10:51 PM
> To: imammedo@redhat.com; eblake@redhat.com; ehabkost@redhat.com
> Cc: Xu, Tao3 <tao3.xu@intel.com>; Liu, Jingqi <jingqi.liu@intel.com>; Wil=
liams, Dan J <dan.j.williams@intel.com>;
> jonathan.cameron@huawei.com; Du, Fan <fan.du@intel.com>; qemu-devel@nongn=
u.org
> Subject: [PATCH v7 11/11] tests/bios-tables-test: add test cases for ACPI=
 HMAT
>=20
> ACPI table HMAT has been introduced, QEMU now builds HMAT tables for Hete=
rogeneous Memory with boot option '-numa node'.
>=20
> Add test cases on PC and Q35 machines with 2 numa nodes.
> Because HMAT is generated when system enable numa, the following tables n=
eed to be added for this test:
>   tests/acpi-test-data/pc/*.acpihmat
>   tests/acpi-test-data/pc/HMAT.*
>   tests/acpi-test-data/q35/*.acpihmat
>   tests/acpi-test-data/q35/HMAT.*
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
Looks good for me.

Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>

Thanks
Jingqi Liu
> ---
>=20
> No changes in v7.
> ---
>  tests/bios-tables-test.c | 43 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c index d8=
63233fe9..27a17921f2 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -860,6 +860,47 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>=20
> +static void test_acpi_tcg_acpi_hmat(const char *machine) {
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine =3D machine;
> +    data.variant =3D ".acpihmat";
> +    test_acpi_one(" -smp 2,sockets=3D2"
> +                  " -m 128M,slots=3D2,maxmem=3D1G"
> +                  " -object memory-backend-ram,size=3D64M,id=3Dm0"
> +                  " -object memory-backend-ram,size=3D64M,id=3Dm1"
> +                  " -numa node,nodeid=3D0,memdev=3Dm0"
> +                  " -numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0"
> +                  " -numa cpu,node-id=3D0,socket-id=3D0"
> +                  " -numa cpu,node-id=3D0,socket-id=3D1"
> +                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-latency,base-lat=3D10,latency=3D5"
> +                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-bandwidth,base-bw=3D20,bandwidth=
=3D5"
> +                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-latency,base-lat=3D10,latency=3D10=
"
> +                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dm=
emory,"
> +                  "data-type=3Daccess-bandwidth,base-bw=3D20,bandwidth=
=3D10"
> +                  " -numa hmat-cache,node-id=3D0,size=3D0x20000,total=3D=
1,level=3D1"
> +                  ",assoc=3Ddirect,policy=3Dwrite-back,line=3D8"
> +                  " -numa hmat-cache,node-id=3D1,size=3D0x20000,total=3D=
1,level=3D1"
> +                  ",assoc=3Ddirect,policy=3Dwrite-back,line=3D8",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_acpi_hmat(void) {
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
> @@ -904,6 +945,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_px=
m);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_h=
mat);
> +        qtest_add_func("acpi/q35/acpihmat",
> + test_acpi_q35_tcg_acpi_hmat);
>      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }
> --
> 2.20.1



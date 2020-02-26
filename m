Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F78C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F8820658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F8820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Qk-0005P1-NA
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j75Pk-0004pw-UY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j75Pj-0004q4-J7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:44:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j75Pg-0004aa-7r; Wed, 26 Feb 2020 17:44:20 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QMfnj7156416; Wed, 26 Feb 2020 17:44:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydh91mx2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 17:44:17 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01QMgRwT157720;
 Wed, 26 Feb 2020 17:44:16 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydh91mx2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 17:44:16 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01QMeYZE028220;
 Wed, 26 Feb 2020 22:44:15 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma05wdc.us.ibm.com with ESMTP id 2ydcmkrm0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 22:44:15 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QMiEZY48300340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 22:44:14 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE73728059;
 Wed, 26 Feb 2020 22:44:14 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8AD828058;
 Wed, 26 Feb 2020 22:44:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 22:44:14 +0000 (GMT)
Subject: Re: [PATCH v4 00/10] vTPM for aarch64
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226205942.11424-1-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <4fb16117-f9d3-61af-9198-931590a46e3d@linux.ibm.com>
Date: Wed, 26 Feb 2020 17:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200226205942.11424-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_09:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260135
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 01QMfnj7156416
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 3:59 PM, Eric Auger wrote:
> This series adds the capability to instantiate an MMIO TPM TIS
> in ARM virt. It is candidate to qemu 5.0.

I queued it now here:=20
https://github.com/stefanberger/qemu-tpm/commits/tpm-next

I will send the PR within a few days. Thanks!

Cheers,

 =C2=A0=C2=A0 Stefan



>
> The existing TPM TIS code is reshuffled into a generic part,
> the ISA device and the sysbus device. The sysbus TPM-TIS
> device gets dynamically instantiated in machvirt on the
> platform bus.
>
> ACPI boot is not yet supported on ARM. Note that the UEFI
> firmware is itself a consumer of the DT description, so we
> need the DT related changes regardless of whether the VM
> boots in DT or ACPI mode.
>
> Related qtests are reshuffled to allow the reuse of existing
> tests for both the ISA and the sysbus devices: Adaption
> consists in changing the qemu command line (change in the
> device name and provide explicit machine options) and adapt
> to the relocation of the TPM-TIS device in the memory map.
>
> The series was tested with the swtpm/libtpms emulator.
> Automatic guest LUKS volume unlocking (tpm2) was successful.
> EDK2 support is under development [3]. Thanks to Ard
> for supporting me when setting up the test environment.
>
> Best Regards
>
> Eric
>
> Testing:
>
> mkdir /tmp/tpm
> swtpm socket \
> --tpm2 \
> -t -d \
> --tpmstate dir=3D/tmp/tpm \
> --ctrl type=3Dunixio,path=3D/tmp/swtpm-sock
>
> qemu command line must be augmented with the following options:
>
> -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
> -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> -device tpm-tis-device,tpmdev=3Dtpm0 \
>
> References:
> [1] libtpms: https://github.com/stefanberger/libtpms/wiki
> [2] swtpm: https://github.com/stefanberger/swtpm/wiki
> [3] [PATCH v3 0/9] ArmVirtPkg: implement measured boot for ArmVirtQemu
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2.0-tpm-patch-v4
>
> History:
>
> v3 -> v4:
> - collect additional R-b's
> - add 'Not used but needed for linking' mention related to
>    tpm_tis_base_addr in CRB test files
> - fix comment style
>
> RFCv2 -> PATCH v3:
> - Updated the doc for ARM
> - Adapted existing tests for ARM
> - use qemu_fdt_setprop_string in add_tpm_tis_fdt_node
> - Collected R-b's
> - Comments not taken into account:
>    - I have kept the tpm-tis-device name for now despite Stefan's
>      suggestion to rename it into tpm-tis-sysbus. This is not
>      frozen though
>    - Common state still is not a QOM object (no double inheritence)
>
> RFC v1 -> RFC v2:
> - restructure the existing code with common, ISA and sysbus part.
> - both ARM and x86 integration were tested.
>
> Eric Auger (10):
>    tpm: rename TPM_TIS into TPM_TIS_ISA
>    tpm: Use TPMState as a common struct
>    tpm: Separate tpm_tis common functions from isa code
>    tpm: Separate TPM_TIS and TPM_TIS_ISA configs
>    tpm: Add the SysBus TPM TIS device
>    hw/arm/virt: vTPM support
>    docs/specs/tpm: Document TPM_TIS sysbus device for ARM
>    test: tpm: pass optional machine options to swtpm test functions
>    test: tpm-tis: Get prepared to share tests between ISA and sysbus
>      devices
>    test: tpm-tis: Add Sysbus TPM-TIS device test
>
>   default-configs/i386-softmmu.mak        |   2 +-
>   docs/specs/tpm.rst                      |  25 +-
>   hw/arm/Kconfig                          |   1 +
>   hw/arm/sysbus-fdt.c                     |  33 ++
>   hw/arm/virt.c                           |   7 +
>   hw/i386/Kconfig                         |   2 +-
>   hw/i386/acpi-build.c                    |   6 +-
>   hw/tpm/Kconfig                          |  12 +-
>   hw/tpm/Makefile.objs                    |   4 +-
>   hw/tpm/tpm_tis.h                        |  91 +++++
>   hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c}  | 181 +---------
>   hw/tpm/tpm_tis_isa.c                    | 170 +++++++++
>   hw/tpm/tpm_tis_sysbus.c                 | 159 +++++++++
>   include/sysemu/tpm.h                    |   7 +-
>   tests/qtest/Makefile.include            |  11 +-
>   tests/qtest/tpm-crb-swtpm-test.c        |   9 +-
>   tests/qtest/tpm-crb-test.c              |   3 +
>   tests/qtest/tpm-tests.c                 |  10 +-
>   tests/qtest/tpm-tests.h                 |   5 +-
>   tests/qtest/tpm-tis-device-swtpm-test.c |  76 ++++
>   tests/qtest/tpm-tis-device-test.c       |  87 +++++
>   tests/qtest/tpm-tis-swtpm-test.c        |   8 +-
>   tests/qtest/tpm-tis-test.c              | 414 +---------------------
>   tests/qtest/tpm-tis-util.c              | 451 +++++++++++++++++++++++=
+
>   tests/qtest/tpm-tis-util.h              |  23 ++
>   tests/qtest/tpm-util.c                  |  11 +-
>   tests/qtest/tpm-util.h                  |   8 +-
>   27 files changed, 1207 insertions(+), 609 deletions(-)
>   create mode 100644 hw/tpm/tpm_tis.h
>   rename hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c} (85%)
>   create mode 100644 hw/tpm/tpm_tis_isa.c
>   create mode 100644 hw/tpm/tpm_tis_sysbus.c
>   create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
>   create mode 100644 tests/qtest/tpm-tis-device-test.c
>   create mode 100644 tests/qtest/tpm-tis-util.c
>   create mode 100644 tests/qtest/tpm-tis-util.h
>



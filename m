Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E05C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6402467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ2UcUEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6402467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7EDl-0005Do-5J
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7ED1-0004bK-TW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7ED0-0007v4-AW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:07:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7ED0-0007rv-0r
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582790869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eh83z+x7FB680JA+sgDAemVOr6VRkcy0TRvAYAJT2+E=;
 b=HQ2UcUEPh9vlKVjiE0TPOwmY+iu3x0iaqasI108Mb7mEwpjxKLKRq7lVKiiYl2oRSqwfgw
 7Lbukwu41weqjdombFZ8oVxWwhq6EhehGINACGMBRlBLVwFJfGmYRi3DoeoMiaTkWiuXQq
 nCkIU7bIDwbdpIDZGH/oSbbvJUY9JKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Ic0sM6vnN26btg92kkujOA-1; Thu, 27 Feb 2020 03:07:46 -0500
X-MC-Unique: Ic0sM6vnN26btg92kkujOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E87F1005516;
 Thu, 27 Feb 2020 08:07:45 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5904277945;
 Thu, 27 Feb 2020 08:07:40 +0000 (UTC)
Subject: Re: [PATCH v4 00/10] vTPM for aarch64
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226205942.11424-1-eric.auger@redhat.com>
 <4fb16117-f9d3-61af-9198-931590a46e3d@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ee98e8ab-06df-e422-1ca5-f3f6a48145f2@redhat.com>
Date: Thu, 27 Feb 2020 09:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4fb16117-f9d3-61af-9198-931590a46e3d@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,
On 2/26/20 11:44 PM, Stefan Berger wrote:
> On 2/26/20 3:59 PM, Eric Auger wrote:
>> This series adds the capability to instantiate an MMIO TPM TIS
>> in ARM virt. It is candidate to qemu 5.0.
>=20
> I queued it now here:
> https://github.com/stefanberger/qemu-tpm/commits/tpm-next
>=20
> I will send the PR within a few days. Thanks!
Thank you. I will just ping Peter to make sure he has no comments on

[PATCH v4 06/10] hw/arm/virt: vTPM support

Eric

>=20
> Cheers,
>=20
> =C2=A0=C2=A0 Stefan
>=20
>=20
>=20
>>
>> The existing TPM TIS code is reshuffled into a generic part,
>> the ISA device and the sysbus device. The sysbus TPM-TIS
>> device gets dynamically instantiated in machvirt on the
>> platform bus.
>>
>> ACPI boot is not yet supported on ARM. Note that the UEFI
>> firmware is itself a consumer of the DT description, so we
>> need the DT related changes regardless of whether the VM
>> boots in DT or ACPI mode.
>>
>> Related qtests are reshuffled to allow the reuse of existing
>> tests for both the ISA and the sysbus devices: Adaption
>> consists in changing the qemu command line (change in the
>> device name and provide explicit machine options) and adapt
>> to the relocation of the TPM-TIS device in the memory map.
>>
>> The series was tested with the swtpm/libtpms emulator.
>> Automatic guest LUKS volume unlocking (tpm2) was successful.
>> EDK2 support is under development [3]. Thanks to Ard
>> for supporting me when setting up the test environment.
>>
>> Best Regards
>>
>> Eric
>>
>> Testing:
>>
>> mkdir /tmp/tpm
>> swtpm socket \
>> --tpm2 \
>> -t -d \
>> --tpmstate dir=3D/tmp/tpm \
>> --ctrl type=3Dunixio,path=3D/tmp/swtpm-sock
>>
>> qemu command line must be augmented with the following options:
>>
>> -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
>> -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>> -device tpm-tis-device,tpmdev=3Dtpm0 \
>>
>> References:
>> [1] libtpms: https://github.com/stefanberger/libtpms/wiki
>> [2] swtpm: https://github.com/stefanberger/swtpm/wiki
>> [3] [PATCH v3 0/9] ArmVirtPkg: implement measured boot for ArmVirtQemu
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v4.2.0-tpm-patch-v4
>>
>> History:
>>
>> v3 -> v4:
>> - collect additional R-b's
>> - add 'Not used but needed for linking' mention related to
>> =C2=A0=C2=A0 tpm_tis_base_addr in CRB test files
>> - fix comment style
>>
>> RFCv2 -> PATCH v3:
>> - Updated the doc for ARM
>> - Adapted existing tests for ARM
>> - use qemu_fdt_setprop_string in add_tpm_tis_fdt_node
>> - Collected R-b's
>> - Comments not taken into account:
>> =C2=A0=C2=A0 - I have kept the tpm-tis-device name for now despite Stefa=
n's
>> =C2=A0=C2=A0=C2=A0=C2=A0 suggestion to rename it into tpm-tis-sysbus. Th=
is is not
>> =C2=A0=C2=A0=C2=A0=C2=A0 frozen though
>> =C2=A0=C2=A0 - Common state still is not a QOM object (no double inherit=
ence)
>>
>> RFC v1 -> RFC v2:
>> - restructure the existing code with common, ISA and sysbus part.
>> - both ARM and x86 integration were tested.
>>
>> Eric Auger (10):
>> =C2=A0=C2=A0 tpm: rename TPM_TIS into TPM_TIS_ISA
>> =C2=A0=C2=A0 tpm: Use TPMState as a common struct
>> =C2=A0=C2=A0 tpm: Separate tpm_tis common functions from isa code
>> =C2=A0=C2=A0 tpm: Separate TPM_TIS and TPM_TIS_ISA configs
>> =C2=A0=C2=A0 tpm: Add the SysBus TPM TIS device
>> =C2=A0=C2=A0 hw/arm/virt: vTPM support
>> =C2=A0=C2=A0 docs/specs/tpm: Document TPM_TIS sysbus device for ARM
>> =C2=A0=C2=A0 test: tpm: pass optional machine options to swtpm test func=
tions
>> =C2=A0=C2=A0 test: tpm-tis: Get prepared to share tests between ISA and =
sysbus
>> =C2=A0=C2=A0=C2=A0=C2=A0 devices
>> =C2=A0=C2=A0 test: tpm-tis: Add Sysbus TPM-TIS device test
>>
>> =C2=A0 default-configs/i386-softmmu.mak=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 docs/specs/tpm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 25 +-
>> =C2=A0 hw/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/arm/sysbus-fdt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 33 ++
>> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 hw/i386/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 hw/i386/acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +-
>> =C2=A0 hw/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
>> =C2=A0 hw/tpm/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 4 +-
>> =C2=A0 hw/tpm/tpm_tis.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 91 +++++
>> =C2=A0 hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c}=C2=A0 | 181 +---------
>> =C2=A0 hw/tpm/tpm_tis_isa.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 170=
 +++++++++
>> =C2=A0 hw/tpm/tpm_tis_sysbus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 159 +++++++++
>> =C2=A0 include/sysemu/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 7 +-
>> =C2=A0 tests/qtest/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
>> =C2=A0 tests/qtest/tpm-crb-swtpm-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>> =C2=A0 tests/qtest/tpm-crb-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 tests/qtest/tpm-tests.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
>> =C2=A0 tests/qtest/tpm-tests.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>> =C2=A0 tests/qtest/tpm-tis-device-swtpm-test.c |=C2=A0 76 ++++
>> =C2=A0 tests/qtest/tpm-tis-device-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 87 +++++
>> =C2=A0 tests/qtest/tpm-tis-swtpm-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 tests/qtest/tpm-tis-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 414 +---------------------
>> =C2=A0 tests/qtest/tpm-tis-util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 451 ++++++++++++++++++++++++
>> =C2=A0 tests/qtest/tpm-tis-util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 ++
>> =C2=A0 tests/qtest/tpm-util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
>> =C2=A0 tests/qtest/tpm-util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
8 +-
>> =C2=A0 27 files changed, 1207 insertions(+), 609 deletions(-)
>> =C2=A0 create mode 100644 hw/tpm/tpm_tis.h
>> =C2=A0 rename hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c} (85%)
>> =C2=A0 create mode 100644 hw/tpm/tpm_tis_isa.c
>> =C2=A0 create mode 100644 hw/tpm/tpm_tis_sysbus.c
>> =C2=A0 create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
>> =C2=A0 create mode 100644 tests/qtest/tpm-tis-device-test.c
>> =C2=A0 create mode 100644 tests/qtest/tpm-tis-util.c
>> =C2=A0 create mode 100644 tests/qtest/tpm-tis-util.h
>>
>=20
>=20



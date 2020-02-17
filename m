Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1CC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D1520836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eglR9sK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D1520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3l2I-0007EO-MZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j3kjv-0005Ys-1i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j3kjo-0003HF-Ka
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:03:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j3kjo-0003FH-BR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581962599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9ngcppJO7ov5HiqA1mh1h+B/0HM30e5mwQuPsa6ex8=;
 b=eglR9sK1ixz0PzejB2lpEHaCKWoqLtfXXuS5U4o7sCfFAQvs+4HLISkaX7OGbmgmiFYula
 XNLvtzqakiZy6FWSzuk55xs9vtTRWbosa6tm/nv6tKPiIjV3j5Il6B5UJECCEoBp0V3rU/
 iV2Oga3gn+10peW6lN9Gf8Ll5rQ/ojE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-LLbJsLGcMBGR24nYUoS-VQ-1; Mon, 17 Feb 2020 13:03:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CCBD800D50;
 Mon, 17 Feb 2020 18:03:15 +0000 (UTC)
Received: from [10.36.116.239] (ovpn-116-239.ams2.redhat.com [10.36.116.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 169025C3FA;
 Mon, 17 Feb 2020 18:03:07 +0000 (UTC)
Subject: Re: [RFC v2 0/6] vTPM for aarch64
To: Ard Biesheuvel <ardb@kernel.org>
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <CAKv+Gu_JsLdLV2JWCoFaw=3MR4DPKxOzE1mv-0h0nUikoGmZ7w@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f50fb895-049f-3787-e1f9-7d5e9bf1013a@redhat.com>
Date: Mon, 17 Feb 2020 19:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_JsLdLV2JWCoFaw=3MR4DPKxOzE1mv-0h0nUikoGmZ7w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LLbJsLGcMBGR24nYUoS-VQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ard,

On 2/16/20 5:35 PM, Ard Biesheuvel wrote:
> On Fri, 14 Feb 2020 at 19:37, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> This series adds the capability to instantiate an MMIO TPM TIS
>> in ARM virt.
>>
>> The existing TPM TIS code is reshuffled into a generic part,
>> the ISA device and the sysbus device. The last patch allows
>> the instantiation of the TPM TIS sysbus device in ARM virt.
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
>> --tpmstate dir=/tmp/tpm \
>> --ctrl type=unixio,path=/tmp/swtpm-sock
>>
>> qemu command line must be augmented with the following options:
>>
>> -chardev socket,id=chrtpm,path=/tmp/swtpm-sock \
>> -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> -device tpm-tis-device,tpmdev=tpm0 \
>>
>> References:
>> [1] libtpms: https://github.com/stefanberger/libtpms/wiki
>> [2] swtpm: https://github.com/stefanberger/swtpm/wiki
>> [3] [PATCH 0/4] ArmVirtPkg: implement measured boot for ArmVirtQemu
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v4.2.0-tpm-rfc-v2
>>
>> History:
>>
>> RFC v1 -> RFC v2:
>> - restructure the existing code with common, ISA and sysbus part.
>> - both ARM and x86 integration were tested.
>> - acknowledgement: migration has not been tested
>>
>> Eric Auger (6):
>>   tpm: rename TPM_TIS into TPM_TIS_ISA
>>   tpm: Use TPMState as a common struct
>>   tpm: Separate tpm_tis common functions from isa code
>>   tpm: Separate TPM_TIS and TPM_TIS_ISA configs
>>   tpm: Add the SysBus TPM TIS device
>>   hw/arm/virt: vTPM support
>>
> 
> Many thanks to Eric for his work on this.
> 
> I have tested this with my EDK2 code and a Linux/arm64 VM booting in
> DT mode with the tpm-tis driver enabled, and it works as expected. I
> can observe the firmware taking measurements during boot, and can dump
> the PCRs from Linux using tpm2_pcrlist.
> 
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Many thanks for the testing.
> 
> Note that the UEFI firmware is itself a consumer of the DT
> description, so we need the DT related changes regardless of whether
> the VM boots in DT or ACPI mode.

OK thank you for the note. I will add this in my cover letter.

Best Regards

Eric
> 
> 
> 
>>  default-configs/i386-softmmu.mak       |   2 +-
>>  hw/arm/Kconfig                         |   1 +
>>  hw/arm/sysbus-fdt.c                    |  36 +++++
>>  hw/arm/virt.c                          |   7 +
>>  hw/i386/Kconfig                        |   2 +-
>>  hw/i386/acpi-build.c                   |   6 +-
>>  hw/tpm/Kconfig                         |  12 +-
>>  hw/tpm/Makefile.objs                   |   4 +-
>>  hw/tpm/tpm_tis.h                       |  91 +++++++++++++
>>  hw/tpm/{tpm_tis.c => tpm_tis_common.c} | 181 ++-----------------------
>>  hw/tpm/tpm_tis_isa.c                   | 170 +++++++++++++++++++++++
>>  hw/tpm/tpm_tis_sysbus.c                | 159 ++++++++++++++++++++++
>>  include/sysemu/tpm.h                   |   7 +-
>>  tests/qtest/Makefile.include           |   4 +-
>>  14 files changed, 502 insertions(+), 180 deletions(-)
>>  create mode 100644 hw/tpm/tpm_tis.h
>>  rename hw/tpm/{tpm_tis.c => tpm_tis_common.c} (85%)
>>  create mode 100644 hw/tpm/tpm_tis_isa.c
>>  create mode 100644 hw/tpm/tpm_tis_sysbus.c
>>
>> --
>> 2.20.1
>>
> 



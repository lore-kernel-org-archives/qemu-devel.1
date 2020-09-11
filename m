Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C83C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6C421D81
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3ACM9ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6C421D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdFV-00017A-KZ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGdEx-0000Vd-0B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGdEt-0007t2-UJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599808373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZqhjSNA5L+3O+HAR/Kwnv1E+OO31igPxoKS3tnjmVw=;
 b=G3ACM9jikOm5CJ9EsR5br7+pco31rJIdQUjWseAGomNJKkc/fv9KjLhTLRj3MHNkWUwSkc
 j0E27wUwBPZ1HyRqero/zihOGYmPBd2lMdInQlbOwweR6c4lijYXgiz6jpUSYEUcBJBKBc
 KwmQUy1BGRoPE3WtLhulafhLHfTH2C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-HmU04_tiPD2VjHzY3j7Ddw-1; Fri, 11 Sep 2020 03:12:49 -0400
X-MC-Unique: HmU04_tiPD2VjHzY3j7Ddw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6080818B9F09
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:12:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-52.ams2.redhat.com
 [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8F781C4B;
 Fri, 11 Sep 2020 07:12:44 +0000 (UTC)
Subject: Re: [PATCH 00/10] edk2: adopt the edk2-stable202008 release
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <94ffbf3f-6168-052a-7a47-d19112ecacc8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <aa18cc4a-9b18-5bb6-19b3-d13539a480d6@redhat.com>
Date: Fri, 11 Sep 2020 09:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <94ffbf3f-6168-052a-7a47-d19112ecacc8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:12:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 21:31, Philippe Mathieu-Daudé wrote:
> On 9/8/20 9:29 AM, Laszlo Ersek wrote:
>> Ref:    https://bugs.launchpad.net/qemu/+bug/1852196
>> Repo:   https://github.com/lersek/qemu.git
>> Branch: edk2stable202008_lp_1852196
>>
>> This series consumes the following upstream edk2 releases:
>>
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202008
>>
>> Worth mentioning (in random order):
>>
>> - various CVE fixes (see shortlog)
>> - OpenSSL-1.1.1g
>> - UEFI HTTPS Boot for ARM/AARCH64
>> - TPM2 for ARM/AARCH64
>> - VCPU hotplug with SMI
>> - support for Linux v5.7+ initrd and mixed mode loading
>> - Fusion-MPT SCSI driver in OVMF
>> - VMware PVSCSI driver in OVMF
>> - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
>> - SEV-ES support
>>
>> The IA32 and X64 binaries are now smaller -- the reason is that I buit
>> them with DevToolSet 9 (gcc-9) on RHEL7, and so this is the first time
>> they've undergone LTO (with the GCC5 edk2 toolchain settings).
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Thanks,
>> Laszlo
>>
>> Laszlo Ersek (10):
>>   Makefile: remove obsolete edk2 exception from "clean" rule
>>   roms/efirom, tests/uefi-test-tools: update edk2's own submodules first
>>   roms/Makefile.edk2: prepare for replacing TPM2*_ENABLE macros
>>   tests: acpi: tolerate "virt/SSDT.memhp" mismatch temporarily
>>   roms/edk2: update submodule from edk2-stable201905 to
>>     edk2-stable202008
>>   roms/Makefile.edk2: complete replacing TPM2*_ENABLE macros
>>   roms/Makefile.edk2: enable new ARM/AARCH64 flags up to
>>     edk2-stable202008
>>   pc-bios: refresh edk2 build artifacts for edk2-stable202008
>>   pc-bios: update the README file with edk2-stable202008 information
>>   tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008
>>
>>  Makefile                               |   1 -
>>  pc-bios/README                         |   4 +--
>>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1178070 -> 1507722 bytes
>>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1172752 -> 1503187 bytes
>>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1736199 -> 1646741 bytes
>>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1943949 -> 1860546 bytes
>>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1717094 -> 1680164 bytes
>>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1958037 -> 1912112 bytes
>>  roms/Makefile                          |   1 +
>>  roms/Makefile.edk2                     |  26 ++++++++++++--------
>>  roms/edk2                              |   2 +-
>>  tests/data/acpi/virt/SSDT.memhp        | Bin 736 -> 736 bytes
>>  tests/uefi-test-tools/Makefile         |   1 +
>>  13 files changed, 21 insertions(+), 14 deletions(-)
> 
> Series:
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> And applied to the edk2-next tree.
> 
> Thanks,
> 
> Phil.
> 

Thank you Phil!
Laszlo



Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE90A2098B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw/TN1dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE90A2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCehH-0007iq-Pf
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCegW-0006yw-MJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:57:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCegU-0002AE-Sr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598860617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAzgSbxuFP4NURZ6lzRE9DkiZN9DW7hBDzXGiX223XI=;
 b=fw/TN1dg/nGjKPpsWUxY1RwKQzB8XPYbUe27Cptc1K0hWlX34SpFxyxMb8YnMtn2JzoJ7p
 wKrHQjr/+XdcsCIREFPbggYyzJxaTtSTfutpRlosSkC5NDVMSpeRKGA8pnGEX70Hho6uvO
 KMoHPuJoqg9WVsF268FjgGsO12aSxN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-2jOygiOyOeeAmxmQZGrfkw-1; Mon, 31 Aug 2020 03:56:52 -0400
X-MC-Unique: 2jOygiOyOeeAmxmQZGrfkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D01189E621;
 Mon, 31 Aug 2020 07:56:51 +0000 (UTC)
Received: from [10.36.112.112] (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F1365C225;
 Mon, 31 Aug 2020 07:56:49 +0000 (UTC)
Subject: Re: [PATCH 0/7] target/arm: Add vSPE support to KVM guest
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <070de656-5550-62b7-faf9-8c4beec56531@redhat.com>
Date: Mon, 31 Aug 2020 09:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1596768588.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:56:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.207, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Murray <andrew.murray@arm.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Haibo,

On 8/7/20 10:10 AM, Haibo Xu wrote:
> This series add support for SPE(Statistical Profiling Extension)[1]
> in KVM guest. It's based on Andrew Murray's kernel KVM patches V2[2],
> and has been tested to ensure that guest can use SPE with valid data.
> E.g.
> 
> In host:
> $ ./qemu-system-aarch64 \
>         -cpu host -M virt,accel=kvm,gic-version=3 -nographic -m 2048M \
>         -kernel ./Image-new \
>         -initrd /boot/initrd.img-5.6.0-rc2+ \
>         -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>         -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>         -device virtio-blk-device,drive=hd0  \
> 
> In guest:
> $ perf record -e arm_spe/ts_enable=1,pa_enable=1,pct_enable=1/ \
>         dd if=/dev/zero of=/dev/null count=1000
> $ perf report --dump-raw-trace > spe_buf.txt
> 
> The spe_buf.txt should contain similar data as below:
> 
> . ... ARM SPE data: size 135944 bytes
> .  00000000:  b0 f4 d3 29 10 00 80 ff a0                      PC 0xff80001029d3f4 el1 ns=1
> .  00000009:  99 0b 00                                        LAT 11 ISSUE
> .  0000000c:  98 0d 00                                        LAT 13 TOT
> .  0000000f:  52 16 00                                        EV RETIRED L1D-ACCESS TLB-ACCESS
> .  00000012:  49 00                                           LD
> .  00000014:  b2 d0 40 d8 70 00 00 ff 00                      VA 0xff000070d840d0
> .  0000001d:  9a 01 00                                        LAT 1 XLAT
> .  00000020:  00 00 00                                        PAD
> .  00000023:  71 a5 1f b3 20 14 00 00 00                      TS 86447955877
> .  0000002c:  b0 7c f9 29 10 00 80 ff a0                      PC 0xff80001029f97c el1 ns=1
> .  00000035:  99 02 00                                        LAT 2 ISSUE
> .  00000038:  98 03 00                                        LAT 3 TOT
> .  0000003b:  52 02 00                                        EV RETIRED
> .  0000003e:  48 00                                           INSN-OTHER
> .  00000040:  00 00 00                                        PAD
> .  00000043:  71 ef 1f b3 20 14 00 00 00                      TS 86447955951
> .  0000004c:  b0 f0 e9 29 10 00 80 ff a0                      PC 0xff80001029e9f0 el1 ns=1
> .  00000055:  99 02 00                                        LAT 2 ISSUE
> .  00000058:  98 03 00                                        LAT 3 TOT
> .  0000005b:  52 02 00                                        EV RETIRED
> 
> If you want to disable the vSPE support, you can use the 'spe=off' cpu
> property:
> 
> ./qemu-system-aarch64 \
>         -cpu host,spe=off -M virt,accel=kvm,gic-version=3 -nographic -m 2048M \
>         -kernel ./Image-new \
>         -initrd /boot/initrd.img-5.6.0-rc2+ \
>         -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>         -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>         -device virtio-blk-device,drive=hd0  \
> 
> Note:
> (1) Since the kernel patches are still under review, some of the macros
>     in the header files may be changed after merging. We may need to
>     update them accordingly.
to be more explicit one needs to replace on the kernel 5.5-rc2 based series

-#define KVM_CAP_ARM_SPE_V1 179
+#define KVM_CAP_ARM_SPE_V1 184

I got misleaded ;-)

+ Andrew in CC as he contributed the kernel part.

For information, I have been working on a kvm unit test series for
testing SPE. I will send an RFC, most probably this week. At the moment
I still face some weirdness such as some unexpected Service state in the
syndrome register. Anyway I will share the existing code so that we can
discuss the issues.

Are there any plans to respin the kernel series

Thanks

Eric

> (2) These patches only add vSPE support in KVM mode, for TCG mode, I'm
>     not sure whether we need to support it.
> (3) Just followed the 'pmu' property, we only allow this feature to be
>     removed from CPUs which enable it by default. But since the SPE is
>     an optional feature extension for Armv8.2, I think a better way may
>     be to disable it by default, and only enable it when the host cpu
>     do have the feature.
> 
> [1]https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/
>    posts/statistical-profiling-extension-for-armv8-a
> [2]https://www.spinics.net/lists/arm-kernel/msg776228.html
> 
> Haibo Xu (7):
>   update Linux headers with new vSPE macros
>   target/arm/kvm: spe: Add helper to detect SPE when using KVM
>   target/arm/cpu: spe: Add an option to turn on/off vSPE support
>   target/arm/kvm: spe: Unify device attr operatioin helper
>   target/arm/kvm: spe: Add device init and set_irq operations
>   hw/arm/virt: spe: Add SPE fdt binding for virt machine
>   target/arm/cpu: spe: Enable spe to work with host cpu
> 
>  hw/arm/virt-acpi-build.c      |  3 +++
>  hw/arm/virt.c                 | 42 ++++++++++++++++++++++++++++++
>  include/hw/acpi/acpi-defs.h   |  1 +
>  include/hw/arm/virt.h         |  1 +
>  linux-headers/asm-arm64/kvm.h |  4 +++
>  linux-headers/linux/kvm.h     |  2 ++
>  target/arm/cpu.c              | 34 +++++++++++++++++++++++++
>  target/arm/cpu.h              |  5 ++++
>  target/arm/kvm.c              | 11 ++++++++
>  target/arm/kvm64.c            | 48 ++++++++++++++++++++++++++++++++---
>  target/arm/kvm_arm.h          | 18 +++++++++++++
>  11 files changed, 166 insertions(+), 3 deletions(-)
> 



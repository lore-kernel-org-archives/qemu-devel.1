Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5364122243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts3Ix3o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5364122243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvcT-0006ds-62
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvb2-0005aR-QX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvb0-0006OO-MZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604407165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI6Y4+XlJlwrHvxocB3ncP7ba8NPybAEToiaJnoIIyI=;
 b=Ts3Ix3o3h8sV7RTCxennQ5YDR6aviviUMswXgDMyrv+5rs8PKBwbNzYbDkim8aXRi0iZCY
 aNvqkQTIy0QrE4saQAGGxZKp4zAQDKTguLfydcADuFVE3o/d9k8MCOQXuI8MDKQkKLcz/y
 kDd9K938EfEl7UJmrzCsLk/lpYJElCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-z2r4LVopP_-IEtFB6vhpUA-1; Tue, 03 Nov 2020 07:39:21 -0500
X-MC-Unique: z2r4LVopP_-IEtFB6vhpUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4245180364D;
 Tue,  3 Nov 2020 12:39:20 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F47F1002D49;
 Tue,  3 Nov 2020 12:39:16 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:39:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: Question on UEFI ACPI tables setup and probing on arm64
Message-ID: <20201103133913.1fee3337@redhat.com>
In-Reply-To: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
References: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>, lersek@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "wangzhigang17@huawei.com" <wangzhigang17@huawei.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 10:50:01 +0800
Ying Fang <fangying1@huawei.com> wrote:

> Hi,
> 
> I have a question on UEFI/ACPI tables setup and probing on arm64 platform.

CCing Laszlo,
who might know how it's implemented.
 
> Currently on arm64 platform guest can be booted with both fdt and ACPI
> supported. If ACPI is enabled, [1] says the only defined method for
> passing ACPI tables to the kernel is via the UEFI system configuration
> table. So AFAIK, ACPI Should be dependent on UEFI.
> 
> What's more [2] says UEFI kernel support on the ARM architectures
> is only available through a *stub*. The stub populates the FDT /chosen
> node with some UEFI parameters describing the UEFI location info.
> 
> So i dump /sys/firmware/fdt from the guest, it does have something like:
> 
> /dts-v1/;
> 
> / {
> 	#size-cells = <0x02>;
> 	#address-cells = <0x02>;
> 
> 	chosen {
> 		linux,uefi-mmap-desc-ver = <0x01>;
> 		linux,uefi-mmap-desc-size = <0x30>;
> 		linux,uefi-mmap-size = <0x810>;
> 		linux,uefi-mmap-start = <0x04 0x3c0ce018>;
> 		linux,uefi-system-table = <0x04 0x3f8b0018>;
> 		bootargs = "BOOT_IMAGE=/vmlinuz-4.19.90-2003.4.0.0036.oe1.aarch64 
> root=/dev/mapper/openeuler-root ro rd.lvm.lv=openeuler/root 
> rd.lvm.lv=openeuler/swap video=VGA-1:640x480-32@60me 
> smmu.bypassdev=0x1000:0x17 smmu.bypassdev=0x1000:0x15 
> crashkernel=1024M,high video=efifb:off video=VGA-1:640x480-32@60me";
> 		linux,initrd-end = <0x04 0x3a85a5da>;
> 		linux,initrd-start = <0x04 0x392f2000>;
> 	};
> };
> 
> But the question is that I did not see any code adding the uefi
> in fdt chosen node in *arm_load_dtb* or anywhere else.
> Qemu only maps the OVMF binary file into a pflash device.
> So I'm really confused on how UEFI information is provided to
> guest by qemu. Does anybody know of the details about it ?
> 
> [1] https://www.kernel.org/doc/html/latest/arm64/arm-acpi.html
> [2] https://www.kernel.org/doc/Documentation/arm/uefi.rst
> 
> Thanks.
> Ying
> 



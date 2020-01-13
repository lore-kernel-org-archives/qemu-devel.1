Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC3C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACD521556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZjbg+8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir21r-0006QN-Ot
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lnkgyv@gmail.com>) id 1ir21E-0005zg-MN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lnkgyv@gmail.com>) id 1ir21D-0000zv-Er
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:52:44 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lnkgyv@gmail.com>) id 1ir21D-0000xf-6s
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:52:43 -0500
Received: by mail-lf1-x141.google.com with SMTP id n12so7222789lfe.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=MZAuOCEWsb3pRZnFOMvQgW6WSG31BaDcmQyuhu30k6E=;
 b=QZjbg+8U9qPFxH19ws3SmQLhwJcBDpkH5flQI5nT6lnV+EO6yNyv4XaN1L8tWUoJYi
 j8+kYZk5LvWjebhrucV/YfzMzxCKsiZ8mjMIgKFJUdsPUuslqxhxo+bnOjfCES5qxPdA
 CGOTZ8ht5uIxjaWDlk+qh7kx2ldo233a6jz10GWTeWZ5E1RHd0hwedNDkqIbcjsNzG1q
 3/wS7jwSiHn3XRMLNaxsD8it91u25qJaYYfmGZ7CP3Niu3KVnEEmRPuzJsSpoyI4zdjf
 Q44BiAT1UdIEPvIZcPS7a/8rUYwQQIwfY9RbTCygl0CpR1qdwigzfYPue9lnmX2qT+Rt
 pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=MZAuOCEWsb3pRZnFOMvQgW6WSG31BaDcmQyuhu30k6E=;
 b=cl1tEs2k89Kz9B4vOTsEnkqVP6Ip4AnqWWecSOhpyp/RSZGg4CICgpg2fjGaUH9fLM
 owHcSZBDQaWZnoXvz0oNyR+br/jjLcPASIhBJ2aNCZg7MIsLr32DCfUC1Xgt9jKaHM4+
 w4ANJOJ6yKegWPmACeY81s4ELOKt+jUW4DqW8MUKCRrdE5tT4e1849MuzKWdmWWr4+CB
 LDlltFMlZ8MsWmbrPLfoilbV6kcf0a/k/TLU3p0ZvS3F/yoCROyx0vSQ8Qkr3nvXnb3H
 DOQOyOaDsLcNbtC855xYUB77E5rdjHKiRVoJak4uzDpEaUJf9wRZFON6CS0nVXe4iKJd
 4TQA==
X-Gm-Message-State: APjAAAUUZOqJ4UkzPQRlhPEtAhf0hZInM5j7bbE6NFOMftnbnQX2SPL4
 Q7TXlpPWgoxYGY4hecm5rWExeY5s
X-Google-Smtp-Source: APXvYqwO+CKWf8+o6T6xsnabNpNblQ/ufwLiKovTLbtgLqIda6nf2R2y9vGHfro4o2LUhhMStMRRrg==
X-Received: by 2002:ac2:5582:: with SMTP id v2mr10068822lfg.183.1578930760814; 
 Mon, 13 Jan 2020 07:52:40 -0800 (PST)
Received: from [192.168.101.65] ([82.97.198.254])
 by smtp.gmail.com with ESMTPSA id s4sm6237761ljd.94.2020.01.13.07.52.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 07:52:40 -0800 (PST)
To: qemu-devel@nongnu.org
From: yurij <lnkgyv@gmail.com>
Subject: PCIe device paththrough via vfio issue
Message-ID: <9ebac151-0a9b-3f64-ccd8-0709088fa2b3@gmail.com>
Date: Mon, 13 Jan 2020 18:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello everybody!

I have a specific PCIe device (sorry, but I can't tell about what is it 
and what it does) but PCI configuration space consists of 4 BARs (lspci 
output brief):

lspci -s 84:00.00 -vvv

. . .
Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at fb001000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at fb000000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
. . .
Kernel driver in use: vfio-pci
. . .

BAR0 merged with BAR1, BAR4 merged with BAR5 so they are 64 bit width.

I put this PCIe device in virtual machine via vfio:

-device vfio-pci,host=84:00.0,id=hostdev0,bus=pci.6,addr=0x0

Virtual machine successfully boot. PCI configuration space in virtual 
environment looks OK (lspci output brief):

lspci -s 06:00.0 -vvv

. . .
Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at fa001000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
. . .
Kernel driver in use: custom_driver

BAR0 merged with BAR1 and BAR4 merged with BAR5 and so they are also 64 
bit width.

The main problem in 4K HOLE in REGION 0 in virtual environment. So some 
device features don't work.

I have enabled iommu trace in host system (trace_event=iommu) and 
display all events (for i in $(find 
/sys/kernel/debug/tracing/events/iommu/ -name enable);do echo 1 > $i; 
done). I saw next events during virtual machine booting:

# cat /sys/kernel/debug/tracing/trace
. . .
        CPU 0/KVM-3046  [051] .... 63113.338894: map: IOMMU: 
iova=0x00000000f8000000 paddr=0x00000000fa000000 size=24576
        CPU 0/KVM-3046  [051] .... 63113.339177: map: IOMMU: 
iova=0x00000000f8007000 paddr=0x00000000fa007000 size=16748544
        CPU 0/KVM-3046  [051] .... 63113.339444: map: IOMMU: 
iova=0x00000000fa000000 paddr=0x00000000fb001000 size=4096
        CPU 0/KVM-3046  [051] .... 63113.339697: map: IOMMU: 
iova=0x00000000fa001000 paddr=0x00000000fb000000 size=4096
        CPU 0/KVM-3046  [051] .... 63113.340209: map: IOMMU: 
iova=0x00000000f9000000 paddr=0x00000000f9000000 size=16777216
. . .

I have enabled qemu trace(-trace events=/root/qemu/trace_events). Trace 
file consists of the falling functions:
vfio_region_mmap
vfio_get_dev_region
vfio_pci_size_rom
vfio_pci_read_config
vfio_pci_write_config
vfio_iommu_map_notify
vfio_listener_region_add_iommu
vfio_listener_region_add_ram

Some important brief from qemu trace:
. . .
янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region 
0000:84:00.0 BAR 0 mmaps[0] [0x0 - 0xffffff]
янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region 
0000:84:00.0 BAR 2 mmaps[0] [0x0 - 0xfff]
янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region 
0000:84:00.0 BAR 3 mmaps[0] [0x0 - 0xfff]
янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region 
0000:84:00.0 BAR 4 mmaps[0] [0x0 - 0xffffff]
. . .
янв 13 18:17:37 VM qemu-system-x86_64[7131]: 
vfio_listener_region_add_ram region_add [ram] 0xf8000000 - 0xf8005fff 
[0x7f691e800000]
янв 13 18:17:37 VM qemu-system-x86_64[7131]: 
vfio_listener_region_add_ram region_add [ram] 0xf8007000 - 0xf8ffffff 
[0x7f691e807000]
янв 13 18:17:37 VM qemu-system-x86_64[7131]: 
vfio_listener_region_add_ram region_add [ram] 0xfa000000 - 0xfa000fff 
[0x7f6b5de37000]
янв 13 18:17:37 VM qemu-system-x86_64[7131]: 
vfio_listener_region_add_ram region_add [ram] 0xfa001000 - 0xfa001fff 
[0x7f6b58004000]
янв 13 18:17:37 VM qemu-system-x86_64[7131]: 
vfio_listener_region_add_ram region_add [ram] 0xf9000000 - 0xf9ffffff 
[0x7f691d800000]

I use qemu 4.0.0 which I rebuild for tracing support 
(--enable-trace-backends=syslog).

Please, help me solve this issue. Thank you!

-- 
with best regards
Yurij Goncharuk


Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A3FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C46208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C46208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDRy-0003ie-Qd
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gpiccoli@canonical.com>)
 id 1jlDK8-0001mn-EE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:16:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <gpiccoli@canonical.com>)
 id 1jlDK6-0001lR-7b
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:16:28 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <gpiccoli@canonical.com>) id 1jlDK3-0003c1-DM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:16:23 +0000
Received: by mail-qv1-f70.google.com with SMTP id a8so15799309qvt.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:autocrypt:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=eX3m0Di1LMY49eKKjvC+O37EN++/7yynGmI/HNgY9Os=;
 b=GjeOFcuQnaYb9uu8lh18Swr0wc+ZfR8DkCkRvE9iK2pqJEryn1Jl6ctpUUeG3Hwuoh
 v1Dl1WiogzDpmmCVMe5Bz9MLmg6C7O/YQGOQmGlUrBSYTFVCvtpIObQ0mPWQbKbhsywk
 9FgRxyEfjhEsJ/LAhmY+cPp0hQvjuWKSa4b+ps4RtqeAGpc3/UJX2jsyAjh5uGfPoLUU
 j2otrBgHrx0wZtX4Ox+RYLYC7x0hUG4aMARAOS8XwAQxJ6Gk0bGsBWXf/ns2BNmH8hjh
 GpS7vOnRtyRQ1xtOdY8rSQYLN6OYuamcD7f//E4BC0hCAqt2UvO/lHbaPnlLDhz+reEj
 Xwjg==
X-Gm-Message-State: AOAM531pEqlyQSax7GmCMWJJ5kLdB2pyLmoeRkWPFMsLn+yqNyNNkRwU
 IwmQTeISfAJe/rie+4NgSCxuCpke+WZBV2mv0T03GYyZ44i6ZUV6Sq3UciamoYH5jT8a+zf8QN1
 mzhyuvUj/rzaD9IWh7AGOZum2QKMJUtnM
X-Received: by 2002:a0c:ffca:: with SMTP id h10mr2804747qvv.238.1592320582470; 
 Tue, 16 Jun 2020 08:16:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEBDqQuoSy7upQA8N3gCTg7WDRg0TDwj1P3JQeAzeeYqhVSfPz/yhCaABu0b0CxKASnKl86w==
X-Received: by 2002:a0c:ffca:: with SMTP id h10mr2804720qvv.238.1592320582127; 
 Tue, 16 Jun 2020 08:16:22 -0700 (PDT)
Received: from [192.168.1.75] ([179.110.231.152])
 by smtp.gmail.com with ESMTPSA id p185sm13373497qkd.128.2020.06.16.08.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 08:16:21 -0700 (PDT)
To: qemu-devel@nongnu.org
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Subject: ovmf / PCI passthrough impaired due to very limiting PCI64 aperture
Message-ID: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
Date: Tue, 16 Jun 2020 12:16:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=gpiccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:16:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pedro.principeza@canonical.com, ehabkost@redhat.com,
 dann.frazier@canonical.com, dgilbert@redhat.com,
 christian.ehrhardt@canonical.com, kraxel@redhat.com, lersek@redhat.com,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello folks, I'd like to start a discussion (or bump it, in case it was
already discussed) about an "issue", or better saying, a limitation
we've been observing (and receiving reports) on qemu/ovmf with regards
to the PCI passthrough of large BAR devices.

After OVMF commit 7e5b1b670c38 ("OvmfPkg: PlatformPei: determine the
64-bit PCI host aperture for X64 DXE"), the PCI 64-bit aperture is a
hardcoded value passed to the guest via ACPI CRS that, in practical
terms does not allow 32G+ BAR PCI devices to be correctly passthrough'ed
to guests.

There was a very informative discussion on edk2 groups [0] started by my
colleague Dann, to which some edk2 and qemu developers responded with a
good amount of information and rationale about this limitation, and the
problems that increasing such limit would bring. All the colleagues that
responded in that group discussion are hereby CC'ed.

The summary (in my understanding) is:

- The main reasoning for the current limitation is to make it simple; we
need to take into account the 64-bit aperture in order to accomplish
memory mapping on OVMF, and for common scenarios the current limit of
32G accommodates the majority of use cases.

- On top of it, increasing the 64-bit aperture will incur in the
increase of the memory required for OVMF-calculated PEI (Pre-EFI
Initialization) page tables.

- The current aperture also accounts for the 36-bit CPU physical bits
(PCPU) common in old processors and in some qemu generic vcpus, and this
"helps" with live migration, since 36-bit seems to be the LCD (lowest
common denominator) between all processors (for 64-bit architectures),
hence the limiting PCI64 aperture wouldn't be yet another factor that
makes live migration difficult or impossible.

- Finally, there's an _experimental_ parameter to allow some users'
flexibility on PCI64 aperture calculation: "X-PciMmio64Mb".

The point is we have more and more devices out there with bigger BARs
(mostly GPUs), that either exceed 32G by themselves or are almost there
(16G) and if users want to pass-through such devices, OVMF doesn't allow
that. Relying on "X-PciMmio64Mb" is problematic due to the
experimental/unstable nature of such parameter.

Linux kernel allows bypassing ACPI CRS with "pci=nocrs", some discussion
about that on [1]. But other OSes may not have such option, effectively
preventing the PCI-PT of such large devices to succeed or forcing user
to rely on the experimental parameter.

I'd like to discuss here a definitive solution; I've started this
discussion on Tianocore bugzilla [2], but Laszlo wisely suggested us to
move here to gather input from qemu community.
Currently I see 2 options, being (a) my preferred one:

(a) We could rely in the guest physbits to calculate the PCI64 aperture.
If the users are doing host bits' passthrough (or setting the physbits
manually through -phys-bits), they are already risking a live migration
failure. Also, if the users are not setting the physbits in the guest,
there must be a default (seems to be 40bit according to my experiments),
seems to be a good idea to rely on that.
If guest physbits is 40, why to have OVMF limiting it to 36, right?

(b) Making the experimental "X-PciMmio64Mb" not experimental anymore is
also an option, allowing users to rely on it without the risk of support
drop.

Please let me know your thoughts on such limitation and how we could
improve it. Other ideas are also welcome, of course. Thanks for the
attention,


Guilherme


[0] edk2.groups.io/g/discuss/topic/ovmf_resource_assignment/59340711
[1] bugs.launchpad.net/bugs/1849563
[2] bugzilla.tianocore.org/show_bug.cgi?id=2796


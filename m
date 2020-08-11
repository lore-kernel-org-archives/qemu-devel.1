Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3792FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54D6206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzCIRFAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D6206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5cia-0006dC-1Y
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5chr-000683-3w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:25:19 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5cho-0001fx-Gq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:25:18 -0400
Received: by mail-oi1-x234.google.com with SMTP id z22so80521oid.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=GvKEYEAWVz3tYqCiq7vvjy2noVPng+iEW0y9bBRPnXg=;
 b=HzCIRFAy/ro5AZzoJIPplzxhMbGZuEHDpY46+KYHx5ELIO7DOGX7yJRaYsNWl9iDg1
 GAWQj1FaLkMufyzIX6OEuzCn0LOEuxyiIwJ6fgj73FA3Ti25g8AOwQAfec/yNhSho5bf
 q3mVRHGEl+fADKJob1u+0JMySjIWo4Q+h0B6LoxtslU7QuJHWi4NwKVCBOz8Ylm4TIij
 HvD2H6einqfaJuJdjFUDFGU4HPG6lalBL9VEc6ip64dLp2+MKMkNl+wMM45MM65TYRp6
 Y5oJHRQwEm0HiyH3T6coFbkGwhtyu1BOeItLSxG7GUgJ+90cKT7t57V2NoNht3TrBW/B
 z8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=GvKEYEAWVz3tYqCiq7vvjy2noVPng+iEW0y9bBRPnXg=;
 b=VGgFBAN/qA12Oy+7RXjxyXR7ZX1+Jjaf3lEP27Z0u3snhEtvrHsq7rRLzxZ3UHHcHw
 AOtQ8PD9zwcb1DkqKfQfgLRE5IPdrMOaoyQz3PAaX8g/9ia/P5orB5lZIlV2puvfFbn4
 o/Wx6N33iHrJA+RZ7J9OTqB4x4AhZ86fhL6yh3i32cB87CaKk/AvFh6CZ2CWMdusxOt3
 7j2EAKpEHnwtxbk6aue7AEaPVP23lYWeTDe/6HJ8oHe/3NQnmNOU20HtVyw/A/Ix6N2M
 yuYseZQJngOcEHczRe7Pm43RJxyA8v2pfxI2qzj0PAlqjn1+YnryJzdN6h5K44yo3Kz6
 5SPw==
X-Gm-Message-State: AOAM530+mLbTMifTbD8rOikFWJsxTjhnOnvHUwBAHCJjRu/IjDi3TvB1
 QxG3NnmYoL4GPhUyU2m65B34JpdW
X-Google-Smtp-Source: ABdhPJylhKBFSOcl1agf9trnQqaBwGO40ydH2I3LxYWHz6LDYdWZgr8vKLilazN5BL43WCsBsm1bSQ==
X-Received: by 2002:a05:6808:345:: with SMTP id
 j5mr5093477oie.37.1597184713054; 
 Tue, 11 Aug 2020 15:25:13 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c135sm66563oig.38.2020.08.11.15.25.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Aug 2020 15:25:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <159718470399.12679.2525201344482512899@sif>
Subject: [ANNOUNCE] QEMU 5.1.0 is now available
Date: Tue, 11 Aug 2020 17:25:03 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 5.1.0 release. This release contains 2500+ commits from 235
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/5.1

Highlights include:

 * ARM: support for ARMv8.2 TTS2UXN architecture feature
 * ARM: support for ARMv8.5 MemTag architecture feature
 * ARM: new board support for sonorapass-bmc
 * ARM: virt: support for memory hot-unplug
 * ARM: support for nvdimm hotplug for ACPI guests
 * AVR: new architecture support for AVR CPUs
 * AVR: new board support for Arduino Duemilanove, Arduino Mega 2560,
   Arduino Mega, and Arduino UNO
 * MIPS: support for Loongson 3A CPUs (R1 and R4)
 * MIPS: performance improvements for FPU and MSA instruction
   emulation
 * PowerPC: support for guest error recovery via FWNMI
 * RISC-V: support for SiFive E34 and Ibex CPUs
 * RISC-V: new board support for HiFive1 revB and OpenTitan
 * RISC-V: Spike machine now supports more than 1 CPU
 * s390: KVM support for protected virtualization (secure execution mode)
 * x86: improvements to HVF acceleration support on macOS
 * x86: reduced virtualization overhead for non-enlightened Windows
   guests via Windows ACPI Emulated Device Table

 * block: support for 2MB logical/physical blocksizes for virtual
   storage devices
 * crypto: support for passing secrets to QEMU via Linux keyring
 * crypto: support for LUKS keyslot management via qemu-img
 * NVMe: support for Persistent Memory Region from NVMe 1.4 spec
 * qemu-img: additional features added for map/convert/measure commands,
   as well as support for zstd compression
 * qemu-img: support for new 'bitmap' command for manipulating
   persistent bitmaps in qcow2 files
 * virtio: TCG guests can now use vhost-user threads
 * virtio: vhost-user now supports registering more than 8 RAM slots

 * and lots more...

Thank you to everyone involved!



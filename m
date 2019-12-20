Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122D5206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRgnOA15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122D5206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOsi-00067K-5o
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 15:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iiOry-0005G5-Fx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iiOrx-0001BS-Bn
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:30 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iiOrx-00016T-4j
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:29 -0500
Received: by mail-lf1-x144.google.com with SMTP id f15so7951410lfl.13
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+A6IT4c/+pZUoS/jx9YhK15VZ2D9C+6KzH019NBL3Lk=;
 b=sRgnOA159MyHYpx+XgaZ2+0MqiPQfUdXtPZYnI1SalCGd9/1Egm0LqXKt9rkloQdVl
 yvFWA10B/ZJUYJeKy7/tVG4cFp3qI9kRtqkdDx4nq97w+hOhRNUYnLGv2UjfFJ6CYuyd
 VoaLPQqhiYoPIW7oXQNptnUvE+1ZGoTABUaFdjemdNkxu3XlM7UumAw5Qxl73SS9EGen
 /BSaTB1dFTLlbIjJa6Zl+9yIW1imsUFhUEOM42MPAjVwuh2U9tk4TgrbVS0j8BXVr7Mm
 enKm0PezY/uS1742I+jVKc8NcEbOzpdTT5WuUWvcFvrXDJabWvxy54GHH29JYDAeJzBT
 7/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+A6IT4c/+pZUoS/jx9YhK15VZ2D9C+6KzH019NBL3Lk=;
 b=PT00TCH80Jk0kxIOtLdOJpDS+XgD9Kn2Ug1D8NfojbSe+aUI4ABz7uxI19r0zNmgcu
 Ecko4TDQ+WAncPp4ADJkCj1hnqg+ZiUHJ07baN35QRtXMmDg8z5MhlpDMX/6Uv4yBhYU
 totcqPXLY8ohKS7cj2lfhnUtJ9N53LzVYGnzKlogKhEw9ZmDyXfH36FCRceC1QQO8yWo
 fN07dvkiSNG00wtsrC9qZb3/FZYctlfWI9r3saSdOsl3TowMazsrJZGcudxuCi3Jv4ho
 uGiN5vv2PDUFRTnkuJ84CYZIsj6UkxUvswVSrVMmK4ohRAnCxBPsc7PvAJ6o6w9+8WPQ
 mF3w==
X-Gm-Message-State: APjAAAU4seGr3/5y0UtY6EqWfqNKj6qLP60rs4+uUuCK8Cqf6/sJxgLT
 zKUvb2ct8WsX0kxiJ9cev90mJ8OSACaG/Q==
X-Google-Smtp-Source: APXvYqxQKOwc4bc9qs9P6M84ZzOLdO8TbugCAJSKar1LucSgOlT0wTbMiQStstUY8GQdmKFXUg79PA==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr10166439lfg.47.1576873646930; 
 Fri, 20 Dec 2019 12:27:26 -0800 (PST)
Received: from moi-limbo-9350.arm.com (user44-177.satfilm.com.pl.
 [77.91.44.177])
 by smtp.gmail.com with ESMTPSA id g27sm4482353lfj.49.2019.12.20.12.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 12:27:26 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/1] target/arm: kvm: Support for KVM DABT without valid
 ISS
Date: Fri, 20 Dec 2019 20:27:06 +0000
Message-Id: <20191220202707.30641-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Christoffer.Dall@arm.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the ARMv7 & ARMv8 load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate the instruction which is one of the
(many) reasons why KVM will not even try to do so.

So far, if a guest made an attempt to access memory outside the memory slot,
KVM reported vague ENOSYS. As a result QEMU exited with no useful information
being provided or even a clue on what has just happened.

Recently ARM KVM introduced support for notifying guest of an attempt to
execute an instruction that resulted in dabt with no valid ISS decoding info.
This still leaves QEMU to handle the case, but at least now, it can enable
further debugging of the encountered issue by being more verbose
in a (hopefully) useful way.



Beata Michalska (1):
  target/arm: kvm: Handle DABT with no valid ISS

 accel/kvm/kvm-all.c    | 15 +++++++
 accel/stubs/kvm-stub.c |  4 ++
 include/sysemu/kvm.h   |  1 +
 target/arm/cpu.h       |  3 +-
 target/arm/kvm.c       | 95 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c     |  3 ++
 target/arm/kvm64.c     |  3 ++
 target/arm/kvm_arm.h   | 19 +++++++++
 8 files changed, 142 insertions(+), 1 deletion(-)

-- 
2.17.1



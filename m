Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EDB2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EDB2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCK1Z-0001yU-1P
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jCK0k-0008NU-SA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jCK0j-0005FQ-OF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:20:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56604 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jCK0h-00057p-2p; Thu, 12 Mar 2020 05:20:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EDEF9ED6D8587C08CEB4;
 Thu, 12 Mar 2020 17:20:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Mar 2020
 17:19:54 +0800
Subject: Re: [kvm-unit-tests PATCH v5 10/13] arm/arm64: ITS: INT functional
 tests
To: Marc Zyngier <maz@kernel.org>, Auger Eric <eric.auger@redhat.com>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-11-eric.auger@redhat.com>
 <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
 <46f0ed1d-3bda-f91b-e2b0-addf1c61c373@redhat.com>
 <301a8b402ff7e480e927b0f8f8b093f2@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7fb9f81f-6520-526d-7031-d3d08cb1dd6a@huawei.com>
Date: Thu, 12 Mar 2020 17:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <301a8b402ff7e480e927b0f8f8b093f2@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 andre.przywara@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 thuth@redhat.com, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/3/11 22:00, Marc Zyngier wrote:
> That is still a problem with the ITS. There is no architectural way
> to report an error, even if the error numbers are architected...
> 
> One thing we could do though is to implement the stall model (as described
> in 5.3.2). It still doesn't give us the error, but at least the command
> queue would stop on detecting an error.

It would be interesting to see the buggy guest's behavior under the
stall mode. I've used the following diff (absolutely *not* a formal
patch, don't handle CREADR.Stalled and CWRITER.Retry at all) to have
a try, and caught another command error in the 'its-trigger' test.

logs/its-trigger.log:
" INT dev_id=2 event_id=20
lib/arm64/gic-v3-its-cmd.c:194: assert failed: false: INT timeout! "

dmesg:
[13297.711958] ------------[ cut here ]------------
[13297.711964] ITS command error encoding 0x10307

It's the last INT test in test_its_trigger() who has triggered this
error, Eric?


Thanks.

---8<---
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 9d53f545a3d5..5717f5da0f22 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -179,6 +179,7 @@ struct vgic_its {
  	u64			cbaser;
  	u32			creadr;
  	u32			cwriter;
+	bool			stalled;

  	/* migration ABI revision in use */
  	u32			abi_rev;
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index d53d34a33e35..72422b75e627 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1519,6 +1519,9 @@ static void vgic_its_process_commands(struct kvm 
*kvm, struct vgic_its *its)
  	if (!its->enabled)
  		return;

+	if (unlikely(its->stalled))
+		return;
+
  	cbaser = GITS_CBASER_ADDRESS(its->cbaser);

  	while (its->cwriter != its->creadr) {
@@ -1531,9 +1534,34 @@ static void vgic_its_process_commands(struct kvm 
*kvm, struct vgic_its *its)
  		 * According to section 6.3.2 in the GICv3 spec we can just
  		 * ignore that command then.
  		 */
-		if (!ret)
-			vgic_its_handle_command(kvm, its, cmd_buf);
+		if (ret)
+			goto done;
+
+		ret = vgic_its_handle_command(kvm, its, cmd_buf);
+
+		/*
+		 * Choose the stall mode on detection of command errors.
+		 * Guest still can't get the architected error numbers though...
+		 */
+		if (ret) {
+			/* GITS_CREADR.Stalled is set to 1. */
+			its->stalled = true;
+
+			/*
+			 * GITS_TYPER.SEIS is 0 atm, no System error will be
+			 * generated.  Instead report error encodings at ITS
+			 * level.
+			 */
+			WARN_RATELIMIT(ret, "ITS command error encoding 0x%x", ret);
+
+			/*
+			 * GITS_CREADR is not incremented and continues to
+			 * point to the entry that triggered the error.
+			 */
+			break;
+		}

+done:
  		its->creadr += ITS_CMD_SIZE;
  		if (its->creadr == ITS_CMD_BUFFER_SIZE(its->cbaser))
  			its->creadr = 0;



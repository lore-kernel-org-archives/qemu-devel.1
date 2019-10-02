Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2131C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B39D2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B39D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFU2g-0004Az-50
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nramas@linux.microsoft.com>) id 1iFTVH-000250-Hc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nramas@linux.microsoft.com>) id 1iFTVG-0005kC-4G
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:32:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35386)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <nramas@linux.microsoft.com>)
 id 1iFTVC-0005eU-KQ; Tue, 01 Oct 2019 21:32:26 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
 by linux.microsoft.com (Postfix) with ESMTPSA id 075762007698;
 Tue,  1 Oct 2019 18:32:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 075762007698
Subject: Re: Is kexec supported in QEMU for ARM64 (qemu-system-aarch64) with
 arm-trusted-firmware, optee, and u-boot.
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <21633062-b021-a8e7-0cc8-062f4c29dde5@linux.microsoft.com>
 <ca5c74db-cf5d-0c3f-eb6f-27d1092420ae@linux.microsoft.com>
 <65b49cb0-c9fb-d966-8dec-1e39d09ab8c7@redhat.com>
 <88878b22-803f-41fc-9df2-2c6eb551b98d@linux.microsoft.com>
 <CAKv+Gu8kwg_tsrH7qne3H11hUPyA6zw-J_jpUmiyJMvXo3-SNQ@mail.gmail.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5938a592-1494-ca0c-8a34-7df38dbbea0c@linux.microsoft.com>
Date: Tue, 1 Oct 2019 18:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8kwg_tsrH7qne3H11hUPyA6zw-J_jpUmiyJMvXo3-SNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 13.77.154.182
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
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 9:30 AM, Ard Biesheuvel wrote:

> 
> kexec is a linux concept, so whether it is supported should not depend
> on the secure world firmware or the underlying host.

I agree Ard.
When I don't use ATF I am able to do kexec in QEMU and successfully boot 
into the new kernel.
Is the following expected?

When I execute kexec ("kexec -l <kernel>", followed by "kexec -e") I hit 
the following assert in ATF (in the file
arm-trusted-firmware/plat/qemu/qemu_pm.c)

/*******************************************************************************
   * Platform handler called when a power domain is about to be turned
   * off. The target_state encodes the power state that each level should
   * transition to.
******************************************************************************/
void qemu_pwr_domain_off(const psci_power_state_t *target_state)
{
      assert(0);
}

Thanks,
  -lakshmi




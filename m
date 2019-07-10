Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B9C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0E62087F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0E62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFC8-0003uS-1H
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hlFA4-0002gi-Rs
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hlF9y-0002GQ-Bb
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:09:36 -0400
Received: from goliath.siemens.de ([192.35.17.28]:59972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hlF9w-0000v2-GO
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:09:34 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x6AG8hFh031182
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2019 18:08:44 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may
 be forged))
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x6AG8gW8003115;
 Wed, 10 Jul 2019 18:08:42 +0200
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <e253d736-8cf5-0c5c-5766-ee71ad808cfd@siemens.com>
 <7431700b-0bfd-32e6-e9f2-64608f8ba6b9@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <753cb413-9e8f-581b-8d9e-635dfd30627d@siemens.com>
Date: Wed, 10 Jul 2019 18:08:41 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <7431700b-0bfd-32e6-e9f2-64608f8ba6b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.28
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.07.19 16:40, Paolo Bonzini wrote:
> On 08/07/19 20:31, Jan Kiszka wrote:
>>> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
>>> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
>>>          error_report("Guest enabled nested virtualization but kernel "
>>>                  "does not support saving of nested state");
>>>          return -EINVAL;
>>>
>> Starting with this commit latest (bisection issue...), running Jailhouse in a
>> guest first stalls L1 (looks like we lose interrupts), and if I try to reset
>> that VM, I lose my host as well:
> 
> If 5.2 is still broken, can you gather a dump of KVM_SET_NESTED_STATE's
> payload?

savevm or is there a dump function in QEMU or the kernel?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


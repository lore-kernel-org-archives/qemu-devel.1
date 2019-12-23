Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A979C206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+8kVCSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A979C206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijM6z-0005rf-Sa
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 06:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ijM5a-0005OU-Ua
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ijM5R-0002QQ-Fn
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ijM4W-00021s-5i
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577101223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnL7A2Gn8SlmnVwgYBnq8bHINgwlqzdVYmw5af3n3Pc=;
 b=T+8kVCSYwgIiH+2GOOmMdryYZvVm1B3seH+CXo8SoZQ8jxS2ys0/NbKFByAcxzXn/AjrkD
 tZgBqpzkiDysi/ugPWaT9h34xCXT0qudNlQrztQLjZo+HfBzOv5kAuBq2Wma+1sx5cXPIH
 vsYNXEELi/Yxgeldl6b+wSfIwrSNkPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-a46I_2pHOMG1Xp5cTaXDAQ-1; Mon, 23 Dec 2019 06:40:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA92DB94
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 11:40:20 +0000 (UTC)
Received: from [10.40.204.49] (ovpn-204-49.brq.redhat.com [10.40.204.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C32CD808D0;
 Mon, 23 Dec 2019 11:40:19 +0000 (UTC)
Subject: Re: [PULL 48/87] x86: move SMM property to X86MachineState
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-49-git-send-email-pbonzini@redhat.com>
 <8e6af403-173f-ff15-11c7-5dad511795a1@redhat.com>
 <20191223113315.GI2529561@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <07a106e4-ffa1-57d6-6909-6814d9c4de25@redhat.com>
Date: Mon, 23 Dec 2019 12:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191223113315.GI2529561@redhat.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: a46I_2pHOMG1Xp5cTaXDAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/23/19 12:33 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 23, 2019 at 12:28:43PM +0100, Michal Pr=C3=ADvozn=C3=ADk wrot=
e:
>> On 12/18/19 1:02 PM, Paolo Bonzini wrote:
>>> Add it to microvm as well, it is a generic property of the x86
>>> architecture.
>>>
>>> Suggested-by: Sergio Lopez <slp@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  hw/i386/pc.c          | 49 -------------------------------------------=
------
>>>  hw/i386/pc_piix.c     |  6 +++---
>>>  hw/i386/pc_q35.c      |  2 +-
>>>  hw/i386/x86.c         | 50 +++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>>  include/hw/i386/pc.h  |  3 ---
>>>  include/hw/i386/x86.h |  5 +++++
>>>  target/i386/kvm.c     |  3 +--
>>>  7 files changed, 59 insertions(+), 59 deletions(-)
>>>
>>
>>
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index ef63f3a..c7ff67a 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -2173,8 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>      }
>>> =20
>>>      if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
>>> -        object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
>>> -        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
>>> +        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>>>          smram_machine_done.notify =3D register_smram_listener;
>>>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>>>      }
>>>
>>
>> Sorry for not catching this earlier, but I don't think this is right.
>> The @ms is not instance of X
>>
>>
>> After I refreshed my qemu master I realized that libvirt is unable to
>> fetch capabilities. Libvirt runs the following command:
>>
>>   qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 -S -no-user-config
>> -nodefaults -nographic -machine none,accel=3Dkvm:tcg
>=20
> Hmm, it would be good if we can get QEMU CI to launch QEMU  in
> this way, as this isn't the first time some change has broken
> launching of QEMU for probing capabilities.

Agreed.

NB, this diff fixes the issue for me, but I have no idea if it's correct
(it looks correct judging by the way the code looked before):

diff --git i/target/i386/kvm.c w/target/i386/kvm.c
index 0b511906e3..7ee3202634 100644
--- i/target/i386/kvm.c
+++ w/target/i386/kvm.c
@@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }

     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
         x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify =3D register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);


Michal



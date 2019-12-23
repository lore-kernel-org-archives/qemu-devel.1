Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F0C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24831206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BADT89EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24831206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijOz1-0008Bz-6d
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 09:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ijOyN-0007lX-No
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ijOyL-00077Y-BW
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:46:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ijOyK-00076o-Fv
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577112371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9XDrWOmf0l3xpwWSd25ogGU8ZZXxZkKAS8Vgq72ehs=;
 b=BADT89EI7lRZS2okM+kPV6CFXwpt+vlG1Gumn3DhJ8FyPVe+uTyWP+pvS2JAmvi92WJpV3
 vvRTn7pg0QyR9cnzR9lm4USEDbV9IhkRMKT9UouC4B/j/5U1UELICARYf1N5oj6UbOJJ2p
 Jk4J9EPtovJEuI7lMll9eG5ei8BlFvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-hJ4aFeSENq6oeOXEnv1uag-1; Mon, 23 Dec 2019 09:46:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00950800D41
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 14:46:07 +0000 (UTC)
Received: from [10.40.204.64] (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42EB060BE2;
 Mon, 23 Dec 2019 14:46:05 +0000 (UTC)
Subject: Re: [PULL 48/87] x86: move SMM property to X86MachineState
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-49-git-send-email-pbonzini@redhat.com>
 <8e6af403-173f-ff15-11c7-5dad511795a1@redhat.com>
 <20191223113315.GI2529561@redhat.com>
 <07a106e4-ffa1-57d6-6909-6814d9c4de25@redhat.com>
 <4cccaf45-443d-56c9-e2e1-9c72b6638562@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <a83ea564-db2e-93e6-68dd-511aa663ef3b@redhat.com>
Date: Mon, 23 Dec 2019 15:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4cccaf45-443d-56c9-e2e1-9c72b6638562@redhat.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hJ4aFeSENq6oeOXEnv1uag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/23/19 2:38 PM, Paolo Bonzini wrote:
> On 23/12/19 12:40, Michal Pr=C3=ADvozn=C3=ADk wrote:
>>
>> diff --git i/target/i386/kvm.c w/target/i386/kvm.c
>> index 0b511906e3..7ee3202634 100644
>> --- i/target/i386/kvm.c
>> +++ w/target/i386/kvm.c
>> @@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      }
>>
>>      if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
>> +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
>>          x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>>          smram_machine_done.notify =3D register_smram_listener;
>>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>=20
> Yes, it's correct.  Is it okay if I just send a patch with your
> Signed-off-by?

ACK.

Michal



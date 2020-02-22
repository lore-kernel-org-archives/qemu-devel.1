Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2BC35670
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A39B206E2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A39B206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5KG0-0005lI-Lu
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 21:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j5KFK-0005Gk-3T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j5KFI-0008QC-Bh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:10:21 -0500
Received: from regular1.263xmail.com ([211.150.70.202]:35554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1j5KFH-0008BJ-W5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:10:20 -0500
Received: from localhost (unknown [192.168.167.209])
 by regular1.263xmail.com (Postfix) with ESMTP id 74026270;
 Sat, 22 Feb 2020 10:10:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [120.244.107.136])
 by smtp.263.net (postfix) whith ESMTP id
 P23774T140157992822528S1582337410500976_; 
 Sat, 22 Feb 2020 10:10:11 +0800 (CST)
X-UNIQUE-TAG: <9d7a2883e1798d75b53c531126dbe4fe>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: gang.chen.5i5j@gmail.com
X-SENDER-IP: 120.244.107.136
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
 <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
 <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <f3bea474-468b-5818-9f69-5463be6d9b2a@emindsoft.com.cn>
Date: Sat, 22 Feb 2020 10:10:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.150.70.202
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/2/22 =E4=B8=8A=E5=8D=8812:18, Paolo Bonzini wrote:
> On 21/02/20 15:09, Chen Gang wrote:
>>> -    /* XXX: test fptags too */
>>> +    if (env->fptags[env->fpstt]) {
>>> +        env->fpus |=3D 0x4100; /* Empty */
>>> +        return;
>>> +    }
>>> +
>> For fpop overflow, this fix is enough, but for me, we still need
>> foverflow to check fpush/fld*_ST0 overflow.
>>
>> Don't you think we need check fpush/f[i]ld*_ST0 overflow?
>=20
> After fld/fild or any other push, FXAM ST0 should not return empty in m=
y
> opinion.
>=20

OK, it sounds reasonable.

After check the intel document for f[i]ld* instructions, it says:

  "Set C1 to 1 if stack overflow occurred; set to 0 otherwise".

In helper_fxam_ST0, I guess, we need "env->fpus |=3D 0x200" (but I don't
know wheter it will be conflict with SIGND(temp)). And we have to still
need foverflow, because all env->fptags being 0 doesn't mean overflow.

Thanks.




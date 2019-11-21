Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B273EC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D5720679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN9mrl6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D5720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmNK-0006Hb-FP
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXmLC-0005L4-M9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXmLA-0006Kw-DK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:17:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXmLA-0006HM-8m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574342259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9wkbzQ8BHB24KL8x3S1E5NYcFxmvgz1R6xaFZ2Lz/A=;
 b=KN9mrl6aXGdeZzmM5NsB9HHzi3V4YM89H4lzIVBJOafyekIvsPsmqCfL57Hh6T7NgQC9kf
 HBex+kyIGTOSBK+17RfdOhQIUV5XSo4r254lAC3R/ZzolxHfwMjukkCuBUGjNN6KRpHUqv
 00BnweCzR3i37UU4XBvDTAJm5+jvDIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-FaQHYuplOb-VrgjrSDbRXw-1; Thu, 21 Nov 2019 08:17:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2976477;
 Thu, 21 Nov 2019 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8230619C70;
 Thu, 21 Nov 2019 13:17:30 +0000 (UTC)
Subject: Re: [PATCH 01/15] s390x: Cleanup cpu resets
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-2-frankja@linux.ibm.com>
 <32e994b4-6ae2-8de2-4ae0-fc61a21f5f7a@redhat.com>
 <b5a83796-792a-3b5b-bbf1-fd806edb8e92@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47baa4e3-3d67-02ad-71cf-dff907cd9b96@redhat.com>
Date: Thu, 21 Nov 2019 14:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b5a83796-792a-3b5b-bbf1-fd806edb8e92@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FaQHYuplOb-VrgjrSDbRXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 14.11, Janosch Frank wrote:
> On 11/21/19 1:53 PM, Thomas Huth wrote:
>> On 20/11/2019 12.43, Janosch Frank wrote:
>>> Let's move the resets into one function and switch by type, so we can
>>> use fallthroughs for shared reset actions.
[...]
>>> +        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fie=
lds));
>>> +        /* Fallthrough */
>>> +    case S390_CPU_RESET_INITIAL:
>>> +        memset(&env->start_initial_reset_fields, 0,
>>> +               offsetof(CPUS390XState, end_reset_fields) -
>>> +               offsetof(CPUS390XState, start_initial_reset_fields));
>>> +        /* architectured initial values for CR 0 and 14 */
>>> +        env->cregs[0] =3D CR0_RESET;
>>> +        env->cregs[14] =3D CR14_RESET;
>>> =20
>>> -    s390_cpu_reset(s);
>>> -    /* initial reset does not clear everything! */
>>> -    memset(&env->start_initial_reset_fields, 0,
>>> -        offsetof(CPUS390XState, end_reset_fields) -
>>> -        offsetof(CPUS390XState, start_initial_reset_fields));
>>> -
>>> -    /* architectured initial values for CR 0 and 14 */
>>> -    env->cregs[0] =3D CR0_RESET;
>>> -    env->cregs[14] =3D CR14_RESET;
>>> -
>>> -    /* architectured initial value for Breaking-Event-Address register=
 */
>>> -    env->gbea =3D 1;
>>> -
>>> -    env->pfault_token =3D -1UL;
>>> -
>>> -    /* tininess for underflow is detected before rounding */
>>> -    set_float_detect_tininess(float_tininess_before_rounding,
>>> -                              &env->fpu_status);
>>> +        /* architectured initial value for Breaking-Event-Address regi=
ster */
>>> +        env->gbea =3D 1;
>>> +        /* tininess for underflow is detected before rounding */
>>> +        set_float_detect_tininess(float_tininess_before_rounding,
>>> +                                  &env->fpu_status);
>>> +        /* Fallthrough */
>>> +    case S390_CPU_RESET_NORMAL:
>>> +        env->pfault_token =3D -1UL;
>>> +        env->bpbc =3D false;
>>> +        break;
>>> +    }
>>> =20
>>>      /* Reset state inside the kernel that we cannot access yet from QE=
MU. */
>>> -    if (kvm_enabled()) {
>>> -        kvm_s390_reset_vcpu(cpu);
>>> +    if (kvm_enabled() && (type =3D=3D S390_CPU_RESET_CLEAR ||
>>> +                          type =3D=3D S390_CPU_RESET_INITIAL)) {
>>> +            kvm_s390_reset_vcpu(cpu);
>>>      }
>>
>> Why don't you simply move that into the switch-case statement, too?
>=20
> There was a reason for that, time to load it from cold storage...

I just noticed that you rework this in patch 10/15, so it indeed makes
sense to keep it outside of the switch-case-statement above...

>> [...]
>>
>> Anyway, re-using code is of course a good idea, but I wonder whether it
>> would be nicer to keep most things in place, and then simply chain the
>> functions like this:
>=20
> I tried that and I prefer the version in the patch.

... and with patch 10 in mind, it indeed also makes more sense to *not*
use the chaining that I've suggested. So never mind, your switch with
the fallthrough statements is just fine.

 Thomas



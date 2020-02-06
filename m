Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D278220720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBig9Bi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D278220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izazf-0008I6-2D
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 01:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izayr-0007kn-Bu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izayp-0001Sy-Kv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:49:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izayp-0001Hh-HI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580971777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=VDcoZY1ZFRsky3PU15o8qkwztr/6tyc0v29JuLE4MIk=;
 b=eBig9Bi1ClDCyRgaGYQqd9rfSY1UbkGzDTRadCtYawsMAUenAcPlxzFmM3ixK8PDgWFNum
 d4NWc+NjWqsJ+mFVC4lhVAlhxhAXq5xVk6LEIahr8KWJesw0jsEaAMUdktRrNXpt103O21
 coz2DnCDBd70IBGlvmKek4s3+O2Q1J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-OPxz6hA4OB-P4a3WQmVB_g-1; Thu, 06 Feb 2020 01:49:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F761081FA0;
 Thu,  6 Feb 2020 06:49:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29105DA75;
 Thu,  6 Feb 2020 06:49:17 +0000 (UTC)
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <20200205175115.GT2221087@redhat.com>
 <CAL1e-=jHpNmTdWSiHZ_StC0MXjLLsyq0cfSE=45=6SwoFnfiaA@mail.gmail.com>
 <CAL1e-=ivAZCj990c+47kVdcaOUgU5sDvoWZNWAMHmVJWd9L3Vg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dde1555d-8aab-0faa-b70f-8510d751c3da@redhat.com>
Date: Thu, 6 Feb 2020 07:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ivAZCj990c+47kVdcaOUgU5sDvoWZNWAMHmVJWd9L3Vg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OPxz6hA4OB-P4a3WQmVB_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/2020 19.53, Aleksandar Markovic wrote:
> On Wed, Feb 5, 2020 at 7:03 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>>> The deprecation policy is primarily intended for notifying of changes
>>> to QEMU's stable interfaces ( CLI, HMP, QMP) which affect behaviour
>>> and usage of QEMU at runtime & are liable to break apps managing
>>> QEMU.
>>>
>>> Changes to build time options have no strong reason to be subjected to
>>> the deprecation process.
>>
>> This sounds reasonable to me.
>>
>> But: Should our deprecation policy be clearer on what is subject to
>> our deprecation procedure, and what is not?
>>
>> Regards,
>> Aleksandar
>>
> 
> And, there is even a section devoted to the build system in
> https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features :
> 
>     B.10 Build system
> 
>     B.10.1 Python 2 support (since 4.1.0)
> 
>     In the future, QEMU will require Python 3 to be available at build
> time. Support for Python 2 in scripts shipped with QEMU is deprecated.
> 
> The wording above comes from the file in our source tree: qemu-deprecated.texi .
> 
> Shouldn't the cases like "--enable-blues" be documented here? I think
> the deprecation of bluetooth devices support should have included a
> short section on involved configure options here.
> 
> Why is Python 2 support different to "--enable-blues" support? There
> should not be some unknown and arbitrary criterium what do and what
> doesn't come in this subsection.
> 
> Or, if our build system is not subject to our deprecation policy, than
> what is the entire subsection "B.10 Build system" doing here, in
> section "Deprecated features"?

See here:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02552.html

i.e. the section was here rather by "accident". It will be removed once
my "qemu-deprecated: Remove text about Python 2" patch hits the master
branch.

 Thomas



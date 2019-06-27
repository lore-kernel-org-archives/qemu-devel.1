Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23930C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB43C208CB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB43C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbgA-0002cC-AE
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgb8l-0001Za-A8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgb8j-0001TJ-QJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgb8j-0001SJ-I5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89333308A953;
 Thu, 27 Jun 2019 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-99.rdu2.redhat.com
 [10.10.123.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15AF060856;
 Thu, 27 Jun 2019 20:37:02 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>
References: <20190621153806.13489-1-wainersm@redhat.com>
 <20190621220748.GA1044@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6a37bfd9-a49d-b30a-2eaf-804984d3f964@redhat.com>
Date: Thu, 27 Jun 2019 17:36:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190621220748.GA1044@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 20:37:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] tests/acceptance: Handle machine type
 for ARM target
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 06/21/2019 07:07 PM, Cleber Rosa wrote:
> On Fri, Jun 21, 2019 at 11:38:06AM -0400, Wainer dos Santos Moschetta w=
rote:
>> Hi all,
>>
>> I'm still unsure this is the best solution. I tend to think that
>> any arch-independent test case (i.e. not tagged 'arch') should
>> be skipped on all arches except for x86_64. Opening up for
>> discussion though.
>>
> I'm confused... if you're calling a test case "arch-independent", why
> should it be skipped on all but one arch?  Anyway, I don't think we
> should define such a broad policy... This line of thought is very
> x86_64 centric, and quite honestly, doesn't map to QEMU's goals.

What I meant for "arch-independent" is a test which does not have "arch"=20
tag. You call it "generic test". We can agree on use "generic test" for=20
better communication.

The absence of "arch" tag can means either 1) "run on all built targets"=20
or 2) "pick one target and run it".=C2=A0 I suggested x86_64 thinking on =
case=20
2) because it provides a default machine type that I supposed (I might=20
be indeed wrong) just works on most cases. Your follow up patch [1]=20
addresses the scenario 1) but allows the user to pick that one target of =
2).

All in all, we should agree on the semantic of "arch" when it is not=20
present. Should it be "any" or "all"? Configurable or not? Let's discuss=20
this on [1].

So NACK this patch.

[1] [RFC PATCH] Acceptance tests: run generic tests on all built targets


>
> I agree that we're being a bit "disonest" by not assuring that tests
> we send will work on all targets... but at least we're having that
> discussion.  The next step would be to start triaging and discussing
> wether it's worth running those against other targets, considering
> the cost and benefits.
>
>> Note: It was decided that ARM targets should not default to any
>> machine type: https://www.mail-archive.com/qemu-devel@nongnu.org/msg62=
5999.html
>>
>> -- 8< --
>> Some tests are meant arch-independent and as such they don't set
>> the machine type (i.e. relying to defaults) on launched VMs. The arm
>> targets, however, don't provide any default machine so tests fail.
>>
>> This patch adds a logic on the base Test class so that machine type
>> is set to 'virt' when:
>>     a) The test case doesn't have arch:aarch64 or arch:arm tag. Here
>>        I assume that if the test was tagged for a specific arch then
>>        the writer took care of setting a machine type.
>>     b) The target binary arch is any of aarch64 or arm. Note:
>>        self.target_arch can end up None if qemu_bin is passed by
>>        Avocado parameter and the filename doesn't match expected
>>        format. In this case the test will fail.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accepta=
nce/avocado_qemu/__init__.py
>> index 2b236a1cf0..fb3e0dc2bc 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -9,6 +9,7 @@
>>   # later.  See the COPYING file in the top-level directory.
>>  =20
>>   import os
>> +import re
>>   import sys
>>   import uuid
>>  =20
>> @@ -65,10 +66,21 @@ class Test(avocado.Test):
>>           if self.qemu_bin is None:
>>               self.cancel("No QEMU binary defined or found in the sour=
ce tree")
>>  =20
>> +        m =3D re.match('qemu-system-(.*)', self.qemu_bin.split('/').p=
op())
>> +        if m:
>> +            self.target_arch =3D m.group(1)
>> +        else:
>> +            self.target_arch =3D None
>> +
> The "arch" tag and parameter are actually related to the target that
> should be used.  I don't see the need for a "target_arch" based on
> that.

I could have used self.arch indeed. But notice that self.arch is None=20
when "arch" tag does not exist. So I still need to guess the=20
architecture from the binary.

>
>>       def _new_vm(self, *args):
>>           vm =3D QEMUMachine(self.qemu_bin)
>>           if args:
>>               vm.add_args(*args)
>> +        # Handle lack of default machine type on some targets.
>> +        # Assume that arch tagged tests have machine type set properl=
y.
>> +        if self.tags.get('arch') is None and \
>> +           self.target_arch in ('aarch64', 'arm'):
>> +            vm.set_machine('virt')
> This (considering it deals with "arch" instead of "target_arch") is
> one of the very important points to be determined.  How much wrapping
> around different QEMU behavior on different targets/machines/devices
> should we do?  This will possibly be case-by-case discussions with
> different outcomes, but hopefully we can come up with a general
> direction.

Yep. Let's continue that discussion on your patch.

Thanks for the comments!

- Wainer


>
> Thanks,
> - Cleber.
>
>>           return vm
>>  =20
>>       @property
>> --=20
>> 2.18.1
>>



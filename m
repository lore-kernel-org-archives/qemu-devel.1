Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A976124683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/RwbKvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A976124683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRAw-0000b6-OQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwRAL-0008Uq-OT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwRAJ-0001zI-8r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:44:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwRAJ-0001yC-4J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580219066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hn1V9dao3s0n6SRjp1KNElxBAN/oRodnjrt1IoSuGl0=;
 b=V/RwbKvzIvMJye/egcGMviXBWN9PA3OtcGuE2w57KWHySVirQS4ymbjOozx26W0RvvOrMe
 8hk5IFoDubJZAR75fIPkLDMX7Bl4LY4FaOrVwx8xzLB+EgFJyUO+4o4x5wazJuKOvtDquS
 Q96g5gRFmAOqrrioH0JTvTmcRBhr8PE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-zUfYqqyLOieeo0uZO6Fs6g-1; Tue, 28 Jan 2020 08:44:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AA8613EC;
 Tue, 28 Jan 2020 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9267D8703F;
 Tue, 28 Jan 2020 13:44:17 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
 <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
 <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
 <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f4362239-7dbd-def7-83dc-59836ed33340@redhat.com>
Date: Tue, 28 Jan 2020 11:44:15 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zUfYqqyLOieeo0uZO6Fs6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/27/20 6:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hey Wainer,
>
> On 1/27/20 6:45 PM, Wainer dos Santos Moschetta wrote:
>> On 1/27/20 1:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/27/20 4:39 PM, Thomas Huth wrote:
>>>> On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 1/27/20 3:41 PM, Thomas Huth wrote:
>>>>>> The canon-a1100 machine can be used with the Barebox firmware. The
>>>>>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>>>>>> can use for testing.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33=20
>>>>>> +++++++++++++++++++++
>>
>>
>> What is the reason for not adding this case in boot_linux_console suite?
>
> Because there are too many tests in this file and it became hardly=20
> maintainable. Also it is easier to add a 'F:' entry in the MAINTAINERS=20
> file to each machine section.
>
>>>>>> =C2=A0=C2=A0 1 file changed, 33 insertions(+)
>>>>>> =C2=A0=C2=A0 create mode 100644 tests/acceptance/machine_arm_canon-a=
1100.py
>>>>>>
>>>>>> diff --git a/tests/acceptance/machine_arm_canon-a1100.py
>>>>>> b/tests/acceptance/machine_arm_canon-a1100.py
>>>>>> new file mode 100644
>>>>>> index 0000000000..3888168451
>>>>>> --- /dev/null
>>>>>> +++ b/tests/acceptance/machine_arm_canon-a1100.py
>>>>>> @@ -0,0 +1,33 @@
>>>>>> +# Functional test that boots the canon-a1100 machine with firmware
>>>>>> +#
>>>>>> +# Copyright (c) 2020 Red Hat, Inc.
>>>>>> +#
>>>>>> +# Author:
>>>>>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
>>>>>> +#
>>>>>> +# This work is licensed under the terms of the GNU GPL, version=20
>>>>>> 2 or
>>>>>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>>>>>> +
>>>>>> +from avocado_qemu import Test
>>>>>> +from avocado_qemu import wait_for_console_pattern
>>>>>> +from avocado.utils import archive
>>>>>> +
>>>>>> +class CanonA1100Machine(Test):
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 def test_arm_canona1100(self):
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ar=
m
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine=
:canon-a1100
>>>>>
>>>>> To the maintainer taking this, please add:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :a=
vocado: tags=3Dpflash_cfi02
>>>>
>>>> Should there be a "device:" between the "=3D" and the device name? At
>>>> least I can see some other files using "device:" for similar tags...
>>>
>>> Ah yes you are right, it is clearer.
>>
>>
>> Notice that avocado_qemu won't automatically convert that tag into=20
>> QEMU's -device option, If that is the intention...
>
> That could be useful, but currently my usage is 'avocado run -t=20
> device:pcnet32' to run all tests using the pcnet32 network device.
>
> I have pflash tests which I plan to use the same way.
>
> This is a hint to other maintainers, who don't have to look at each=20
> test to find the set of tests that suits them.
>
> IOW "As a maintainer of the device:pflash I'm interested to run all=20
> tests using this device, and while they pass I won't look at them".
>
> (This is how I expect maintainers to use the acceptance tests when I=20
> add some).


OK, understood. Thanks for sharing your usage of acceptance tests!

- Wainer




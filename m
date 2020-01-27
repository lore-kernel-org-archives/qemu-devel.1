Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4542C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F75214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaNBkOs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F75214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8Tq-0005eW-VH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw8SA-0004vQ-1m
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw8S7-0002IJ-6p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:45:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw8S6-0002Ha-WA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSGfOssOTucN2+HAUd/XYOyoe5e6O3EVKoc7YRzPJeA=;
 b=YaNBkOs2IvGQrNOocEoxhOiI0AokaDMe+tFSGPI4KcrCShTdyjGDb1c/oDmJ+Jz781oAfm
 YQjDywYJPQgGvcHi/w9vzj4pHv1r3PS3PJrU/eG9J81QoieUU11z1WCkOpCFlOxcCSHrSO
 jsac5BM5/BFWGTlnp64E2JSMIFdK0iM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-hPNdAvmyMNmLB8LOn5kxtQ-1; Mon, 27 Jan 2020 12:45:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A841813E8;
 Mon, 27 Jan 2020 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09F42863CF;
 Mon, 27 Jan 2020 17:45:21 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
 <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
Date: Mon, 27 Jan 2020 15:45:20 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hPNdAvmyMNmLB8LOn5kxtQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/27/20 1:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/27/20 4:39 PM, Thomas Huth wrote:
>> On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/27/20 3:41 PM, Thomas Huth wrote:
>>>> The canon-a1100 machine can be used with the Barebox firmware. The
>>>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>>>> can use for testing.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33=20
>>>> +++++++++++++++++++++


What is the reason for not adding this case in boot_linux_console suite?


>>>> =C2=A0=C2=A0 1 file changed, 33 insertions(+)
>>>> =C2=A0=C2=A0 create mode 100644 tests/acceptance/machine_arm_canon-a11=
00.py
>>>>
>>>> diff --git a/tests/acceptance/machine_arm_canon-a1100.py
>>>> b/tests/acceptance/machine_arm_canon-a1100.py
>>>> new file mode 100644
>>>> index 0000000000..3888168451
>>>> --- /dev/null
>>>> +++ b/tests/acceptance/machine_arm_canon-a1100.py
>>>> @@ -0,0 +1,33 @@
>>>> +# Functional test that boots the canon-a1100 machine with firmware
>>>> +#
>>>> +# Copyright (c) 2020 Red Hat, Inc.
>>>> +#
>>>> +# Author:
>>>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>>>> +
>>>> +from avocado_qemu import Test
>>>> +from avocado_qemu import wait_for_console_pattern
>>>> +from avocado.utils import archive
>>>> +
>>>> +class CanonA1100Machine(Test):
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 def test_arm_canona1100(self):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:c=
anon-a1100
>>>
>>> To the maintainer taking this, please add:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avo=
cado: tags=3Dpflash_cfi02
>>
>> Should there be a "device:" between the "=3D" and the device name? At
>> least I can see some other files using "device:" for similar tags...
>
> Ah yes you are right, it is clearer.


Notice that avocado_qemu won't automatically convert that tag into=20
QEMU's -device option, If that is the intention...

Thanks!

- Wainer


>
>



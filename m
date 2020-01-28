Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFD3205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAW5JlG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFD3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRSL-0008BD-1e
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwRRH-0007cy-1I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwRRF-0000rI-72
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:01:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwRRF-0000qR-2i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580220116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXg/X3vLFRTWY3nsE39OIA4RzJ5gQ0H3jrsDYrJ6ngs=;
 b=MAW5JlG+mD1iI2EBDRxjuk8Rahn7DEHIrffxqRPP5NKO+mF9tFuu0CtLBrSnvxWdvXMsp0
 EHhgwoyvlLj+uam1H9kFaUjWPQUU8ewMSW9iufINVHsM3YgDsPMjFSGQWxTCh6uImBqZEV
 A5ErAyOo3846mx3hJ2ESh3pcQRiutdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-yhb9YR8hPGyA8omKbpKG5Q-1; Tue, 28 Jan 2020 09:01:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E4B10071F9;
 Tue, 28 Jan 2020 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92FFB1001281;
 Tue, 28 Jan 2020 14:01:40 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
 <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
 <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
 <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
 <6b5cba1d-4aba-cd59-74a8-880a8d800a35@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <766805d9-0dbc-eda1-4157-1feb33fc9ea5@redhat.com>
Date: Tue, 28 Jan 2020 12:01:38 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6b5cba1d-4aba-cd59-74a8-880a8d800a35@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yhb9YR8hPGyA8omKbpKG5Q-1
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


On 1/28/20 10:16 AM, Thomas Huth wrote:
> On 27/01/2020 21.56, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hey Wainer,
>>
>> On 1/27/20 6:45 PM, Wainer dos Santos Moschetta wrote:
>>> On 1/27/20 1:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 1/27/20 4:39 PM, Thomas Huth wrote:
>>>>> On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 1/27/20 3:41 PM, Thomas Huth wrote:
>>>>>>> The canon-a1100 machine can be used with the Barebox firmware. The
>>>>>>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>>>>>>> can use for testing.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>> ---
>>>>>>>  =C2=A0=C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33
>>>>>>> +++++++++++++++++++++
>>>
>>> What is the reason for not adding this case in boot_linux_console suite=
?
>> Because there are too many tests in this file and it became hardly
>> maintainable. Also it is easier to add a 'F:' entry in the MAINTAINERS
>> file to each machine section.


Maybe it reached an inflection point and deserves to be split among=20
files and directories...


> Additionally, this is not a test with a Linux kernel, it uses the
> Barebox firmware instead. So boot_*linux*_console.py sounds like the
> wrong place for this test.

OK, makes complete sense.

One last comment about this new file. To not look like boring I let=20
pylint say that for me :) :

[wainersm@localhost qemu]$ pylint-3=20
tests/acceptance/machine_arm_canon-a1100.py
************* Module machine_arm_canon-a1100
tests/acceptance/machine_arm_canon-a1100.py:1:0: C0103: Module name=20
"machine_arm_canon-a1100" doesn't conform to snake_case naming style=20
(invalid-name)

With that fix:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Thanks,

Wainer


>
>   Thomas



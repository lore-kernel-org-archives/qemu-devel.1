Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E435F24681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf5TY6W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E435F24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwPqG-0003y7-6N
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwPnT-0002nQ-NK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwPnS-00035R-Ow
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:16:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37846
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwPnS-000354-MU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580213805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=q6gUrwN2AZjCBQs0Mq9KS9CzBrHVLDSRXxFIuYn4DZo=;
 b=Nf5TY6W2UhNyxlMjKLkv83BazBoVQN70GGAiqJQvNnaPGVo9kfzDzs10Vm63F8Wpob7JEj
 /QQ7J9RgjtLkHPkKEmT/bxX/3c8elT/xrUpyFNhzDVezy4/NRdaWiKl7+VuITPb3nLQrYg
 1JfdDy9lWqD4pN4Yw5LB1K+6zWUW/4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-HXVbC5CMMmimxHD9cMPX7Q-1; Tue, 28 Jan 2020 07:16:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB450800EBB;
 Tue, 28 Jan 2020 12:16:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-147.ams2.redhat.com [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3254319C58;
 Tue, 28 Jan 2020 12:16:34 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
 <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
 <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
 <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6b5cba1d-4aba-cd59-74a8-880a8d800a35@redhat.com>
Date: Tue, 28 Jan 2020 13:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HXVbC5CMMmimxHD9cMPX7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

On 27/01/2020 21.56, Philippe Mathieu-Daud=C3=A9 wrote:
> Hey Wainer,
>=20
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
>>>>>> =C2=A0=C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33
>>>>>> +++++++++++++++++++++
>>
>>
>> What is the reason for not adding this case in boot_linux_console suite?
>=20
> Because there are too many tests in this file and it became hardly
> maintainable. Also it is easier to add a 'F:' entry in the MAINTAINERS
> file to each machine section.

Additionally, this is not a test with a Linux kernel, it uses the
Barebox firmware instead. So boot_*linux*_console.py sounds like the
wrong place for this test.

 Thomas



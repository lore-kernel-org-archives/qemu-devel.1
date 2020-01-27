Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42675C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF7220716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uzao6MBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6VD-0007ne-8b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw6U7-0006zt-Jx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw6U2-0003rM-Ut
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:39:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw6U2-0003qm-Rh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580139566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jQs9KlunjJne6iaccbTLtY9Fo/2axkW4mD4egK/4l9M=;
 b=Uzao6MBH20urs6dCzirRVbiTLForEO7LYZnU3nCsZETvwbHTyUAALD9liw+RsNKtGc7Bt+
 uroFqHpHJoWA3M6wQx3pPJTSkHNkvUtPXhaqqtcRT/7LLOjRz1VNgCvIX1vRFfOqaoKI1z
 YmQxnPfcEO+HPAVlk/Z/3FL1vfws+is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-s3wsw1wkNMq7TwfYUIVE7Q-1; Mon, 27 Jan 2020 10:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 624528B7883;
 Mon, 27 Jan 2020 15:39:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA71460BF4;
 Mon, 27 Jan 2020 15:39:11 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
Date: Mon, 27 Jan 2020 16:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: s3wsw1wkNMq7TwfYUIVE7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/27/20 3:41 PM, Thomas Huth wrote:
>> The canon-a1100 machine can be used with the Barebox firmware. The
>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>> can use for testing.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33 ++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 33 insertions(+)
>> =C2=A0 create mode 100644 tests/acceptance/machine_arm_canon-a1100.py
>>
>> diff --git a/tests/acceptance/machine_arm_canon-a1100.py
>> b/tests/acceptance/machine_arm_canon-a1100.py
>> new file mode 100644
>> index 0000000000..3888168451
>> --- /dev/null
>> +++ b/tests/acceptance/machine_arm_canon-a1100.py
>> @@ -0,0 +1,33 @@
>> +# Functional test that boots the canon-a1100 machine with firmware
>> +#
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +#
>> +# Author:
>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>> +
>> +from avocado_qemu import Test
>> +from avocado_qemu import wait_for_console_pattern
>> +from avocado.utils import archive
>> +
>> +class CanonA1100Machine(Test):
>> +
>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_arm_canona1100(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:can=
on-a1100
>=20
> To the maintainer taking this, please add:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: ta=
gs=3Dpflash_cfi02

Should there be a "device:" between the "=3D" and the device name? At
least I can see some other files using "device:" for similar tags...

 Thomas



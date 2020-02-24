Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22737C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11A82072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekb6lv14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Cmm-0004sM-5x
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6CmD-0004TF-GT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6CmC-0002R5-CL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:23:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6CmC-0002Qy-91
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582547035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gglqy4Z9U3P88TF3kAzxyU7xRwg97j4Tr4JhkAD0KKo=;
 b=Ekb6lv141JSy0jS+iPOak+BQBF+Q/Eu05DnrLVlyrEmZf7I5tQRCF5vQaCnC2Fn3Ldm4CX
 AljFm60TjHECB7W6Dob8zHDL7aKkOZXg5NSrpPDn5C+avNFTjAHzR8dQo4db+KY7ksj+/3
 qiQIzc+gDtpzPdnjgvA8sbmqsIoqkTs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-OaGmjL7TNmOjRxP8iw7L1A-1; Mon, 24 Feb 2020 07:23:53 -0500
X-MC-Unique: OaGmjL7TNmOjRxP8iw7L1A-1
Received: by mail-wr1-f72.google.com with SMTP id u8so5521722wrp.10
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rUjiMaDlkGeKoD0fe7Ehd3mVmfxsIzMPGZeRoOnOEcw=;
 b=r2BHhPIcgm1qDRl7cACRyqNRij7atbSwwBSuX5ZAnJG6o3aZkZoUCqsjOdpi3v36jx
 Fy7HAELEwCfVlaHJBVySHoZ2jVcBYbRDAxg95EDHsdfBi+vC2dPpRBZ1hxG7CbTGbD+f
 2JzTafe3kERuIokRFXZlmPokiW0uyBhUz+py5vuM0YD1iiu/Z4X+QdJ+0wT/uypPlcMB
 PIhgOizqmMmRFIi0CDu/3wgtCDe4Oe+KERzBZ3/oz7PgPhWaqQvIfBGaH4HG0o6nfHVx
 xN0t8OAxSt8Zjfq2G/PqDRMv7WaHmlp1GqkNqrOlJbDz4IQBaSPKI1y9fQCYTCk0k/40
 zV0w==
X-Gm-Message-State: APjAAAWfX17r5heolIFUICsustbeszbdpaw8fQEtChHWZzZrC8zIJowP
 7BBmDf5T6mbFOljiftZCZH8w+nHgkk6aW/K800zK2Msxg0Cbfp4zadqcGFFrOiy997LskQ9RxTQ
 VKg+nFgnlfiIZABA=
X-Received: by 2002:a1c:bdc6:: with SMTP id
 n189mr22496635wmf.102.1582547032357; 
 Mon, 24 Feb 2020 04:23:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyz8s/HNlz77m5zNHL06POCJc5O991LY62/KcwJlcL5yzMwwqxzU62fM4i3+sk38QbQuZjkvw==
X-Received: by 2002:a1c:bdc6:: with SMTP id
 n189mr22496602wmf.102.1582547031997; 
 Mon, 24 Feb 2020 04:23:51 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c6sm2010623wrx.39.2020.02.24.04.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:23:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/docker: Add test-acceptance runner
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20190818231827.27573-1-philmd@redhat.com>
 <20190818231827.27573-4-philmd@redhat.com>
 <20190820133113.GA4422@dhcp-17-173.bos.redhat.com>
 <87d0d5bk73.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7cca3e85-442c-c6a8-a905-a800a4f4af57@redhat.com>
Date: Mon, 24 Feb 2020 13:23:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87d0d5bk73.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 2:41 PM, Alex Benn=C3=A9e wrote:
> Cleber Rosa <crosa@redhat.com> writes:
>> On Mon, Aug 19, 2019 at 01:18:26AM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Add a runner script to be able to run acceptance tests within
>>> Docker images. We can now reproduce Travis CI builds locally (and
>>> debug  them!).
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   tests/docker/test-acceptance | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>   create mode 100755 tests/docker/test-acceptance
>>>
>>> diff --git a/tests/docker/test-acceptance b/tests/docker/test-acceptanc=
e
>>> new file mode 100755
>>> index 0000000000..84edaa676c
>>> --- /dev/null
>>> +++ b/tests/docker/test-acceptance
>>> @@ -0,0 +1,21 @@
>>> +#!/bin/bash -e
>>> +#
>>> +# Compile default Travis-CI target and run Avocado acceptance tests
>>> +#
>>> +# Copyright (c) 2019 Red Hat Inc.
>>> +#
>>> +# Authors:
>>> +#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>> +# or (at your option) any later version. See the COPYING file in
>>> +# the top-level directory.
>>> +
>>> +. common.rc
>>> +
>>> +cd "$BUILD_DIR"
>>> +
>>> +DEF_TARGET_LIST=3D"x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch6=
4-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>>> +build_qemu
>>> +check_qemu check-acceptance
>>> --=20
>>> 2.20.1
>>>
>>>
>>
>> I'm currently seeing test errors when running in a container:
>>
>>    MKDIR   /tmp/qemu-test/build/tests/results
>>    AVOCADO tests/acceptance
>> JOB ID     : fe56cc0b2d1adbc0b5bb5828902e113d596edccf
>> JOB LOG    : /tmp/qemu-test/build/tests/results/job-2019-08-19T22.13-fe5=
6cc0/job.log
>>   (01/27) /tmp/qemu-test/src/tests/acceptance/boot_linux_console.py:Boot=
LinuxConsole.test_x86_64_pc:  ERROR: join() argument must be str or bytes, =
not 'NoneType' (0.05 s)
>> Interrupting job (failfast).
>> RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 26 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>> JOB TIME   : 0.26 s
>> /tmp/qemu-test/src/tests/Makefile.include:1158: recipe for target 'check=
-acceptance' failed
>> make: *** [check-acceptance] Error 9
>>
>> That being said, I'm not running it under docker, but under podman,
>> although I'm not convinced yet that is the defining issue.  I'll try
>> to identify what's going here.
>=20
> Was there a conclusion to the discussion about this series?

No sure if there was a conclusion...

tests/docker/ is listed as 'Maintained' but the listed maintainers only=20
use Docker. If Podman is supported, then maybe we need another=20
maintainer for Podman? We are not testing it so far.



Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B294C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8900E20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYRYf6aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8900E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXrf-0007bX-BV
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ipXqw-0006uY-2Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ipXqu-0000qz-RZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:27:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ipXqu-0000mF-Hx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578576475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sF0ueo2+TTDLb5D9F78loHCw/00F08jMzmaFdCn+eRg=;
 b=BYRYf6aaV1peCP3oibQ+nWAEOaQ7NWD+7YinNRbv73JZoGzU+AlKrzCoJHTtOkE7WcWT6s
 wL8QlPG5bquxdpRkNjzzIvc7JMKwP+uftYHJXSVPLRqEpNIwN/7eBGns/LX6t5AjTG086Y
 PMB6GXppztmUuIwqxa3+jWGO4CG0XJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-v_9o27oNOe2Re57FR-xYdg-1; Thu, 09 Jan 2020 08:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 708101005502;
 Thu,  9 Jan 2020 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.gru2.redhat.com
 [10.97.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF56C80A2F;
 Thu,  9 Jan 2020 13:27:46 +0000 (UTC)
Subject: Re: [PATCH 1/2] travis.yml: avocado: Print logs of non-pass tests only
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191230184327.2800-1-wainersm@redhat.com>
 <20191230184327.2800-2-wainersm@redhat.com> <8736cr5x8n.fsf@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <dc087501-61cf-cfa4-91cd-6372690908ea@redhat.com>
Date: Thu, 9 Jan 2020 11:27:44 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8736cr5x8n.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: v_9o27oNOe2Re57FR-xYdg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, philmd@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/7/20 9:20 AM, Alex Benn=C3=A9e wrote:
> Wainer dos Santos Moschetta <wainersm@redhat.com> writes:
>
>> The acceptance tests build on Travis is configured to print
>> the entire Avocado's job log in case any test fail. Usually one is
>> interested on failed tests only though. So this change the Travis
>> configuration in order to show the log of tests which status is
>> different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
>> will have the log printed too because it can help to debug some
>> condition on CI environment which is not being fulfilled.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   .travis.yml | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 376b7d6dfa..e7fdcb238c 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -262,8 +262,8 @@ matrix:
>>       - env:
>>           - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>>           - TEST_CMD=3D"make check-acceptance"
>> -      after_failure:
>> -        - cat tests/results/latest/job.log
>> +      after_script:
>> +        - python3 -c 'import json; r =3D
>> json.load(open("tests/results/latest/results.json"));
>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>> ("PASS", "SKIP")]' | xargs cat
> Shame there is no scriptlet for this sort of thing packaged with
> avocado. Anyway I'll give it a spin and see if any failures come up.

Good point. I'm working on such as scriptlet ('plugin' on Avocado=20
jargon) but I think we can stick with this change.

Thanks!

- Wainer

>
>>         addons:
>>           apt:
>>             packages:
>



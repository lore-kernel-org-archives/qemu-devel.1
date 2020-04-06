Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EAC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22AE20780
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Baxe4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22AE20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33973 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLTqs-0002gM-4n
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLTq9-0001kC-LB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLTq8-0002Zd-LP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:39:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLTq8-0002ZP-Ij
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586187548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNfL2omsBhQVXlV3HYHqAS3ViRskOp1K5Q8Jvf5pGBM=;
 b=E8Baxe4ywkZANIVqM63kHRFEZd85FQyC2kpBxC42z02zUHcX3ZqEqJtvwVCnQclM0gqkDU
 o76NXngXlEBJJ6zkdZyAZdoTn0BkW4vGtz1wPrCeppLzXJ4Hv9PIZSSfXN6xfc18laQcsi
 ZXf6YhHDqZa30b8BXPiZ/AMuRR6HzBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-AIC3DPtLNuKpOtgCW8iCiQ-1; Mon, 06 Apr 2020 11:39:04 -0400
X-MC-Unique: AIC3DPtLNuKpOtgCW8iCiQ-1
Received: by mail-wr1-f72.google.com with SMTP id t25so8541865wrb.16
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 08:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J8RDXc9yKh5UMGoOkB00ikg9/8z4jUB9RJ31knku4D8=;
 b=EyI9PBjJuCbSShMv0ct55Q1Cy/7Dt5rdSp1brY3ahlpNPrY9MdnB/k+FfkPUGi2bQN
 +CceYHfndx/ReM3aDUALpEkAEYCoSNIs1h4z/lbyBbXewNGB8DULWKjNxebC/OS6M/EM
 6o+e5TfcL54ID9JQhjDIJmHuSTXtp+G+UNKdkcc6bVO2vjG4dUQctvaZMxAmWkMOD5IF
 1A4TuwHZ/mceeU7b+da7/L0G9RO53K+Xqb6XzIAQrSOs7bhpRTgQUD02JH3TyMIgIjC1
 z5tKnRnPdXka9gPWCekRSKTs7ShcqkmZbWVObEiJ8FvzAqhZV/An2GezYoTY4WnPv33s
 xZyA==
X-Gm-Message-State: AGi0PuamU0KK11zhNAIbPcQ/WWeNMnOdRt8WayjTwUFuM1ZSVFkcc/gQ
 JvXegAjPOyEcP3IrvwiqNJUJNIkXwNdU+BHo7YU8ot96FVbqfG2w9FEtMuwUPVENVdSuqZZFbTO
 12/WB7ISq8YFRXXY=
X-Received: by 2002:a5d:6588:: with SMTP id q8mr22430039wru.189.1586187543465; 
 Mon, 06 Apr 2020 08:39:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpyjDlnEXmTB3ykTO6u0pcdUuw2WMrxGlPEhhecyhJXKQii5SWsSTfiC7WM8ASrmFS1FMS2A==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr22430016wru.189.1586187543199; 
 Mon, 06 Apr 2020 08:39:03 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a8sm24507369wmb.39.2020.04.06.08.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 08:39:02 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets
 before check-acceptance
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-8-philmd@redhat.com> <87369gbpgq.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b9c706f-b9b0-35c6-457f-e03f746c9287@redhat.com>
Date: Mon, 6 Apr 2020 17:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87369gbpgq.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 5:31 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   .travis.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 2fd63eceaa..c6b32da447 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -317,7 +317,7 @@ jobs:
>>         dist: bionic
>>         env:
>>           - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alp=
ha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64e=
l-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmm=
u,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>> -        - TEST_CMD=3D"make check-acceptance"
>> +        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-assets
>> check-acceptance DEBUG=3D1"
>=20
> You could use TEST_BUILD_CMD for the fetching of acceptance tests - can
> that be done in parallel?

I'd say calling fetch-acceptance-assets parallelized is what seems to=20
break this Travis job (which is why I enforced -j1), but I'll refer to=20
Willian here.

>=20
> Also no point in -j1 here - it's implied.

You are right, I wanted to be sure this still work even if the globlal=20
script running the tests is updated. But the correct fix is probably to=20
use .NOTPARALLEL in the fetch-acceptance-assets rule in the previous patch.

>=20
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>>         after_script:
>>           - python3 -c 'import json; r =3D json.load(open("tests/results=
/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["sta=
tus"] not in ("PASS", "SKIP")]' | xargs cat
>=20
>=20



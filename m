Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D15DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD620702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ9Qahod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4Lq-0004eN-FN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw4LH-00047c-5K
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw4LF-000443-L8
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:22:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw4LF-00043o-HP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580131332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aB9kUk5ctG0RxgHEX2uURz1zw1nvRkSkcTM8skY9h0s=;
 b=ZZ9QahodZdMaAXwdZzmE3wStBBfNuTwkjrKcJV+euJUFdTixUYR7yQcRUnd5QzVsyqo/BQ
 Fxze+7fOUq9BCpog/dvZyre41AiYguyXTkHY0MOMawO38NWaV38LctkW+gLmbIg0YrrG3j
 N71Jqr//0sIW/vrEo8/XD1UZYLG6Z8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-esrO01dtNrCh4ZK5_SzEQA-1; Mon, 27 Jan 2020 08:22:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F64B13E2;
 Mon, 27 Jan 2020 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4226360BF4;
 Mon, 27 Jan 2020 13:22:06 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
 <8f085a1a-b9df-29d4-db51-eb345a44a971@redhat.com>
 <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <37b98a5d-8e96-9961-a230-4ee47d0c3169@redhat.com>
Date: Mon, 27 Jan 2020 11:22:05 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: esrO01dtNrCh4ZK5_SzEQA-1
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/25/20 2:43 PM, Thomas Huth wrote:
> On 24/01/2020 22.28, Wainer dos Santos Moschetta wrote:
>> On 1/24/20 3:03 PM, Thomas Huth wrote:
>>> The 2018 edition of the QEMU advent calendar 2018 featured Linux images
>>> for various non-x86 machines. We can use them for a boot tests in our
>>> acceptance test suite.
>>>
>>> Let's also make sure that we build the corresponding machines in Travis=
,
>>> and while we're there, drop the superfluous --python parameter (python3
>>> is now the only supported version anyway).
>> Yes, please, removal of --python was in my wish list.
>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =C2=A0 .travis.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>  =C2=A0 tests/acceptance/boot_linux_console.py | 96 +++++++++++++++++++=
+++++++
>>>  =C2=A0 2 files changed, 97 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..73ca12c921 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -268,7 +268,7 @@ matrix:
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) tests
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/usr=
/bin/python3
>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-so=
ftmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68=
k-softmmu,sparc-softmmu"
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>>> CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68=
k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or=
1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-sof=
tmmu,xtensa-softmmu"
>>>
>>
>> Perhaps use MAIN_SOFTMMU_TARGETS in only append the other targets, like:
>>
>> --target-list=3D${MAIN_SOFTMMU_TARGETS},alpha-softmmu,sparc-softmmu,....
> Not sure ... while it is a nice way to shorten the line here, it adds a
> dependecy to that variable ... and MAIN_SOFTMMU_TARGETS has been changed
> a couple of times during the course of time, so we might risk to lose
> some testing coverage here in case someone removes a target from
> MAIN_SOFTMMU_TARGETS but forgets to add it here again...? I think we
> should better use the explicit list here instead.

Your reasoning makes sense to me. Feel free to ignore my suggestion.

Thanks,

Wainer

>
>   Thomas
>
>



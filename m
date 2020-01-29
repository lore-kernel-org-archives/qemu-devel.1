Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29FCC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF39D20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDIWYKCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhfR-0008Es-QU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwhes-0007ng-EG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwhep-0006q8-M5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:21:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52019
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwhep-0006op-ER
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580282462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=H+kLgPzLtG8LB6H0jlRDss+WdldbxhUqneKXpAdi/mU=;
 b=iDIWYKCKQY3JXWzieFEHWGfR/11pTe28jScP2OyXU3goDZ6E98NkH6K+F3lahlkYszt5q1
 l5/c8I+9SFpGFf7KcGljzH/oTF8IJNMDy04m5luohoLI+LA/aMEDywFa3ki8EfsHOMb5+A
 GW70lpUbosaw1xQtLH3n5OsTP6PahG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-qpSpve21M0qXzGd2dy3G_A-1; Wed, 29 Jan 2020 02:20:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B53918A6EC0;
 Wed, 29 Jan 2020 07:20:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F2D84BC5;
 Wed, 29 Jan 2020 07:20:45 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com> <874kwfg2qh.fsf@linaro.org>
 <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
 <266be40c-6f5c-ad76-d326-bb174ebf047f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <411567d3-2a32-eaf8-7689-3649aad4267c@redhat.com>
Date: Wed, 29 Jan 2020 08:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <266be40c-6f5c-ad76-d326-bb174ebf047f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qpSpve21M0qXzGd2dy3G_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/01/2020 14.33, Wainer dos Santos Moschetta wrote:
>=20
> On 1/28/20 11:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On Tue, Jan 28, 2020 at 1:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
>> wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> The NAME variable can be used to describe nicely a job (see [*]).
>>>>> As we currently have 32 jobs, use it. This helps for quickly
>>>>> finding a particular job.
>>>>>
>>>>> =C2=A0=C2=A0 before: https://travis-ci.org/qemu/qemu/builds/639887646
>>>>> =C2=A0=C2=A0 after: https://travis-ci.org/philmd/qemu/builds/64179504=
3
>>>> Very good idea, correlating a job in the GUI to an entry in the yml
>>>> file
>>>> was really a pain, so far.
>>>>
>>>>> [*]
>>>>> https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-wi=
thin-matrices
>>>>>
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>> =C2=A0 .travis.yml | 101
>>>>> ++++++++++++++++++++++++++++++++++------------------
>>>>> =C2=A0 1 file changed, 67 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>> index 6c1038a0f1..d68e35a2c5 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -94,24 +94,28 @@ after_script:
>>>>>
>>>>> =C2=A0 matrix:
>>>>> =C2=A0=C2=A0=C2=A0 include:
>>>>> -=C2=A0=C2=A0=C2=A0 - env:
>>>>> +=C2=A0=C2=A0=C2=A0 - name: "[x86] GCC static (user)"
>>>> Could you please drop the [x86] and other architectures from the names=
?
>>>> Travis already lists the build architecture in the job status page, so
>>>> this information is redundant.
>>> Hmm for me the Travis page mis-renders the architecture (on firefox) so
>>> I do find the arch in the text fairly handy.
>> This might be a font problem, I can't see the architecture on neither
>> Firefox nor Chrome:
>>
>> https://pasteboard.co/IS3O358.png
>=20
>=20
> It is the partially hidden column between the job number and the penguin
> (or apple if MacOS).
>=20
> Funny, I can see the arch on Philippe's dashboard
> (https://travis-ci.org/philmd/qemu) but it disappears on my own
> (https://travis-ci.org/wainersm/qemu).

I've never had problems here, for me the column shows up correctly
everywhere. It looks like this:

 http://people.redhat.com/~thuth/travis.png

> Anyway, most of the jobs run on x86_64. So perhaps mark only the non-x86
> ones?

Sounds like a good compromise to me!

 Thomas



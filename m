Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA0BC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080D622522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKXaLHsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080D622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwR1G-0001ox-5i
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwR0X-0000z5-0U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwR0T-0006XV-1w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:34:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwR0S-0006X2-U4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580218455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prJ7CyNKefmrUV0g8Vhe2T6WaZwHKQuc+8DwRKfss/A=;
 b=DKXaLHsDzCZuSDb6BLEfeYhU8GivIcjbWhlSl+l75ds+srwqJalAv5kaR1Gxe32zxizGhE
 P8T53Cs4k4FGNfDUFaAoMIzvCi+ULvohMRUvZPCaBM1CmprjR3Lr+Db9XPKclHwpXVj832
 AKU6PjmAtSL6AUDQV92+Y57HHj+BZxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-uylLu2oCPBCIVkPr0pUdkw-1; Tue, 28 Jan 2020 08:34:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77B798010DC;
 Tue, 28 Jan 2020 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74AB860C05;
 Tue, 28 Jan 2020 13:34:01 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com> <874kwfg2qh.fsf@linaro.org>
 <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <266be40c-6f5c-ad76-d326-bb174ebf047f@redhat.com>
Date: Tue, 28 Jan 2020 11:33:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uylLu2oCPBCIVkPr0pUdkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/28/20 11:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On Tue, Jan 28, 2020 at 1:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The NAME variable can be used to describe nicely a job (see [*]).
>>>> As we currently have 32 jobs, use it. This helps for quickly
>>>> finding a particular job.
>>>>
>>>>    before: https://travis-ci.org/qemu/qemu/builds/639887646
>>>>    after: https://travis-ci.org/philmd/qemu/builds/641795043
>>> Very good idea, correlating a job in the GUI to an entry in the yml fil=
e
>>> was really a pain, so far.
>>>
>>>> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs=
-within-matrices
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>   .travis.yml | 101 ++++++++++++++++++++++++++++++++++----------------=
--
>>>>   1 file changed, 67 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 6c1038a0f1..d68e35a2c5 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -94,24 +94,28 @@ after_script:
>>>>
>>>>   matrix:
>>>>     include:
>>>> -    - env:
>>>> +    - name: "[x86] GCC static (user)"
>>> Could you please drop the [x86] and other architectures from the names?
>>> Travis already lists the build architecture in the job status page, so
>>> this information is redundant.
>> Hmm for me the Travis page mis-renders the architecture (on firefox) so
>> I do find the arch in the text fairly handy.
> This might be a font problem, I can't see the architecture on neither
> Firefox nor Chrome:
>
> https://pasteboard.co/IS3O358.png


It is the partially hidden column between the job number and the penguin=20
(or apple if MacOS).

Funny, I can see the arch on Philippe's dashboard=20
(https://travis-ci.org/philmd/qemu) but it disappears on my own=20
(https://travis-ci.org/wainersm/qemu).

Anyway, most of the jobs run on x86_64. So perhaps mark only the non-x86=20
ones?

- Wainer

>
>



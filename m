Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921CC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48BF2071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7xF+nIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48BF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieBUc-0007W1-Ub
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 00:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ieBTu-00073v-5g
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ieBTp-0006eI-SK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:21:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ieBTp-0006c2-H0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575868868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPZU3xXpuYUx1tpiqNK/YSD+CUUaDtrA7ENO5AOQ9NE=;
 b=V7xF+nIltAwNPWvrvg142qW7D5yCNb/AFffwFAk/8lhIxBZsz7UP/vVdRlPehFPtEUIpTV
 8QeedkdBqX66rEz3S7EzQS5VDV0tS9/OwCPQg9BUUetfaYIU3w3CwSVN8Qk6YBe4pfeZ/g
 QeV8/zaMcO/1E/8/8R1Yd24Dk9qB4f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-RmGIC_OtMyS9QSuYqCjZZw-1; Mon, 09 Dec 2019 00:21:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 167A7107ACE6;
 Mon,  9 Dec 2019 05:21:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C78B60148;
 Mon,  9 Dec 2019 05:21:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 077D41138606; Mon,  9 Dec 2019 06:21:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v2 3/5] MAINTAINERS: Adjust maintainership for Malta board
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <b2bdb632-7f17-85e5-5c8c-079316fe38bd@redhat.com>
 <CAL1e-=jxootskQhJ29kfuDdSqCpObUdJfO3MW=zsuupqQ-t3Xg@mail.gmail.com>
Date: Mon, 09 Dec 2019 06:20:59 +0100
In-Reply-To: <CAL1e-=jxootskQhJ29kfuDdSqCpObUdJfO3MW=zsuupqQ-t3Xg@mail.gmail.com>
 (Aleksandar Markovic's message of "Sat, 7 Dec 2019 20:15:00 +0100")
Message-ID: <87k176nkg4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RmGIC_OtMyS9QSuYqCjZZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Thursday, November 14, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> +Paul Burton
>>
>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Change the maintainership for Malta board to improve its quality.
>>>
>>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>   MAINTAINERS | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3bf2144..6afec32 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -955,8 +955,9 @@ F: hw/display/jazz_led.c
>>>   F: hw/dma/rc4030.c
>>>     Malta
>>> -M: Aurelien Jarno <aurelien@aurel32.net>
>>>
>> > +R: Aurelien Jarno <aurelien@aurel32.net>
>>
>> Aurelien, do you want to stay co-maintainer with this one?
>> Else, thanks for staying listed as designated reviewer :)
>>
>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>
>> I'm happy to continue Aurelien work with this board :)
>> Similarly to the Fuloong board, I mostly use the Malta as a hobby, so I'=
ll
>> use my personal email.
>>
>> Paul, do you mind being co-maintainer or at least listed as designated
>> reviewer here?
>>
>> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>
>>
>> I don't see commits from Herv=C3=A9 with this board, so he is probably n=
ot
>> interested.
>>
>>   S: Maintained
>>>
>>
>> Until Paul is interested in co-maintenance, let's change this board stat=
us
>> to 'Odd Fixes'.
>>
>>
> Philippe, I'll use your other email address in v3 as you asked, but this
> board really has to have Maintained status, since it is used for tests,
> within and outside of QEMU official tests, it would be really shame to
> degrade it to Odd fixes, unthinkable.

If "Odd Fixes" is what Philippe can provide, and "Maintained" is what we
want, then we need to find an additional maintainer (Paul Burton?) who
can provide what we want.



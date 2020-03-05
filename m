Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA52C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E6E208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFXuyeJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E6E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9jOb-0005ZG-6U
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 00:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9jNz-0004y0-1l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9jNx-0006d9-M7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:49:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9jNx-0006cp-IO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583387368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFV8ULI0PSMp5mytalx6OiXeE8yQDwSA0V7Y6M+j028=;
 b=AFXuyeJxOZ726SvBp0JG+B7WEo6Om5QriBzQ6pLim+qOBIq+b5TTfjm/dqoH0TxC5GfoMM
 egz8qHqtZjgUnvN4TW32XAXdLdHQzatqKbwiMqLwSD5ueQlQnL6k+a2XXVRYFYqZNuyzGV
 rUzViDLPlo3Y+AL7FfNaLa09OyDvf4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-GwtE0-boMYSNwOLj43uctw-1; Thu, 05 Mar 2020 00:49:25 -0500
X-MC-Unique: GwtE0-boMYSNwOLj43uctw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1E6800D54;
 Thu,  5 Mar 2020 05:49:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C19641CB;
 Thu,  5 Mar 2020 05:49:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 298DE11386A6; Thu,  5 Mar 2020 06:49:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v6 9/9] iotests: add pylintrc file
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-10-jsnow@redhat.com>
 <87h7z4r3dx.fsf@dusky.pond.sub.org>
 <ba878308-54ba-3eee-41ec-b14c19fda8b2@redhat.com>
Date: Thu, 05 Mar 2020 06:49:22 +0100
In-Reply-To: <ba878308-54ba-3eee-41ec-b14c19fda8b2@redhat.com> (John Snow's
 message of "Wed, 4 Mar 2020 14:17:48 -0500")
Message-ID: <87imjj1hct.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 3/4/20 2:22 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>>> Repeatable results. run `pylint iotests.py` and you should get a pass.
>>=20
>> Start your sentences with a capital letter, please.
>>=20
>
> The German complains about the capitalization, but not the sentence
> fragment.

Heh!

>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/pylintrc | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 tests/qemu-iotests/pylintrc
>>>
>>> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
>>> new file mode 100644
>>> index 0000000000..feed506f75
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/pylintrc
>>> @@ -0,0 +1,20 @@
>>> +[MESSAGES CONTROL]
>>> +
>>> +# Disable the message, report, category or checker with the given id(s=
). You
>>> +# can either give multiple identifiers separated by comma (,) or put t=
his
>>> +# option multiple times (only on the command line, not in the configur=
ation
>>> +# file where it should appear only once). You can also use "--disable=
=3Dall" to
>>> +# disable everything first and then reenable specific checks. For exam=
ple, if
>>> +# you want to run only the similarities checker, you can use "--disabl=
e=3Dall
>>> +# --enable=3Dsimilarities". If you want to run only the classes checke=
r, but have
>>> +# no Warning level messages displayed, use "--disable=3Dall --enable=
=3Dclasses
>>> +# --disable=3DW".
>>> +disable=3Dinvalid-name,
>>> +        missing-docstring,
>>> +        line-too-long,
>>> +        too-many-lines,
>>> +        too-few-public-methods,
>>> +        too-many-arguments,
>>> +        too-many-locals,
>>> +        too-many-branches,
>>> +        too-many-public-methods,
>>> \ No newline at end of file
>>=20
>> Add the newline, please.
>>=20
>> German pejorative for the too-many- and too-few- warnings: "M=C3=BCsli".
>> Implies it's for muesli-knitters / granola-crunchers indulging their
>> orthorexia.
>>=20
>
> They are useful at times as they can suggest when you are going a bit
> overboard on "organically grown" design. For cleaning an existing
> codebase, it's more of a hindrance to the immediate goal of establishing
> a baseline.

Yes, gentle nudges to reconsider your code organization can be useful.
But when we run pylint with the goal of getting no output, even warnings
are much more than gentle nudges.

> (*cough* I try to adhere to them in my own freshly written code, and
> disable per-line when I've decided to veto the suggestion. Not
> appropriate for a codebase like ours. As Max reminds me, it's just tests
> -- don't make them too clever or pretty.)
>
> Regardless. It's not appropriate here and now.
>
>> missing-docstring is not advisable for libraries.  Feels okay here.
>>=20
>
> Ideally we do start using them, but it's out of scope here. Since I did
> some cleanup, I wanted to establish the baseline of what I adhered to.
>
> *not* suggest that it's the destination state.
>
> Adding proper docstrings should be done during mypy conversion once the
> types are determined, understood, and enforced. Not before then.
>
>> line-too-long might be worth cleaning up.  How many of them do we have
>> now?
>>=20
>
> Five in iotests.py using the default length of 100. 15 if I limit to 80.
>
> If we agree that 100 is okay, I can tackle this in an amendment patch.
> If 80 is okay, I'm going to put it off as one coat of paint too many.
>
> (I will try to clean up the 100+ lines for my next version. I am
> hesitant to make a deeper cut because I have the feeling it's the type
> of series that will incur a lot of nitpicks on indent style.)

One step at a time.



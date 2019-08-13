Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2DDC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 05:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7DD20673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 05:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7DD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxPbU-0004Y3-LM
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 01:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxPb6-000439-Vh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxPb5-0001Pr-Sx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxPb5-0001P1-LC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:43:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC1EC8763B;
 Tue, 13 Aug 2019 05:43:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E22287982D;
 Tue, 13 Aug 2019 05:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60FE81136444; Tue, 13 Aug 2019 07:43:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-12-armbru@redhat.com>
 <87blwuodot.fsf@linaro.org> <87y2zytsgi.fsf@dusky.pond.sub.org>
Date: Tue, 13 Aug 2019 07:43:42 +0200
In-Reply-To: <87y2zytsgi.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Mon, 12 Aug 2019 15:37:49 +0200")
Message-ID: <875zn1aacx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 13 Aug 2019 05:43:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 11/29] typedefs: Separate incomplete
 types and function types
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> While there, drop the obsolete file comment.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  include/qemu/typedefs.h | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>> index fcdaae58c4..29346648d4 100644
>>> --- a/include/qemu/typedefs.h
>>> +++ b/include/qemu/typedefs.h
>>> @@ -1,10 +1,10 @@
>>>  #ifndef QEMU_TYPEDEFS_H
>>>  #define QEMU_TYPEDEFS_H
>>>
>>> -/* A load of opaque types so that device init declarations don't have =
to
>>> -   pull in all the real definitions.  */
>>> -
>>> -/* Please keep this list in case-insensitive alphabetical order */
>>> +/*
>>> + * Incomplete struct types
>>
>> Maybe expand this a little...
>>
>>   "Incomplete struct types for modules that don't need the complete
>>   definitions but still pass around typed variables."?
>
> If we explain proper use of qemu/typedefs.h in HACKING, as discussed in
> review of v1[*], we could point there.

Perhaps rewriting the obsolete file comment would be better.  Something
like this:

    /*
     * This header is for selectively avoiding #include just to get a
     * typedef name.
     *
     * Declaring a typedef name in its "obvious" place can result in
     * inclusion cycles, in particular for complete struct and union
     * types that need more types for their members.  It can also result
     * in headers pulling in many more headers, slowing down builds.
     *
     * You can break such cycles and unwanted dependencies by declaring
     * the typedef name here.
     *
     * For struct types used in only a few headers, judicious use of the
     * struct tag instead of the typedef name is commonly preferable.
     */

    /*
     * Incomplete struct types
     * Please keep this list in case-insensitive alphabetical order.
     */
    typedef struct AdapterInfo AdapterInfo;
    [...]

    /*
     * Pointer types
     * Such typedefs should be limited to cases where the typedef's users
     * are oblivious of its "pointer-ness".
     * Please keep this list in case-insensitive alphabetical order.
     */
    typedef struct IRQState *qemu_irq;

    /*
     * Function types
     */
    typedef void SaveStateHandler(QEMUFile *f, void *opaque);
    typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
    typedef void (*qemu_irq_handler)(void *opaque, int n, int level);

What do you think?

[...]


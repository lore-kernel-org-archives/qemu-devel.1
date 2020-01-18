Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E6C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 13:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88B124699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 13:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzsJXE7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88B124699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iso9M-0005xm-15
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 08:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iso8e-00059D-TK
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iso8b-0003Y1-Vr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:27:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iso8b-0003Wt-Iy
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579354060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8w7064/FC54QWkO5c5dHGuWITtPCZOwiFG7Xt0RvIM=;
 b=RzsJXE7NLI0gWZSBuJRnXqjtIWxBIVlTeWH4fpp4xeHPGXbkXoaaNjzN1wBt7/88D9i4Qm
 KtEM3JvydOyD+xlXG1FQ30FMweIUEzG5AD5+7ukJ4Pt3pdAItz66BQ+EW0VMr1uBxnhV3e
 y7eiG3JsqnbbjHOvdG0Ztmu0DVpOLiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-1xexDuVaOFmYeM89l3Fzow-1; Sat, 18 Jan 2020 08:27:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D442F29;
 Sat, 18 Jan 2020 13:27:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76AA35C1B2;
 Sat, 18 Jan 2020 13:27:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04BF91138600; Sat, 18 Jan 2020 14:27:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] mailmap: Add more entries to sanitize 'git log' output
References: <20191218185723.7738-1-philmd@redhat.com>
 <87h80ts0ii.fsf@dusky.pond.sub.org>
 <aef8102c-23d5-7cdc-7183-673c116a44b2@redhat.com>
Date: Sat, 18 Jan 2020 14:27:32 +0100
In-Reply-To: <aef8102c-23d5-7cdc-7183-673c116a44b2@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 18 Jan 2020 09:17:42
 +0100")
Message-ID: <87tv4sq4hn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1xexDuVaOFmYeM89l3Fzow-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/18/20 8:10 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> Most of these developers have the Signed-off-by tag properly
>>> written, but not the author/commiter name. Fix this.
>>> Also we incorrectly wrote Arei Gonglei name, update and reorder.
>>>
>>> git-log does not use this file by default until you specify the
>>> --use-mailmap flag:
>>>
>>>    $ git log --use-mailmap
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   .mailmap | 29 ++++++++++++++++++++++++++++-
>>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index 3816e4effe..1a859d9e65 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -56,6 +56,10 @@ Aaron Lindsay <aaron@os.amperecomputing.com>
>>>   Alexey Gerasimenko <x1917x@gmail.com>
>>>   Alex Ivanov <void@aleksoft.net>
>>>   Andreas F=C3=A4rber <afaerber@suse.de>
>>> +Andreas F=C3=A4rber <andreas.faerber@web.de>
>>> +Andreas F=C3=A4rber <andreas.faerber@web.de> <andreas.faerber>
>>> +Arei Gonglei <arei.gonglei@huawei.com>
>>> +Arei Gonglei <arei.gonglei@huawei.com> <root@ceth6.(none)>
>>
>> I can't find this one in git-log.
>
> I was first surprised:
>
> $ git log -1 3b08098b40
> commit 3b08098b409c0fb28f85436ba1adeb1d401ec8f7
> Author:     Gonglei <arei.gonglei@huawei.com>
> AuthorDate: Wed Dec 3 18:25:46 2014 +0000
> Commit:     root <root@ceth6.(none)>
> CommitDate: Mon Dec 22 14:39:21 2014 +0800
>
>     bootdevice: add validate check for qemu_boot_set()
>
>     Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>     Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> After thinking for a bit I remembered I once changed my default format:
>
> $ git config format.pretty
> fuller

Aha!  Could've thought of this myself...

> I suppose I should add this in the commit description.

Can't hurt.

[...]
>>>   Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
>>>   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> +Siwei Zhuang <siwei.zhuang@data61.csiro.au>
>>
>> It's actually spelled Siwei.Zhuang@data61.csiro.au in git-log.
>> Shouldn't matter.
>
> Correct:
>
> $ git shortlog -e 6478dd745d~..6478dd745d
> Zhuang, Siwei (Data61, Kensington NSW) <Siwei.Zhuang@data61.csiro.au> (1)=
:
>       hw/riscv: Add optional symbol callback ptr to riscv_load_kernel()
>
> $ git shortlog -e 6478dd745d~..6478dd745d
> Siwei Zhuang <Siwei.Zhuang@data61.csiro.au> (1):
>       hw/riscv: Add optional symbol callback ptr to riscv_load_kernel()

Suggest to adjust case if you respin.

> Thanks for caring checking all entries!

Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]



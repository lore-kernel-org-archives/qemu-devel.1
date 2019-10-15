Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBACC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEA02067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEA02067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKHKv-000506-97
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 03:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iKHKB-0004TL-AN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iKHK7-00047r-4l
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iKHK6-00047K-TK
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:32:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2712F308624A;
 Tue, 15 Oct 2019 07:32:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77AB45D9E2;
 Tue, 15 Oct 2019 07:32:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECA871138619; Tue, 15 Oct 2019 09:32:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v4 1/8] target/mips: Clean up helper.c
References: <1570991178-5511-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1570991178-5511-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <87a7a36awg.fsf@dusky.pond.sub.org>
 <CAL1e-=gD629LfDPokJ6XAnR_xxE-vHw3RZqg=JDai-xAcJC0Dg@mail.gmail.com>
Date: Tue, 15 Oct 2019 09:32:46 +0200
In-Reply-To: <CAL1e-=gD629LfDPokJ6XAnR_xxE-vHw3RZqg=JDai-xAcJC0Dg@mail.gmail.com>
 (Aleksandar Markovic's message of "Mon, 14 Oct 2019 10:10:01 +0200")
Message-ID: <87mue2xy3l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 15 Oct 2019 07:32:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> --00000000000007f6800594da656e
> Content-Type: text/plain; charset="UTF-8"
>
> On Monday, October 14, 2019, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:
>>
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>> >
>> > Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>> >
>> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> > ---
>> >  target/mips/helper.c | 128 ++++++++++++++++++++++++++++++
>> +--------------------
>> >  1 file changed, 78 insertions(+), 50 deletions(-)
>> >
>> > diff --git a/target/mips/helper.c b/target/mips/helper.c
>> > index a2b6459..2411a2c 100644
>> > --- a/target/mips/helper.c
>> > +++ b/target/mips/helper.c
[...]
>> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
>> >      int32_t adetlb_mask;
>> >
>> >      switch (mmu_idx) {
>> > -    case 3 /* ERL */:
>> > -        /* If EU is set, always unmapped */
>> > +    case 3:
>> > +        /*
>> > +         * ERL
>> > +         * If EU is set, always unmapped
>> > +         */
>> >          if (eu) {
>> >              return 0;
>> >          }
>>
>> This changes from the usual way we format switch case comments to an
>> unusual way.
>>
>> If you want to pursue this change, please put it in a separate patch,
>> so this one is really about fixing "errors and warnings reported by
>> 'checkpatch.pl -f'", as your commit message promises.
>>
>>
>
> Hi, Markus. Thank you for your response.
>
> There must be some misunderstanding here:
>
> The line:
>
>    case 3 /* ERL */:
>
> generates a checkpatch warning. I don't know why I would put it in a
> separate patch, if this patch is about fixing checkpatch warnings. Please
> explain.

You're right; I misread the line you patch as

     case 3: /* ERL */

> Secondly, I don't see that this is a usual way we format switch statement.
> I found just several cases in the whole QEMU code base (and you claimed in
> previous comments that there are thousands).
>
> I am just guessing that you somehow mixed this line with the line:
>
>    case 3: /* ERL */
>
> that would have not generated checkpatch warning.

You guessed correctly.  Telling me right away that my remark doesn't
make sense to you would've helped :)

The pattern

    case VALUE: /* comment on VALUE */

is common: >8000 instances.

The pattern

    case VALUE /* comment on VALUE */:

is uncommon: <20 instances.  I agree with cleaning it up.

However, I find the common pattern applied here

    case 3: /* ERL */
        /* If EU is set, always unmapped */
        if (eu) {
            return 0;
        }

more readable than the unusual (to my eyes)

    case 3:
        /*
         * ERL
         * If EU is set, always unmapped
         */
        if (eu) {
            return 0;
        }

The first line of the comment applies to the value preceding it, the
second to the code following it.  Making these connections doesn't
exactly take genius, but neither is it effortless.

Nice and consistent coding style is all about reducing the effort of
reading code.

For what it's worth, the pattern

    case VALUE: /* comment on VALUE */
        /* comment on CODE */
        CODE

occurs almost 300 times.

> I don't see any reason to change this patch. Please let me know it you
> still think I should do something else. And you are welcome to analyse any
> patches of mine.

Please consider keeping two separate comments, i.e. just move the colon
to its usual place.

Thanks!


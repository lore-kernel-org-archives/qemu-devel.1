Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD99C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AF121920
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AF121920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrDD-0002Xv-Qw
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqBM-0002Wr-4F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqBK-00009B-Rc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqBK-00008q-JQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DCE2C065116;
 Fri, 27 Sep 2019 12:03:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AB7A196B2;
 Fri, 27 Sep 2019 12:03:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 905D2113864E; Fri, 27 Sep 2019 14:03:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v2 01/20] target/mips: Clean up helper.c
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
 <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
Date: Fri, 27 Sep 2019 14:03:11 +0200
In-Reply-To: <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
 (Aleksandar Markovic's message of "Fri, 27 Sep 2019 06:32:52 +0200")
Message-ID: <874l0ydk00.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 27 Sep 2019 12:03:16 +0000 (UTC)
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, arikalo@wavecomp.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar, your message is hard to read, because you sent Content-Type:
multipart/alternative, and both the test/html and the test/plain
alternative ride roughshot over the quoted text's line structure.
Quoted patches become unreadable garbage.  Please check your e-mail
setup.

Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 25.09.2019. 17.53, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=
=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>> >
>> > Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>> >
>> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> > ---
>> >  target/mips/helper.c | 132
> +++++++++++++++++++++++++++++++--------------------
>> >  1 file changed, 80 insertions(+), 52 deletions(-)
>> >
>> > diff --git a/target/mips/helper.c b/target/mips/helper.c
>> > index a2b6459..3dd1aae 100644
>> > --- a/target/mips/helper.c
>> > +++ b/target/mips/helper.c
>> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool
> eu, int mmu_idx)
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
>>
>> My IDE show the current form nicer when the switch is folded.
>>
>> Are these comment really bothering checkpatch?
>>
>
> While being sintaxically correct, interleaving comments and code in a
> single code line is considered a bad practice by many.

I take that as a "no".

The preferences of "many" (whoever they may be) are a lot less relevant
than the specific project's prevailing style.  "git-grep ' case .*/\*'"
shows thousands of hits.

If you want to pursue this change, please put it in a separate patch,
so this one is really about fixing "errors and warnings reported by
'checkpatch.pl -f'", as your commit message promises.

>> >          if (eu) {
>> >              return 0;
>> >          }
[...]
>> Except 2 comments, OK for the rest.
>>
>> Another patch that makes rebasing very painful :(
>>
>
> It would be fantastic if you apply the same reasoning to your patches, th=
at
> spread all over the code base, and happen so frequently, and certainly
> create enormously more rebasing problems for multitude of people than this
> patch or series does.

Please tone down the aggression a notch.

Philippe merely observed a trade-off.  We deal with such trade-offs all
the time.  When your reviewer challenges one, you consider it (unless
you did that already), then tell him what you concluded.

"Tu quoque" is not a proper reply to such an observation (or to anything
else for that matter).  When you have an issue with Philippe's patches,
address it in review of Philippe's patches.

Thank you.


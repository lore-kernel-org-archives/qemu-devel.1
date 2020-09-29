Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C5C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A32208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buG9k77K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A32208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFg5-0002Jh-OK
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFf9-0001tZ-EN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFf6-0007qv-IT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:27:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601386038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqtxvZorKFyXMHDslH2s9vBkapP/UEIeegUu5DoPhZA=;
 b=buG9k77KrxaJya75Z5FfVGQZx9uQSqU2+LHGoB5k0Oa+lZ7ZB4EbWqFbaFs1OsNMG3QFNA
 oOihKxlMLaXwhZLJrQCFRveeH9ll9uZXmpQq0WRjh+2rLLI7pMsxloTWJPvWftDsUkwFY+
 wP6iqFRlti9gXB1qZLmIoR9Iy7lrqLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-DmQeRqEzP1yfYD73fIpGnQ-1; Tue, 29 Sep 2020 09:27:15 -0400
X-MC-Unique: DmQeRqEzP1yfYD73fIpGnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB35D8015C5;
 Tue, 29 Sep 2020 13:27:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B5E7881E;
 Tue, 29 Sep 2020 13:27:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B811113864A; Tue, 29 Sep 2020 15:27:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 17/21] docs/devel/qapi-code-gen.txt: Update to new
 rST backend conventions
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-18-peter.maydell@linaro.org>
 <87wo0cu5es.fsf@dusky.pond.sub.org>
 <CAFEAcA9024SOxuA-_=iUOtmtgZMxMQ8fvkuu8Wt9by83oJ0qsQ@mail.gmail.com>
Date: Tue, 29 Sep 2020 15:27:12 +0200
In-Reply-To: <CAFEAcA9024SOxuA-_=iUOtmtgZMxMQ8fvkuu8Wt9by83oJ0qsQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 29 Sep 2020 13:43:14 +0100")
Message-ID: <87k0wcr9vz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 29 Sep 2020 at 13:35, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Update the documentation of QAPI document comment syntax to match
>> > the new rST backend requirements. The principal changes are:
>> >  * whitespace is now significant,
>>
>> Well, differently significant :)  Anyway, close enough.
>>
>> >                                   and multiline definitions
>> >    must have their second and subsequent lines indented to
>> >    match the first line
>> >  * general rST format markup is permitted, not just the small
>> >    set of markup the old texinfo generator handled. For most
>> >    things (notably bulleted and itemized lists) the old format
>> >    is the same as rST was.
>>
>> "was the same as rST is"?
>
> Yes :-)

Can fix in my tree.

>
>> v5 had
>>
>>   @@ -899,6 +915,12 @@ commands and events), member (for structs and unions), branch (for
>>    alternates), or value (for enums), and finally optional tagged
>>    sections.
>>
>>   +Descriptions of arguments can span multiple lines; if they
>>   +do then the second and subsequent lines must be indented
>>   +to line up with the first character of the first line of the
>>   +description. The parser will report a syntax error if there
>>   +is insufficient indentation.
>>   +
>>    FIXME: the parser accepts these things in almost any order.
>>    FIXME: union branches should be described, too.
>>
>> I questioned the value of the last sentence.  You dropped both.
>> Intentional?
>
> I moved the first sentence to patch 5 in v6 (ie to the patch
> which updates parser.py to enforce those indentation restrictions),
> so as to make patches 1..5 suitable for merging even if we needed
> to respin the second half of the series.

I see.

>> > @@ -937,6 +950,16 @@ multiline argument descriptions.
>> >  A 'Since: x.y.z' tagged section lists the release that introduced the
>> >  definition.
>> >
>> > +The text of a section can start on a new line, in
>> > +which case it must not be indented at all.  It can also start
>> > +on the same line as the 'Note:', 'Returns:', etc tag.  In this
>> > +case if it spans multiple lines then second and subsequent
>> > +lines must be indented to match the first.
>
> I also moved this paragraph into patch 5 (where it appears just
> above the "A 'Since:..." text you can see in the context here)
> but forgot to delete the copy of it here, so at this point it is
> duplicate text and should not be in this patch. Oops.
>
>> > +
>> > +An 'Example' or 'Examples' section is automatically rendered
>> > +entirely as literal fixed-width text.  In other sections,
>> > +the text is formatted, and rST markup can be used.
>
> (This patch is the right place for this paragraph.)

Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>



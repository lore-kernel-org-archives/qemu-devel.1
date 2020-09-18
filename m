Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B069C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1B21D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu0JIspx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1B21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDip-0001ML-Lc
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJDhk-0000P2-TW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:33:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJDhj-0004xf-57
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600425201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0Zf+LHoB6VnIsSMmBlyfBeGmve6j2ApLN7MuHAEXaE=;
 b=Eu0JIspxVk7QEeRiNxpivDABAaUGeLMRU8LL1s1HmBboza/fiO45z7iggIF8oESJAuUTYT
 yrKzSsBK7DLkza4hnaoSOmZcqexpHMt6X6q2kFPedmihvq2s4QsKiitiKOVrkBUHJauTnZ
 33IMxJOuDfWBM0scYi/KnCvZEgybAks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-w_qw0xzPMHioyPofa4U6tA-1; Fri, 18 Sep 2020 06:33:20 -0400
X-MC-Unique: w_qw0xzPMHioyPofa4U6tA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F00C188C130;
 Fri, 18 Sep 2020 10:33:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC60F19D6C;
 Fri, 18 Sep 2020 10:33:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69E23113864A; Fri, 18 Sep 2020 12:33:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/37] qapi: delint using flake8
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
 <87wo0tor80.fsf@dusky.pond.sub.org>
 <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com>
 <87a6xog7n8.fsf@dusky.pond.sub.org>
 <82b4b8ce-b348-75fd-bd44-d96303a4875d@redhat.com>
Date: Fri, 18 Sep 2020 12:33:17 +0200
In-Reply-To: <82b4b8ce-b348-75fd-bd44-d96303a4875d@redhat.com> (John Snow's
 message of "Thu, 17 Sep 2020 12:57:02 -0400")
Message-ID: <87bli3jrwy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/17/20 3:54 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 9/16/20 8:12 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> Petty style guide fixes and line length enforcement.  Not a big win, not
>>>>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>>>>> easy baseline to enforce hereafter.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
[...]
>>>>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>>>>> index e1df0e341f..2e4b4de0fa 100644
>>>>> --- a/scripts/qapi/commands.py
>>>>> +++ b/scripts/qapi/commands.py
>>>>> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>>>>    def gen_marshal_output(ret_type):
>>>>>        return mcgen('''
>>>>>    -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>>>>> QObject **ret_out, Error **errp)
>>>>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
>>>>> +                                          Error **errp)
>>>> The continued parameter list may become misalignd in generated C.
>>>> E.g.
>>>>       static void qmp_marshal_output_BlockInfoList(BlockInfoList *ret_in, QObject **ret_out,
>>>>                                                 Error **errp)
>>>>       {
>>>>       ...
>>>>       }
>>>> Do we care?
>>>>
>>>
>>> Yeah, I don't know. Do we?
>> I care, but I also care for automated style checks.
>> 
>>> It actually seemed more annoying to try and get flake8 to make an
>>> exception for these handful of examples.
>>>
>>> Path of least resistance led me here, but I can try and appease both
>>> systems if you'd prefer.
>> Up to now, I ran the style checkers manually, and this was just one
>> of
>> several complaints to ignore, so I left the code alone.
>> If it gets in the way of running them automatically, and messing up
>> the
>> generated code slightly is the easiest way to get it out of the way,
>> then I can accept the slight mess.
>> 
>
> I changed this a little to put all the args on the next line, which is
> slightly unusual but works okay.

I think it's slightly more unusual than the non-matching indentation
was.

Yet another way to skin this cat:

    static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
                                    QObject **ret_out, Error **errp)

Now the second line is not aligned with the left parenthesis both in the
Python source and in the generated C.

> I think that's a fine middle ground, because the alternative (to me)
> is to start using abstracted code generation tokens in a tree
> structure, etc etc etc.
>
> Embedded templates are always gonna look kinda nasty, I think, because
> you're trying to fight style guidelines in two languages
> simultaneously and it's never gonna quite work out exactly how you
> want without some pretty complex abstraction mechanisms that are well
> beyond the power we need right now.

The thought "screw this, pile the output through /usr/bin/indent" has
crossed my mind more than once.



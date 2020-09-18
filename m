Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480B720789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWqOYFPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480B720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJE4c-0006Cv-82
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJE3l-0005h0-CU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJE3f-0008Vi-P6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600426562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUaEPiZPN1YdbwhOwBH8+jPtqZAGgo0xZtWUVcE87/0=;
 b=eWqOYFPvfDN/REb/1yYyOQHcJIVwqYDnOK2ImAIfb36TLJFcJ8g2bXigVO/O5UwTEkqHJI
 7DvWHz8wc8dCSxsBRX8YmLQkuiMDM5DOHRZTjq1MYFnfr3qUErg2sAH2pLycwXuKjYEd4F
 kelWhvGK22HmHWep+vsQvrxLIdrTO2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-i7E1-2_2MCSB5zfELRVz6Q-1; Fri, 18 Sep 2020 06:56:00 -0400
X-MC-Unique: i7E1-2_2MCSB5zfELRVz6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFB364092;
 Fri, 18 Sep 2020 10:55:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE9C5C641;
 Fri, 18 Sep 2020 10:55:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8C0A113864A; Fri, 18 Sep 2020 12:55:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/37] qapi/common.py: Add indent manager
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-10-jsnow@redhat.com>
 <87k0wtiwlb.fsf@dusky.pond.sub.org>
 <37ea889c-746e-bea9-a719-6bee9e86f1a8@redhat.com>
 <87v9gcesh8.fsf@dusky.pond.sub.org>
 <301fb683-9b57-d355-3b08-776ab4869975@redhat.com>
Date: Fri, 18 Sep 2020 12:55:57 +0200
In-Reply-To: <301fb683-9b57-d355-3b08-776ab4869975@redhat.com> (John Snow's
 message of "Thu, 17 Sep 2020 13:18:15 -0400")
Message-ID: <87363fjqv6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/17/20 4:07 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 9/16/20 11:13 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>
>
>>>> Let's replace "the indent" by "the indentation" globally.
>>>>
>>>
>>> They're both cromulent as nouns and one is shorter.
>>>
>>> I'll switch in good faith; do you prefer "Indentation" as a noun?
>> Use of "indent" as a noun was new to me, but what do I know; you're
>> the
>> native speaker.  Use your judgement.  Applies to the class name, too.
>> 
>
> I made the change; see gitlab commits or wait for v2 to see if it
> reads better to you.
>
>>>>> +        return self._level
>>>>>    +    def __repr__(self) -> str:
>>>>> +        return "{}({:d})".format(type(self).__name__, self._level)
>>>> Is __repr__ needed?
>>>>
>>>
>>> Yes; it's used in the underflow exception , and it is nice when using
>>> the python shell interactively.
>>>
>>> repr(Indent(4)) == "Indent(4)"
>> Meh.  There's another three dozen classes for you to put lipstick on
>> :)
>> 
>
> We'll get to them in due time. For now, please admire the lipstick.

If I take off my glasses and step six feet back, I just might be able to
overlook it.

>>>>> +    def pop(self, amount: int = 4) -> int:
>>>>> +        """Pop `amount` spaces off of the indent, default four."""
>>>>> +        if self._level < amount:
>>>>> +            raise ArithmeticError(
>>>>> +                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
>> I think assert(amount <= self._level) would do just fine.
>> 
>
> Secretly, asserts can be disabled in Python just like they can in C code.

There are compilers that let you switch off array bounds checking.
Would you advocate manual bounds checking to protect people from their
own folly?

> My habit: if it's something that should already be true given the
> nature of how the code is laid out, use an assertion. If I am
> preventing an erroneous state (Especially from callers in other
> modules), explicitly raise an exception.

I check function preconditions ruthlessly with assert.  There's no sane
way to recover anyway.

Without a way to recover, the only benefit is crashing more prettily.
If the error is six levels deep in a some fancy-pants framework, then
prettier crashes might actually help someone finding the error slightly
faster.  But it ain't.

My final argument is local consistency: use of assertions to check
preconditions is pervasive in scripts/qapi/.

> (See the gitlab branch for the updated version of this patch, which
> has changed the code slightly.)

[...]



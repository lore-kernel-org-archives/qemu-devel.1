Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0121C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4948120809
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUtztKVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4948120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGXw-0005uX-B3
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGTq-0004Xt-UL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:43:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGTn-00040p-QE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600674194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2WHT3yNYYCK3XWpo/rfz9tq9qKGBn9AP5S3Kp1CL4s=;
 b=RUtztKVHFchfj2qlYR811tTpLfuvUNIRQxMLUSF77pT+Hf/3JXurd0OuW4KCluHL9tb2dX
 62WeB/Sx6r2NvJOmvVcKPF1iwp3P8a1Fq35tbZX13pXCBPddah4cXgAT4S42GDEnS/L41R
 zuWkF/bYJTpwO5slQQ5wm4O03UWBLoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-3zy5A49zPjKVXY6zfDQM7g-1; Mon, 21 Sep 2020 03:43:10 -0400
X-MC-Unique: 3zy5A49zPjKVXY6zfDQM7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDCC210BBEC2;
 Mon, 21 Sep 2020 07:43:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 954FB10013D0;
 Mon, 21 Sep 2020 07:43:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A0311132E9A; Mon, 21 Sep 2020 09:43:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/37] qapi/common.py: Add indent manager
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-10-jsnow@redhat.com>
 <87k0wtiwlb.fsf@dusky.pond.sub.org>
 <37ea889c-746e-bea9-a719-6bee9e86f1a8@redhat.com>
 <87v9gcesh8.fsf@dusky.pond.sub.org>
 <301fb683-9b57-d355-3b08-776ab4869975@redhat.com>
 <87363fjqv6.fsf@dusky.pond.sub.org>
 <084495dc-dfb3-084d-ff83-cdfb90cd61f4@redhat.com>
Date: Mon, 21 Sep 2020 09:43:07 +0200
In-Reply-To: <084495dc-dfb3-084d-ff83-cdfb90cd61f4@redhat.com> (John Snow's
 message of "Fri, 18 Sep 2020 12:08:19 -0400")
Message-ID: <87r1qva838.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On 9/18/20 6:55 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>
>>> We'll get to them in due time. For now, please admire the lipstick.
>> If I take off my glasses and step six feet back, I just might be
>> able to
>> overlook it.
>> 
>
> I consider writing a nice __repr__ good habit, I'd prefer not to
> delete it just because the rest of our code doesn't do so yet. (Give
> me time.)
>
> I spend a lot of my time in the interactive python console: having
> nice __repr__ methods is a good habit, not an unsightly blemish.
>
>>>>>>> +    def pop(self, amount: int = 4) -> int:
>>>>>>> +        """Pop `amount` spaces off of the indent, default four."""
>>>>>>> +        if self._level < amount:
>>>>>>> +            raise ArithmeticError(
>>>>>>> +                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
>>>> I think assert(amount <= self._level) would do just fine.
>>>>
>>>
>>> Secretly, asserts can be disabled in Python just like they can in C code.
>> There are compilers that let you switch off array bounds checking.
>> Would you advocate manual bounds checking to protect people from their
>> own folly?
>> 
>>> My habit: if it's something that should already be true given the
>>> nature of how the code is laid out, use an assertion. If I am
>>> preventing an erroneous state (Especially from callers in other
>>> modules), explicitly raise an exception.
>> I check function preconditions ruthlessly with assert.  There's no
>> sane
>> way to recover anyway.
>> Without a way to recover, the only benefit is crashing more
>> prettily.
>> If the error is six levels deep in a some fancy-pants framework, then
>> prettier crashes might actually help someone finding the error slightly
>> faster.  But it ain't.
>> My final argument is local consistency: use of assertions to check
>> preconditions is pervasive in scripts/qapi/.
>> 
>
> You're right that there's no safe recovery from an error such as
> this. The only actual difference is whether you see AssertionError or 
> ArithmeticError.
>
> One can be disabled (But you rightly shouldn't), the other can't. One
> has more semantic meaning and information to it.

YAGNI.

> I prefer what I've currently written.

Where personal preference collides with local consistency, I'm with
local consistency.

You can get the two in line: change everything to your preference.

You signalled intent to do that for __repr__(): "Give me time".
Alright, having such __repr__() is obviously more important / useful to
you than avoiding the extra code is to me.

I received no such signal for checking preconditions.  Good, because I'd
go "are you serious?" :)



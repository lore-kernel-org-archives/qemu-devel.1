Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE52C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A06122D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLCk+qrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A06122D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Y0Q-0007c4-7q
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 00:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Xzq-00076E-Gt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 00:59:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Xzo-0008WF-EN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 00:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596689955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9H2sWurs7qvgmg+995i0t8adhxofUEjhuOEZOc2fKYo=;
 b=PLCk+qrm+Yrpmwa6ENzWHJykBfMr42cgJy3uwy0rNEbMJvZvaNPpJdcK9doifI27ZQ6RK9
 ev4BFHJM51YCIZmdO0rCCqHaTImc6i8JuDeeXdUGqgx5GcsPPNp7po34frNesjTbuVzTrr
 rKmUvF3E9NVaQ0OCMbQ6jFZXTeKlgA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-FPcBWZFQMraHkiH99PxXuQ-1; Thu, 06 Aug 2020 00:59:11 -0400
X-MC-Unique: FPcBWZFQMraHkiH99PxXuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9433458;
 Thu,  6 Aug 2020 04:59:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 010C17B913;
 Thu,  6 Aug 2020 04:59:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CDE01132801; Thu,  6 Aug 2020 06:58:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
 <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <90445173-cc5c-e725-5782-5b1095af6e53@redhat.com>
Date: Thu, 06 Aug 2020 06:58:58 +0200
In-Reply-To: <90445173-cc5c-e725-5782-5b1095af6e53@redhat.com> (John Snow's
 message of "Wed, 5 Aug 2020 12:04:16 -0400")
Message-ID: <87lfis5q0d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 8/5/20 3:36 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 8/4/20 4:03 AM, Markus Armbruster wrote:
>>>> The pain of tweaking the parser is likely dwarved several times over by
>>>> the pain of the flag day.
>>>
>>> You mention this often; I wonder if I misunderstand the critique,
>>> because the pain of a "flag day" for a new file format seems
>>> negligible to me.
>>>
>>> I don't think we edit these .json files very often. Generally, we add
>>> a new command when we need one. The edits are usually one or two lines
>>> plus docstrings.
>>>
>>> If anyone has patches in-flight, I genuinely doubt it will take more
>>> than a few minutes to rewrite for the new file format.
>>>
>>> No?
>>
>> You describe the the flag day's one-time pain.
>>
>> There's also the longer term pain of having to work around git-blame
>> unable to see beyond the flag day.
>>
>
> So it's not really the "flag day" we're worried about anymore, it's
> the ongoing ease-of-use for vcs history.

Feel free to call that pain however you want.  I'm going to call it
"lasting aftereffects of the flag day" :)

>> I'm not claiming the pain is prohibitive (if I thought it was, I
>> would've tried to strange this thread in its crib), I am claiming it'll
>> be much more painful (read: expensive) than a parser tweak.
>>
>
> I do use `git blame` quite a lot, but with a project as old as QEMU,
> most of my trips through history do involve jumping across a few
> refactor gaps as a normal part of that process.
>
> As Dan points out, I often have to back out and add refactorSHA^ to my
> invocation, and just keep hopping backwards until I find what I am
> truly after. It just feels like a fact of programmer life for me at
> this point.

The fact that we all need to cope with this class of issue doesn't mean
we should create more instances unthinkingly.

We should only when we believe the benefits are worth it, and can't find
a cheaper way to get them.

We've discussed "is it really that bad" at some length.  What I'm
missing so far is a clear writeup of the benefits beyond "editor works
out of the box" (which is quite a desirable benefit, but can also be had
without a flag day).

> I've not used Paolo's invocation before, but it looks like it might be
> useful. I'll try to remember to try it out.



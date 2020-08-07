Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB55C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC69221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clq/7sQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC69221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42qz-0008I7-W3
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42qA-0007KO-MW
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:55:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34028
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42q7-00017X-VG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596808519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tGQtLedpkAIA+1aRSkBO7B4yyc7FwMUKPp3ydEBfj0U=;
 b=clq/7sQphdyI12+6+iGpwbMJtyxzy5ljRDpEfGTHLgg2Lb0lT91MGq6pYL2gPp8auQuNRM
 XIP9PUJJd9N46Uxg4ptdEmebzXC4tLNprMg95OKalho2OlBpeWcxfWIBSTHsb1iQuTZWmm
 CWwx3dobeCIA8Z42yZzuIqO1q19RdZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-X7sAF3-oPw-sXDZhUaeGcQ-1; Fri, 07 Aug 2020 09:55:16 -0400
X-MC-Unique: X7sAF3-oPw-sXDZhUaeGcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A096101C8A5;
 Fri,  7 Aug 2020 13:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D13FE5FC3B;
 Fri,  7 Aug 2020 13:55:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D5DB1132801; Fri,  7 Aug 2020 15:55:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
Date: Fri, 07 Aug 2020 15:55:10 +0200
In-Reply-To: <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com> (Paolo
 Bonzini's message of "Fri, 7 Aug 2020 10:39:47 +0200")
Message-ID: <87ft8yd0ht.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/20 09:56, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> This the more or less final version of the Meson conversion.  Due to
>>> the sheer size of the series you have been CCed only on the cover
>>> letter.
>> 
>> Perfect timing: right before I drop off for two weeks of vacation.  I'm
>> excused!  *Maniacal laughter*
>> 
>> Have you run it through our CI?
>
> Of course not. O:-)
>
>> without even more weeks of intense rebasing.
>
> FWIW there were only three hard rebases from 5.0 to 5.2:
> qemu-storage-daemon (by far the hardest), linux-user's syscall_nr.h
> generation, and fuzzing (easiest except it required conversion of qtest).  S
>
> I would like to merge this on August 21st.  I hope to post a
> "definitive" verion on August 14th, and hope to work with Peter the next
> week on getting it to pass his tests.

Sounds good to me.

>                                        Perhaps that's optimistic though.

If it's not ready then, we pick another date and try again.

> Depending on when it's ready, I can pick up the series that gets rid of
> Texinfo, if Peter and yourself don't want to learn Meson just for that.

I appreciate the offer.  I figure I'll eventually have to learn some
Meson anyway.  Still, having to learn it *now* to unblock that series
may be inconvenient.

> Anyway, I think this is the no-return point: if people say no, I'm not
> going to push it any further.  If people say yes, we'd better merge it
> quickly and be done with it.
>
> I do understand resistance.  It's a new tool replacing a 40-year-old
> standard; build systems are not fancy; and there is a substantial sunken
> cost.  All I can answer is that the line between sunken cost and
> Stockholm syndrome is a fine one.  I cannot say this stuff has been
> *fun*, but at least the debugging was refreshing compared to Makefiles.
>  Again not a very high bar, but it's something.

I'm willing to trust your judgement on this one.

I'm notoriously conservative in my choice of tools, and GNU Make is a
much better tool than some people give it credit for, but I've long felt
we've pushed it beyond its limits.

[...]



Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31513C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBE021D95
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaU1qROe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBE021D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AE4-0003JQ-8A
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1AD8-0002Xk-8N
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:11:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1AD5-0005EA-R4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596121865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCK/tBx/pEN3xVJ+/dFaojg6ii0gFp7E1boM0G1oYiU=;
 b=iaU1qROeWlpxxJwDWCpXklsAUR4R3dwX0aY4r/a3qQDZ1iJ73JbZaQC6CN+lUp7M2pndIE
 ETccAbeUQGbiceEWI4ocEJ1UKNalYVkYdn4lfTqqU8S3z7fum3cll4SH5op7Ff3sYydBHJ
 oFn8B5354giKhGavVkzxk/FBeR0ce+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-goXgiGSHPqK3HbrFcJwjYA-1; Thu, 30 Jul 2020 11:11:01 -0400
X-MC-Unique: goXgiGSHPqK3HbrFcJwjYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6DF102C7E9;
 Thu, 30 Jul 2020 15:11:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF9391992D;
 Thu, 30 Jul 2020 15:10:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CC101132FD2; Thu, 30 Jul 2020 17:10:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
Date: Thu, 30 Jul 2020 17:10:58 +0200
In-Reply-To: <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 (Peter Maydell's message of "Tue, 28 Jul 2020 16:25:04 +0100")
Message-ID: <87k0ylvy0t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 Jul 2020 at 16:17, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 7/16/20 10:41 AM, Peter Maydell wrote:
>> > Add a documentation comment for qemu_get_thread_id(): since this
>> > is rather host-OS-specific it's useful if people writing the
>> > implementation and people thinking of using the function know
>> > what the purpose and limitations are.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> > Based on conversation with Dan on IRC, and prompted by the recent
>> > patch to add OpenBSD support.
>> >
>> > Q: should we document exactly what the thread-id value is for
>> > each host platform in the QMP documentation ? Somebody writing
>> > a management layer app should ideally not have to grovel through
>> > the application to figure out what they should do with the
>> > integer value they get back from query-cpus...
>> >
>> >   include/qemu/osdep.h | 14 ++++++++++++++
>> >   1 file changed, 14 insertions(+)
>>
>> Do we need a counterpart change...
>>
>> >
>> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> > index 4841b5c6b5f..8279f72e5ed 100644
>> > --- a/include/qemu/osdep.h
>> > +++ b/include/qemu/osdep.h
>> > @@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
>> >
>> >   bool qemu_write_pidfile(const char *pidfile, Error **errp);
>> >
>> > +/**
>> > + * qemu_get_thread_id: Return OS-specific ID of current thread
>> > + *
>> > + * This function returns an OS-specific identifier of the
>> > + * current thread. This will be used for the "thread-id" field in
>> > + * the response to the QMP query-cpus and query-iothreads commands.
>>
>> ...to the qapi definition of query-cpus and query-iothreads?
>
> Well, that was my question above. Currently the QAPI documentation
> says absolutely nothing about what the thread-id values mean
> for any host OS (beyond "ID of the underlying host thread"), which
> means that any management layer application needs to look in the
> implementation to find out what they actually are...

... which they will have to do to actually use it for the purpose we
have in mind, namely:

>> > + * The intention is that a VM management layer application can then
>> > + * use it to tie specific QEMU vCPU and IO threads to specific host
>> > + * CPUs using whatever the host OS's CPU affinity setting API is.
>> > + * New implementations of this function for new host OSes should
>> > + * return the most sensible integer ID that works for that purpose.
>> > + *
>> > + * This function should not be used for anything else inside QEMU.
>> > + */

Do they?

> Improving the QAPI docs would probably be something like:
>  * add a list of host OSes and semantics to the doc comment
>    for CpuInfoFast
>  * add cross-references to that definition from everywhere
>    else in QAPI that uses a thread-id/thread_id
>  * add a comment in the C file to say "if you're adding another
>    OS ifdef here please update the QAPI doc comment"

If they do, then this sounds like a plan.

By the way, the #else case smells:

    #else
        return getpid();
    #endif

The PID is quite unlikely to be "an OS-specific identifier of the
current thread".  Shouldn't we fail instead of lie when we don't know
how to compute the truth?



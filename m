Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C71C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CE220815
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CE220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoGU-00044p-KW
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHoFF-0002u7-0V
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHoFD-0005MS-Tc
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHoFD-0005M8-OM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5D2A10576CB;
 Tue,  8 Oct 2019 12:05:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D03F60923;
 Tue,  8 Oct 2019 12:05:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0EB271138648; Tue,  8 Oct 2019 14:05:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-2-vsementsov@virtuozzo.com>
 <878spvmwns.fsf@dusky.pond.sub.org>
 <8f936e58-988f-b5af-266d-4230a477ada4@virtuozzo.com>
Date: Tue, 08 Oct 2019 14:05:18 +0200
In-Reply-To: <8f936e58-988f-b5af-266d-4230a477ada4@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 8 Oct 2019 09:30:07 +0000")
Message-ID: <87v9szjvcx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 08 Oct 2019 12:05:35 +0000 (UTC)
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 08.10.2019 12:08, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
>>> pointer to NULL-initialized pointer, or pointer to error_abort or
>>> error_fatal, for callee to report error.
>> 
>> Yes.
>> 
>>> But very few functions instead get Error **errp as IN-argument:
>>> it's assumed to be set, and callee should clean it.
>> 
>> What do you mean by "callee should clean"?  Let's see below.
>> 
>>> In such cases, rename errp to errp_in.
>> 
>> I acknowledge that errp arguments that don't have the usual meaning can
>> be confusing.
>> 
>> Naming can help, comments can help, but perhaps we can tweak the code to
>> avoid the problem instead.  Let's see:
>> 
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
[...]
>> We can avoid the confusing Error **errp in all three cases by peeling
>> off an indirection.  What do you think?
>> 
>
> I like the idea, thanks! I think, I'll try to make a patch.
>
> But you are right, unfortunately there more cases, at least, pointed by
> Greg
>
> error_append_socket_sockfd_hint and
> error_append_security_model_hint
>
> Which don't free error..

Neither do error_append_hint() and error_prepend().

For anything named error_append_FOO_hint() or error_prepend_FOO(),
confusion seems unlikely.

>                          But if they append hint, they should always be called
> on wrapped errp, accordingly to the problem about fatal_error, so they may
> be converted to Error *err too.. Hmm, I should think about the script to find
> such functions.

I figure I better read more of your series before I comment on this
thought.


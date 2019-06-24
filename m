Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0560C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84957208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84957208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPcQ-0002Tr-Qq
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfPXk-0007Ef-Rz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfPXi-0004LY-RF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfPXh-0004J1-PV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 181B430024AD
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 14:01:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 116525B68E;
 Mon, 24 Jun 2019 14:01:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 83F5B11386A0; Mon, 24 Jun 2019 16:01:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20190620114116.27254-1-imammedo@redhat.com>
 <87blynv1lu.fsf@dusky.pond.sub.org>
 <20190624115805.36cc794a@redhat.com>
Date: Mon, 24 Jun 2019 16:01:49 +0200
In-Reply-To: <20190624115805.36cc794a@redhat.com> (Igor Mammedov's message of
 "Mon, 24 Jun 2019 11:58:05 +0200")
Message-ID: <87y31rnktu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 24 Jun 2019 14:01:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] deprecate -mem-path fallback to anonymous
 RAM
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 24 Jun 2019 10:17:33 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Igor Mammedov <imammedo@redhat.com> writes:
>> 
>> > Fallback might affect guest or worse whole host performance
>> > or functionality if backing file were used to share guest RAM
>> > with another process.
>> >
>> > Patch deprecates fallback so that we could remove it in future
>> > and ensure that QEMU will provide expected behavior and fail if
>> > it can't use user provided backing file.
>> >
>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > ---
>> > PS:
>> > Patch is written on top of
>> >   [PATCH v4 0/3] numa: deprecate '-numa node,  mem' and default memory distribution
>> > to avoid conflicts in qemu-deprecated.texi
>> >
>> >  numa.c               | 4 ++--
>> >  qemu-deprecated.texi | 8 ++++++++
>> >  2 files changed, 10 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/numa.c b/numa.c
>> > index 91a29138a2..53d67b8ad9 100644
>> > --- a/numa.c
>> > +++ b/numa.c
>> > @@ -494,8 +494,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>> >              if (mem_prealloc) {
>> >                  exit(1);
>> >              }
>> > -            error_report("falling back to regular RAM allocation.");
>> > -
>> > +            warn_report("falling back to regular RAM allocation. "
>> > +                        "Fallback to RAM allocation is deprecated.");  
>> 
>> Can we give the user clues on how to avoid the deprecated fallback?
>
> I've intentionally left it out for a lack of clear enough advise.
> Something like:
>   "Make sure that host has resources to map file pointed by -mem-path"
> would be pretty useless.

I see.

> I think describing how host should be configured in various ways
> depending on type of backing storage is well out of scope of any
> QEMU documentation. But if you have an idea to what to put there
> (or what to put in deprecation doc and refer to from here),
> I'll add it on respin.
>
>> Warning message nitpick: the message should be a single phrase, with no
>> newline or trailing punctuation.  Suggest something like
>> 
>>                warn_report("falling back to regular RAM allocation");
>>                error_printf("This is deprecated.  <Advice on what\n"
>>                             "to do goes here>\n");
>> 
>> >              /* Legacy behavior: if allocation failed, fall back to
>> >               * regular RAM allocation.
>> >               */
>> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> > index 2fe9b72121..2193705644 100644
>> > --- a/qemu-deprecated.texi
>> > +++ b/qemu-deprecated.texi
>> > @@ -112,6 +112,14 @@ QEMU using implicit generic or board specific splitting rule.
>> >  Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
>> >  it's supported by used machine type) to define mapping explictly instead.
>> >  
>> > +@subsection -mem-path fallback to RAM (since 4.1)
>> > +Currently if system memory allocation from file pointed by @option{mem-path}
>> > +fails, QEMU fallbacks to allocating from anonymous RAM. Which might result
>> > +in unpredictable behavior since provided backing file wasn't used.  
>> 
>> 
>> Noch such verb "to fallback", obvious fix "QEMU falls back to"
>> 
>> Suggest "RAM, which might".
>> 
>> Better: "since the backing file specified by the user is ignored".
>> 
>> >                                                                     In future
>> > +QEMU will not fallback and fail to start up, so user could fix his/her QEMU/host
>> > +configuration or explicitly use -m without -mem-path if system memory allocated
>> > +from anonymous RAM suits usecase.  
>> 
>> What's "system memory allocation"?
> Using man page language, would be
>  'guest startup RAM size'
> acceptable?
>
>
>> Perhaps: "In the future, QEMU will not fall back, but fail instead.
>> Adjust either the host configuration [FIXME how?] or the QEMU
>> configuration [FIXME how?]."
>
> Maybe
> "
>  In the future, QEMU will not fall back, but fail instead.
>  Adjust either the QEMU configuration by removing @option{-mem-path} so
>  QEMU will use only anonymous or host configuration to make sure that

Do you mean "only anonymous memory"?

>  there are sufficient resources on backing storage pointed by -mem-path
>  to allocate amount specified by @option{-m}.
> "

Perhaps this could suffice: "Users will be responsible for making sure
the backing storage specified with -mem-path can actually provide the
guest RAM configured with -m."

>> > +
>> >  @section QEMU Machine Protocol (QMP) commands
>> >  
>> >  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)  
>> 


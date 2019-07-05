Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3DC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B17E218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17E218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOmx-0004b7-4N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjOfY-0006wB-Hc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjOfU-0007Xs-DI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hjOfU-00078H-5e
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9797C18B2CF;
 Fri,  5 Jul 2019 13:54:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89062968C9;
 Fri,  5 Jul 2019 13:54:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13AD71132ABF; Fri,  5 Jul 2019 15:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: vandersonmr <vandersonmr2@gmail.com>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
Date: Fri, 05 Jul 2019 15:54:21 +0200
In-Reply-To: <20190702210017.4275-5-vandersonmr2@gmail.com> (vandersonmr's
 message of "Tue, 2 Jul 2019 18:00:16 -0300")
Message-ID: <877e8wk2nm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 13:54:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vandersonmr <vandersonmr2@gmail.com> writes:

> adding options to list tbs by some metric and
> investigate their code.

What's "tbs"?

Why is listing them useful?

What do you mean by "some metric"?

What do you mean by "and investigate their code?"

> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  hmp-commands-info.hx | 22 ++++++++++++++
>  monitor/misc.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..0b8c0de95d 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -288,6 +288,28 @@ ETEXI
>          .params     = "",
>          .help       = "show dynamic compiler info",
>          .cmd        = hmp_info_jit,
> +    {
> +        .name       = "tbs",
> +        .args_type  = "number:i?,sortedby:s?",
> +        .params     = "[number sortedby]",
> +        .help       = "show a [number] translated blocks sorted by [sortedby]"
> +                      "sortedby opts: hotness hg",

Your use of [square brackets] in .help is unusual.  Please try to have
your commands' help blend into the existing help.

> +        .cmd        = hmp_info_tbs,
> +    },
> +    {
> +        .name       = "tb",
> +        .args_type  = "id:i,flags:s?",
> +        .params     = "id [log1[,...] flags]",
> +        .help       = "show information about one translated block by id",
> +        .cmd        = hmp_info_tb,
> +    },
> +    {
> +        .name       = "coverset",
> +        .args_type  = "number:i?",
> +        .params     = "[number]",
> +        .help       = "show hottest translated blocks neccesary to cover"
> +                      "[number]% of the execution count",

When a parameter takes a percentage, "number" is a suboptimal name :)

> +        .cmd        = hmp_info_coverset,
>      },
>  #endif
>  

Standard request for new HMP commands without corresponding QMP
commands: please state in the commit message why the QMP command is not
worthwhile.

HMP commands without a QMP equivalent are okay if their functionality
makes no sense in QMP, or is of use only for human users.

Example for "makes no sense in QMP": setting the current CPU, because a
QMP monitor doesn't have a current CPU.

Examples for "is of use only for human users": HMP command "help", the
integrated pocket calculator.

Debugging commands are kind of borderline.  Debugging is commonly a
human activity, where HMP is just fine.  However, humans create tools to
assist with their activities, and then QMP is useful.  While I wouldn't
encourage HMP-only for the debugging use case, I wouldn't veto it.

Your (overly terse!) commit message and help texts make me guess the
commands are for gathering statistics.  Statistics can have debugging
uses.  But they often have non-debugging uses as well.  What use cases
can you imagine for these commands?

[...]


Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36751C46477
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1291B2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1291B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhcZ-0003Mx-9v
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbhau-0002gS-Kw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbhat-0001qR-M0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbhar-0001n5-Eb; Fri, 14 Jun 2019 04:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F9D13082E56;
 Fri, 14 Jun 2019 08:29:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 498927BE97;
 Fri, 14 Jun 2019 08:29:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BADA811386A6; Fri, 14 Jun 2019 10:29:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-13-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 10:29:42 +0200
In-Reply-To: <20190613153405.24769-13-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:34:02 +0200")
Message-ID: <87tvcsfu2x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 14 Jun 2019 08:29:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 12/15] monitor: Split out
 monitor/monitor.c
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Move the monitor core infrastructure from monitor/misc.c to
> monitor/monitor.c. This is code that can be shared for all targets, so
> compile it only once.
>
> What remains in monitor/misc.c after this patch is mostly monitor
> command implementations (which could move to hmp-cmds.c or qmp-cmds.c
> later) and code that requires a system emulator or is even
> target-dependent (including HMP command completion code).
>
> The amount of function and particularly extern variables in
> monitor_int.h is probably a bit larger than it needs to be, but this way
> no non-trivial code modifications are needed. The interfaces between all
> monitor parts can be cleaned up later.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
[...]
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> new file mode 100644
> index 0000000000..6802b8e491
> --- /dev/null
> +++ b/monitor/monitor.c
> @@ -0,0 +1,637 @@
[...]
> +QemuOptsList qemu_mon_opts = {
> +    .name = "mon",
> +    .implied_opt_name = "chardev",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_mon_opts.head),
> +    .desc = {
> +        {
> +            .name = "mode",
> +            .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "chardev",
> +            .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "pretty",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +        { /* end of list */ }

checkpatch.pl gripes:

    WARNING: Block comments use a leading /* on a separate line

I agree with ignoring this one, because it's the way it looks
everywhere.

> +    },
> +};
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


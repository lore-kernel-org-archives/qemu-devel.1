Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FC92082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FC92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfJQ-0004bZ-VH
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbfIK-00044E-E0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbfIJ-0005nT-4Z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbfIG-0005Bs-8o; Fri, 14 Jun 2019 02:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 151213082126;
 Fri, 14 Jun 2019 06:01:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE371608C1;
 Fri, 14 Jun 2019 06:01:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B27111386A6; Fri, 14 Jun 2019 08:01:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-7-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 08:01:50 +0200
In-Reply-To: <20190613153405.24769-7-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:33:56 +0200")
Message-ID: <878su4iu29.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 06:01:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 06/15] monitor: Rename HMP command type
 and tables
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

> This renames the type for HMP monitor commands and the tables holding
> the commands to make clear that they are related to HMP and to allow
> making them public later:
>
> * mon_cmd_t -> HMPCommand (fixing use of a reserved name, too)
> * mon_cmds -> hmp_cmds
> * info_cmds -> hmp_info_cmds
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

checkpatch.pl gripes:

> ---
>  monitor.c       | 68 ++++++++++++++++++++++++-------------------------
>  hmp-commands.hx |  2 +-
>  2 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 5eacaa48a6..006c650761 100644
> --- a/monitor.c
> +++ b/monitor.c
[...]
> @@ -4531,20 +4531,20 @@ static void monitor_event(void *opaque, int event)
>  static int
>  compare_mon_cmd(const void *a, const void *b)
>  {
> -    return strcmp(((const mon_cmd_t *)a)->name,
> -            ((const mon_cmd_t *)b)->name);
> +    return strcmp(((const HMPCommand *)a)->name,
> +            ((const HMPCommand *)b)->name);
>  }
>  
>  static void sortcmdlist(void)
>  {
>      int array_num;
> -    int elem_size = sizeof(mon_cmd_t);
> +    int elem_size = sizeof(HMPCommand);
>  
> -    array_num = sizeof(mon_cmds)/elem_size-1;
> -    qsort((void *)mon_cmds, array_num, elem_size, compare_mon_cmd);
> +    array_num = sizeof(hmp_cmds)/elem_size-1;

229: ERROR: spaces required around that '/' (ctx:VxV)
229: ERROR: spaces required around that '-' (ctx:VxV)

> +    qsort((void *)hmp_cmds, array_num, elem_size, compare_mon_cmd);
>  
> -    array_num = sizeof(info_cmds)/elem_size-1;
> -    qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
> +    array_num = sizeof(hmp_info_cmds)/elem_size-1;

Likewise.

I figure we should simply use ARRAY_SIZE().

static void sortcmdlist(void)
{
    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds), sizeof(*hmp_cmds),
          compare_mon_cmd);
    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds), sizeof(*hmp_info_cmds),
          compare_mon_cmd);
}

Can touch up in my tree.

> +    qsort((void *)hmp_info_cmds, array_num, elem_size, compare_mon_cmd);
>  }
>  
>  static void monitor_iothread_init(void)
[...]


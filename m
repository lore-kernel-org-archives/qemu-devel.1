Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C11C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4E122277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/6HdNIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4E122277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZplQ-0003Tz-Ab
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpkP-00032t-Gv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZpkK-00080X-3M
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604384681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWLJPnKAgf+Eh6UhALuYNL0esaiZmDrd3RoUF6s8N+0=;
 b=Z/6HdNIGxfKVsJH+di3IRvAs9gdkd7atSEpnOqm+L5UHCk9AR7KCYEIsjiXgLWj4hAYf/E
 M/IlRibRa8R5SDu9lySiNpKfCzk2s9iBkUxC1F7oMnyiqWZ3J1zgYh9vkCvLsAmwtgEuOQ
 ZjseCcKBi0pmzUL/NdsMt53AEU7Ngxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-PjVsdfBAOy6_-2gLuRBv3Q-1; Tue, 03 Nov 2020 01:24:38 -0500
X-MC-Unique: PjVsdfBAOy6_-2gLuRBv3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9D83805F0D;
 Tue,  3 Nov 2020 06:24:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 711FA10013BD;
 Tue,  3 Nov 2020 06:24:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5D931132BD6; Tue,  3 Nov 2020 07:24:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: chaihaoyu <chaihaoyu1@huawei.com>
Subject: Re: [PATCH v2 1/3] softmmu: Do not use C99 // comments
References: <160398385565.11191.16172040000588233087@66eaa9a8a123>
 <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Date: Tue, 03 Nov 2020 07:24:34 +0100
In-Reply-To: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com> (chaihaoyu's
 message of "Tue, 3 Nov 2020 12:06:14 +0800")
Message-ID: <87zh3zot3x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: alex.chen@huawei.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, hunongda@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chaihaoyu <chaihaoyu1@huawei.com> writes:

> Hi, recently I found some code style problems while using checkpatch.pl tool,please review.
>
> Date: Tue, 3 Nov 2020 11:01:40 +0800
> signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
> ---
>  softmmu/memory.c         | 2 +-
>  softmmu/memory_mapping.c | 2 +-
>  softmmu/physmem.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 107ce0a4f8..5fb591b001 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -36,7 +36,7 @@
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
>
> -//#define DEBUG_UNASSIGNED
> +/* #define DEBUG_UNASSIGNED */
>
>  static unsigned memory_region_transaction_depth;
>  static bool memory_region_update_pending;
> diff --git a/softmmu/memory_mapping.c b/softmmu/memory_mapping.c
> index 18d0b8067c..f64053499e 100644
> --- a/softmmu/memory_mapping.c
> +++ b/softmmu/memory_mapping.c
> @@ -19,7 +19,7 @@
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
>
> -//#define DEBUG_GUEST_PHYS_REGION_ADD
> +/* #define DEBUG_GUEST_PHYS_REGION_ADD */
>
>  static void memory_mapping_list_add_mapping_sorted(MemoryMappingList *list,
>                                                     MemoryMapping *mapping)
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 44ffb60b5d..78c1b6580a 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -75,7 +75,7 @@
>  #include <daxctl/libdaxctl.h>
>  #endif
>
> -//#define DEBUG_SUBPAGE
> +/* #define DEBUG_SUBPAGE */
>
>  /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
>   * are protected by the ramlist lock.

I recommend to leave these alone.

CODING_STYLE.rst:

    Rationale: The // form is valid in C99, so this is purely a matter of
    consistency of style. The checkpatch script will warn you about this.

For "real" comments, we overwhelmingly use /* */, and avoiding // makes
sense.  Most exceptions are in code we copy from elsewhere, such as
disas/libvixl/.

For commenting out *code*, we use both forms.  Here are the counts for
commenting out macro definitions:

    $ git-grep '^/\* *# *define' | wc -l
    125
    $ git-grep '^// *# *define' | wc -l
    192



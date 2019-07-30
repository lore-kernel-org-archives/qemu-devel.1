Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69367C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2AE2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUUL-0002CO-H4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hsUTv-0001nj-Lg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hsUTt-00039a-Jw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41637)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hsUTt-00039A-Eu
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B06B5DF26;
 Tue, 30 Jul 2019 15:56:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B31960BF7;
 Tue, 30 Jul 2019 15:56:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Ivan Ren <renyime@gmail.com>
In-Reply-To: <1564464992-22305-1-git-send-email-ivanren@tencent.com> (Ivan
 Ren's message of "Tue, 30 Jul 2019 13:36:32 +0800")
References: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 30 Jul 2019 17:56:00 +0200
Message-ID: <87d0hrjz3j.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 30 Jul 2019 15:56:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: always initial ram_counters for
 a new migration
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ivan Ren <renyime@gmail.com> wrote:
> From: Ivan Ren <ivanren@tencent.com>
>
> This patch fix a multifd migration bug in migration speed calculation, this
> problem can be reproduced as follows:
> 1. start a vm and give a heavy memory write stress to prevent the vm be
>    successfully migrated to destination
> 2. begin a migration with multifd
> 3. migrate for a long time [actually, this can be measured by transferred bytes]
> 4. migrate cancel
> 5. begin a new migration with multifd, the migration will directly run into
>    migration_completion phase
>
> Reason as follows:
>
> Migration update bandwidth and s->threshold_size in function
> migration_update_counters after BUFFER_DELAY time:
>
>     current_bytes = migration_total_bytes(s);
>     transferred = current_bytes - s->iteration_initial_bytes;
>     time_spent = current_time - s->iteration_start_time;
>     bandwidth = (double)transferred / time_spent;
>     s->threshold_size = bandwidth * s->parameters.downtime_limit;
>
> In multifd migration, migration_total_bytes function return
> qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
> s->iteration_initial_bytes will be initialized to 0 at every new migration,
> but ram_counters is a global variable, and history migration data will be
> accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
> pending_size >= s->threshold_size become false in migration_iteration_run
> after the first migration_update_counters.
>
> Signed-off-by: Ivan Ren <ivanren@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


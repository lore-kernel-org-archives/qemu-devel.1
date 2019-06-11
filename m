Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A0C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175EE208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175EE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacR7-0006UR-7L
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hacNi-0004GP-3z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hacDx-00038G-EP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hacDv-00036c-J0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB3B53092645;
 Tue, 11 Jun 2019 08:33:32 +0000 (UTC)
Received: from redhat.com (ovpn-117-129.ams2.redhat.com [10.36.117.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C9E600CD;
 Tue, 11 Jun 2019 08:33:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <20190611082520.GA11125@richard> (Wei Yang's message of "Tue, 11
 Jun 2019 16:25:20 +0800")
References: <20190402003106.17614-1-richardw.yang@linux.intel.com>
 <20190611082520.GA11125@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 11 Jun 2019 10:33:29 +0200
Message-ID: <87zhmottba.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 08:33:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: remove unused field bytes_xfer
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Tue, Apr 02, 2019 at 08:31:06AM +0800, Wei Yang wrote:
>>MigrationState->bytes_xfer is only set to 0 in migrate_init().
>>
>>Remove this unnecessary field.
>>
>>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
> Hi, David

Hi

I am on duty this week, will get it.

>
> Are you willing to pick up this one?
>
>>---
>> migration/migration.c | 1 -
>> migration/migration.h | 1 -
>> 2 files changed, 2 deletions(-)
>>
>>diff --git a/migration/migration.c b/migration/migration.c
>>index dea7078bf4..c929cf8d0f 100644
>>--- a/migration/migration.c
>>+++ b/migration/migration.c
>>@@ -1681,7 +1681,6 @@ void migrate_init(MigrationState *s)
>>      * parameters/capabilities that the user set, and
>>      * locks.
>>      */
>>-    s->bytes_xfer = 0;
>>     s->cleanup_bh = 0;
>>     s->to_dst_file = NULL;
>>     s->rp_state.from_dst_file = NULL;
>>diff --git a/migration/migration.h b/migration/migration.h
>>index 852eb3c4e9..b9efbe9168 100644
>>--- a/migration/migration.h
>>+++ b/migration/migration.h
>>@@ -116,7 +116,6 @@ struct MigrationState
>>     DeviceState parent_obj;
>> 
>>     /*< public >*/
>>-    size_t bytes_xfer;
>>     QemuThread thread;
>>     QEMUBH *cleanup_bh;
>>     QEMUFile *to_dst_file;
>>-- 
>>2.19.1


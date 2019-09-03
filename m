Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B2022CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B2022CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56tL-000459-SG
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i56sf-0003gA-6V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i56sc-0003Mh-Ld
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i56sc-0003Lk-GM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF0914E83E;
 Tue,  3 Sep 2019 11:21:44 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB157100197A;
 Tue,  3 Sep 2019 11:21:42 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:21:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190903112140.GE2744@work-vm>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 03 Sep 2019 11:21:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] UUID validation during migration
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi,
> 
> This series adds an UUID validation at the start of the migration
> on the target side. The idea is to identify the source of migration.
> 
> Possible case of problem:
> 1. There are 3 servers: A, B and C
> 2. Server A has a VM 1, server B has a VM 2
> 3. VM 1 and VM 2 want to migrate to the server C
> 4. Target of VM 1 starts on the server C and dies too quickly for some reason
> 5. Target of VM 2 starts just after that and listen the same tcp port X, which
>    the target of VM 1 wanted to use
> 6. Source of VM 1 connects to the tcp port X, and migrates to VM 2 source

That shouldn't be possible in practice; you specify the destination tcp
port when you start the destination qemu; so unless the management code
that starts the migration is very broken it should know which port it's
migrating to.
However, if it is very broken then this is a good check.

Dave

> 7. It's possible that migration might be successful (e.g., devices are the same)
> 8. So, the target of VM 2 is in undefined state
> 
> The series adds a capability to prevent successful (by mistake) migration.
> 
> The new capability x-validate-uuid only affects the source so that it sends
> its UUID to the target. The target will validate the received UUID and stop
> the migration if UUIDs are not equal.
> 
> Regards,
> Yury
> 
> Yury Kotov (3):
>   migration: Add x-validate-uuid capability
>   tests/libqtest: Allow to set expected exit status
>   tests/migration: Add a test for x-validate-uuid capability
> 
>  migration/migration.c  |   9 +++
>  migration/migration.h  |   1 +
>  migration/savevm.c     |  45 +++++++++++++
>  qapi/migration.json    |   5 +-
>  tests/libqtest.c       |  14 ++++-
>  tests/libqtest.h       |   9 +++
>  tests/migration-test.c | 140 ++++++++++++++++++++++++++++++++---------
>  7 files changed, 189 insertions(+), 34 deletions(-)
> 
> -- 
> 2.22.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


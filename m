Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F40CC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719F0207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719F0207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGWr-00047p-Gd
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1haGUi-0002xL-Ma
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1haGUg-0004vp-Jw
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1haGUc-0004Dd-F2
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:21:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A95C43084021;
 Mon, 10 Jun 2019 09:20:48 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.ams2.redhat.com [10.36.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A545C219;
 Mon, 10 Jun 2019 09:20:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <20190520020352.GA9990@richard> (Wei Yang's message of "Mon, 20
 May 2019 10:03:52 +0800")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-4-quintela@redhat.com>
 <20190520020352.GA9990@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 10 Jun 2019 11:20:45 +0200
Message-ID: <87a7epx0cy.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 10 Jun 2019 09:20:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/8] tests: Add migration multifd test
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Wed, May 15, 2019 at 02:15:39PM +0200, Juan Quintela wrote:
>>We set multifd-channels.
>>
>>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>Reviewed-by: Thomas Huth <thuth@redhat.com>
>>Signed-off-by: Juan Quintela <quintela@redhat.com>
>>---
>> tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 48 insertions(+)
>>
>>diff --git a/tests/migration-test.c b/tests/migration-test.c
>>index 0b25aa3d6c..ff480e0682 100644
>>--- a/tests/migration-test.c
>>+++ b/tests/migration-test.c
>>@@ -1028,6 +1028,53 @@ static void test_precopy_tcp(void)
>>     g_free(uri);
>> }
>> 
>>+static void test_multifd_tcp(void)
>>+{
>>+    char *uri;
>>+    QTestState *from, *to;
>>+
>>+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false)) {
>>+        return;
>>+    }
>>+
>>+    /*
>>+     * We want to pick a speed slow enough that the test completes
>>+     * quickly, but that it doesn't complete precopy even on a slow
>>+     * machine, so also set the downtime.
>>+     */
>>+    /* 1 ms should make it not converge*/
>>+    migrate_set_parameter_int(from, "downtime-limit", 1);
>>+    /* 1GB/s */
>>+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>>+
>>+    migrate_set_parameter_int(from, "multifd-channels", 2);
>>+    migrate_set_parameter_int(to, "multifd-channels", 2);
>>+
>>+    migrate_set_capability(from, "multifd", "true");
>>+    migrate_set_capability(to, "multifd", "true");
>
> Hi, Juan
>
> In case to test multifd, what's the minimum configuration? Set multifd
> capability at both side is fine?

It is required.  For older configuration, we are a bit more lax about
that requirement.  For anything new, we want it to be set in both sides.

Thanks, Juan.


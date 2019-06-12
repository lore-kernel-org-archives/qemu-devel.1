Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C7C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04472080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04472080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayPD-0001x1-Ow
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hayHo-0004Pl-9A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hayBB-0000lR-Gk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hayB9-0000dj-FD; Wed, 12 Jun 2019 04:00:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DAD21C8FA9;
 Wed, 12 Jun 2019 07:59:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E972160CCC;
 Wed, 12 Jun 2019 07:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C8A71138648; Wed, 12 Jun 2019 09:59:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-4-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 09:59:48 +0200
In-Reply-To: <20190611134043.9524-4-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:35 +0200")
Message-ID: <875zpb5j4b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 07:59:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/11] monitor: Make MonitorQMP a child
 class of Monitor
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

> Currently, struct Monitor mixes state that is only relevant for HMP,
> state that is only relevant for QMP, and some actually shared state.
> In particular, a MonitorQMP field is present in the state of any
> monitor, even if it's not a QMP monitor and therefore doesn't use the
> state.
>
> As a first step towards a clean separation between QMP and HMP, let
> MonitorQMP extend Monitor and create a MonitorQMP object only when the
> monitor is actually a QMP monitor.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This is a bit harder to review than necessary, because it mixes the
largely mechanical "replace QMP member by child class" with the
necessary prerequisite "clean up to access QMP stuff only when the
monitor is actually a QMP monitor".  I'm going to post a split.

Effectively preexisting: we go from Monitor * to MonitorQMP * without
checking in several places.  I'll throw in assertions.

Incremental diff over your patch:

diff --git a/monitor.c b/monitor.c
index d18cf18393..62a3c06aeb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -736,8 +736,7 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
-        monitor_data_destroy_qmp(qmp_mon);
+        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     }
     readline_free(mon->rs);
     qobject_unref(mon->outbuf);
@@ -1094,7 +1093,10 @@ static void query_commands_cb(QmpCommand *cmd, void *opaque)
 CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list = NULL;
-    MonitorQMP *mon = container_of(cur_mon, MonitorQMP, common);
+    MonitorQMP *mon;
+
+    assert(monitor_is_qmp(cur_mon));
+    mon = container_of(cur_mon, MonitorQMP, common);
 
     qmp_for_each_command(mon->commands, query_commands_cb, &list);
 
@@ -1213,7 +1215,10 @@ static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    MonitorQMP *mon = container_of(cur_mon, MonitorQMP, common);
+    MonitorQMP *mon;
+
+    assert(monitor_is_qmp(cur_mon));
+    mon = container_of(cur_mon, MonitorQMP, common);
 
     if (mon->commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,


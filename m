Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C593C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AD4212F5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AD4212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hac8v-0001Fz-FC
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hac6i-0007fY-Oy
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hac6h-0004xa-GN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:26:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:57800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hac6h-0004ws-34
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:26:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 01:26:14 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2019 01:26:12 -0700
Date: Tue, 11 Jun 2019 16:25:48 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190611082548.GB11125@richard>
References: <20190401061457.9393-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401061457.9393-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH] migration: cleanup check on ops in
 savevm.handlers iteration
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 01, 2019 at 02:14:57PM +0800, Wei Yang wrote:
>During migration, there are several places to iterate on
>savevm.handlers. And on each iteration, we need to check its ops and
>related callbacks before invoke it.
>
>Generally, ops is the first element to check, and it is only necessary
>to check it once.
>
>This patch clean all the related part in savevm.c to check ops only once
>in those iterations.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Hi, David

Are you willing to pick up this one?

>---
> migration/savevm.c | 35 ++++++++++++++---------------------
> 1 file changed, 14 insertions(+), 21 deletions(-)
>
>diff --git a/migration/savevm.c b/migration/savevm.c
>index 5f0ca7fac2..92af2471cd 100644
>--- a/migration/savevm.c
>+++ b/migration/savevm.c
>@@ -1096,10 +1096,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
>         if (!se->ops || !se->ops->save_setup) {
>             continue;
>         }
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
>         save_section_header(f, se, QEMU_VM_SECTION_START);
> 
>@@ -1127,10 +1126,9 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>         if (!se->ops || !se->ops->resume_prepare) {
>             continue;
>         }
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
>         ret = se->ops->resume_prepare(s, se->opaque);
>         if (ret < 0) {
>@@ -1223,10 +1221,9 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>         if (!se->ops || !se->ops->save_live_complete_postcopy) {
>             continue;
>         }
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
>         trace_savevm_section_start(se->idstr, se->section_id);
>         /* Section type */
>@@ -1265,18 +1262,16 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>     cpu_synchronize_all_states();
> 
>     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>-        if (!se->ops ||
>+        if (!se->ops || !se->ops->save_live_complete_precopy ||
>             (in_postcopy && se->ops->has_postcopy &&
>              se->ops->has_postcopy(se->opaque)) ||
>-            (in_postcopy && !iterable_only) ||
>-            !se->ops->save_live_complete_precopy) {
>+            (in_postcopy && !iterable_only)) {
>             continue;
>         }
> 
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
>         trace_savevm_section_start(se->idstr, se->section_id);
> 
>@@ -1377,10 +1372,9 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
>         if (!se->ops || !se->ops->save_live_pending) {
>             continue;
>         }
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
>         se->ops->save_live_pending(f, se->opaque, threshold_size,
>                                    res_precopy_only, res_compatible,
>@@ -2276,10 +2270,9 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>         if (!se->ops || !se->ops->load_setup) {
>             continue;
>         }
>-        if (se->ops && se->ops->is_active) {
>-            if (!se->ops->is_active(se->opaque)) {
>+        if (se->ops->is_active &&
>+            !se->ops->is_active(se->opaque)) {
>                 continue;
>-            }
>         }
> 
>         ret = se->ops->load_setup(f, se->opaque);
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me


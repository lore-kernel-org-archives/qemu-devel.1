Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE04C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEA921835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEA921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9UF-0004Gd-Qa
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu9Tf-0003ox-Q7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu9Td-0006gD-L9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:26:58 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:44506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iu9Tc-0006eV-V6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:26:57 -0500
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by
 mgwym02.jp.fujitsu.com with smtp
 id 39e5_157b_1395f7a2_3964_4830_89d4_06ea0ae15689;
 Wed, 22 Jan 2020 15:26:47 +0900
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 180D5AC00D0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 15:26:47 +0900 (JST)
Received: from G01JPEXCHYT13.g01.fujitsu.local
 (G01JPEXCHYT13.g01.fujitsu.local [10.128.194.52])
 by g01jpfmpwyt01.exch.g01.fujitsu.local (Postfix) with ESMTP id EDE726D6745;
 Wed, 22 Jan 2020 15:26:45 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT13.g01.fujitsu.local (10.128.194.52) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 15:26:46 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH v2 109/109] virtiofsd: add some options to the help message
Date: Wed, 22 Jan 2020 15:35:32 +0900
Message-ID: <20200122063532.18649-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121122433.50803-110-dgilbert@redhat.com>
References: <20200121122433.50803-110-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.41
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Add following options to the help message:
> - cache
> - flock|no_flock
> - norace
> - posix_lock|no_posix_lock
> - readdirplus|no_readdirplus
> - timeout
> - writeback|no_writeback
> - xattr|no_xattr
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> dgilbert: Split cache, norace, posix_lock, readdirplus off
>   into our own earlier patches that added the options
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com><Paste>

Hello,

I think we also need to remove unused options from help message as well.
Could you please review following patch and add or fold to this patch
if it is ok.

Thanks,
Misono

=====
[PATCH] virtiofsd: Remove unused options

Following options came from libfuse but not used in virtiofs:
 - allow_other (always set to 1 in guest kernel)
 - auto_unmount
 - -s (singlethread)

Let's remove unused options from help in order not to confuse users.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 12 +++---------
 tools/virtiofsd/fuse_lowlevel.h |  1 -
 tools/virtiofsd/helper.c        |  2 --
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 2ce3e739fd..00554c6aa7 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2539,11 +2539,9 @@ void fuse_lowlevel_help(void)
      * potentially of interest to an end-user
      */
     printf(
-        "    -o allow_other             allow access by all users\n"
         "    -o allow_root              allow access by root\n"
         "    --socket-path=PATH         path for the vhost-user socket\n"
         "    --fd=FDNUM                 fd number of vhost-user socket\n"
-        "    -o auto_unmount            auto unmount on process termination\n"
         "    --thread-pool-size=NUM     thread pool size limit (default %d)\n",
         THREAD_POOL_SIZE);
 }
@@ -2612,14 +2610,10 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
          * Allowing access only by root is done by instructing
          * kernel to allow access by everyone, and then restricting
          * access to root and mountpoint owner in libfuse.
+         *
+         * Note: allow_other is set to 1 in guest kernel for virtiofs
+         * so nothing needs to be done here
          */
-        /*
-         * We may be adding the option a second time, but
-         * that doesn't hurt.
-         */
-        if (fuse_opt_add_arg(args, "-oallow_other") == -1) {
-            goto out2;
-        }
     }
     if (args->argc == 1 && args->argv[0][0] == '-') {
         fuse_log(FUSE_LOG_ERR,
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 3a7213f42f..aa5f62c846 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1820,7 +1820,6 @@ void fuse_cmdline_help(void);
  */
 
 struct fuse_cmdline_opts {
-    int singlethread;
     int foreground;
     int debug;
     int nodefault_subtype;
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 8f00737b1a..9dd4199800 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -47,7 +47,6 @@ static const struct fuse_opt fuse_helper_opts[] = {
     FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("-f", foreground),
     FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
-    FUSE_HELPER_OPT("-s", singlethread),
     FUSE_HELPER_OPT("fsname=", nodefault_subtype),
     FUSE_OPT_KEY("fsname=", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("subtype=", nodefault_subtype),
@@ -145,7 +144,6 @@ void fuse_cmdline_help(void)
            "    --syslog                   log to syslog (default stderr)\n"
            "    -f                         foreground operation\n"
            "    --daemonize                run in background\n"
-           "    -s                         disable multi-threaded operation\n"
            "    -o cache=<mode>            cache mode. could be one of \"auto, "
            "always, none\"\n"
            "                               default: auto\n"
-- 
2.21.1


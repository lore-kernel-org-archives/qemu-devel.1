Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E12C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13C020663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3K1l0Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIbg-0002Ew-PG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jgIb9-0001lU-Lg
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:53:43 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jgIb7-0004Ch-TL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:53:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id F2F335EE
 for <qemu-devel@nongnu.org>; Tue,  2 Jun 2020 21:53:38 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
 by compute1.internal (MEProxy); Tue, 02 Jun 2020 21:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=45wpVm
 AducafuvP7moSih2zvAnFcNTn7pXXDJ9prjjI=; b=D3K1l0NsBVQb6boocfZEHD
 5iruxQJ3HayEco1ldUpwCVDadNdOqudVxu/D0p+zt70xd1nvds5clDUJbQZ5jyHH
 dRVGR8s7zPlDjn2p7nWERM44ATwMDCGhbCkeV+Em8JxOIQ1ZAJOMK73Kz+O39lpS
 G4bErQl3IzGeuktvHOga9FyAMRyFeT7f6/jZ7jgUKdn/8DiE1UgvORRYzD3MtZTy
 Xqc6lvJCnRIXBGA/MKWxy3184nmG36OrWA9K6VgCVsfHVj3/9G9F/J8FrsOTi9x+
 lmw/K0DFjTklFo5ZkIB9lWmqe/2Sg41aomLfTsCoVAidkQr0g0ABhwLYkK3GduUA
 ==
X-ME-Sender: <xms:ogLXXktR_pLTzOtNMVbG_7mUZij3arlOkZ5XxXtN5sO17tyfD_NqGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefkedggeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
 ertderreejnecuhfhrohhmpedfveholhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghr
 shesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeijeevieekfeeigeehve
 eiffelvefhjeektdevhedugffffffgtedtgeduffehvdenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdroh
 hrgh
X-ME-Proxy: <xmx:ogLXXhcbbFY-9gJG4RcL3P6jwvNkxJMw_x97St_So91XjmcKncMELA>
 <xmx:ogLXXvyK8s5-a36I6koZU_ilF0bnOD4I0B9dPkjgq2wliBjYe_APDA>
 <xmx:ogLXXnMBV_PQBU7L-_Ihw-P3rIwNLwcrx5okpef2QlzuJmEpCNEylw>
 <xmx:ogLXXtfWbDqYY57nJWE_QCo0NCVzDhhT8YxPtCjbzACUZndr4lQVjQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4C5882005F; Tue,  2 Jun 2020 21:53:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-519-g0f677ba-fm-20200601.001-g0f677ba6
Mime-Version: 1.0
Message-Id: <7b355ffb-2b96-4984-a198-ac40a07c422e@www.fastmail.com>
In-Reply-To: <20200602095547.GD9852@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200602095547.GD9852@stefanha-x1.localdomain>
Date: Tue, 02 Jun 2020 21:53:18 -0400
From: "Colin Walters" <walters@verbum.org>
To: qemu-devel@nongnu.org
Subject: =?UTF-8?Q?Re:_[PATCH]_virtiofsd:_Use_clone()_and_not_unshare(),
 _support_?= =?UTF-8?Q?non-root?=
Content-Type: text/plain
Received-SPF: none client-ip=64.147.123.21; envelope-from=walters@verbum.org;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 21:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, Jun 2, 2020, at 5:55 AM, Stefan Hajnoczi wrote:
> 
> Ping Colin. It would be great if you have time to share your thoughts on
> this discussion and explain how you are using this patch.

Yeah sorry about not replying in this thread earlier, this was just a quick Friday side project for me and the thread obviously exploded =)

Thinking about this more, probably what would be good enough for now is an option to just disable internal containerization/sandboxing.  In fact per the discussion our production pipeline runs inside OpenShift 4 and because Kubernetes doesn't support user namespaces yet it also doesn't support recursive containerization, so we need an option to turn off the internal containerization.

Our use case is somewhat specialized - for what we're doing we generally trust the guest.  We use VMs for operating system testing and development of content we trust, as opposed to e.g. something like kata.

It's fine for us to run virtiofs as the same user/security context as qemu.

So...something like this?  (Only compile tested)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1240828208..603773c505 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -51,6 +51,7 @@ struct fuse_session {
     int fd;
     int debug;
     int deny_others;
+    int no_namespaces;
     struct fuse_lowlevel_ops op;
     int got_init;
     struct cuse_data *cuse_data;
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 2dd36ec03b..263134f792 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2522,6 +2522,7 @@ static const struct fuse_opt fuse_ll_opts[] = {
     LL_OPTION("-d", debug, 1),
     LL_OPTION("--debug", debug, 1),
     LL_OPTION("allow_root", deny_others, 1),
+    LL_OPTION("--no-namespaces", no_namespaces, 1),
     LL_OPTION("--socket-path=%s", vu_socket_path, 0),
     LL_OPTION("--fd=%d", vu_listen_fd, 0),
     LL_OPTION("--thread-pool-size=%d", thread_pool_size, 0),
@@ -2542,6 +2543,7 @@ void fuse_lowlevel_help(void)
      */
     printf(
         "    -o allow_root              allow access by root\n"
+        "    --no-namespaces            Disable internal use of unshare()/clone(UNSHARE)\n"
         "    --socket-path=PATH         path for the vhost-user socket\n"
         "    --fd=FDNUM                 fd number of vhost-user socket\n"
         "    --thread-pool-size=NUM     thread pool size limit (default %d)\n",
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 3ba1d90984..7c54a9cde3 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2551,15 +2551,15 @@ static void setup_namespaces(struct lo_data *lo, struct fuse_session *se)
     char *tmpdir;
 
     /*
-     * Create a new pid namespace for *child* processes.  We'll have to
-     * fork in order to enter the new pid namespace.  A new mount namespace
-     * is also needed so that we can remount /proc for the new pid
-     * namespace.
-     *
-     * Our UNIX domain sockets have been created.  Now we can move to
-     * an empty network namespace to prevent TCP/IP and other network
-     * activity in case this process is compromised.
-     */
+    * Create a new pid namespace for *child* processes.  We'll have to
+    * fork in order to enter the new pid namespace.  A new mount namespace
+    * is also needed so that we can remount /proc for the new pid
+    * namespace.
+    *
+    * Our UNIX domain sockets have been created.  Now we can move to
+    * an empty network namespace to prevent TCP/IP and other network
+    * activity in case this process is compromised.
+    */
     if (unshare(CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET) != 0) {
         fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\n");
         exit(1);
@@ -2775,6 +2775,8 @@ static void setup_capabilities(void)
 static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
                           bool enable_syslog)
 {
+    if (se->no_namespaces)
+        return;
     setup_namespaces(lo, se);
     setup_mounts(lo->source);
     setup_seccomp(enable_syslog);


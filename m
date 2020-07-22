Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1774C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B867D20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/PMyFh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B867D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJKq-0002GO-UJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jyJK4-0001pA-MM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:18:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jyJK1-0004yI-U0
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595441908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUqY8o022DSNjRy8kFgUuOpcMR1RQQW9DDViJ3Eef9I=;
 b=F/PMyFh2gzSPdelfnCwACzbbB2F0Odez8xga5cU5qw3NFf6PAMRt6poOisCe5qRwEBdnsJ
 RicPkevTXym41JcnKy1xI+nbW9PWWJ8X1RYHs6nr2bl7jehAeB2Ratkv/awp8RDY4ZDBaG
 BJnfO8PS/d5e8gso+VRtyIcHgx8QVoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-SOMdMiuwPsuNXqKWHipOfQ-1; Wed, 22 Jul 2020 14:17:17 -0400
X-MC-Unique: SOMdMiuwPsuNXqKWHipOfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0926019200C0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 18:17:17 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-98.rdu2.redhat.com [10.10.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0B31A8EC;
 Wed, 22 Jul 2020 18:17:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C46492202B4; Wed, 22 Jul 2020 14:17:10 -0400 (EDT)
Date: Wed, 22 Jul 2020 14:17:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 2/3] virtiofsd: add
 container-friendly -o chroot sandboxing option
Message-ID: <20200722181710.GA598987@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722130206.224898-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 02:02:05PM +0100, Stefan Hajnoczi wrote:
> virtiofsd cannot run in an unprivileged container because CAP_SYS_ADMIN
> is required to create namespaces.
> 
> Introduce a weaker sandbox that is sufficient in container environments
> because the container runtime already sets up namespaces. Use chroot to
> restrict path traversal to the shared directory.
> 
> virtiofsd loses the following:
> 
> 1. Mount namespace. The process chroots to the shared directory but
>    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
>    syscalls.
> 
> 2. Pid namespace. This should be fine because virtiofsd is the only
>    process running in the container.
> 
> 3. Network namespace. This should be fine because seccomp already
>    rejects the connect(2) syscall, but an additional layer of security
>    is lost. Container runtime-specific network security policies can be
>    used drop network traffic (except for the vhost-user UNIX domain
>    socket).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/helper.c         |  3 +++
>  tools/virtiofsd/passthrough_ll.c | 44 ++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..7421c9ca1a 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -151,6 +151,9 @@ void fuse_cmdline_help(void)
>             "    -o cache=<mode>            cache mode. could be one of \"auto, "
>             "always, none\"\n"
>             "                               default: auto\n"
> +           "    -o chroot|no_chroot        use container-friendly chroot instead\n"
> +           "                               of stronger mount namespace sandbox\n"
> +           "                               default: false\n"

This option name disabling namespace setup is little confusing to me.

Will it make sense to provide another option to disable/enable
namespaces. "-o no-namespaces" and that disables setting up
namespaces.

Thanks
Vivek

>             "    -o flock|no_flock          enable/disable flock\n"
>             "                               default: no_flock\n"
>             "    -o log_level=<level>       log level, default to \"info\"\n"
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 50a164a599..990c0a8a70 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -139,6 +139,7 @@ enum {
>  
>  struct lo_data {
>      pthread_mutex_t mutex;
> +    int chroot; /* 1 - use chroot, 0 - use mount namespace */
>      int debug;
>      int writeback;
>      int flock;
> @@ -162,6 +163,8 @@ struct lo_data {
>  };
>  
>  static const struct fuse_opt lo_opts[] = {
> +    { "chroot", offsetof(struct lo_data, chroot), 1 },
> +    { "no_chroot", offsetof(struct lo_data, chroot), 0 },
>      { "writeback", offsetof(struct lo_data, writeback), 1 },
>      { "no_writeback", offsetof(struct lo_data, writeback), 0 },
>      { "source=%s", offsetof(struct lo_data, source), 0 },
> @@ -2665,6 +2668,37 @@ static void setup_capabilities(char *modcaps_in)
>      pthread_mutex_unlock(&cap.mutex);
>  }
>  
> +/*
> + * Use chroot as a weaker sandbox for environment where the process is launched
> + * without CAP_SYS_ADMIN.
> + */
> +static void setup_chroot(struct lo_data *lo)
> +{
> +    lo->proc_self_fd = open("/proc/self/fd", O_PATH);
> +    if (lo->proc_self_fd == -1) {
> +        fuse_log(FUSE_LOG_ERR, "open(\"/proc/self/fd\", O_PATH): %m\n");
> +        exit(1);
> +    }
> +
> +    /*
> +     * Make the shared directory the file system root so that FUSE_OPEN
> +     * (lo_open()) cannot escape the shared directory by opening a symlink.
> +     *
> +     * It's still possible to escape the chroot via lo->proc_self_fd but that
> +     * requires gaining control of the process first.
> +     */
> +    if (chroot(lo->source) != 0) {
> +        fuse_log(FUSE_LOG_ERR, "chroot(\"%s\"): %m\n", lo->source);
> +        exit(1);
> +    }
> +
> +    /* Move into the chroot */
> +    if (chdir("/") != 0) {
> +        fuse_log(FUSE_LOG_ERR, "chdir(\"/\"): %m\n");
> +        exit(1);
> +    }
> +}
> +
>  /*
>   * Lock down this process to prevent access to other processes or files outside
>   * source directory.  This reduces the impact of arbitrary code execution bugs.
> @@ -2672,8 +2706,13 @@ static void setup_capabilities(char *modcaps_in)
>  static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
>                            bool enable_syslog)
>  {
> -    setup_namespaces(lo, se);
> -    setup_mounts(lo->source);
> +    if (lo->chroot) {
> +        setup_chroot(lo);
> +    } else {
> +        setup_namespaces(lo, se);
> +        setup_mounts(lo->source);
> +    }
> +
>      setup_seccomp(enable_syslog);
>      setup_capabilities(g_strdup(lo->modcaps));
>  }
> @@ -2820,6 +2859,7 @@ int main(int argc, char *argv[])
>      struct fuse_session *se;
>      struct fuse_cmdline_opts opts;
>      struct lo_data lo = {
> +        .chroot = 0,
>          .debug = 0,
>          .writeback = 0,
>          .posix_lock = 1,
> -- 
> 2.26.2
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs



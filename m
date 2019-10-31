Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F54BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077B12086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077B12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQDK0-00084Q-Gm
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iQD7G-0002Ps-Rz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iQD7F-0003vt-07
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:16:06 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64163)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iQD7E-0003q0-2R
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:16:04 -0400
X-IronPort-AV: E=Sophos;i="5.68,252,1569276000"; d="scan'208";a="409826328"
Received: from unknown (HELO function) ([193.50.111.121])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 31 Oct 2019 17:15:47 +0100
Received: from samy by function with local (Exim 4.92.3)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iQD6x-0001oB-HA; Thu, 31 Oct 2019 17:15:47 +0100
Date: Thu, 31 Oct 2019 17:15:47 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jordi Pujol <jordipujolp@gmail.com>
Subject: Re: [PATCH v2] smb daemon get additional command line parameters
 from env variable
Message-ID: <20191031161547.pipit5hxzjnf6jmt@function>
References: <CACTE=gpFbUSxXeTwu6_tzSeoh_9Yp905aMdzCPCUz3h7kcgeyw@mail.gmail.com>
 <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
 <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.83
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Jordi Pujol, le jeu. 31 oct. 2019 14:33:00 +0100, a ecrit:
> The smbd daemon takes additional command line options
> from environment variable SMBDOPTIONS.
> Set the environment variable SMBDOPTIONS before executing qemu.
> 
> Example:
> 
> export SMBDOPTIONS="--option='server min protocol=CORE' -d 4"
> 
> Signed-off-by: Jordi Pujol Palomer <jordipujolp@gmail.com>

> ---
> --- qemu-4.1-a/net/slirp.c
> +++ qemu_4.1-b/net/slirp.c
> @@ -909,6 +909,12 @@ static int slirp_smb(SlirpState* s, cons
>               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
>      g_free(smb_conf);
> 
> +    char *options = g_strdup(g_getenv("SMBDOPTIONS"));

Why strduping it? you can just use g_getenv.

> +    if (options) {
> +        smb_cmdline = g_strdup_printf("%s %s", smb_cmdline, options);
> +    }
> +    g_free(options);
> +
>      if (slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 139) < 0 ||
>          slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 445) < 0) {
>          slirp_smb_cleanup(s);
> 

> --- qemu-4.1-a/slirp/src/misc.c 2019-10-29 14:40:15.043120941 +0100
> +++ qemu-4.1-b/slirp/src/misc.c 2019-10-29 14:41:04.440235684 +0100

Please submit this part to https://gitlab.freedesktop.org/slirp/libslirp/

Make sure to note in the changelog that g_shell_parse_argv does only
tokenization, and no replacement.

Samuel

> @@ -168,7 +168,9 @@ g_spawn_async_with_fds_slirp(const gchar
>  int fork_exec(struct socket *so, const char *ex)
>  {
>      GError *err = NULL;
> -    char **argv;
> +    gint argc = 0;
> +    gchar **argv = NULL;
> +    gboolean ret;
>      int opt, sp[2];
> 
>      DEBUG_CALL("fork_exec");
> @@ -179,7 +181,13 @@ int fork_exec(struct socket *so, const c
>          return 0;
>      }
> 
> -    argv = g_strsplit(ex, " ", -1);
> +    ret = g_shell_parse_argv(ex, &argc, &argv, &err);
> +    if (err) {
> +        g_critical("fork_exec invalid command: %s", err->message);
> +        g_error_free(err);
> +        return 0;
> +    }
> +
>      g_spawn_async_with_fds(NULL /* cwd */, argv, NULL /* env */,
>                             G_SPAWN_SEARCH_PATH, fork_exec_child_setup,
>                             NULL /* data */, NULL /* child_pid */, sp[1], sp[1],
> **************************************************
> 
> Thanks,
> 
> Jordi Pujol
> 


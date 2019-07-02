Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4849BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C3120665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C3120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFXA-0000re-8z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hiFV9-0007DP-CQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hiFV7-0001nv-UL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hiFV7-0001nZ-LK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:55:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1007C0586C1;
 Tue,  2 Jul 2019 09:55:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 200D819730;
 Tue,  2 Jul 2019 09:54:57 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:54:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190701175010.GN3573@redhat.com>
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701123558.30512-4-ppandit@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 09:55:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] net: tap: refactor
 net_bridge_run_helper routine
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 06:05:58PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Refactor 'net_bridge_run_helper' routine to avoid buffer
> formatting to prepare 'helper_cmd' and using shell to invoke
> helper command. Instead directly execute helper program with
> due arguments.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  net/tap.c | 43 +++++++++----------------------------------
>  1 file changed, 9 insertions(+), 34 deletions(-)
> 
> Update v3: remove buffer formatting and use of shell to invoke helper
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00071.html
> 
> diff --git a/net/tap.c b/net/tap.c
> index e8aadd8d4b..bc9b3407a6 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -478,7 +478,6 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>      sigset_t oldmask, mask;
>      int pid, status;
>      char *args[5];
> -    char **parg;
>      int sv[2];
>  
>      sigemptyset(&mask);
> @@ -498,9 +497,6 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>      }
>      if (pid == 0) {
>          int open_max = sysconf(_SC_OPEN_MAX), i;
> -        char fd_buf[6+10];
> -        char br_buf[6+IFNAMSIZ] = {0};
> -        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
>  
>          for (i = 3; i < open_max; i++) {
>              if (i != sv[1]) {
> @@ -508,39 +504,18 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>              }
>          }
>  
> -        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=", sv[1]);
> +        args[0] = (char *)helper;
> +        args[1] = (char *)"--use-vnet";
> +        args[2] = g_strdup_printf("%s%d", "--fd=", sv[1]);
> +        args[3] = g_strdup_printf("%s%s", "--br=", bridge);
> +        args[4] = NULL;
>  
> -        if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
> -            /* assume helper is a command */
> +        execv(helper, args);
>  
> -            if (strstr(helper, "--br=") == NULL) {
> -                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
> -            }
> +        g_free(args[2]);
> +        g_free(args[3]);
> +        fprintf(stderr, "failed to execute helper: %s\n", helper);
>  
> -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> -                     helper, "--use-vnet", fd_buf, br_buf);
> -
> -            parg = args;
> -            *parg++ = (char *)"sh";
> -            *parg++ = (char *)"-c";
> -            *parg++ = helper_cmd;
> -            *parg++ = NULL;
> -
> -            execv("/bin/sh", args);
> -        } else {
> -            /* assume helper is just the executable path name */
> -
> -            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
> -
> -            parg = args;
> -            *parg++ = (char *)helper;
> -            *parg++ = (char *)"--use-vnet";
> -            *parg++ = fd_buf;
> -            *parg++ = br_buf;
> -            *parg++ = NULL;
> -
> -            execv(helper, args);
> -        }

Hmm, it seems I was probaly a bit too optimistic in my suggestion to
drop use of shell entirely.

The original code was passing through to the shell to handle the case
where the user requested

   -netdev bridge,helper="/path/to/helper myarg otherarg"

In theory any parts could contain shell meta characters, but even if
they don't we'll have slightly broken compat with this change.

The QEMU man page has never documented that you can pass a command
and args, which get sent via the shell though. It only ever documented
the helper arg as being a plain qualified binary path.

So the question is how strictly we need to consider compatiblity.

The "if it isn't documented it never existed" option is to use your
patch here.

The moderately aggressive option is to just use g_shell_parse_argv()
to split the "helper" into a set of argv we can exec directly, and
declare that we don't support shell meta characters in helper.

The safest option is to put in a place a deprecation saying we'll
drop use of shell in future, only implementing the agressive
option in a later release.

Perhaps from your POV, the easy thing is to avoid this entire
question - just leave the code calling shell, but switch to
g_strdup_printf instead of snprintf.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD7EC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C5B2087E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJIsk-0003NP-Dl
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iJIrn-0002u7-5w
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iJIrl-000572-T4
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:59:34 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:38620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iJIrl-00054M-N5
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:59:33 -0400
Received: from player770.ha.ovh.net (unknown [10.109.143.146])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id C39E020AB60
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 16:59:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id B8210AE61C4D;
 Sat, 12 Oct 2019 14:59:20 +0000 (UTC)
Date: Sat, 12 Oct 2019 16:59:18 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 009/126] 9pfs: well form error hint helpers
Message-ID: <20191012165918.219f40d9@bahia.lan>
In-Reply-To: <20191011160552.22907-10-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-10-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16882587629187602771
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrieejgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.36.253
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 19:03:55 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Make error_append_security_model_hint and
> error_append_socket_sockfd_hint hint append helpers well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-local.c | 4 ++--
>  hw/9pfs/9p-proxy.c | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 08e673a79c..35635e7e7e 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1469,9 +1469,9 @@ static void local_cleanup(FsContext *ctx)
>      g_free(data);
>  }
>  
> -static void error_append_security_model_hint(Error **errp)
> +static void error_append_security_model_hint(Error **errp_in)
>  {
> -    error_append_hint(errp, "Valid options are: security_model="
> +    error_append_hint(errp_in, "Valid options are: security_model="
>                        "[passthrough|mapped-xattr|mapped-file|none]\n");
>  }
>  
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 57a8c1c808..0cea8b19fa 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -1114,9 +1114,10 @@ static int connect_namedsocket(const char *path, Error **errp)
>      return sockfd;
>  }
>  
> -static void error_append_socket_sockfd_hint(Error **errp)
> +static void error_append_socket_sockfd_hint(Error **errp_in)
>  {
> -    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
> +    error_append_hint(errp_in,
> +                      "Either specify socket=/some/path where /some/path"
>                        " points to a listening AF_UNIX socket or sock_fd=fd"
>                        " where fd is a file descriptor to a connected AF_UNIX"
>                        " socket\n");



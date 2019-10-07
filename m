Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA1C352AA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1094E2070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1094E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQQk-0006ik-9I
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHQQ5-0006HY-4O
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHQQ3-0004oc-Sx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:39:12 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:40947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHQQ3-0004nD-N9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:39:11 -0400
Received: from player728.ha.ovh.net (unknown [10.109.146.173])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1B0CD10AAD7
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 12:39:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id A5043A923FD2;
 Mon,  7 Oct 2019 10:38:56 +0000 (UTC)
Date: Mon, 7 Oct 2019 12:38:55 +0200
From: Greg Kurz <groug@kaod.org>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Don't try and recover return path in
 non-postcopy
Message-ID: <20191007123855.5f596f50@bahia.lan>
In-Reply-To: <20191007103507.31308-1-dgilbert@redhat.com>
References: <20191007103507.31308-1-dgilbert@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1568660047461062962
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheejgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  7 Oct 2019 11:35:07 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> In normal precopy we can't do reconnection recovery - but we also
> don't need to, since you can just rerun migration.
> At the moment if the 'return-path' capability is on, we use
> the return path in precopy to give a postiive 'OK' to the end

s/postiive/positive

> of migration; however if migration fails then we fall into
> the postcopy recovery path and hang.  This fixes it by only
> running the return path in the postcopy case.
> 
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

Thanks !

Tested-by: Greg Kurz <groug@kaod.org>

>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5f7e4d15e9..d5d9b31bb7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2481,7 +2481,7 @@ retry:
>  out:
>      res = qemu_file_get_error(rp);
>      if (res) {
> -        if (res == -EIO) {
> +        if (res == -EIO && migration_in_postcopy()) {
>              /*
>               * Maybe there is something we can do: it looks like a
>               * network down issue, and we pause for a recovery.



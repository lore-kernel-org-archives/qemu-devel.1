Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0657FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112A20644
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkSi-0002Dr-30
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:55:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOkRU-0001Y5-7M
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOkRT-0008W8-9x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOkRT-0008Vi-4b; Thu, 09 May 2019 10:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4510E3D94D;
	Thu,  9 May 2019 14:54:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B9D5DF49;
	Thu,  9 May 2019 14:54:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5DA4C1132B35; Thu,  9 May 2019 16:54:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190509133737.242548-1-sgarzare@redhat.com>
Date: Thu, 09 May 2019 16:54:35 +0200
In-Reply-To: <20190509133737.242548-1-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Thu, 9 May 2019 15:37:37 +0200")
Message-ID: <87y33f1xw4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 09 May 2019 14:54:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] net/slirp: fix the error message when the
 prefix len is invalid
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> Add a missing parentheses at the end of the error message,
> when we have an invalid prefix len.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/slirp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/slirp.c b/net/slirp.c
> index 95934fb36d..0f4ae0abc0 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>      }
>      if (vprefix6_len < 0 || vprefix6_len > 126) {
>          error_setg(errp,
> -                   "Invalid prefix provided (prefix len must be in range 0-126");
> +                   "Invalid prefix provided "
> +                   "(prefix len must be in range 0-126)");
>          return -1;
>      }

Preexisting: the error message fails to identify the offending
parameter.  The user needs to make the connection to "ipv6-prefixlen"
based on the fact that the only parameters with "prefix" in name or
description are "ipv6-prefix" and "ipv6-prefixlen", and only the latter
is a length.

What about "Parameter 'ipv6-prefixlen' expects a length below 127", or
"Parameter 'ipv6-prefixlen' expects a value between 0 and 126"?


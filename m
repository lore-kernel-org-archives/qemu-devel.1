Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C72C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B542070D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B542070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE8hT-0001Wv-FU
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 04:35:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hE8ge-0001Fd-WF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hE8gd-0004jU-KG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:34:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hE8gd-0004iF-Aw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2BD9307B964
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:34:23 +0000 (UTC)
Received: from work-vm (ovpn-117-246.ams2.redhat.com [10.36.117.246])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8574B18AC3;
	Wed, 10 Apr 2019 08:34:21 +0000 (UTC)
Date: Wed, 10 Apr 2019 09:34:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Message-ID: <20190410083418.GC2980@work-vm>
References: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 10 Apr 2019 08:34:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: fix error code with
 migration blockers
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410083419.I26QD8TG1mOYZrqSCDZHfWPbJMY5tLgBVM2Y6XhSD34@z>

* Cole Robinson (crobinso@redhat.com) wrote:
> The only caller that checks the error code is looking for != 0,
> so returning false is incorrect.
> 
> Fixes: 5aaac467938 "migration: savevm: consult migration blockers"
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Thanks, this was in 3.1.0 so isn't a 4.0 regression, so it'll have
to wait for 4.1.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34bcad3807..a3dae4cf02 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2544,7 +2544,7 @@ int save_snapshot(const char *name, Error **errp)
>      AioContext *aio_context;
>  
>      if (migration_is_blocked(errp)) {
> -        return false;
> +        return ret;
>      }
>  
>      if (!replay_can_snapshot()) {
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


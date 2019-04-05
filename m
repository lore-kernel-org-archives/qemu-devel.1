Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935EC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3A721726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3A721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQ9O-0005m1-IM
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:49:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCQ4J-0000b0-RM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCPt6-000890-Kz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCPt6-00081t-4y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 432863164680
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 14:32:10 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D2A60565;
	Fri,  5 Apr 2019 14:32:06 +0000 (UTC)
Date: Fri, 5 Apr 2019 15:32:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190405143203.GA20049@work-vm>
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190403114958.3705-2-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 05 Apr 2019 14:32:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/8] migration: Fix migrate_set_parameter
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405143204.H_3LdGRSyR-TWtL41VBWg3LtEKOvHEoTpFyXuYENY10@z>

* Juan Quintela (quintela@redhat.com) wrote:
> Otherwise we are setting err twice, what is wrong and causes an abort.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Queued just this one.

> ---
>  hmp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 92941142af..8eec768088 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1825,8 +1825,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size = true;
>          visit_type_size(v, param, &cache_size, &err);
> -        if (err || cache_size > INT64_MAX
> -            || (size_t)cache_size != cache_size) {
> +        if (err) {
> +            break;
> +        }
> +        if (cache_size > INT64_MAX || (size_t)cache_size != cache_size) {
>              error_setg(&err, "Invalid size %s", valuestr);
>              break;
>          }
> -- 
> 2.20.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


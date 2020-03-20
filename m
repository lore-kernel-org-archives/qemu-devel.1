Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C29C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE0020709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdRSiPJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE0020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFK35-00015V-9M
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jFK29-00005j-T2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jFK28-00045l-JX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:58:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jFK28-000440-FS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584719883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2a2MJR6B7CLot9Ji/lwHJcaY5hSgFoq/VvlS+iq64I=;
 b=DdRSiPJCjmmx2gJFiiYzjyt+1Pqgmj4l+Wg3qetBkaa4T1hRr2DoXF+oqzzewDKr0BJjjw
 fTYd0d5cMsRIW2SaOKRP7rGO7dc7tTnf7M4WDAzSA03gk+NtuTcsslYeSwt96kxVWwqs2W
 jxPkMngDsZFsdySitCB9PpTQkfK1L0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-v1CFJo9KNRW53bg3jw_Y8A-1; Fri, 20 Mar 2020 11:58:01 -0400
X-MC-Unique: v1CFJo9KNRW53bg3jw_Y8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB5B8024D8;
 Fri, 20 Mar 2020 15:58:00 +0000 (UTC)
Received: from work-vm (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 806155C1D8;
 Fri, 20 Mar 2020 15:57:59 +0000 (UTC)
Date: Fri, 20 Mar 2020 15:57:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH] xbzrle: update xbzrle doc
Message-ID: <20200320155756.GD3464@work-vm>
References: <20200320143216.423374-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200320143216.423374-1-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> Add new parameter description, also:
> 1. Remove unsociable space.
> 2. Nit picking: s/two/2 in report
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  docs/xbzrle.txt       | 7 ++++++-
>  migration/migration.c | 2 +-
>  monitor/hmp-cmds.c    | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/xbzrle.txt b/docs/xbzrle.txt
> index c0a7dfd44c..b431bdaf0f 100644
> --- a/docs/xbzrle.txt
> +++ b/docs/xbzrle.txt
> @@ -92,6 +92,11 @@ Usage
>  power of 2. The cache default value is 64MBytes. (on source only)
>      {qemu} migrate_set_cache_size 256m
> =20
> +Commit 73af8dd8d7 "migration: Make xbzrle_cache_size a migration paramet=
er"
> +(v2.11.0) deprecated migrate-set-cache-size, therefore, the new paramete=
r
> +is recommended.
> +    {qemu} migrate_set_parameter xbzrle-cache-size 256m
> +
>  4. Start outgoing migration
>      {qemu} migrate -d tcp:destination.host:4444
>      {qemu} info migrate
> @@ -108,7 +113,7 @@ power of 2. The cache default value is 64MBytes. (on =
source only)
>      xbzrle transferred: I kbytes
>      xbzrle pages: J pages
>      xbzrle cache miss: K
> -    xbzrle overflow : L
> +    xbzrle overflow: L
> =20
>  xbzrle cache-miss: the number of cache misses to date - high cache-miss =
rate
>  indicates that the cache size is set too low.
> diff --git a/migration/migration.c b/migration/migration.c
> index c1d88ace7f..4b26110d57 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1243,7 +1243,7 @@ static bool migrate_params_check(MigrationParameter=
s *params, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "xbzrle_cache_size",
>                     "is invalid, it should be bigger than target page siz=
e"
> -                   " and a power of two");
> +                   " and a power of 2");
>          return false;
>      }
> =20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index f8be6bbb16..dbfb121eb2 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -303,7 +303,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
>                         info->xbzrle_cache->cache_miss);
>          monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
>                         info->xbzrle_cache->cache_miss_rate);
> -        monitor_printf(mon, "xbzrle overflow : %" PRIu64 "\n",
> +        monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
>                         info->xbzrle_cache->overflow);
>      }
> =20
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



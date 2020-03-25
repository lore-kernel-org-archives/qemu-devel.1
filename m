Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A86AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4574820722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST6v+DXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4574820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3aa-0003Kg-D6
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH3St-0000wM-Ha
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH3Ss-0002HH-8g
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH3Ss-0002HB-4T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pQSzsXA8k7j7fsQ3/qd2G70ok2BSExyJYKWpGqLUKs=;
 b=ST6v+DXrmpbfq2RNGd4bE1STIyW2AKpczw24DqicauHhTDEgl1/Eb+QIVIe2cP3L6hCfix
 HABDmBsRpbvXOR3Rp0+Gik/moIjB64rTtcvZ1Qb6g1qfFkJTQIkGQfT8IbuM/SQBX5rXZU
 Dd7m0Q8m9fs2vH9aJEYvGNsEGjh/ZyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-TUerQ2oWOB-SLCOZlDveXg-1; Wed, 25 Mar 2020 06:40:45 -0400
X-MC-Unique: TUerQ2oWOB-SLCOZlDveXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D948718FF663;
 Wed, 25 Mar 2020 10:40:44 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B49E01BC6D;
 Wed, 25 Mar 2020 10:40:43 +0000 (UTC)
Date: Wed, 25 Mar 2020 10:40:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v3] migration: use "" instead of (null) for tls-authz
Message-ID: <20200325104041.GA2589@work-vm>
References: <119f539a9f4d198bc3bcced46b8280520d60bc51.1585100802.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <119f539a9f4d198bc3bcced46b8280520d60bc51.1585100802.git.maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> run:
> (qemu) info migrate_parameters
> announce-initial: 50 ms
> ...
> announce-max: 550 ms
> multifd-compression: none
> xbzrle-cache-size: 4194304
> max-postcopy-bandwidth: 0
>  tls-authz: '(null)'
>=20
> Migration parameter 'tls-authz' is used to provide the QOM ID
> of a QAuthZ subclass instance that provides the access control
> check, default is NULL. But the empty string is not a valid
> object ID, so use "" instead of the default. Although it will
> fail when lookup an object with ID "", it is harmless, just
> consistent with tls_creds.
>=20
> As a bonus, this patch also fixed the bad indentation on the
> last line and removed 'has_tls_authz' redundant check in
> 'hmp_info_migrate_parameters'.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Thanks!

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

> ---
>  migration/migration.c | 3 ++-
>  monitor/hmp-cmds.c    | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 4b26110d57..c4c9aee15e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->has_tls_hostname =3D true;
>      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
>      params->has_tls_authz =3D true;
> -    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
> +    params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
> +                                 s->parameters.tls_authz : "");
>      params->has_max_bandwidth =3D true;
>      params->max_bandwidth =3D s->parameters.max_bandwidth;
>      params->has_downtime_limit =3D true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index a71de0e60b..dc48e6986c 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -459,9 +459,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BAND=
WIDTH),
>              params->max_postcopy_bandwidth);
> -        monitor_printf(mon, " %s: '%s'\n",
> +        monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> -            params->has_tls_authz ? params->tls_authz : "");
> +            params->tls_authz);
>      }
> =20
>      qapi_free_MigrationParameters(params);
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



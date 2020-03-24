Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E40820786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bs0Og1Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E40820786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgZA-0003Cl-IR
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGgUF-0004LK-IT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGgU9-0003b7-Id
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:08:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGgU9-0003aT-At
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585044516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyHe0M8kHT+p3dI5Gi4VZ6mu2KuPIyvLLCims2QpujQ=;
 b=bs0Og1HpYe79iTxeqWjhXaHCb2snvpDrqIYrPKJtFPtepDfqnsiwf8DtRlZJeI0BL2jPOO
 tqfACIl80HFsBsWllSLWmg4Ikdem9xAxyEj2oP6/JadaU0jGAAQyQshkh3s4F70/GPclUS
 P9k1I5nc8uUs8eSRG1olCPAoKbSBixQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-jPs4E31FOV-PjijfFi1kXA-1; Tue, 24 Mar 2020 06:08:34 -0400
X-MC-Unique: jPs4E31FOV-PjijfFi1kXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C3C18017DF;
 Tue, 24 Mar 2020 10:08:28 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45CB9194BB;
 Tue, 24 Mar 2020 10:08:25 +0000 (UTC)
Date: Tue, 24 Mar 2020 10:08:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2] migration: use "" instead of (null) for tls-authz
Message-ID: <20200324100823.GB2645@work-vm>
References: <0a9dc2fcb78da13eb326992384bc4e57de83d9f9.1584797648.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <0a9dc2fcb78da13eb326992384bc4e57de83d9f9.1584797648.git.maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: armbru@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 quintela@redhat.com
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

Yes, it's probably the best we can do given Dan's explanation that
we can't change tls_authz to be non-null.

> Also fixed the bad indentation on the last line.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  migration/migration.c | 3 ++-
>  monitor/hmp-cmds.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index c1d88ace7f..b060153ef7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->has_tls_hostname =3D true;
>      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
>      params->has_tls_authz =3D true;
> -    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
> +    params->tls_authz =3D s->parameters.tls_authz ? \
> +                        g_strdup(s->parameters.tls_authz) : g_strdup("")=
;

The \ is unneeded; this isn't a macro; it's also a little shorter to do
it as:
    params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
                                 s->parameters.tls_authz : "");

Dave


>      params->has_max_bandwidth =3D true;
>      params->max_bandwidth =3D s->parameters.max_bandwidth;
>      params->has_downtime_limit =3D true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..f8be6bbb16 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -459,7 +459,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BAND=
WIDTH),
>              params->max_postcopy_bandwidth);
> -        monitor_printf(mon, " %s: '%s'\n",
> +        monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->has_tls_authz ? params->tls_authz : "");
>      }
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



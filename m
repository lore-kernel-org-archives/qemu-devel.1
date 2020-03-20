Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03004C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C0520722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcATmRpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C0520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLVB-0008K5-VM
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jFLUX-0007rT-Uf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jFLUW-0004gC-KU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:31:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jFLUW-0004g2-GG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584725488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pdpcs61L7/cTOAYvGjRtlCy0cu0eGvmYZXKlkPtHfRE=;
 b=TcATmRpSESztkNmeyKw86v9HO63lHzf+sg+KeBIsxeW2/bulz1aGwG44w7NxJNGrYy/sdF
 DzQEuMPlCnSyIquZHk4qowsEY6ch6jPyFCS0THzS5dpKYgWs3zMpubTKs0lc7Qaf1Cqztd
 ZUXrRChTGnvcyMUfAM1yza6CzC5LXpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-GXkMCYbBN6q1qkQhmkDWhA-1; Fri, 20 Mar 2020 13:31:26 -0400
X-MC-Unique: GXkMCYbBN6q1qkQhmkDWhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5781085983;
 Fri, 20 Mar 2020 17:31:25 +0000 (UTC)
Received: from work-vm (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F6160C84;
 Fri, 20 Mar 2020 17:31:19 +0000 (UTC)
Date: Fri, 20 Mar 2020 17:31:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com
Subject: Re: [PATCH] monitor/hmp-cmds: fix bad indentation in 'info
 migrate_parameters' cmd output
Message-ID: <20200320173117.GE3464@work-vm>
References: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com>
 <878sjv11xm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <878sjv11xm.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Rearranging the text a bit)

* Markus Armbruster (armbru@redhat.com) wrote:

> David (cc'ed) should be able to tell us which fix is right.
>=20
> @tls_creds and @tls_hostname look like they could have the same issue.

A certain Markus removed the Null checks in 8cc99dc because 4af245d
guaranteed they would be None-Null for tls-creds/hostname - so we
should be OK for those.

But tls-authz came along a lot later in d2f1d29 and doesn't
seem to have the initialisation, which is now in
migration_instance_init.

So I *think* the fix for this is to do the modern equivalent of 4af245d
:

diff --git a/migration/migration.c b/migration/migration.c
index c1d88ace7f..0bc1b93277 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3686,6 +3686,7 @@ static void migration_instance_init(Object *obj)
=20
     params->tls_hostname =3D g_strdup("");
     params->tls_creds =3D g_strdup("");
+    params->tls_authz =3D g_strdup("");
=20
     /* Set has_* up only for parameter checks */
     params->has_compress_level =3D true;

Copying in Dan to check that wouldn't break tls.

Dave

> Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:
>=20
> > run:
> > (qemu) info migrate_parameters
> > announce-initial: 50 ms
> > ...
> > announce-max: 550 ms
> > multifd-compression: none
> > xbzrle-cache-size: 4194304
> > max-postcopy-bandwidth: 0
> >  tls-authz: '(null)'
> >
> > The last line seems a bit out of place, fix it.
>=20
> Yes, indentation is off, and your patch fixes that.  But there's also
> the '(null)', which emanates a certain bug smell.  Let's have a look at
> the code:
>=20
> > Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> > ---
> >  monitor/hmp-cmds.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 58724031ea..f8be6bbb16 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -459,7 +459,7 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>    void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>    {
>        MigrationParameters *params;
>=20
>        params =3D qmp_query_migrate_parameters(NULL);
>=20
>        if (params) {
>            [...]
> >          monitor_printf(mon, "%s: %" PRIu64 "\n",
> >              MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BA=
NDWIDTH),
> >              params->max_postcopy_bandwidth);
> > -        monitor_printf(mon, " %s: '%s'\n",
> > +        monitor_printf(mon, "%s: '%s'\n",
> >              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> >              params->has_tls_authz ? params->tls_authz : "");
> >      }
>=20
> Here, params->tls_authz is null even though params->has_tls_authz is
> true.
>=20
> GNU Libc is nice enough not to crash when you attempt to print a null
> pointer, but other libcs are not.
>=20
> Where does the null pointer come from?
>=20
>    MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>    {
>        MigrationParameters *params;
>        MigrationState *s =3D migrate_get_current();
>=20
>        /* TODO use QAPI_CLONE() instead of duplicating it inline */
>        params =3D g_malloc0(sizeof(*params));
>        [...]
> --->   params->has_tls_authz =3D true;
> --->   params->tls_authz =3D g_strdup(s->parameters.tls_authz);
>        [...]
>=20
>        return params;
>    }
>=20
> Note we ignore s->parameters.has_tls_authz.
>=20
> If @tls_authz is should be present in params exactly when it is present
> in s->params, we should do this:
>=20
>        params->has_tls_authz =3D s->parameters.has_tls_authz;
>        params->tls_authz =3D g_strdup(s->parameters.tls_authz);
>=20
> If @tls_authz is should be present exactly when it's not null, we should
> do this:
>=20
>        params->has_tls_authz =3D !!s->parameters.tls_authz;
>        params->tls_authz =3D g_strdup(s->parameters.tls_authz);
>=20
> If @tls_authz should always be present, we need to substitute the null
> pointer by a suitable string, like this:
>=20
>        params->has_tls_authz =3D true;
>        params->tls_authz =3D s->parameters.tls_authz
>            ? g_strdup(s->parameters.tls_authz) : "";
>=20
> The /* TODO use QAPI_CLONE() instead of duplicating it inline */
> suggests yet another possible fix.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



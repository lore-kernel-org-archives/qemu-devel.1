Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A752C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287B02072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtQbiph3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287B02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJsD-00078Y-9W
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFJZ3-0003zH-U8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFJZ2-00038b-41
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:28:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFJZ1-00035V-Rk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584718076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ltFfa9DdLZo30+HLiB2iUWN2mJLROqQ5//bR9A5Hns=;
 b=NtQbiph3yStxfwskeF+e0z/mrBbmbOmd97wrIF5c8gqzxQeDyO+GqQRCImFvYRnwNi15/O
 qxhUvk8wT7+odkoBPlcoQtB6ebOawJjUsFwpM2y64KcZJz7Z+a26hTDpPrulO3Xj3jpjAP
 UnUhDN4pj7yc+4w+F1iLugn8FtG1e88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-xmpxT2bEPVaYkh-duUMumg-1; Fri, 20 Mar 2020 11:27:54 -0400
X-MC-Unique: xmpxT2bEPVaYkh-duUMumg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04ABDBE5;
 Fri, 20 Mar 2020 15:27:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA31A9B936;
 Fri, 20 Mar 2020 15:27:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B05A1138404; Fri, 20 Mar 2020 16:27:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH] monitor/hmp-cmds: fix bad indentation in 'info
 migrate_parameters' cmd output
References: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com>
Date: Fri, 20 Mar 2020 16:27:49 +0100
In-Reply-To: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com> (Mao
 Zhongyi's message of "Fri, 20 Mar 2020 21:00:13 +0800")
Message-ID: <878sjv11xm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:

> run:
> (qemu) info migrate_parameters
> announce-initial: 50 ms
> ...
> announce-max: 550 ms
> multifd-compression: none
> xbzrle-cache-size: 4194304
> max-postcopy-bandwidth: 0
>  tls-authz: '(null)'
>
> The last line seems a bit out of place, fix it.

Yes, indentation is off, and your patch fixes that.  But there's also
the '(null)', which emanates a certain bug smell.  Let's have a look at
the code:

> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  monitor/hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..f8be6bbb16 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -459,7 +459,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
   void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
   {
       MigrationParameters *params;

       params =3D qmp_query_migrate_parameters(NULL);

       if (params) {
           [...]
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BAND=
WIDTH),
>              params->max_postcopy_bandwidth);
> -        monitor_printf(mon, " %s: '%s'\n",
> +        monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->has_tls_authz ? params->tls_authz : "");
>      }

Here, params->tls_authz is null even though params->has_tls_authz is
true.

GNU Libc is nice enough not to crash when you attempt to print a null
pointer, but other libcs are not.

Where does the null pointer come from?

   MigrationParameters *qmp_query_migrate_parameters(Error **errp)
   {
       MigrationParameters *params;
       MigrationState *s =3D migrate_get_current();

       /* TODO use QAPI_CLONE() instead of duplicating it inline */
       params =3D g_malloc0(sizeof(*params));
       [...]
--->   params->has_tls_authz =3D true;
--->   params->tls_authz =3D g_strdup(s->parameters.tls_authz);
       [...]

       return params;
   }

Note we ignore s->parameters.has_tls_authz.

If @tls_authz is should be present in params exactly when it is present
in s->params, we should do this:

       params->has_tls_authz =3D s->parameters.has_tls_authz;
       params->tls_authz =3D g_strdup(s->parameters.tls_authz);

If @tls_authz is should be present exactly when it's not null, we should
do this:

       params->has_tls_authz =3D !!s->parameters.tls_authz;
       params->tls_authz =3D g_strdup(s->parameters.tls_authz);

If @tls_authz should always be present, we need to substitute the null
pointer by a suitable string, like this:

       params->has_tls_authz =3D true;
       params->tls_authz =3D s->parameters.tls_authz
           ? g_strdup(s->parameters.tls_authz) : "";

The /* TODO use QAPI_CLONE() instead of duplicating it inline */
suggests yet another possible fix.

David (cc'ed) should be able to tell us which fix is right.

@tls_creds and @tls_hostname look like they could have the same issue.



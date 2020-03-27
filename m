Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37C82072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqogW8A3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37C82072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnOF-0005mw-5G
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHnNF-0004ur-Ro
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHnND-0008Cs-OT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:42:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHnND-00087Q-J1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585309323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoNk/rv7g9P5DxfGRe6PC4Ugq9BYkd1SJe+ediHRkYk=;
 b=fqogW8A3yBNx9RRCe9T7dADH8jpZXSdtXcXo+v+3A64R0fNL0E59ChtZMqL/QDXh8IB5+Q
 eN5kPA2LrkUJ7OGQiUiIYz/NhY0m2qR4i5KlZTMx5sa92AXrz+w9+RI3SOn0+7X/5JlHwa
 TGgF9ktqUu1IZLGzSBsjPxU3NM6mk1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-85F2ISowOJ6iNsY9vcHerg-1; Fri, 27 Mar 2020 07:41:59 -0400
X-MC-Unique: 85F2ISowOJ6iNsY9vcHerg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06298017DF;
 Fri, 27 Mar 2020 11:41:56 +0000 (UTC)
Received: from work-vm (ovpn-113-109.ams2.redhat.com [10.36.113.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B205B9B93C;
 Fri, 27 Mar 2020 11:41:54 +0000 (UTC)
Date: Fri, 27 Mar 2020 11:41:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH] migration: fix bad indentation in error_report()
Message-ID: <20200327114148.GE2786@work-vm>
References: <20200327081221.201520-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200327081221.201520-1-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> bad indentation conflicts with CODING_STYLE doc.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  migration/migration.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index c4c9aee15e..aa43137bd2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1203,15 +1203,15 @@ static bool migrate_params_check(MigrationParamet=
ers *params, Error **errp)
> =20
>      if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX))=
 {
>          error_setg(errp, "Parameter 'max_bandwidth' expects an integer i=
n the"
> -                         " range of 0 to %zu bytes/second", SIZE_MAX);
> +                   " range of 0 to %zu bytes/second", SIZE_MAX);

No, where a parameter crosses multiple lines, it is clearer to line up
the continuation of the parameter with the parameter above.

>          return false;
>      }
> =20
>      if (params->has_downtime_limit &&
>          (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
>          error_setg(errp, "Parameter 'downtime_limit' expects an integer =
in "
> -                         "the range of 0 to %d milliseconds",
> -                         MAX_MIGRATE_DOWNTIME);
> +                   "the range of 0 to %d milliseconds",
> +                   MAX_MIGRATE_DOWNTIME);

same as above.

>          return false;
>      }
> =20
> @@ -2109,8 +2109,8 @@ void qmp_migrate_set_downtime(double value, Error *=
*errp)
>  {
>      if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
>          error_setg(errp, "Parameter 'downtime_limit' expects an integer =
in "
> -                         "the range of 0 to %d seconds",
> -                         MAX_MIGRATE_DOWNTIME_SECONDS);
> +                   "the range of 0 to %d seconds",
> +                   MAX_MIGRATE_DOWNTIME_SECONDS);

same as above.

>          return;
>      }
> =20
> @@ -2495,7 +2495,7 @@ retry:
>          if (header_type >=3D MIG_RP_MSG_MAX ||
>              header_type =3D=3D MIG_RP_MSG_INVALID) {
>              error_report("RP: Received invalid message 0x%04x length 0x%=
04x",
> -                    header_type, header_len);
> +                         header_type, header_len);

OK, yes that's better.

>              mark_source_rp_bad(ms);
>              goto out;
>          }
> @@ -2504,9 +2504,9 @@ retry:
>              header_len !=3D rp_cmd_args[header_type].len) ||
>              header_len > sizeof(buf)) {
>              error_report("RP: Received '%s' message (0x%04x) with"
> -                    "incorrect length %d expecting %zu",
> -                    rp_cmd_args[header_type].name, header_type, header_l=
en,
> -                    (size_t)rp_cmd_args[header_type].len);
> +                         "incorrect length %d expecting %zu",
> +                         rp_cmd_args[header_type].name, header_type, hea=
der_len,
> +                         (size_t)rp_cmd_args[header_type].len);

OK.

>              mark_source_rp_bad(ms);
>              goto out;
>          }
> @@ -2561,7 +2561,7 @@ retry:
>              }
>              if (header_len !=3D expected_len) {
>                  error_report("RP: Req_Page_id with length %d expecting %=
zd",
> -                        header_len, expected_len);
> +                             header_len, expected_len);

OK.

Dave

>                  mark_source_rp_bad(ms);
>                  goto out;
>              }
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



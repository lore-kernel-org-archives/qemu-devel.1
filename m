Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F901C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53361206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COmIv3Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53361206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHsyW-0000JS-Q6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHswb-000758-5p
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHswY-0007hE-0z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHswX-0007dG-NG
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585330732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LTHti2hhBiCo/ppNmpR1RdygXbLOlBAMIjiAvoADhA=;
 b=COmIv3Jc+jrsQWE7X3QyOmML9mfxBqjKzrovL99DyEph+6Bi7dCTAFxKz92uTDeip/JGey
 88IMv7IZwz8FtHFGq7BlVtyazyTecpbXrM1qGDf+csu15QqfHPINxNcV1BhUK/GiCMjsSf
 XtozajrJ/+TqwwHzZBQTHoRM/bI4hWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-9WD1oyF1OW28t6r4d1H3jw-1; Fri, 27 Mar 2020 13:38:51 -0400
X-MC-Unique: 9WD1oyF1OW28t6r4d1H3jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034111084424;
 Fri, 27 Mar 2020 17:38:50 +0000 (UTC)
Received: from work-vm (ovpn-113-149.ams2.redhat.com [10.36.113.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FDC35DA75;
 Fri, 27 Mar 2020 17:38:48 +0000 (UTC)
Date: Fri, 27 Mar 2020 17:38:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2] migration: fix bad indentation in error_report()
Message-ID: <20200327173846.GL2786@work-vm>
References: <09f7529c665cac0c6a5e032ac6fdb6ca701f7e37.1585329482.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <09f7529c665cac0c6a5e032ac6fdb6ca701f7e37.1585329482.git.maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Thanks,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index c4c9aee15e..2b7b5bccfa 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2495,7 +2495,7 @@ retry:
>          if (header_type >=3D MIG_RP_MSG_MAX ||
>              header_type =3D=3D MIG_RP_MSG_INVALID) {
>              error_report("RP: Received invalid message 0x%04x length 0x%=
04x",
> -                    header_type, header_len);
> +                         header_type, header_len);
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



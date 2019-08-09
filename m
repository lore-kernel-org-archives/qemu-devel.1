Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873EC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E5120C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E5120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw9hR-0000U2-9C
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hw9h4-0008Tm-3Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hw9h3-0003dk-1O
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hw9h2-0003d4-S6
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:32:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2BA24628B
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 18:32:47 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DC5608A7;
 Fri,  9 Aug 2019 18:32:43 +0000 (UTC)
Date: Fri, 9 Aug 2019 19:32:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190809183240.GG2840@work-vm>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190808150325.21939-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190808150325.21939-2-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 09 Aug 2019 18:32:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-file: move qemu_{get,
 put}_counted_string() declarations
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Move migration helpers for strings under include/, so they can be used
> outside of migration/
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

I've queued this one (just 1/2) for the migration pull I'll do as soon
as 4.2 opens.

> ---
>  include/migration/qemu-file-types.h | 4 ++++
>  migration/qemu-file.h               | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/migration/qemu-file-types.h b/include/migration/qe=
mu-file-types.h
> index c0a1988155..2867e3da84 100644
> --- a/include/migration/qemu-file-types.h
> +++ b/include/migration/qemu-file-types.h
> @@ -161,6 +161,10 @@ static inline void qemu_get_sbe64s(QEMUFile *f, in=
t64_t *pv)
>      qemu_get_be64s(f, (uint64_t *)pv);
>  }
> =20
> +size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
> +
> +void qemu_put_counted_string(QEMUFile *f, const char *name);
> +
>  int qemu_file_rate_limit(QEMUFile *f);
> =20
>  #endif
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 13baf896bd..185d3de505 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -155,8 +155,6 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>  void qemu_fflush(QEMUFile *f);
>  void qemu_file_set_blocking(QEMUFile *f, bool block);
> =20
> -size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
> -
>  void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
>  void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
>  void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
> @@ -175,6 +173,4 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_=
t block_offset,
>                               ram_addr_t offset, size_t size,
>                               uint64_t *bytes_sent);
> =20
> -void qemu_put_counted_string(QEMUFile *f, const char *name);
> -
>  #endif
> --=20
> 2.23.0.rc1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


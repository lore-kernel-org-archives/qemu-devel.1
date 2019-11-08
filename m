Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8DFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72661215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyB7meFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72661215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2oh-00082W-Ia
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT2lh-0003xr-5X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT2lg-0000NY-0k
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT2lf-0000NI-T8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XX5FHc8wYfkwtXD6PmSX3XB7+tf4pxp2o8N3NQ7GLwg=;
 b=gyB7meFUu1T0cV64P/K+SdLeVk/o4bC4plHxxXZKwsYOBcSYY2juyB2SX/6aNrhh4qSL19
 sKzARtTjkpEPTrPb5vQ/EY6iSV6v6M2WbCGitDFHPk5TdlpmQi1gU0eTVLSpYBIAWccwXQ
 9lx0aQikBy/SPLYlwCSkLoWQUi0PKXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-a7bkyGgJOi-Qq9agWr4jqA-1; Fri, 08 Nov 2019 06:49:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8043E107ACC3;
 Fri,  8 Nov 2019 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 829661A7E4;
 Fri,  8 Nov 2019 11:49:27 +0000 (UTC)
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, alex.bennee@linaro.org
References: <20191108104307.125020-1-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f878e27-d9b8-d021-79f9-cdbbb86092ba@redhat.com>
Date: Fri, 8 Nov 2019 12:49:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108104307.125020-1-dgilbert@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: a7bkyGgJOi-Qq9agWr4jqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 11.43, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> We're seeing occasional asserts in 'wait_for_migraiton_fail', that
> I can't reliably reproduce, and where the cores don't have any useful
> state.  Print the 'status' out, so we can see which unexpected state
> we're ending up in.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tests/migration-test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 59f291c654..ac780dffda 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -899,8 +899,13 @@ static void wait_for_migration_fail(QTestState *from=
, bool allow_active)
>  =20
>       do {
>           status =3D migrate_query_status(from);
> -        g_assert(!strcmp(status, "setup") || !strcmp(status, "failed") |=
|
> -                 (allow_active && !strcmp(status, "active")));
> +        bool result =3D !strcmp(status, "setup") || !strcmp(status, "fai=
led") ||
> +                 (allow_active && !strcmp(status, "active"));
> +        if (!result) {
> +            fprintf(stderr, "%s: unexpected status status=3D%s allow_act=
ive=3D%d\n",
> +                    __func__, status, allow_active);
> +        }
> +        g_assert(result);
>           failed =3D !strcmp(status, "failed");
>           g_free(status);
>       } while (!failed);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>



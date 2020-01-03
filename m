Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5B4206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilylU67C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5B4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQHj-0008Mc-Q0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inQH0-0007e3-1y
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inQGx-000107-6e
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:58:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inQGx-0000uC-16
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578070682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mOhBIxP2ji2YnrE8OKzKTkc/h9xU45SPdUXCj33CKQ=;
 b=ilylU67CtJTWsL/0AjWxIruaCELlzA6ywagpYOS6s/HtDUp2AGfXKKuGu7aPmEXUGwy7Rf
 xn9PTpjl1mcOILVpfUIyNHLa2jE/dVW7xkFa9CbFUA3BQxgpv7KtYa8I5bgtyTBxbK4yZC
 GlgSmkGksVZOrN4N2yz2318SFYg2uQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-O3FryvwnP5qtmTvkDsSDuA-1; Fri, 03 Jan 2020 11:58:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF724800D48
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 16:57:59 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C39CC7D552;
 Fri,  3 Jan 2020 16:57:57 +0000 (UTC)
Date: Fri, 3 Jan 2020 16:57:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 03/10] migration-test: introduce functions to handle
 string parameters
Message-ID: <20200103165755.GN3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-4-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-4-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: O3FryvwnP5qtmTvkDsSDuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I'm surprised we don't need to quote the %s's in qtest_qmp, but it
seems that we never do it in any other of the qtest_qmp calls that I can
see when we use %s.

Dave

> ---
>  tests/migration-test.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 1c9f2c4e6a..fc221f172a 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -460,6 +460,43 @@ static void migrate_set_parameter_int(QTestState *wh=
o, const char *parameter,
>      migrate_check_parameter_int(who, parameter, value);
>  }
> =20
> +static char *migrate_get_parameter_str(QTestState *who,
> +                                       const char *parameter)
> +{
> +    QDict *rsp;
> +    char *result;
> +
> +    rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters' }=
");
> +    result =3D g_strdup(qdict_get_str(rsp, parameter));
> +    qobject_unref(rsp);
> +    return result;
> +}
> +
> +static void migrate_check_parameter_str(QTestState *who, const char *par=
ameter,
> +                                        const char *value)
> +{
> +    char *result;
> +
> +    result =3D migrate_get_parameter_str(who, parameter);
> +    g_assert_cmpstr(result, =3D=3D, value);
> +    g_free(result);
> +}
> +
> +__attribute__((unused))
> +static void migrate_set_parameter_str(QTestState *who, const char *param=
eter,
> +                                      const char *value)
> +{
> +    QDict *rsp;
> +
> +    rsp =3D qtest_qmp(who,
> +                    "{ 'execute': 'migrate-set-parameters',"
> +                    "'arguments': { %s: %s } }",
> +                    parameter, value);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    qobject_unref(rsp);
> +    migrate_check_parameter_str(who, parameter, value);
> +}
> +
>  static void migrate_pause(QTestState *who)
>  {
>      QDict *rsp;
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



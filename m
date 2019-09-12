Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401AC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B332084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B332084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LKR-00089c-3l
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i8LEW-00021u-PA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i8LEV-0005rR-GU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i8LEV-0005qd-AE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 974078980E1;
 Thu, 12 Sep 2019 09:17:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54D8460872;
 Thu, 12 Sep 2019 09:17:41 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:17:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190912091739.GA9817@redhat.com>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-15-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731160719.11396-15-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 12 Sep 2019 09:17:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH  v4 14/54] plugin: add core code
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: aaron@os.amperecomputing.com, cota@braap.org, qemu-devel@nongnu.org,
 bobby.prani@gmail.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 05:06:39PM +0100, Alex Benn=C3=A9e wrote:
> From: "Emilio G. Cota" <cota@braap.org>
>=20
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: moved directory and merged various fixes]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +static int plugin_load(struct qemu_plugin_desc *desc)
> +{
> +    qemu_plugin_install_func_t install;
> +    struct qemu_plugin_ctx *ctx;
> +    char *err;
> +    int rc;
> +
> +    ctx =3D qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
> +    memset(ctx, 0, sizeof(*ctx));
> +    ctx->desc =3D desc;
> +
> +    ctx->handle =3D dlopen(desc->path, RTLD_NOW);
> +    if (ctx->handle =3D=3D NULL) {
> +        error_report("%s: %s", __func__, dlerror());
> +        goto err_dlopen;
> +    }
> +
> +    /* clear any previous dlerror, call dlsym, then check dlerror */
> +    dlerror();
> +    install =3D dlsym(ctx->handle, "qemu_plugin_install");

If you use 'GModule' instead of dlopen, then we get portability to
many more platforms, including ablity to load DLLs on Windows:

  https://developer.gnome.org/glib/stable/glib-Dynamic-Loading-of-Modules=
.html



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


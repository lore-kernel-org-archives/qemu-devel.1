Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB3EC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C8F20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R60W6lUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C8F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipv4O-0001sm-7x
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 09:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdillama@redhat.com>) id 1ipv3d-0001RO-6r
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1ipv3a-0004wj-IZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:14:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1ipv3a-0004ty-EE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578665673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c1tLUd6IYxCuOZX5RLmg7NWoM1vLJdn5r4PYEBTmdE=;
 b=R60W6lUzTjoVFWKL+6C0k8NxKWHrI+LHcs3S3txq+PCdQCXX1MFeciUinrvonhXnoA/DAi
 hRdz6VDiHfNSYPTZciZGQLASmLDcBxbLD06asYBZCBMU0z8cB6jHaa9SD8te7lt02Z5O7r
 uqll/2JgxqI3Y7eCc6IbMn/dXcWBcrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-fjq2gbNQML6aTWIVOrSwZg-1; Fri, 10 Jan 2020 09:13:26 -0500
Received: by mail-wr1-f71.google.com with SMTP id r2so951919wrp.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 06:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WdVYBanUXsHVjpigilwTHTH8yvsRkFv5QphsCCW02PY=;
 b=DUCuEAvgs/JYKqXJgw11vMA6mo4GXUhAhx2UkeWU5hxfwkvEb8pYP3Jw0bkzI7Pn9b
 QzAUI2ooyGFZOvyZb2Ls7mOTNiYoEUiKQEPoYv+YPhdW6ck3zmILxGqVg+BU+3RAXK/1
 y9eM6/pI64RQpxIn74loTXMWW4oI4H07Dry9vlKareFl6G44PVrI8gozS8WRAhAcE17b
 AQsPopEJnovHk4bZmjoOPyp7fyxB5SJKUaUxBiyDJ9PExq0rgDY4Gk/bLI8J4W492lg5
 QIhlZCv+nHkg/4hMrfB/MvMTWg2HMCi5U2yG2VF5PfSH0puq9vTkQYjccGziC7uLypOv
 Mqyg==
X-Gm-Message-State: APjAAAUppjztUytU1JDwfEqYbiLWWLDjQzDJDhkvDR6yigLLTucz2Nd9
 IO37hScMkEKVakoQcKMrgql/tEUz7H/e/94Mk5U6cUvzs1JJ2SOVkyg9bvJPp0/WZZ68s+CFrVO
 OjvSYUNUmuAEZds8kuU58uoKcr7dOqlQ=
X-Received: by 2002:a1c:8116:: with SMTP id c22mr4556679wmd.27.1578665604874; 
 Fri, 10 Jan 2020 06:13:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHFxZ0wGLT/lZsq2RkNh50tx9T0CUHBUxFH6NH47eMK9RQdzS4llTk6b0JaoQgj4LzqBrqQvARSC8QNAP8HlM=
X-Received: by 2002:a1c:8116:: with SMTP id c22mr4556641wmd.27.1578665604521; 
 Fri, 10 Jan 2020 06:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20200110111513.321728-1-fflorensa@online.net>
 <20200110111513.321728-2-fflorensa@online.net>
In-Reply-To: <20200110111513.321728-2-fflorensa@online.net>
From: Jason Dillaman <jdillama@redhat.com>
Date: Fri, 10 Jan 2020 09:13:12 -0500
Message-ID: <CA+aFP1A-C-7FYMtCQkK4XHwON5E6ZZ=Qu5N3Tf2-bhcTkEH=zQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] block/rbd: Add support for ceph namespaces
To: Florian Florensa <fflorensa@online.net>
X-MC-Unique: fjq2gbNQML6aTWIVOrSwZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, dillaman <dillaman@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 6:15 AM Florian Florensa <fflorensa@online.net> wro=
te:
>
> Starting from ceph Nautilus, RBD has support for namespaces, allowing
> for finer grain ACLs on images inside a pool, and tenant isolation.
>
> In the rbd cli tool documentation, the new image-spec and snap-spec are :
>  - [pool-name/[namespace-name/]]image-name
>  - [pool-name/[namespace-name/]]image-name@snap-name
>
> When using an non namespace's enabled qemu, it complains about not
> finding the image called namespace-name/image-name, thus we only need to
> parse the image once again to find if there is a '/' in its name, and if
> there is, use what is before it as the name of the namespace to later
> pass it to rados_ioctx_set_namespace.
> rados_ioctx_set_namespace if called with en empty string or a null
> pointer as the namespace parameters pretty much does nothing, as it then
> defaults to the default namespace.
>
> The namespace is extracted inside qemu_rbd_parse_filename, stored in the
> qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
> and qemu itself.
>
> Signed-off-by: Florian Florensa <fflorensa@online.net>
> ---
>  block/rbd.c          | 44 +++++++++++++++++++++++++++++++-------------
>  qapi/block-core.json |  4 ++++
>  2 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 027cbcc695..84115d34b4 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    char *namespace;
>      uint64_t image_size;
>  } BDRVRBDState;
>
> @@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
>      const char *start;
>      char *p, *buf;
>      QList *keypairs =3D NULL;
> -    char *found_str;
> +    char *found_str, *image_name;
>
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
> @@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char *fil=
ename, QDict *options,
>      qdict_put_str(options, "pool", found_str);
>
>      if (strchr(p, '@')) {
> -        found_str =3D qemu_rbd_next_tok(p, '@', &p);
> -        qemu_rbd_unescape(found_str);
> -        qdict_put_str(options, "image", found_str);
> +        image_name =3D qemu_rbd_next_tok(p, '@', &p);
>
>          found_str =3D qemu_rbd_next_tok(p, ':', &p);
>          qemu_rbd_unescape(found_str);
>          qdict_put_str(options, "snapshot", found_str);
>      } else {
> -        found_str =3D qemu_rbd_next_tok(p, ':', &p);
> +        image_name =3D qemu_rbd_next_tok(p, ':', &p);
> +    }
> +    /* Check for namespace in the image_name */
> +    if (strchr(image_name, '/')) {
> +        found_str =3D qemu_rbd_next_tok(image_name, '/', &image_name);
>          qemu_rbd_unescape(found_str);
> -        qdict_put_str(options, "image", found_str);
> +        qdict_put_str(options, "namespace", found_str);
> +    } else {
> +        qdict_put_str(options, "namespace", "");
>      }
> +    qemu_rbd_unescape(image_name);
> +    qdict_put_str(options, "image", image_name);
>      if (!p) {
>          goto done;
>      }
> @@ -343,6 +350,11 @@ static QemuOptsList runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "Rados pool name",
>          },
> +        {
> +            .name =3D "namespace",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Rados namespace name in the pool",
> +        },
>          {
>              .name =3D "image",
>              .type =3D QEMU_OPT_STRING,
> @@ -467,13 +479,14 @@ static int coroutine_fn qemu_rbd_co_create_opts(con=
st char *filename,
>       * schema, but when they come from -drive, they're all QString.
>       */
>      loc =3D rbd_opts->location;
> -    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
> -    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
> -    loc->has_conf =3D !!loc->conf;
> -    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
> -    loc->has_user =3D !!loc->user;
> -    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
> -    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
> +    loc->pool        =3D g_strdup(qdict_get_try_str(options, "pool"));
> +    loc->conf        =3D g_strdup(qdict_get_try_str(options, "conf"));
> +    loc->has_conf    =3D !!loc->conf;
> +    loc->user        =3D g_strdup(qdict_get_try_str(options, "user"));
> +    loc->has_user    =3D !!loc->user;
> +    loc->q_namespace =3D g_strdup(qdict_get_try_str(options, "namespace"=
));
> +    loc->image       =3D g_strdup(qdict_get_try_str(options, "image"));
> +    keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs")=
;
>
>      ret =3D qemu_rbd_do_create(create_options, keypairs, password_secret=
, errp);
>      if (ret < 0) {
> @@ -648,6 +661,11 @@ static int qemu_rbd_connect(rados_t *cluster, rados_=
ioctx_t *io_ctx,
>          error_setg_errno(errp, -r, "error opening pool %s", opts->pool);
>          goto failed_shutdown;
>      }
> +    /*
> +     * Set the namespace after opening the io context on the pool,
> +     * if nspace =3D=3D NULL or if nspace =3D=3D "", it is just as we di=
d nothing
> +     */
> +    rados_ioctx_set_namespace(*io_ctx, opts->q_namespace);
>
>      return 0;
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index fcb52ec24f..c6f187ec9b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3661,6 +3661,9 @@
>  #
>  # @pool:               Ceph pool name.
>  #
> +# @namespace:          Rados namespace name in the Ceph pool.
> +#                      (Since 5.0)
> +#
>  # @image:              Image name in the Ceph pool.
>  #
>  # @conf:               path to Ceph configuration file.  Values
> @@ -3687,6 +3690,7 @@
>  ##
>  { 'struct': 'BlockdevOptionsRbd',
>    'data': { 'pool': 'str',
> +            '*namespace': 'str',
>              'image': 'str',
>              '*conf': 'str',
>              '*snapshot': 'str',
> --
> 2.24.1
>

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

--=20
Jason



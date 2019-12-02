Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF5F20881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd9qx4e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF5F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibeC7-00036N-Q8
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 00:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibeBQ-0002eh-4x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibeBN-0007Id-7y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:23:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibeBN-0007I9-2l
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575264215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYdy6+9Tyvn2U7tF7yy3sBWpbgyP+IkV77JT8AxADyU=;
 b=Gd9qx4e3sLHhKN3QmDvXXFJZ6lLjsXN1e8fyIXfLDXTihI0NfssP3zHf2IXSEWZrIAtrZr
 LfMPaQf823Fbfm0oc96hO0DvRAH4cOYoB9+1a9EcoN/Wo9tZ92nj9yGSmAL84vZaEk4ZJJ
 vPYtehmbq+JPU/ViRYO5j0Q8W07AYBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-WS2bBucJOcC34q6EMH520A-1; Mon, 02 Dec 2019 00:22:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CBB018543A1;
 Mon,  2 Dec 2019 05:22:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AC1819C68;
 Mon,  2 Dec 2019 05:22:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9AE71138606; Mon,  2 Dec 2019 06:22:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 01/37] qdev: remove unused qdev_prop_int64
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-2-marcandre.lureau@redhat.com>
Date: Mon, 02 Dec 2019 06:22:48 +0100
In-Reply-To: <20191120152442.26657-2-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Wed, 20 Nov 2019 19:24:06 +0400")
Message-ID: <878snvnvx3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WS2bBucJOcC34q6EMH520A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 32 --------------------------------
>  include/hw/qdev-properties.h |  3 ---
>  2 files changed, 35 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ac28890e5a..be4cb01f0b 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -409,31 +409,6 @@ static void set_uint64(Object *obj, Visitor *v, cons=
t char *name,
>      visit_type_uint64(v, name, ptr, errp);
>  }
> =20
> -static void get_int64(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -    Property *prop =3D opaque;
> -    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> -
> -    visit_type_int64(v, name, ptr, errp);
> -}
> -
> -static void set_int64(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -    Property *prop =3D opaque;
> -    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> -
> -    if (dev->realized) {
> -        qdev_prop_set_after_realize(dev, name, errp);
> -        return;
> -    }
> -
> -    visit_type_int64(v, name, ptr, errp);
> -}
> -
>  const PropertyInfo qdev_prop_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
> @@ -441,13 +416,6 @@ const PropertyInfo qdev_prop_uint64 =3D {
>      .set_default_value =3D set_default_value_uint,
>  };
> =20
> -const PropertyInfo qdev_prop_int64 =3D {
> -    .name  =3D "int64",
> -    .get   =3D get_int64,
> -    .set   =3D set_int64,
> -    .set_default_value =3D set_default_value_int,
> -};
> -
>  /* --- string --- */
> =20
>  static void release_string(Object *obj, const char *name, void *opaque)
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index c6a8cb5516..690ff07ae2 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -13,7 +13,6 @@ extern const PropertyInfo qdev_prop_uint16;
>  extern const PropertyInfo qdev_prop_uint32;
>  extern const PropertyInfo qdev_prop_int32;
>  extern const PropertyInfo qdev_prop_uint64;
> -extern const PropertyInfo qdev_prop_int64;
>  extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
>  extern const PropertyInfo qdev_prop_chr;
> @@ -164,8 +163,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
>  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> -#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
>  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \

History of its use:

    Author: Peter Xu <peterx@redhat.com>
    Date:   Tue Jul 18 11:39:01 2017 +0800

        qdev: provide DEFINE_PROP_INT64()

        We have nearly all the stuff, but this one is missing. Add it in.

        Am going to use this new helper for MigrationParameters fields, sin=
ce
        most of them are int64_t.

        CC: Markus Armbruster <armbru@redhat.com>
        CC: Eduardo Habkost <ehabkost@redhat.com>
        CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
        CC: Peter Xu <peterx@redhat.com>
        CC: Juan Quintela <quintela@redhat.com>
        CC: Marcel Apfelbaum <marcel@redhat.com>
        CC: Eric Blake <eblake@redhat.com>
        Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
        Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
        Reviewed-by: Juan Quintela <quintela@redhat.com>
        Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
        Signed-off-by: Peter Xu <peterx@redhat.com>
        Message-Id: <1500349150-13240-2-git-send-email-peterx@redhat.com>
        Signed-off-by: Juan Quintela <quintela@redhat.com>

    commit 89632fafdc64927647b6f45416307cd3d4c746db
    Author: Peter Xu <peterx@redhat.com>
    Date:   Tue Jul 18 11:39:02 2017 +0800

        migration: export parameters to props

        Export migration parameters to qdev properties. Then we can use, fo=
r
        example:

          -global migration.x-cpu-throttle-initial=3Dxxx

        To specify migration parameters during init.

        Prefix "x-" is appended for each parameter exported to show that th=
is is
        not a stable interface, and only for debugging/testing purpose.

        Reviewed-by: Juan Quintela <quintela@redhat.com>
        Signed-off-by: Peter Xu <peterx@redhat.com>
        Message-Id: <1500349150-13240-3-git-send-email-peterx@redhat.com>
        Signed-off-by: Juan Quintela <quintela@redhat.com>

    [More commits adding uses...]

    commit 741d4086c856320807a2575389d7c0505578270b
    Author: Juan Quintela <quintela@redhat.com>
    Date:   Fri Dec 1 13:08:38 2017 +0100

        migration: Use proper types in json

        We use int for everything (int64_t), and then we check that value i=
s
        between 0 and 255.  Change it to the valid types.

        This change only happens for HMP.  QMP always use bytes and similar=
.

        Signed-off-by: Juan Quintela <quintela@redhat.com>
        Reviewed-by: Eric Blake <eblake@redhat.com>

    [All uses gone again]

We can remove it now, and revert the removal when new uses pop up.
Churn.  I'd say remove if we think new uses are unlikely.  I doubt they
are.



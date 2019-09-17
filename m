Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C24F2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACkx-0006jo-MO
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iACgL-0003qf-Fz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iACgK-0002g3-3h
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iACgJ-0002fl-UT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C5F181F19
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:34:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B66351001947;
 Tue, 17 Sep 2019 12:34:00 +0000 (UTC)
Date: Tue, 17 Sep 2019 13:33:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190917123357.GN1069@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 17 Sep 2019 12:34:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vmstate: add qom interface to get id
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 04:25:10PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Add an interface to get the instance id, instead of depending on
> Device and qdev_get_dev_path().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/Makefile.objs        |  1 +
>  hw/core/qdev.c               | 14 ++++++++++++++
>  hw/core/vmstate-if.c         | 23 +++++++++++++++++++++++
>  include/hw/vmstate-if.h      | 32 ++++++++++++++++++++++++++++++++

These two new files will want adding to some section of MAINTAINERS, sinc=
e
there's no wildcard rule matching for these dirs currently.

>  include/migration/register.h |  2 ++
>  include/migration/vmstate.h  |  2 ++
>  tests/Makefile.include       |  1 +
>  7 files changed, 75 insertions(+)
>  create mode 100644 hw/core/vmstate-if.c
>  create mode 100644 include/hw/vmstate-if.h

> diff --git a/include/hw/vmstate-if.h b/include/hw/vmstate-if.h
> new file mode 100644
> index 0000000000..92682f5bc2
> --- /dev/null
> +++ b/include/hw/vmstate-if.h
> @@ -0,0 +1,32 @@

License header

> +#ifndef VMSTATE_IF_H
> +#define VMSTATE_IF_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_VMSTATE_IF "vmstate-if"
> +
> +#define VMSTATE_IF_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(VMStateIfClass, (klass), TYPE_VMSTATE_IF)
> +#define VMSTATE_IF_GET_CLASS(obj)                           \
> +    OBJECT_GET_CLASS(VMStateIfClass, (obj), TYPE_VMSTATE_IF)
> +#define VMSTATE_IF(obj)                             \
> +    INTERFACE_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
> +
> +typedef struct VMStateIf VMStateIf;
> +
> +typedef struct VMStateIfClass {
> +    InterfaceClass parent_class;
> +
> +    char * (*get_id)(VMStateIf *obj);
> +} VMStateIfClass;
> +
> +static inline char *vmstate_if_get_id(VMStateIf *vmif)
> +{
> +    if (!vmif) {
> +        return NULL;
> +    }
> +
> +    return VMSTATE_IF_GET_CLASS(vmif)->get_id(vmif);
> +}

With license header fixes

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


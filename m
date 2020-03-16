Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C1AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3782051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZG53JPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3782051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDquQ-0003RB-Ab
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jDp7w-0003qE-3z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jDp7u-0004co-Jr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:45:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jDp7u-0004Wb-Ee
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ir7cnEShMX2afXDmBHf0ov09sd3AdT7sSXAVzutCg6o=;
 b=JZG53JPCaXRTUHkxzq/0xbihNZskNGeshRAOXx5JdfPLVialxC9mOYm/c/GKVVBm6NbH/A
 r/4ahV3KTqN6CPqtT4rq4k5KNhxSf44vDUr0Kbkpw1w9krcQEWw97ORjqOJyxFrowdrsGL
 oMxdk6nuQH3Mr4jQYsTwVhVI1/j65g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-x2gDq8VWMVqc7A90WWmVaA-1; Mon, 16 Mar 2020 08:45:48 -0400
X-MC-Unique: x2gDq8VWMVqc7A90WWmVaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B9685EE6B;
 Mon, 16 Mar 2020 12:45:46 +0000 (UTC)
Received: from localhost (ovpn-200-42.brq.redhat.com [10.40.200.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 396027A411;
 Mon, 16 Mar 2020 12:45:39 +0000 (UTC)
Date: Mon, 16 Mar 2020 13:45:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 5/8] qapi/misc: Restrict query-vm-generation-id
 command to machine code
Message-ID: <20200316134538.4209b297@redhat.com>
In-Reply-To: <20200316000348.29692-6-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-6-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S.
 Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 01:03:45 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  qapi/machine.json | 20 ++++++++++++++++++++
>  qapi/misc.json    | 21 ---------------------
>  hw/acpi/vmgenid.c |  2 +-
>  stubs/vmgenid.c   |  2 +-
>  4 files changed, 22 insertions(+), 23 deletions(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index c096efbea3..1a2a4b0d48 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -415,6 +415,26 @@
>  ##
>  { 'command': 'query-target', 'returns': 'TargetInfo' }
> =20
> +##
> +# @GuidInfo:
> +#
> +# GUID information.
> +#
> +# @guid: the globally unique identifier
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
> +
> +##
> +# @query-vm-generation-id:
> +#
> +# Show Virtual Machine Generation ID
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
>  ##
>  # @LostTickPolicy:
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index f70025f34c..8c02870227 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1383,24 +1383,3 @@
>  #
>  ##
>  { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
> -
> -##
> -# @GuidInfo:
> -#
> -# GUID information.
> -#
> -# @guid: the globally unique identifier
> -#
> -# Since: 2.9
> -##
> -{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
> -
> -##
> -# @query-vm-generation-id:
> -#
> -# Show Virtual Machine Generation ID
> -#
> -# Since: 2.9
> -##
> -{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> -
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 2df7623d74..2b26bacaf8 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -12,7 +12,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "qemu/module.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
> index 568e42b064..bfad656c6c 100644
> --- a/stubs/vmgenid.c
> +++ b/stubs/vmgenid.c
> @@ -1,6 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "qapi/qmp/qerror.h"
> =20
>  GuidInfo *qmp_query_vm_generation_id(Error **errp)



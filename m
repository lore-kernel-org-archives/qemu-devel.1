Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F2C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142BB20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlKgNqQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142BB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDquo-0003c1-O8
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jDpV5-0003RM-9v
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jDpV4-000562-1F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:09:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jDpV3-0004zs-Sd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584364185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji6W5MVJziJ0ZX9L3kszFiFNaa2iMgdSBH/Fx0f1UZ4=;
 b=GlKgNqQXWYT5KsDcNKHdIIfzBF/Ivl4h7fLYXPdQjzIIDATObDsuYbxf79kNVsU1/8+KVh
 9jv8kyE/qxEODhppJedH14Ip6S/ZoqVPvXL41uA7pHaeyzKKiNhZBUTfyUcgDnpLQKrDKV
 GXn+IZi0i1qkudveBmCyWjL7XD0xzUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-nSpadLffMPy5YTZqSrCN2Q-1; Mon, 16 Mar 2020 09:09:42 -0400
X-MC-Unique: nSpadLffMPy5YTZqSrCN2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF28113EA;
 Mon, 16 Mar 2020 13:09:40 +0000 (UTC)
Received: from localhost (ovpn-200-42.brq.redhat.com [10.40.200.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C99BE5D9E2;
 Mon, 16 Mar 2020 13:09:32 +0000 (UTC)
Date: Mon, 16 Mar 2020 14:09:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 4/8] qapi/misc: Move query-uuid command with block code
Message-ID: <20200316134317.4d40d16b@redhat.com>
In-Reply-To: <20200316000348.29692-5-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-5-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Mon, 16 Mar 2020 01:03:44 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

here should be why

PS:
 I don't see a reason to move it to block code at all
if this command is moved then it should be machine code

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qapi/block-core.json | 30 ++++++++++++++++++++++++++++++
>  qapi/misc.json       | 30 ------------------------------
>  block/iscsi.c        |  2 +-
>  stubs/uuid.c         |  2 +-
>  4 files changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 91586fb1fb..5c3fa6c5d0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5415,3 +5415,33 @@
>  { 'command': 'blockdev-snapshot-delete-internal-sync',
>    'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
>    'returns': 'SnapshotInfo' }
> +
> +##
> +# @UuidInfo:
> +#
> +# Guest UUID information (Universally Unique Identifier).
> +#
> +# @UUID: the UUID of the guest
> +#
> +# Since: 0.14.0
> +#
> +# Notes: If no UUID was specified for the guest, a null UUID is returned=
.
> +##
> +{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
> +
> +##
> +# @query-uuid:
> +#
> +# Query the guest UUID information.
> +#
> +# Returns: The @UuidInfo for the guest
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-uuid" }
> +# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
> +#
> +##
> +{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tru=
e }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ed28e41229..f70025f34c 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -97,36 +97,6 @@
>  ##
>  { 'command': 'query-kvm', 'returns': 'KvmInfo' }
> =20
> -##
> -# @UuidInfo:
> -#
> -# Guest UUID information (Universally Unique Identifier).
> -#
> -# @UUID: the UUID of the guest
> -#
> -# Since: 0.14.0
> -#
> -# Notes: If no UUID was specified for the guest, a null UUID is returned=
.
> -##
> -{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
> -
> -##
> -# @query-uuid:
> -#
> -# Query the guest UUID information.
> -#
> -# Returns: The @UuidInfo for the guest
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "query-uuid" }
> -# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
> -#
> -##
> -{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tru=
e }
> -
>  ##
>  # @IOThreadInfo:
>  #
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 682abd8e09..68ed5cf3f8 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -42,7 +42,7 @@
>  #include "qemu/uuid.h"
>  #include "sysemu/replay.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
>  #include "crypto/secret.h"
> diff --git a/stubs/uuid.c b/stubs/uuid.c
> index 67f182fa3a..9ef75fdae4 100644
> --- a/stubs/uuid.c
> +++ b/stubs/uuid.c
> @@ -1,5 +1,5 @@
>  #include "qemu/osdep.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-block-core.h"
>  #include "qemu/uuid.h"
> =20
>  UuidInfo *qmp_query_uuid(Error **errp)



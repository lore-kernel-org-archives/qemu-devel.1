Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0461C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B142082F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIKD5QTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1adT-0001Op-JE
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j1acH-0000SI-U2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j1acF-0003BO-35
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:50:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j1acE-000376-Ru
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581447034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHbEgfA3Kda4AjtPZbYjLlHehEcdunpL7H8ZqYpPnyc=;
 b=NIKD5QTitMtHv8O5xvjtbvQm41TEVjwHx66ImU0sYezdUaFeDv3Fmyi+L2Y8ncJ0eDhLrb
 dSkPTWqduYSkfi1QfObRUsaPvRwnOFHse9i5oOUSK3L+Li76J1MTa3dlm+yuU5Q2s/Zhst
 bZawNkutrx/MB1VETvZXB1X26f3WLN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-wn-fBfxoNk6gw4gJRB3PFA-1; Tue, 11 Feb 2020 13:50:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCFB31007277
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 18:50:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 170BC90083;
 Tue, 11 Feb 2020 18:50:19 +0000 (UTC)
Date: Tue, 11 Feb 2020 18:50:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 1/8] multifd: Add multifd-method parameter
Message-ID: <20200211185016.GP55376@redhat.com>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129115655.10414-2-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wn-fBfxoNk6gw4gJRB3PFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 12:56:48PM +0100, Juan Quintela wrote:
> This will store the compression method to use.  We start with none.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 13 +++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  migration/migration.c        | 13 +++++++++++++
>  monitor/hmp-cmds.c           | 13 +++++++++++++
>  qapi/migration.json          | 30 +++++++++++++++++++++++++++---
>  tests/qtest/migration-test.c | 14 ++++++++++----
>  6 files changed, 79 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 7f93bfeb88..4442844d37 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -8,6 +8,7 @@

> @@ -488,6 +488,19 @@
>  ##
>  { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
> =20
> +##
> +# @MultiFDMethod:
> +#
> +# An enumeration of multifd compression.
> +#
> +# @none: no compression.
> +#
> +# Since: 5.0
> +#
> +##
> +{ 'enum': 'MultiFDMethod',
> +  'data': [ 'none' ] }

I feel like "MultiFDMethod" is better called "MultiFDCompression"

> +
>  ##
>  # @MigrationParameter:
>  #
> @@ -586,6 +599,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multifd-method: Which compression method to use.
> +#                  Defaults to none. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -598,7 +614,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-method' ] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -688,6 +704,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multifd-method: Which compression method to use.
> +#                  Defaults to none. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -713,7 +732,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -=09    '*max-cpu-throttle': 'int' } }
> +            '*max-cpu-throttle': 'int',
> +            '*multifd-method': 'MultiFDMethod' } }


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D27C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FDF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4YIMXKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FDF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA58-0006r2-Ev
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEA4S-0006K7-3R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEA4Q-0007zA-NL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:07:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEA4Q-0007vO-Iq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584443258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TF204cY1qC6l9HVQs6Lh94FXDWABbdvp6yJPoIW0RE=;
 b=D4YIMXKG/CErPNGZNqyOK3E6ZTz9DbBEe/P0B/PO+jc61Ie9vyFvw/KWL6P2az1akDFhuK
 OB4uTqO9BaUVjl4Jzcf3fKN6kc7UWP8Xj6QdybJEW1wUUQ7z7hW7FzSwtvQ0uzzE4OY/9k
 VDRTwqjWdxLf29tPh3WvTLSn6t1jrm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-nrWzRZ67O664FXOzpM4qrQ-1; Tue, 17 Mar 2020 07:07:34 -0400
X-MC-Unique: nrWzRZ67O664FXOzpM4qrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 645AA800EB6;
 Tue, 17 Mar 2020 11:07:33 +0000 (UTC)
Received: from localhost (unknown [10.40.208.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5E9393526;
 Tue, 17 Mar 2020 11:07:24 +0000 (UTC)
Date: Tue, 17 Mar 2020 12:07:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 5/8] qapi/misc: Restrict query-vm-generation-id
 command to machine code
Message-ID: <20200317120723.1a0d6cc3@redhat.com>
In-Reply-To: <c8d31aa1-9e52-a45f-a23c-1e66305194a0@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-6-philmd@redhat.com>
 <20200316134538.4209b297@redhat.com>
 <c8d31aa1-9e52-a45f-a23c-1e66305194a0@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Tue, 17 Mar 2020 10:44:33 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 3/16/20 1:45 PM, Igor Mammedov wrote:
> > On Mon, 16 Mar 2020 01:03:45 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =20
> >=20
> > Acked-by: Igor Mammedov <imammedo@redhat.com> =20
> >> ---
> >>   qapi/machine.json | 20 ++++++++++++++++++++
> >>   qapi/misc.json    | 21 ---------------------
> >>   hw/acpi/vmgenid.c |  2 +-
> >>   stubs/vmgenid.c   |  2 +-
> >>   4 files changed, 22 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index c096efbea3..1a2a4b0d48 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -415,6 +415,26 @@
> >>   ##
> >>   { 'command': 'query-target', 'returns': 'TargetInfo' }
> >>  =20
> >> +##
> >> +# @GuidInfo:
> >> +#
> >> +# GUID information.
> >> +#
> >> +# @guid: the globally unique identifier
> >> +#
> >> +# Since: 2.9
> >> +##
> >> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
> >> +
> >> +##
> >> +# @query-vm-generation-id:
> >> +#
> >> +# Show Virtual Machine Generation ID
> >> +#
> >> +# Since: 2.9
> >> +##
> >> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> >> +
> >>   ##
> >>   # @LostTickPolicy:
> >>   #
> >> diff --git a/qapi/misc.json b/qapi/misc.json
> >> index f70025f34c..8c02870227 100644
> >> --- a/qapi/misc.json
> >> +++ b/qapi/misc.json
> >> @@ -1383,24 +1383,3 @@
> >>   #
> >>   ##
> >>   { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
> >> -
> >> -##
> >> -# @GuidInfo:
> >> -#
> >> -# GUID information.
> >> -#
> >> -# @guid: the globally unique identifier
> >> -#
> >> -# Since: 2.9
> >> -##
> >> -{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
> >> -
> >> -##
> >> -# @query-vm-generation-id:
> >> -#
> >> -# Show Virtual Machine Generation ID
> >> -#
> >> -# Since: 2.9
> >> -##
> >> -{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' } =20
>=20
> Daniel explained on IRC the GUID structure is "standardized by microsoft=
=20
> as a way to detect when a guest has certain operations applied" to a=20
> saved snapshot.
>=20
> https://docs.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-=
generation-identifier=20
>=20
>=20
> So this one goes to qapi/block-core.json, right?

I think it belongs to machine

>=20
> >> -
> >> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> >> index 2df7623d74..2b26bacaf8 100644
> >> --- a/hw/acpi/vmgenid.c
> >> +++ b/hw/acpi/vmgenid.c
> >> @@ -12,7 +12,7 @@
> >>  =20
> >>   #include "qemu/osdep.h"
> >>   #include "qapi/error.h"
> >> -#include "qapi/qapi-commands-misc.h"
> >> +#include "qapi/qapi-commands-machine.h"
> >>   #include "qemu/module.h"
> >>   #include "hw/acpi/acpi.h"
> >>   #include "hw/acpi/aml-build.h"
> >> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
> >> index 568e42b064..bfad656c6c 100644
> >> --- a/stubs/vmgenid.c
> >> +++ b/stubs/vmgenid.c
> >> @@ -1,6 +1,6 @@
> >>   #include "qemu/osdep.h"
> >>   #include "qapi/error.h"
> >> -#include "qapi/qapi-commands-misc.h"
> >> +#include "qapi/qapi-commands-machine.h"
> >>   #include "qapi/qmp/qerror.h"
> >>  =20
> >>   GuidInfo *qmp_query_vm_generation_id(Error **errp) =20
> >  =20
>=20



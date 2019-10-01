Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F581C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2400F2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2400F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPbx-0001k4-2B
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFPYk-0008E2-FD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFPYh-0000VE-HW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:19:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iFPYh-0000Se-7p
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:19:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE8718A1C8F;
 Tue,  1 Oct 2019 21:19:45 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58E2E60464;
 Tue,  1 Oct 2019 21:19:42 +0000 (UTC)
Subject: Re: [PATCH 6/7] qapi: Split up scripts/qapi/common.py
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f195452f-43f8-a1be-653b-e4d8d2d888e3@redhat.com>
Date: Tue, 1 Oct 2019 16:19:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001191514.11208-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 01 Oct 2019 21:19:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 2:15 PM, Markus Armbruster wrote:
> The QAPI code generator clocks in at some 3100 SLOC in 8 source files.
> Almost 60% of the code is in qapi/common.py.  Split it into more
> focused modules:
>=20
> * Move QAPISchemaPragma and QAPISourceInfo to qapi/source.py.
>=20
> * Move QAPIError and its sub-classes to qapi/error.py.
>=20
> * Move QAPISchemaParser and QAPIDoc to parser.py.  Use the opportunity
>    to put QAPISchemaParser first.
>=20
> * Move check_expr() & friends to qapi/expr.py.  Use the opportunity to
>    put the code into a more sensible order.

Code motion can be easier to review when it is 1:1 (using 'diff -u <(sed=20
-n '/^-//p' patch) <(sed -n '/^\+//p'patch)', which is quite small if=20
code moved wholesale).  Reordering things breaks that property.

>=20
> * Move QAPISchema & friends to qapi/schema.py
>=20
> * Move QAPIGen and its sub-classes, ifcontext,
>    QAPISchemaModularCVisitor, and QAPISchemaModularCVisitor to qapi/gen=
.py
>=20
> A number of helper functions remain in qapi/common.py.  I considered
> moving the code generator helpers to qapi/gen.py, but decided not to.
> Perhaps we should rewrite them as methods of QAPIGen some day.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>   15 files changed, 2411 insertions(+), 2329 deletions(-)

Sheesh. This one's big.  I'm half-tempted to ask you to split it=20
further.  But here goes my review anyway...

>   create mode 100644 scripts/qapi/error.py
>   create mode 100644 scripts/qapi/expr.py
>   create mode 100644 scripts/qapi/gen.py
>   create mode 100644 scripts/qapi/parser.py
>   create mode 100644 scripts/qapi/schema.py
>   create mode 100644 scripts/qapi/source.py
>=20
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 3d98ca2e0c..f93f3c7c23 100755
> --- a/scripts/qapi-gen.py


> +++ b/scripts/qapi/error.py
> @@ -0,0 +1,42 @@
> +#
> +# QAPI error classes
> +#
> +# Copyright (c) 2017-2019 Red Hat Inc.
> +#
> +# Authors:
> +#  Markus Armbruster <armbru@redhat.com>
> +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.

It's a shame the generator got stuck at GPLv2-only.  I don't know if=20
that's worth cleaning up as part of refactoring, but if so, it would be=20
best as a separate patch from the code motion.

> +++ b/scripts/qapi/gen.py

> +++ b/scripts/qapi/parser.py

> +++ b/scripts/qapi/schema.py

> +++ b/scripts/qapi/source.py
I didn't see any obvious accidental changes in all that motion (although=20
given the size, the review was more cursory of the form "does it look=20
like an entire chunk of code moved from one file to another per the=20
commit message" than "read every line").

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


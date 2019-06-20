Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE337C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27222084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27222084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsyp-0002xJ-Ie
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hdsjG-0007Qa-EX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hdsX8-000753-TE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hdsX8-00074d-Og
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17B3930C3183
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:35:02 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BC119C5B;
 Thu, 20 Jun 2019 08:34:59 +0000 (UTC)
Date: Thu, 20 Jun 2019 09:34:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620083457.GF25448@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-5-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 20 Jun 2019 08:35:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: Split qom.json and qdev.json
 off misc.json
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
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 10:10:37PM +0200, Markus Armbruster wrote:
> Move commands object-add, object-del, qom-get, qom-list,
> qom-list-properties, qom-list-types, and qom-set with their types from
> misc.json to new qom.json.  Add qom.json to MAINTAINERS section QOM.
>=20
> Move commands device-list-properties, device_add, device-del, and
> event DEVICE_DELETED from misc.json to new qdev.json.  qdev.json
> remains uncovered by MAINTAINERS, like the rest of qdev.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS           |   1 +
>  hw/block/xen-block.c  |   2 +-
>  hw/core/qdev.c        |   2 +-
>  monitor/hmp-cmds.c    |   1 +
>  monitor/qmp-cmds.c    |   1 +
>  qapi/Makefile.objs    |   5 +-
>  qapi/misc.json        | 351 ------------------------------------------
>  qapi/qapi-schema.json |   2 +
>  qapi/qdev.json        | 125 +++++++++++++++
>  qapi/qom.json         | 244 +++++++++++++++++++++++++++++
>  qdev-monitor.c        |   2 +-
>  11 files changed, 380 insertions(+), 356 deletions(-)
>  create mode 100644 qapi/qdev.json
>  create mode 100644 qapi/qom.json

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63390eadb5..1aef0afaf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2035,6 +2035,7 @@ R: Eduardo Habkost <ehabkost@redhat.com>
>  S: Supported
>  F: include/qom/
>  X: include/qom/cpu.h
> +F: qapi/qom.json
>  F: qom/
>  X: qom/cpu.c
>  F: tests/check-qom-interface.c

So we don't have any designated "qdev" maintainers i see.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


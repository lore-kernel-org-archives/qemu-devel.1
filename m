Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC48C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BCE2084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BCE2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsp0-0004h7-6E
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hdsj6-0006s7-JR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hdsbp-0001OM-2p
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hdsbj-0001IM-EH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1288C81E19
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:39:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD8F60A97;
 Thu, 20 Jun 2019 08:39:41 +0000 (UTC)
Date: Thu, 20 Jun 2019 09:39:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620083938.GH25448@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-7-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 08:39:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/17] qom: Move HMP command handlers to
 qom/
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 10:10:39PM +0200, Markus Armbruster wrote:
> There are just two HMP commands related to QOM: qom-list and qom-set.
> Move their handlers from monitor/hmp-cmds.c to new qom/qom-hmp-cmds.c,
> where they are covered by MAINTAINERS section QOM.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/monitor/hmp.h |  2 ++
>  monitor/hmp-cmds.c    | 50 +---------------------------------
>  qom/Makefile.objs     |  2 +-
>  qom/qom-hmp-cmds.c    | 62 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 50 deletions(-)
>  create mode 100644 qom/qom-hmp-cmds.c

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


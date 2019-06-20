Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FC4C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF6E206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF6E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdslv-0001Nu-Td
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hdsj4-0006s8-Nj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hdse3-0003DD-F3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hdse3-0003Ap-9f
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 357B4316290E
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:42:05 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 693CE604CC;
 Thu, 20 Jun 2019 08:42:01 +0000 (UTC)
Date: Thu, 20 Jun 2019 09:41:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620084158.GI25448@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-8-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 08:42:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/17] MAINTAINERS: Merge sections CPU,
 NUMA into Machine core
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

On Wed, Jun 19, 2019 at 10:10:40PM +0200, Markus Armbruster wrote:
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aef0afaf7..f18fddbbbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1268,8 +1268,12 @@ S: Supported
>  F: hw/core/machine.c
>  F: hw/core/null-machine.c
>  F: hw/cpu/cluster.c
> +F: numa.c
> +F: qom/cpu.c

Not a blocker for this patch, but as a later patch, I'd encourage you to
move qom/cpu.c somewhere else. Pretty much anywhere else would be better
than under qom/ IMHO :-)

>  F: include/hw/boards.h
>  F: include/hw/cpu/cluster.h
> +F: include/qom/cpu.h

Likewise

> +F: include/sysemu/numa.h
>  T: git https://github.com/ehabkost/qemu.git machine-next
> =20
>  Xtensa Machines
> @@ -1833,11 +1837,6 @@ M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: scripts/coverity-model.c
> =20
> -CPU
> -S: Supported
> -F: qom/cpu.c
> -F: include/qom/cpu.h
> -
>  Device Tree
>  M: Alistair Francis <alistair.francis@wdc.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
> @@ -1945,13 +1944,6 @@ W: http://info.iet.unipi.it/~luigi/netmap/
>  S: Maintained
>  F: net/netmap.c
> =20
> -NUMA
> -M: Eduardo Habkost <ehabkost@redhat.com>
> -S: Maintained
> -F: numa.c
> -F: include/sysemu/numa.h
> -T: git https://github.com/ehabkost/qemu.git machine-next
> -
>  Host Memory Backends
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
> --=20
> 2.21.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


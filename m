Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE1FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0012084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0012084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHdu-0005Im-Kl
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1heHRJ-0003Q1-Gs
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1heHRG-0000el-E4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1heHRG-0000eG-7W
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86BF33082137;
 Fri, 21 Jun 2019 11:10:37 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACDE661101;
 Fri, 21 Jun 2019 11:10:35 +0000 (UTC)
Date: Fri, 21 Jun 2019 12:10:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190621111032.GJ11706@redhat.com>
References: <20190621105441.3025-1-anthony.perard@citrix.com>
 <20190621105441.3025-3-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190621105441.3025-3-anthony.perard@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 21 Jun 2019 11:10:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] xen: Import other xen/io/*.h
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 11:54:41AM +0100, Anthony PERARD wrote:
> A Xen public header have been imported into QEMU (by
> f65eadb639 "xen: import ring.h from xen"), but there are other header
> that depends on ring.h which come from the system when building QEMU.
>=20
> This patch resolves the issue of having headers from the system
> importing a different copie of ring.h.
>=20
> This patch is prompt by the build issue described in the previous
> patch: 'Revert xen/io/ring.h of "Clean up a few header guard symbols"'
>=20
> ring.h and the new imported headers are moved to
> "include/hw/xen/interface" as those describe interfaces with a guest.
>=20
> The imported headers are cleaned up a bit while importing them: some
> part of the file that QEMU doesn't use are removed (description
> of how to make hypercall in grant_table.h have been removed).
>=20
> Other cleanup:
> - xen-mapcache.c and xen-legacy-backend.c don't need grant_table.h.
> - xenfb.c doesn't need event_channel.h.

Personally I would have just kept the headers "as is" and not
changed anything. As long as the unused pieces don't actively
cause problems for the QEMU build, removing them just makes
life more complex if you periodically refresh the headers with
new copies from future Xen releases.

Not a show stopper though - your choice as maintainer, so

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>=20
> Notes:
>     v3:
>     - keep original header guard
>     - squashed of "xen: Fix build with public headers" and "xen: Import
>       other xen/io/*.h" as this patch isn't the one that fix the build =
issue
>       anymore.

>=20
>  hw/9pfs/xen-9pfs.h                       |    4 +-
>  hw/block/xen_blkif.h                     |    5 +-
>  hw/char/xen_console.c                    |    2 +-
>  hw/display/xenfb.c                       |    7 +-
>  hw/net/xen_nic.c                         |    2 +-
>  hw/usb/xen-usb.c                         |    3 +-
>  hw/xen/xen-legacy-backend.c              |    2 -
>  include/hw/xen/interface/grant_table.h   |   36 +
>  include/hw/xen/interface/io/blkif.h      |  712 +++++++++++++++
>  include/hw/xen/interface/io/console.h    |   46 +
>  include/hw/xen/interface/io/fbif.h       |  156 ++++
>  include/hw/xen/interface/io/kbdif.h      |  566 ++++++++++++
>  include/hw/xen/interface/io/netif.h      | 1010 ++++++++++++++++++++++
>  include/hw/xen/interface/io/protocols.h  |   42 +
>  include/hw/xen/{ =3D> interface}/io/ring.h |    0
>  include/hw/xen/interface/io/usbif.h      |  254 ++++++
>  include/hw/xen/interface/io/xenbus.h     |   70 ++
>  include/hw/xen/xen_common.h              |    2 +-
>  18 files changed, 2903 insertions(+), 16 deletions(-)
>  create mode 100644 include/hw/xen/interface/grant_table.h
>  create mode 100644 include/hw/xen/interface/io/blkif.h
>  create mode 100644 include/hw/xen/interface/io/console.h
>  create mode 100644 include/hw/xen/interface/io/fbif.h
>  create mode 100644 include/hw/xen/interface/io/kbdif.h
>  create mode 100644 include/hw/xen/interface/io/netif.h
>  create mode 100644 include/hw/xen/interface/io/protocols.h
>  rename include/hw/xen/{ =3D> interface}/io/ring.h (100%)
>  create mode 100644 include/hw/xen/interface/io/usbif.h
>  create mode 100644 include/hw/xen/interface/io/xenbus.h




Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EEC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDEA217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDEA217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPTo-0000AP-3G
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:32:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTPSJ-0007le-L2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTPSH-0002Nz-Kt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTPS8-0002Hg-Tn
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C07C0307EA8D;
	Wed, 22 May 2019 11:30:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAF605D705;
	Wed, 22 May 2019 11:30:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AAB0FA1E7; Wed, 22 May 2019 13:30:30 +0200 (CEST)
Date: Wed, 22 May 2019 13:30:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190522113030.qx3yvicbqgxm7l45@sirius.home.kraxel.org>
References: <20190522095821.15240-1-kraxel@redhat.com>
	<20190522095821.15240-4-kraxel@redhat.com>
	<CAJ+F1C+n0+N--o93WrzPa4mDfezahv4wxOJqVTuOfTrmqqmLrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+n0+N--o93WrzPa4mDfezahv4wxOJqVTuOfTrmqqmLrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 22 May 2019 11:30:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] egl-helpers: add dmabuf modifier
 support.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 12:47:47PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, May 22, 2019 at 12:04 PM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >
> > Add modifier parameter to egl_get_fd_for_texture(), to return the use=
d
> > modifier on dmabuf exports.
>=20
> But nothing uses it yet?

WIP still.  Sneak preview:
  https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/display-drm

> > Check and use QemuDmaBuf->modifier in egl_dmabuf_import_texture() for
> > dmabuf imports.
>=20
> That could be a separate patch, or merged with the first patch.

Ok, I'll split it.

cheers,
  Gerd



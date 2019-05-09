Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFBC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E009721479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E009721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfJ5-0004yD-So
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:25:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOfHv-0004T2-Vw
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOfHu-000870-S2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOfHu-00086R-ML
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C84BE3E00
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 09:24:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79E765D710;
	Thu,  9 May 2019 09:24:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 98A6311AA3; Thu,  9 May 2019 11:24:18 +0200 (CEST)
Date: Thu, 9 May 2019 11:24:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190509092418.65ftbkyy4qzki7jk@sirius.home.kraxel.org>
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
	<20190503130034.24916-5-marcandre.lureau@redhat.com>
	<20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
	<CAMxuvaw9kOt3yoRk4sWPeRyUmRLWboCCyrO00W0Se+W-OOrGRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaw9kOt3yoRk4sWPeRyUmRLWboCCyrO00W0Se+W-OOrGRw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 09 May 2019 09:24:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Add vhost-user-input-pci
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 10:37:20AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, May 9, 2019 at 8:32 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info =3D=
 {
> > > +    .base_name =3D TYPE_VHOST_USER_INPUT_PCI,
> > > +    .generic_name =3D "vhost-user-input-pci",
> > > +    .transitional_name =3D "vhost-user-input-pci-transitional",
> > > +    .non_transitional_name =3D "vhost-user-input-pci-non-transitio=
nal",
> >
> > virtio-input is virtio 1.0 only, so we don't need these variants.
> > Incremental fix below, if you ack that I can squash it for the pull r=
eq.
> > Or you send a v3 (in case you have other changes pending).
> >
> > cheers,
> >   Gerd
>=20
> ack, thanks

Spoke too soon, patch failed tests.
New version (with some virtio-input-host fixes on top) pushed to:

	https://git.kraxel.org/cgit/qemu/log/?h=3Dtesting/vhost-input

Can you please verify?

thanks,
  Gerd



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B996CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDE92175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDE92175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2we-0003ts-Sl
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:40:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP2vh-0003Qz-J2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP2vg-0003yy-Lb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:39:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP2vg-0003wK-Dr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90E0AC05001C;
	Fri, 10 May 2019 10:39:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47E2F1001E81;
	Fri, 10 May 2019 10:39:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0C86BA1E1; Fri, 10 May 2019 12:39:01 +0200 (CEST)
Date: Fri, 10 May 2019 12:39:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190510103900.botgnbbo2ii4jxgo@sirius.home.kraxel.org>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
	<3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
	<20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
	<3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 10 May 2019 10:39:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
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
Cc: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 12:20:56PM +0300, Marcel Apfelbaum wrote:
> Hi Gerd,
>=20
> On 5/10/19 11:59 AM, Gerd Hoffmann wrote:
> >    Hi,
> >=20
> > > Got it, thanks. Is a pity ramfb is not a PCI device :), it was wort=
h the
> > > question anyway.
> > If you look for a simple pci display device check out bochs-display.
> > It's simliar to stdvga (so ovmf and bochs-drm.ko can drive it just
> > fine), but without legacy vga emulation, only a linear framebuffer is
> > supported.  And code size is a fraction of stdvga ...
>=20
> I actually need the ramfb display in conjunction with kvmgt.
>=20
> I want to be able to save the VM state to disk, which is actually a kin=
d
> of 'live migration' as far as I understand, but live-migration can't wo=
rk
> since
> we use device assignment=A0 (vfio-pci-nohotplug device).

vfio live migration is being worked on btw.

> I was hoping to be able to hot-unplug/hot-plug the vfio device,
> but as the name suggests, can't do so since
> the ramfb display uses fw-config to pass the configuration to firmware.

Yes, fw_cfg files can't be hotplugged, that is where this restriction
comes from.

> How hard/possible is to make ramfb display a PCI device and move the
> configuration from fw-config to PCI configuration space?

Well, the whole point of using ramfb is that it is *not* a pci device,
but something you can attach to other devices as boot display.  Right
now we have that for vfio only, in theory it can likewise be done for
virtio (so you can use virtio-ramfb instead of virtio-vga for bios
display support).  Prototype exists.  Given that OVMF has a full
virtio-gpu driver there isn't much need for that though ...

Piggyback on the pci config space of the device you are attaching ramfb
to isn't going to work very well for unknown devices (i.e. vfio case).
For virtio it would have worked without too much trouble probably, using
a vendor capability to grab some register space.

For a separate pci device you can just use bochs-display.  Maybe add
some logic for the automagic display switching (i.e. if vfio has a valid
framebuffer use that and bochs-display otherwise).

cheers,
  Gerd



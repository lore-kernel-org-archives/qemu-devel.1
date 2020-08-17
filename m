Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE0820738
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE0820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cLo-0007Ou-5e
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7cKr-0006ob-Ou
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:38424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7cKp-0008MH-EP
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k7cKn-0005OX-2J
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 10:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E36F22E80EA
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 10:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2020 10:19:25 -0000
From: Gerd Hoffmann <1882851@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: diego-viola kraxel-redhat
X-Launchpad-Bug-Reporter: Diego Viola (diego-viola)
X-Launchpad-Bug-Modifier: Gerd Hoffmann (kraxel-redhat)
References: <159174217343.32241.17743917589333297614.malonedeb@gac.canonical.com>
 <20200817090342.bemmtkvz4seayp2i@sirius.home.kraxel.org>
Message-Id: <20200817101925.ljpfgz336zxegsup@sirius.home.kraxel.org>
Subject: [Bug 1882851] Re: [PATCH] drm/virtio: fix unblank
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d6d0b96812d8def2ca0ffcc25cb4d200f2f30aeb";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fd2dee17897baf5d7fd092993bd1342b70973a26
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 04:50:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1882851 <1882851@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 11:03:42AM +0200, Gerd Hoffmann wrote:
>   Hi,
> =

> > > --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> > > @@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct =
drm_crtc *crtc,
> > >  	struct virtio_gpu_output *output =3D drm_crtc_to_virtio_gpu_output(=
crtc);
> > >  =

> > >  	output->enabled =3D true;
> > > +	output->need_update =3D true;
> =

> > > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > @@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struc=
t drm_plane *plane,
> > >  	    plane->state->src_w !=3D old_state->src_w ||
> > >  	    plane->state->src_h !=3D old_state->src_h ||
> > >  	    plane->state->src_x !=3D old_state->src_x ||
> > > -	    plane->state->src_y !=3D old_state->src_y) {
> > > +	    plane->state->src_y !=3D old_state->src_y ||
> > > +	    output->need_update) {
> > =

> > Uh instead of hand-rolling what's essentially a drm_crtc_needs_modeset
> > check, why not use that one? atomic helpers try to keep the usual suspe=
cts
> > for state transitions already handy, to avoid every driver rolling their
> > own. Or do I miss something here?
> =

> Well, the virtio-gpu virtual hardware can't do plane updates and crtc
> updates independant from each other.  So the crtc callbacks handle
> disable only (we don't need a fb for that) and leave the enable to the
> plane update.
> =

> I suspect calling drm_atomic_crtc_needs_modeset() in plane update isn't
> going to fly ...

Digged a bit more, seems crtc_state->*_changed is cleared after modeset
so the following plane update wouldn't see it.  Which I think means
there is no way around tracking that in need_update.

output->enabled is probably not needed though, seems I can replace that
by either output->crtc.state->enable or ->active.  Not fully sure which
one, probably ->active.

take care,
  Gerd

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882851

Title:
  QEMU video freezes with "Guest disabled display" (virtio driver)

Status in QEMU:
  New

Bug description:
  I am using Arch Linux as my Guest and Host OS, after starting qemu
  with the following command:

    $ qemu-system-x86_64 -enable-kvm -hda arch-zoom.qcow2 -m 4G -vga
  virtio

  and waiting for a screen blank, I get this message:

    Guest disabled display

  And nothing happens after that, I can move the mouse or hit any key,
  and the message is still there.

  I can still reboot the VM but that's not optimal.

  I can reproduce this with the latest QEMU release (5.0.0) or git master, =

  I also tried this with older releases (4.0.0, 3.0.0) and the issue is sti=
ll there.

  I can't reproduce this with other video drivers (std, qxl).

  With std/qxl the screen will blank a bit and then continue as normal.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882851/+subscriptions


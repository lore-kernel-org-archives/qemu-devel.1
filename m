Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D717C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 04:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0003020825
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 04:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0003020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ6PO-0006ip-1P
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 00:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tiwei.bie@intel.com>) id 1hZ6OZ-0006At-Am
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 00:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tiwei.bie@intel.com>) id 1hZ6OY-00064l-9g
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 00:22:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:8989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tiwei.bie@intel.com>)
 id 1hZ6OV-0005Z3-Fw; Fri, 07 Jun 2019 00:22:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2019 21:22:11 -0700
X-ExtLoop1: 1
Received: from npg-dpdk-virtio-tbie-2.sh.intel.com (HELO ___) ([10.67.104.151])
 by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2019 21:22:09 -0700
Date: Fri, 7 Jun 2019 12:21:00 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190607042100.GB13920@___>
References: <20190426061815.6384-1-tiwei.bie@intel.com>
 <CAJ+F1CKjHprs15oqrB8K2COUunjeGx-y7kBvAtaxJ17n5yt+iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKjHprs15oqrB8K2COUunjeGx-y7kBvAtaxJ17n5yt+iQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix reconnection support for
 host notifier
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
Cc: cunming.liang@intel.com, qemu-stable <qemu-stable@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Thu, Jun 06, 2019 at 03:30:29PM +0200, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Apr 26, 2019 at 8:32 AM Tiwei Bie <tiwei.bie@intel.com> wrote:
> >
> > We need to destroy the host notifiers when cleaning up
> > the backend. Otherwise, some resources are not released
> > after the connection is closed, and it may prevent the
> > external backend from reopening them (e.g. VFIO files)
> > during restart.
> >
> > Fixes: 44866521bd6e ("vhost-user: support registering external host notifiers")
> > Cc: qemu-stable@nongnu.org
> >
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  hw/virtio/vhost-user.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 553319c7ac..56656629c0 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1454,10 +1454,24 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
> >  static int vhost_user_backend_cleanup(struct vhost_dev *dev)
> >  {
> >      struct vhost_user *u;
> > +    VhostUserState *user;
> > +    int i;
> >
> >      assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
> >
> >      u = dev->opaque;
> > +
> > +    if (dev->vq_index == 0) {
> > +        user = u->user;
> > +        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > +            if (user->notifier[i].addr) {
> > +                object_unparent(OBJECT(&user->notifier[i].mr));
> > +                munmap(user->notifier[i].addr, qemu_real_host_page_size);
> > +                user->notifier[i].addr = NULL;
> > +            }
> > +        }
> > +    }
> 
> Why not call vhost_user_cleanup() ? Alternatively, factor the notifier
> code in a seperate vhost_user_notifiers_cleanup() ?

I like the idea to factor the notifier code in a seperate
vhost_user_notifiers_cleanup(). I can do it. Thanks!

> 
> > +
> >      if (u->postcopy_notifier.notify) {
> >          postcopy_remove_notifier(&u->postcopy_notifier);
> >          u->postcopy_notifier.notify = NULL;
> > @@ -1881,6 +1895,8 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
> >          error_setg(errp, "Cannot initialize vhost-user state");
> >          return false;
> >      }
> > +
> > +    memset(user, 0, sizeof(*user));
> 
> This looks superflous. Is it really needed?

I think you are right. We already checked whether user->chr
is zero. The caller should make sure that the VhostUserState
will be zero initialized.

> 
> I wish there would be some basic tests for external host notifiers. Is
> it too much to ask to add it in vhost-user-test.c ?

Sounds good to me. Besides, there are already some basic
external host notifier supports in tests/vhost-user-bridge.c
that can be enabled with -H. I'm not sure whether that already
met what you want. If adding some basic tests in vhost-user-test.c
would help, I'd like to do it.

Thanks for the review!
Tiwei

> 
> 
> >      user->chr = chr;
> >      return true;
> >  }
> > --
> > 2.17.1
> >
> >
> 
> 
> -- 
> Marc-André Lureau


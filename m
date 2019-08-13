Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180BBC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11BE20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11BE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVCH-0003Tn-5u
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44743)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxVBs-00035N-GS
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxVBr-00014T-6u
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxVBq-00013y-US
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 074F84E4E6;
 Tue, 13 Aug 2019 11:42:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5D671001947;
 Tue, 13 Aug 2019 11:42:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C6DE716E32; Tue, 13 Aug 2019 13:42:03 +0200 (CEST)
Date: Tue, 13 Aug 2019 13:42:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20190813114203.z62dgyyneqcp3mru@sirius.home.kraxel.org>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
 <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
 <14dfe5ce-d74c-dccd-a62b-753b2efa924b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14dfe5ce-d74c-dccd-a62b-753b2efa924b@roeck-us.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 13 Aug 2019 11:42:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ehci: Ensure that device is not NULL
 before calling usb_ep_get
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 06, 2019 at 06:23:38AM -0700, Guenter Roeck wrote:
> On 8/2/19 7:11 AM, Gerd Hoffmann wrote:
> > On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > > > The following assert is seen once in a while while resetting the
> > > > Linux kernel.
> > > >=20
> > > > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > > > 	Assertion `dev !=3D NULL' failed.
> > > >=20
> > > > The call to usb_ep_get() originates from ehci_execute().
> > > > Analysis and debugging shows that p->queue->dev can indeed be NUL=
L
> > > > in this function. Add check for this condition and return an erro=
r
> > > > if it is seen.
> > >=20
> > > Your patch is not wrong as it corrects your case, but I wonder why =
we
> > > get there. This assert seems to have catched a bug.
> >=20
> > https://bugzilla.redhat.com//show_bug.cgi?id=3D1715801 maybe.
> >=20
> > > Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather=
 than
> > > ehci_finalize()? Then we shouldn't need this patch.
> >=20
> > The two ehci_queues_rip_all() calls in ehci_reset() should clean up e=
verything
> > properly.
> >=20
> > Can you try the patch below to see whenever a ehci_find_device failur=
e is the
> > root cause?
> >=20
> > thanks,
> >    Gerd
> >=20
> > diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> > index 62dab0592fa2..2b0a57772ed5 100644
> > --- a/hw/usb/hcd-ehci.c
> > +++ b/hw/usb/hcd-ehci.c
> > @@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState=
 *ehci, int async)
> >           q->dev =3D ehci_find_device(q->ehci,
> >                                     get_field(q->qh.epchar, QH_EPCHAR=
_DEVADDR));
> >       }
> > +    if (q->dev =3D=3D NULL) {
> > +        fprintf(stderr, "%s: device %d not found\n", __func__,
> > +                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> > +    }
> Turns out I end up seeing that message hundreds of times early on each =
boot,
> no matter which architecture. It is quite obviously a normal operating =
condition.

Yep, as long as the queue is not active this is completely harmless.
So we need to check a bit later.  In execute() looks a bit too late
though, we don't have a good backup plan then.

Does the patch below solve the problem without bad side effects?

thanks,
  Gerd

From 5980eaad23f675a2d509d0c55e288793619761bc Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Aug 2019 13:37:09 +0200
Subject: [PATCH] ehci: try fix queue->dev null ptr dereference

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 62dab0592fa2..5f089f30054b 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1834,6 +1834,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
             ehci_set_state(q->ehci, q->async, EST_EXECUTING);
             break;
         }
+    } else if (q->dev =3D=3D NULL) {
+        ehci_trace_guest_bug(q->ehci, "no device attached to queue");
+        ehci_set_state(q->ehci, q->async, EST_HORIZONTALQH);
     } else {
         p =3D ehci_alloc_packet(q);
         p->qtdaddr =3D q->qtdaddr;
--=20
2.18.1



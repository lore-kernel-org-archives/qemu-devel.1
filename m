Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0496C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B703020B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B703020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYIt-000544-20
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1htYHq-0004BQ-Pl
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1htYHp-0003D4-NJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:12:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1htYHp-0003CM-Hn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2023A30A5413;
 Fri,  2 Aug 2019 14:12:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAF3260BF4;
 Fri,  2 Aug 2019 14:11:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E41CE11AB8; Fri,  2 Aug 2019 16:11:49 +0200 (CEST)
Date: Fri, 2 Aug 2019 16:11:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 02 Aug 2019 14:12:00 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > The following assert is seen once in a while while resetting the
> > Linux kernel.
> >=20
> > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > 	Assertion `dev !=3D NULL' failed.
> >=20
> > The call to usb_ep_get() originates from ehci_execute().
> > Analysis and debugging shows that p->queue->dev can indeed be NULL
> > in this function. Add check for this condition and return an error
> > if it is seen.
>=20
> Your patch is not wrong as it corrects your case, but I wonder why we
> get there. This assert seems to have catched a bug.

https://bugzilla.redhat.com//show_bug.cgi?id=3D1715801 maybe.

> Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather tha=
n
> ehci_finalize()? Then we shouldn't need this patch.

The two ehci_queues_rip_all() calls in ehci_reset() should clean up every=
thing
properly.

Can you try the patch below to see whenever a ehci_find_device failure is=
 the
root cause?

thanks,
  Gerd

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 62dab0592fa2..2b0a57772ed5 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *eh=
ci, int async)
         q->dev =3D ehci_find_device(q->ehci,
                                   get_field(q->qh.epchar, QH_EPCHAR_DEVA=
DDR));
     }
+    if (q->dev =3D=3D NULL) {
+        fprintf(stderr, "%s: device %d not found\n", __func__,
+                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
+    }
=20
     if (async && (q->qh.epchar & QH_EPCHAR_H)) {
=20


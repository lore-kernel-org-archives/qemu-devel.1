Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C9C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B436A20640
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B436A20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MO7-0003oq-Qy
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i7MMy-0002qJ-OH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i7MMx-00072S-Lb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1i7MMr-0006xh-Me; Mon, 09 Sep 2019 12:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C77FA3766F;
 Mon,  9 Sep 2019 16:18:16 +0000 (UTC)
Received: from work-vm (ovpn-117-249.ams2.redhat.com [10.36.117.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 485ED6012D;
 Mon,  9 Sep 2019 16:18:07 +0000 (UTC)
Date: Mon, 9 Sep 2019 17:18:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190909161804.GE2726@work-vm>
References: <20190909155813.27760-1-laurent@vivier.eu>
 <20190909155813.27760-9-laurent@vivier.eu>
 <CAFEAcA9NiHrGekrEte7__aGKSz-JBObdbWdMxmxduYozngDUNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA9NiHrGekrEte7__aGKSz-JBObdbWdMxmxduYozngDUNQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 09 Sep 2019 16:18:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 8/9] hw/m68k: add a dummy SWIM floppy
 controller
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Mon, 9 Sep 2019 at 17:05, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>=20
> > +static void sysbus_swim_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D sysbus_swim_realize;
> > +}
>=20
> Missing reset and VMState for migration. These should be
> baseline requirements for adding new device models to the
> tree, because in an ideal world every device would support
> both -- we should be gradually fixing the existing devices
> which are missing these, and not letting new devices in,
> so the situation gets gradually better, not worse.

I'm happy to see things marked unmigratable instead for obscure
devices; I don't see the need to worry about migration for stuff
that's not going to be migrated.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


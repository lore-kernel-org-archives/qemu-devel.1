Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9779C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9074520673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9074520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpcJ-000491-M3
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iHpbP-0003iE-NS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iHpbN-0001gp-GC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iHpbL-0001d5-9I; Tue, 08 Oct 2019 09:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25706307D989;
 Tue,  8 Oct 2019 13:32:29 +0000 (UTC)
Received: from localhost (ovpn-116-88.gru2.redhat.com [10.97.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646E41001B08;
 Tue,  8 Oct 2019 13:32:20 +0000 (UTC)
Date: Tue, 8 Oct 2019 10:32:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 11/11] hw/misc/vmcoreinfo: Convert reset handler to
 DeviceReset
Message-ID: <20191008133219.GV4084@habkost.net>
References: <20190926151733.25349-1-philmd@redhat.com>
 <20190926151733.25349-12-philmd@redhat.com>
 <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 08 Oct 2019 13:32:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 06:02:47PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/26/19 5:17 PM, Philippe Mathieu-Daud=E9 wrote:
> > Convert the reset handler into a proper Device reset method.
>=20
> Marc-Andr=E9 noticed this one is incorrect, because while being QDEV it=
 is
> not connected to a QBUS.
>=20
> Maybe we can add a Device::unconnected property, and when set, the
> parent realize() calls 'qemu_register_reset(dev->reset, dev);'?
> This might look the same, but at least Devices implementations could
> stop to use this function...

Can we make this automatic instead of requiring another explicit
setting?

Today we have at least 3 different ways of getting a device to be
reset: qemu_register_reset(); explicit device_reset_all() call in
another reset handler; and implicit device_reset_all() call done
through parent buses/devices.  I wouldn't like to create a 4th
method.

What I really wish for, is a opt-out mechanism for reset (meaning
all devices would be guaranteed to be reset unless they
explicitly opt out), instead of 3 or 4 different opt-in
mechanisms.

--=20
Eduardo


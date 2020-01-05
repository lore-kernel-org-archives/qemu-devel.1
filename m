Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E40C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 19:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0821206F0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 19:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0821206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioBw3-0000pe-2a
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 14:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ioBvT-0000PH-Dz
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ioBvR-0003Xr-Sb
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:51:03 -0500
Received: from relay64.bu.edu ([128.197.228.104]:57807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ioBvR-0003XJ-PD
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:51:01 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 005Jo2jT007485
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 5 Jan 2020 14:50:06 -0500
Date: Sun, 5 Jan 2020 14:50:02 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 02/21] libqos: Rename i2c_send and i2c_recv
Message-ID: <20200105195002.rmo2fyppv3jqyhxh@mozz.bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-3-alxndr@bu.edu>
 <8a74a941-b646-3708-c6cc-5dcb0fb1fbca@redhat.com>
 <dcd102bf-e390-b8df-c0c7-f2459132790f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcd102bf-e390-b8df-c0c7-f2459132790f@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay64.bu.edu id
 005Jo2jT007485
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.104
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200103 1201, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/9/19 1:02 PM, Thomas Huth wrote:
> > On 29/11/2019 22.34, Oleinik, Alexander wrote:
> > > The names i2c_send and i2c_recv collide with functions defined in
> > > hw/i2c/core.c. This causes an error when linking against libqos and
> > > softmmu simultaneously (for example when using qtest inproc). Renam=
e the
> > > libqos functions to avoid this.
> > >=20
> > > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > > ---
> > >   tests/libqos/i2c.c   | 10 +++++-----
> > >   tests/libqos/i2c.h   |  4 ++--
> > >   tests/pca9552-test.c | 10 +++++-----
> > >   3 files changed, 12 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
> > > index 156114e745..38f800dbab 100644
> > > --- a/tests/libqos/i2c.c
> > > +++ b/tests/libqos/i2c.c
> > > @@ -10,12 +10,12 @@
> > >   #include "libqos/i2c.h"
> > >   #include "libqtest.h"
> > > -void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len=
)
> > > +void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t le=
n)
> > >   {
> > >       i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
> > >   }
> > > -void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> > > +void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> > >   {
> > >       i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
> > >   }
> >=20
> > I'd prefer qos_i2c_send and qos_i2c_recv instead ... but that's just =
a
> > matter of taste.
> >=20
> > Acked-by: Thomas Huth <thuth@redhat.com>
>=20
> Agreed.
>=20
> Renamed qos_*:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
Paolo originally suggested the qi2c names in the v3 patchset, since they
are consistent with the QI2CDevice struct and the qvirtio functions.
Prior to that they had worse i2c_test... names. Scanning through the
other function names in tests/libqos, it seems most qos_ functions are
related to the internals of the qos system (eg. qos_graph_init,
qos_node_create_machine ...), while q-prefixed functions are generally
hw-specific (eg. qpci_msix_enable, qfw_cfg_read_data,
qusb_pci_init_one). Of course this pattern isn't perfectly consistent
(eg. qos_init_sdhci_mm).

Unless there is something I'm missing, I'm leaning toward leaving the
functions named qi2c_recv, qi2c_send.


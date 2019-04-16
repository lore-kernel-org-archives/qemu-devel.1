Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83C2C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E5220652
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E5220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGKXF-0006kw-0K
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:37:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=002ee81e8=Paul.Durrant@citrix.com>)
	id 1hGKWH-0006Hk-EJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=002ee81e8=Paul.Durrant@citrix.com>)
	id 1hGKWF-0001tl-P6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:36:48 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:25054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=002ee81e8=Paul.Durrant@citrix.com>)
	id 1hGKW3-0001dF-UC; Tue, 16 Apr 2019 05:36:36 -0400
X-IronPort-AV: E=Sophos;i="5.60,357,1549929600"; d="scan'208";a="88886611"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Stefan Hajnoczi' <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH 2/3] xen-bus: allow AioContext
	to be specified for each event channel
Thread-Index: AQHU7h4IPncTeUxY+ESOf6AKMI/BvKY1PAwAgABHK7CAB01vgIABwmBA
Date: Tue, 16 Apr 2019 09:36:29 +0000
Message-ID: <3ce7ee587d3d443b9d1b407a3c9e37a7@AMSPEX02CL01.citrite.net>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
	<20190410125708.GE1435@perard.uk.xensource.com>
	<582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
	<20190415084249.GA29134@stefanha-x1.localdomain>
In-Reply-To: <20190415084249.GA29134@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 185.25.65.24
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] xen-bus: allow AioContext
 to be specified for each event channel
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416093629.lB_6BGEUk3zOLheKhimYvFW9GN09feigS_a-brkMBW4@z>

> -----Original Message-----
[snip]
> > > I wonder if the `'is_external' parameter of aio_set_fd_handler shoud =
be
> > > `true' here, instead. That flag seems to be used when making a snapsh=
ot
> > > of a blockdev, for example.
> > >
> > > That was introduced by:
> > > dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402=
b2f66d55b07586
> > >
> > > What do you think?
> >
> > Interesting. I admit I was merely transcribing what qemu_set_fd_handler=
() passes without really
> looking into the values. Looking at the arguments that virtio-blk passes =
to aio_set_event_notifier()
> though, and what 'is_external' means, it would appear that setting it to =
true is probably the right
> thing to do. Do you want me to send a v2 of the series or can you fix it =
up?
>=20
> Hi,
> Handlers are invoked by the aio_poll() event loop.  Some handlers are
> considered "external" in the sense that they submit new I/O requests
> from the guest or outside world.  Others are considered "internal" in
> the sense that they are part of the block layer and not an entry point
> into the block layer.
>=20
> There are points where the block layer wants to run the event loop but
> new requests must not be submitted.  In this case aio_disable_external()
> will be called so that "external" handlers are not processed.
>=20
> For example, see virtio's virtio_queue_aio_set_host_notifier_handler().
> This is the virtqueue kick ioeventfd and it shouldn't be processed when
> aio_disable_external() has been called.
>=20

Thanks for the explanation Stefan. Xen event channels/shared rings should i=
ndeed be considered as external sources.

  Cheers,

    Paul


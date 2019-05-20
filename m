Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C3C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DE0206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DE0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmUP-0000gs-HK
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:54:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hSmAS-0000sX-TO
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hSmAR-0001nD-2Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:33:44 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hSmAN-0001jH-9m; Mon, 20 May 2019 13:33:39 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id EB9F2BF42F;
	Mon, 20 May 2019 17:33:35 +0000 (UTC)
Date: Mon, 20 May 2019 19:33:31 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190520173331.GA18987@apples.localdomain>
Mail-Followup-To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
	Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20190517084234.26923-1-klaus@birkelund.eu>
	<20190517084234.26923-9-klaus@birkelund.eu>
	<f94686a4-b402-36c6-8070-185c0416b303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f94686a4-b402-36c6-8070-185c0416b303@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [PATCH 8/8] nvme: add an OpenChannel 2.0 NVMe
 device (ocssd)
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
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 11:45:00AM -0500, Eric Blake wrote:
> On 5/17/19 3:42 AM, Klaus Birkelund Jensen wrote:
> > This adds a new 'ocssd' block device that emulates an OpenChannel 2.0
> > device. The device is backed by a new 'ocssd' block backend that is
> > based on the raw format driver but includes a header that holds the
> > device geometry and write data requirements. This new block backend i=
s
> > special in that the size is not specified explicitly but in terms of
> > sector size, number of chunks, number of parallel units, etc. This
> > called for the addition of the `no_size_required` field in `struct
> > BlockDriver` to not fail image creation when the size parameter is
> > missing.
> >=20
> > The ocssd device is an individual device but shares a lot of code wit=
h
> > the nvme device. Thus, some core functionality of nvme/nvme.c has bee=
n
> > exported for use by nvme/ocssd.c.
> >=20
> > Thank you to the following people for their contributions to the
> > original qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementati=
on.
> >=20
> >   Matias Bj=F8rling <mb@lightnvm.io>
> >   Javier Gonz=E1lez <javier@javigon.com>
> >   Simon Andreas Frimann Lund <ocssd@safl.dk>
> >   Hans Holmberg <hans@owltronix.com>
> >   Jesper Devantier <contact@pseudonymous.me>
> >   Young Tack Jin <youngtack.jin@circuitblvd.com>
> >=20
> > Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> > ---
> >  MAINTAINERS                     |   14 +-
> >  Makefile.objs                   |    1 +
> >  block.c                         |    2 +-
> >  block/Makefile.objs             |    2 +-
> >  block/nvme.c                    |    2 +-
> >  block/ocssd.c                   |  690 ++++++++
> >  hw/block/Makefile.objs          |    2 +-
> >  hw/block/{ =3D> nvme}/nvme.c      |  192 ++-
> >  hw/block/nvme/ocssd.c           | 2647 +++++++++++++++++++++++++++++=
++
> >  hw/block/nvme/ocssd.h           |  140 ++
> >  hw/block/nvme/trace-events      |  136 ++
> >  hw/block/trace-events           |  109 --
> >  include/block/block_int.h       |    3 +
> >  include/block/nvme.h            |   12 +-
> >  include/block/ocssd.h           |  231 +++
> >  {hw =3D> include/hw}/block/nvme.h |   61 +
> >  include/hw/pci/pci_ids.h        |    2 +
> >  qapi/block-core.json            |   47 +-
> >  18 files changed, 4121 insertions(+), 172 deletions(-)
> >  create mode 100644 block/ocssd.c
> >  rename hw/block/{ =3D> nvme}/nvme.c (94%)
> >  create mode 100644 hw/block/nvme/ocssd.c
> >  create mode 100644 hw/block/nvme/ocssd.h
> >  create mode 100644 hw/block/nvme/trace-events
> >  create mode 100644 include/block/ocssd.h
> >  rename {hw =3D> include/hw}/block/nvme.h (63%)
>=20
> Feels big; are you sure this can't be split into smaller pieces to ease
> review?
>=20

I know, but I'm not sure how to meaningfully split it up. Would you
prefer that I move files in one commit? Changed stuff to nvme.{c,h} is
mostly removing static from functions and creating a prototype in the
header files to allow the ocssd device to use the functions. The commit
should be restricted to just adding the ocssd device. Any features and
additions required in the nvme device are added in previous commits.

> I'm focusing just on the qapi portions:
>=20

Thank you for the review of that, but it looks like this will all be
dropped from a v2 (see mail from Kevin), because it's simply bad
design to have the driver and device depend so closely on each other.


Thanks,
Klaus


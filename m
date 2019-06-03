Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFDEC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1214276D9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1214276D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXnug-0008Ay-1z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:26:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hXntC-0007Fl-OH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hXntB-0003x1-SL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hXntB-0003w0-MW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 708C43107B0F;
	Mon,  3 Jun 2019 14:24:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-131.ams2.redhat.com
	[10.36.117.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 007966090E;
	Mon,  3 Jun 2019 14:24:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3F3F116E1A; Mon,  3 Jun 2019 16:24:33 +0200 (CEST)
Date: Mon, 3 Jun 2019 16:24:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190603142433.eydpb7vhdj7o7r26@sirius.home.kraxel.org>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<6068295f-5a36-5d16-8895-95385f0b44be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6068295f-5a36-5d16-8895-95385f0b44be@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 14:24:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,=20

> One question: are we sure all guest OSes we care about can deal with
> discontiguous 32-bit PCI MMIO aperture(s)? Personally, I've got no clue=
.
> Is a "na=EFve" OS imaginable that looks only at the first suitable rang=
e
> in the _CRS?

Well, I know there is physical hardware doing the same thing,
my work station for example:

[ ... ]
c8000000-f7ffffff : PCI Bus 0000:00
  c8000000-c81fffff : PCI Bus 0000:01
  e0000000-efffffff : 0000:00:02.0
    e0000000-e02fffff : BOOTFB
[ ... ]
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : Reserved
    f8000000-fbffffff : pnp 00:06
fd000000-fe7fffff : PCI Bus 0000:00
  fd000000-fdabffff : pnp 00:07
[ ... ]

Which of course is no guarantee that no na=EFve OS exists, but I think th=
e
chances that we'll run into trouble with this are rather small.

cheers,
  Gerd



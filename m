Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083AEC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D732733D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D732733D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpzD-0002kN-3c
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:39:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXpv2-0007UL-Lc
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXpkj-000823-Vf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hXpkj-000813-Qp
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CFE731628E3;
	Mon,  3 Jun 2019 16:23:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-13.rdu2.redhat.com
	[10.10.121.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B06925D9CD;
	Mon,  3 Jun 2019 16:23:50 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<6068295f-5a36-5d16-8895-95385f0b44be@redhat.com>
	<20190603142433.eydpb7vhdj7o7r26@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <337774a9-e5df-73d8-cf2a-8a173af41157@redhat.com>
Date: Mon, 3 Jun 2019 18:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190603142433.eydpb7vhdj7o7r26@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 03 Jun 2019 16:23:59 +0000 (UTC)
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

On 06/03/19 16:24, Gerd Hoffmann wrote:
>   Hi,=20
>=20
>> One question: are we sure all guest OSes we care about can deal with
>> discontiguous 32-bit PCI MMIO aperture(s)? Personally, I've got no clu=
e.
>> Is a "na=C3=AFve" OS imaginable that looks only at the first suitable =
range
>> in the _CRS?
>=20
> Well, I know there is physical hardware doing the same thing,
> my work station for example:
>=20
> [ ... ]
> c8000000-f7ffffff : PCI Bus 0000:00
>   c8000000-c81fffff : PCI Bus 0000:01
>   e0000000-efffffff : 0000:00:02.0
>     e0000000-e02fffff : BOOTFB
> [ ... ]
> f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>   f8000000-fbffffff : Reserved
>     f8000000-fbffffff : pnp 00:06
> fd000000-fe7fffff : PCI Bus 0000:00
>   fd000000-fdabffff : pnp 00:07
> [ ... ]
>=20
> Which of course is no guarantee that no na=C3=AFve OS exists, but I thi=
nk the
> chances that we'll run into trouble with this are rather small.

OK. Thank you.
Laszlo


Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A887C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5B82196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5B82196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iImKy-00049V-Hp
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 00:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iImKD-0003UB-Nh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iImKC-0008Lk-GB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iImK6-0008Fc-LG; Fri, 11 Oct 2019 00:14:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69ABB10CC1ED;
 Fri, 11 Oct 2019 04:14:37 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B83615C1B2;
 Fri, 11 Oct 2019 04:14:27 +0000 (UTC)
Date: Fri, 11 Oct 2019 01:14:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 0/8] hw: Convert various reset() handler to DeviceReset
Message-ID: <20191011041425.GJ4084@habkost.net>
References: <20191010131527.32513-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191010131527.32513-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 04:14:37 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Li Qiang <liq3ea@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Queueing on machine-next.  Thanks!

On Thu, Oct 10, 2019 at 03:15:19PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Only patch 3/8 is missing review:
> - hw/ide/piix: Convert reset handler to DeviceReset
>=20
> Since v2:
> - Fixed PIIX_IDE conversion (Li)
> - Added more R-b tag.
>=20
> Since v1:
> - Removed the pci-host devices
> - Removed the vmcoreinfo conversion (elmarco) but add a comment.
> - Added Igor's R-b tag.
>=20
> Following the thread discussion between Peter/Markus/Damien about
> reset handlers:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
> I started to remove qemu_register_reset() calls from few qdevified
> devices (the trivial ones).
>=20
> Regards,
>=20
> Phil.
>=20
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01677.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06367.html
>=20
> Philippe Mathieu-Daud=E9 (8):
>   hw/acpi/piix4: Convert reset handler to DeviceReset
>   hw/isa/piix4: Convert reset handler to DeviceReset
>   hw/ide/piix: Convert reset handler to DeviceReset
>   hw/ide/sii3112: Convert reset handler to DeviceReset
>   hw/ide/via82c: Convert reset handler to DeviceReset
>   hw/isa/vt82c686: Convert reset handler to DeviceReset
>   hw/input/lm832x: Convert reset handler to DeviceReset
>   hw/misc/vmcoreinfo: Add comment about reset handler
>=20
>  hw/acpi/piix4.c      |  7 +++----
>  hw/ide/piix.c        |  9 ++++-----
>  hw/ide/sii3112.c     |  7 +++----
>  hw/ide/via.c         | 10 ++++------
>  hw/input/lm832x.c    | 12 +++++-------
>  hw/isa/piix4.c       |  7 +++----
>  hw/isa/vt82c686.c    | 11 ++++-------
>  hw/misc/vmcoreinfo.c |  4 ++++
>  8 files changed, 30 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.21.0
>=20

--=20
Eduardo


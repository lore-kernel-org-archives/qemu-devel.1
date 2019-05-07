Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03C720675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03C720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxmo-0000t0-2p
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:57:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNxlu-0000Zj-Ap
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNxlt-0002mB-9Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hNxlt-0002ls-4B
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:56:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D5B13091786
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 10:56:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-152.rdu2.redhat.com
	[10.10.120.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0C860BEC;
	Tue,  7 May 2019 10:56:25 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190506141923.12183-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fcf6d003-36b2-9e8c-4708-58293a610a6e@redhat.com>
Date: Tue, 7 May 2019 12:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190506141923.12183-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 10:56:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/2] roms: Add 'clean' make rule and
 EDK2 documentation fix
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/19 16:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> Two trivial patches waiting Laszlo's series to land.

... I think you can submit a pullreq with these two patches now --
because I believe that you refer to

  [Qemu-devel] [PULL 00/12] bundle edk2 platform firmware with QEMU

above, and that's been merged for a while now.

Thanks!
Laszlo

> Since v2:
> - removed duplicated space chars (Laszlo)
> - added Laszlo's R-b tag
>=20
> Since v1:
> - rebased
>=20
> v2:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00853.html
> v1:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01589.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01598.html
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   roms: Correct the EDK2_BASETOOLS_OPTFLAGS variable description
>   roms: List and describe the Makefile 'clean' rule
>=20
>  roms/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20



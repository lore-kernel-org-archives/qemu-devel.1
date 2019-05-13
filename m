Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11384C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DAB20578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DAB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ5BB-0008Fi-4M
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:15:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ54B-0002S4-R8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ4rO-0002hp-7W
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQ4rO-0002hc-2N
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CF6B3082B4F;
	Mon, 13 May 2019 06:54:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5036A97E;
	Mon, 13 May 2019 06:54:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8D539A1E0; Mon, 13 May 2019 08:54:49 +0200 (CEST)
Date: Mon, 13 May 2019 08:54:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190513065449.onhk23e7hjtpio4q@sirius.home.kraxel.org>
References: <20190510140103.3834-1-kraxel@redhat.com>
	<CAFEAcA_1wgkdY4KgTOwf8iS9ZOTVjWg8qc7GBonn9ffp6yyybg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_1wgkdY4KgTOwf8iS9ZOTVjWg8qc7GBonn9ffp6yyybg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 13 May 2019 06:54:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Input 20190510 patches
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Hi; there are some compile failures here I'm afraid:
>=20
> On ppc64:
>=20
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n"=
,
>          ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> cc1: all warnings being treated as errors
>=20
> On arm (and probably any 32-bit host):
>=20
> /home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c: In
> function 'vu_set_mem_table_exec_postcopy':
> /home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:624:23:
> error: cast to pointer from integer of different size
> [-Werror=3Dint-to-pointer-cast]
>          ret =3D madvise((void *)dev_region->mmap_addr,
>                        ^
> /home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:636:23:
> error: cast to pointer from integer of different size
> [-Werror=3Dint-to-pointer-cast]
>          ret =3D madvise((void *)dev_region->mmap_addr,
>                        ^
> /home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:669:22:
> error: cast to pointer from integer of different size
> [-Werror=3Dint-to-pointer-cast]
>          if (mprotect((void *)dev_region->mmap_addr,
>                       ^

Patch #6 dropped, v2 sent.

cheers,
  Gerd



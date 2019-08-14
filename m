Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2896FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF565206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF565206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxtKP-0002Wu-7A
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 09:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1hxtJi-000222-Mw
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1hxtJh-0006zY-Iy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>)
 id 1hxtJf-0006QO-EY; Wed, 14 Aug 2019 09:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0050309BDA0;
 Wed, 14 Aug 2019 13:27:49 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8E80806B4;
 Wed, 14 Aug 2019 13:27:43 +0000 (UTC)
Message-ID: <4876e26ccda980f45e0ad1492097a66b07fe65de.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,  "Richard
 W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, Pino Toscano
 <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 15:27:42 +0200
In-Reply-To: <20190814121527.17876-3-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-3-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 14 Aug 2019 13:27:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Avoid using libssh
 deprecated API
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-14 at 14:15 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> The libssh packaged by a distribution can predate version 0.8,
> but still provides the newer API introduced after version 0.7.
>=20
> Using the deprecated API leads to build failure, as on Ubuntu 18.04:
>=20
>     CC      block/ssh.o
>   block/ssh.c: In function 'check_host_key_hash':
>   block/ssh.c:444:5: error: 'ssh_get_publickey' is deprecated [-Werror=3D=
deprecated-declarations]
>        r =3D ssh_get_publickey(s->session, &pubkey);
>        ^
>   In file included from block/ssh.c:27:0:
>   /usr/include/libssh/libssh.h:489:31: note: declared here
>    SSH_DEPRECATED LIBSSH_API int ssh_get_publickey(ssh_session session,=
 ssh_key *key);
>                                  ^~~~~~~~~~~~~~~~~
>   rules.mak:69: recipe for target 'block/ssh.o' failed
>   make: *** [block/ssh.o] Error 1
>=20
> Fix by using the newer API if available.
>=20
> Suggested-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  block/ssh.c | 2 +-
>  configure   | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Did I really suggest this? I have no recollection of doing so, or
even getting involved with libssh support in QEMU at all for that
matter.

--=20
Andrea Bolognani / Red Hat / Virtualization



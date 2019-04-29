Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB296C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B5920656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B5920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7PI-0005qo-GY
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:37:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hL7OT-0005SH-K4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hL7OS-0003zG-Q9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hL7OS-0003yK-K8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B1368110E;
	Mon, 29 Apr 2019 14:36:22 +0000 (UTC)
Received: from ovpn-205-83.brq.redhat.com (unknown [10.40.205.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 801526CE7B;
	Mon, 29 Apr 2019 14:36:13 +0000 (UTC)
Message-ID: <bce204dbe4349dca7153d9b90904662f3038d183.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
	qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 16:36:11 +0200
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 29 Apr 2019 14:36:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
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
Cc: otubo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429143611.qVBTbvobF7b3daGxrqjy40UekGMbHo3biDsd_M2rft0@z>

On Mon, 2019-04-29 at 15:47 +0200, Marc-Andr=C3=A9 Lureau wrote:
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
>=20
> Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> use of the sandbox option group to produce a sensible error, it didn't
> do the same for another call to qemu_opts_parse_noisily():
>=20
> (gdb) bt
>     at util/qemu-option.c:829
>  #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffff=
ab5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
>      at util/qemu-option.c:829
>  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized o=
ut>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/q=
emu-option.c:890
>  #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:3589
>=20
> Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> Cc: david@gibson.dropbear.id.au
> Cc: otubo@redhat.com
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

This fixes the crash for me, so

  Tested-by: Andrea Bolognani <abologna@redhat.com>

--=20
Andrea Bolognani / Red Hat / Virtualization



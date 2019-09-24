Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7D820872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7D820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnbB-0002jo-K7
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iCnAE-0001Xf-Oh
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iCnAC-0008RR-Ra
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:55:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iCnAC-0008Pg-Lo; Tue, 24 Sep 2019 11:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1C2118CB8FE;
 Tue, 24 Sep 2019 15:55:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-118.rdu2.redhat.com
 [10.10.120.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEF98600C8;
 Tue, 24 Sep 2019 15:55:28 +0000 (UTC)
Subject: Re: [PATCH] roms: Add a 'make help' target alias
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190920171159.18633-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a0c746cb-c39b-32b4-3635-3e0c6cbd2b14@redhat.com>
Date: Tue, 24 Sep 2019 17:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190920171159.18633-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 24 Sep 2019 15:55:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/20/19 19:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Various C projects provide a 'make help' target. Our root directory
> does so. The roms/ directory lacks a such rule, but already displays
> a help output when the default target is called.
> Add a 'help' target aliased to the default one, to avoid:
>=20
>   $ make -C roms help
>   make: *** No rule to make target 'help'.  Stop.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index 6cf07d3b44..3ffd13cc7e 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -51,7 +51,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  #
>  EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> =20
> -default:
> +default help:
>  	@echo "nothing is build by default"
>  	@echo "available build targets:"
>  	@echo "  bios               -- update bios.bin (seabios)"
>=20

How about we just print: "help yourself"?

Just kidding. :P

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


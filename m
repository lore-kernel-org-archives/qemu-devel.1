Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A4C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 00:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A96206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 00:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A96206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHzor-0006fj-2v
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 20:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iHzo1-00061h-Qb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iHzo0-0007iT-Qp
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iHznx-0007gn-Ck; Tue, 08 Oct 2019 20:26:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAB9D18C892C;
 Wed,  9 Oct 2019 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8805D71C;
 Wed,  9 Oct 2019 00:26:04 +0000 (UTC)
Date: Tue, 8 Oct 2019 20:26:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 01/19] hw/arm/raspi: Use the IEC binary prefix definitions
Message-ID: <20191009002602.GA19707@localhost.localdomain>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190926173428.10713-2-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 09 Oct 2019 00:26:12 +0000 (UTC)
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
 =?iso-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 07:34:09PM +0200, Philippe Mathieu-Daud=E9 wrote:
> IEC binary prefixes ease code review: the unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 74c062d05e..615d755879 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>      mc->ignore_memory_transaction_failures =3D true;
>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
>  #endif
> --=20
> 2.20.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>


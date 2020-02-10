Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B85C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC20A20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvabC8/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC20A20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15IJ-0006nQ-Qz
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j15Hi-00066y-4J
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j15Hg-0003Wc-4k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:23:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j15Hf-0003VW-OB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581326595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gD+HNLzM7ECZRmNnNVB/w4eyEsLWPMIA0svlJ7VXYTo=;
 b=GvabC8/Q7lPDdXyGaKPiz9aI7mu+BhTo5y0oqn6b1yz2gxKAzlUXf1OD4dDR0UPdUJSaVx
 PE0d5phtZqKalBQgNzB/S13hCW034VM8JJXtsYxDkGBD1ot7jVYXcjxCnvfbs6oVj4jIoz
 hQt3LQvYt9os/0dtfxU3bzFTI+Rw5zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-QOQ3nhCcMMuRcedbnZNcww-1; Mon, 10 Feb 2020 04:23:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92406101FC74;
 Mon, 10 Feb 2020 09:23:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-219.ams2.redhat.com [10.36.116.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6252790E0;
 Mon, 10 Feb 2020 09:22:47 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] hw: Make MachineClass::is_default a boolean type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6cbffb9e-05d7-c2ac-12bd-2eb7cc7d54ae@redhat.com>
Date: Mon, 10 Feb 2020 10:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207161948.15972-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QOQ3nhCcMMuRcedbnZNcww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/2020 17.19, Philippe Mathieu-Daud=C3=A9 wrote:
> There's no good reason for it to be type int, change it to bool.
>=20
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v4:
> - fixed incorrect changes to max_cpus (Laurent)
> - describe field
> ---
[...]
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203079..9088db8fb6 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -423,7 +423,7 @@ static void pc_i440fx_5_0_machine_options(MachineClas=
s *m)
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
>      m->alias =3D "pc";
> -    m->is_default =3D 1;
> +    m->is_default =3D true;
>      pcmc->default_cpu_version =3D 1;
>  }
> =20
> @@ -434,7 +434,7 @@ static void pc_i440fx_4_2_machine_options(MachineClas=
s *m)
>  {
>      pc_i440fx_5_0_machine_options(m);
>      m->alias =3D NULL;
> -    m->is_default =3D 0;
> +    m->is_default =3D false;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> @@ -446,7 +446,7 @@ static void pc_i440fx_4_1_machine_options(MachineClas=
s *m)
>  {
>      pc_i440fx_4_2_machine_options(m);

Since we're calling pc_i440fx_4_2_machine_options() here...

>      m->alias =3D NULL;
> -    m->is_default =3D 0;
> +    m->is_default =3D false;

... you could even remove this line now...

>      compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
>  }
> @@ -459,7 +459,7 @@ static void pc_i440fx_4_0_machine_options(MachineClas=
s *m)
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_i440fx_4_1_machine_options(m);
>      m->alias =3D NULL;
> -    m->is_default =3D 0;
> +    m->is_default =3D false;

... and this one, too.

>      pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
> @@ -473,7 +473,7 @@ static void pc_i440fx_3_1_machine_options(MachineClas=
s *m)
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> =20
>      pc_i440fx_4_0_machine_options(m);
> -    m->is_default =3D 0;
> +    m->is_default =3D false;

dito.

But that could also be done in a later patch, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>



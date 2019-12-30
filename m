Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F643C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE9F20718
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAVHtoHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE9F20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilvm4-00074H-Fp
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 09:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ilvlC-0006ds-O1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ilvl8-0005N8-BT
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:11:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ilvl8-0005ML-2V
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577715060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaXVgPG4+b/mPHMGXj00UKUrXs95SLbLmSaEF0N/dMw=;
 b=MAVHtoHE8sJcuu1HCcPj41xA5wWcV0TdzSiLINuI0rgmBBWYdB+atzx8IoHnzT9ylcrkNA
 uwHfiIzSutnJiIx1nx4R7+QyUCSsHHEXDMAAZW4QAfT31gnDIA8gnReJ2oWpIJXhwd5gZq
 4czMf4yHq0LT0RJ6PN7EjfweZnQP9/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-j27jFcbzP0W3ndE1NVICrw-1; Mon, 30 Dec 2019 09:10:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3BDC8024D8;
 Mon, 30 Dec 2019 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D782360E1C;
 Mon, 30 Dec 2019 14:10:48 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] tests/acceptance: Do not set the machine type
 manually
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191229224505.24466-1-f4bug@amsat.org>
 <20191229224505.24466-7-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b67d94e6-5e27-766f-46e8-65a1416508aa@redhat.com>
Date: Mon, 30 Dec 2019 12:10:46 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191229224505.24466-7-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: j27jFcbzP0W3ndE1NVICrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/29/19 8:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since commit ba21bde93 we don't need to set the machine type
> manually, the one set by the ":avocado: tags=3Dmachine" will be used.

Correct.

>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/machine_avr6.py | 1 -
>   1 file changed, 1 deletion(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_=
avr6.py
> index 7a7d8afc29..394b3d4f8f 100644
> --- a/tests/acceptance/machine_avr6.py
> +++ b/tests/acceptance/machine_avr6.py
> @@ -45,7 +45,6 @@ class AVR6Machine(Test):
>           rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
>           rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
>  =20
> -        self.vm.set_machine('sample')
>           self.vm.add_args('-bios', rom_path)
>           self.vm.add_args('-nographic')
>           self.vm.launch()



Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ECF20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW5OeIrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ECF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihujr-0008JO-7n
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihuix-0007dc-J0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihuiu-0002qs-Ud
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:16:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihuiu-0002mD-Li
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576757767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BG6PkLmSL2pjmhhB/FbOkgZYwFjUekTzuEU4/82gflc=;
 b=bW5OeIrpMdji8JaMgBdaOTp2iR4OX4KtNG6aWzeI3lrBCMnPp6qWbTACuTlv4va+KWGJRJ
 AzQFl1aNkt0WzKtatx/Je6xqEmKoZooIr68C/0h+LLej1iThGKtu88AJVoKtxgT3OBQ5y4
 OH9qSWzdDNJSD8yp8Fy+7O5S5DNfeyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-tSMJREfxMfiGGg5W44LUMg-1; Thu, 19 Dec 2019 07:16:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DCF5107ACC5;
 Thu, 19 Dec 2019 12:16:01 +0000 (UTC)
Received: from gondolin (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 248825C54A;
 Thu, 19 Dec 2019 12:15:30 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:15:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 14/14] chardev: Use QEMUChrEvent enum in
 IOEventHandler typedef
Message-ID: <20191219131526.776cdcb0.cohuck@redhat.com>
In-Reply-To: <20191218172009.8868-15-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-15-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tSMJREfxMfiGGg5W44LUMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Paul Burton <pburton@wavecomp.com>,
 Alberto Garcia <berto@igalia.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 qemu-block@nongnu.org, Zhang Chen <chen.zhang@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Reitz <mreitz@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 18:20:09 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The Chardev events are listed in the QEMUChrEvent enum.
>=20
> By using the enum in the IOEventHandler typedef we:
>=20
> - make the IOEventHandler type more explicit (this handler
>   process out-of-band information, while the IOReadHandler
>   is in-band),
> - help static code analyzers.
>=20
> This patch was produced with the following spatch script:
>=20
>   @match@
>   expression backend, opaque, context, set_open;
>   identifier fd_can_read, fd_read, fd_event, be_change;
>   @@
>   qemu_chr_fe_set_handlers(backend, fd_can_read, fd_read, fd_event,
>                            be_change, opaque, context, set_open);
>=20
>   @depends on match@
>   identifier opaque, event;
>   identifier match.fd_event;
>   @@
>    static
>   -void fd_event(void *opaque, int event)
>   +void fd_event(void *opaque, QEMUChrEvent event)
>    {
>    ...
>    }
>=20
> Then the following files were manually modified:
>=20
>   - include/chardev/char-fe.h
>   - include/chardev/char.h
>   - include/chardev/char-mux.h
>   - chardev/char.c
>   - chardev/char-mux.c
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

(...)

> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 2aab04fd4b..f7aba12565 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -142,7 +142,7 @@ static void terminal_read(void *opaque, const uint8_t=
 *buf, int size)
>      }
>  }
> =20
> -static void chr_event(void *opaque, int event)
> +static void chr_event(void *opaque, QEMUChrEvent event)
>  {
>      Terminal3270 *t =3D opaque;
>      CcwDevice *ccw_dev =3D CCW_DEVICE(t);

Acked-by: Cornelia Huck <cohuck@redhat.com>



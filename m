Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D913C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1387720716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD5wkyY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1387720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihufe-0006Py-W0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihuf0-00060G-FL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihuez-0008CH-2V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:12:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihuey-00084p-VN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576757523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QADSq3MBoBdsl4x2X362vKoUjinjn2m19LWrD7wbEHk=;
 b=RD5wkyY+B8ZoE+gJ4s6OqDdnvveizh0xsAF37qeAW4HPr5rSOiLLug9u5Wor/riq+VY7aY
 jNoVXsWkqhdNpZUD+mSL/gTLo3+7iBaQbTn8V+rqMpCcQEpCo5rzwOkr6JtT7zPDWaRceU
 BqALiOHGZ7RnM4pMjnU66zqPRpgSeQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-1iCuqHgaP425ZZIP_fAa-g-1; Thu, 19 Dec 2019 07:12:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A382C107ACE4;
 Thu, 19 Dec 2019 12:12:00 +0000 (UTC)
Received: from gondolin (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 723475C54A;
 Thu, 19 Dec 2019 12:11:52 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:11:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 03/14] hw/char/terminal3270: Explicit ignored
 QEMUChrEvent in IOEventHandler
Message-ID: <20191219131149.5973d2ba.cohuck@redhat.com>
In-Reply-To: <20191218172009.8868-4-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-4-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1iCuqHgaP425ZZIP_fAa-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 18:19:58 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
>=20
>     CC      s390x-softmmu/hw/char/terminal3270.o
>   hw/char/terminal3270.c: In function =E2=80=98chr_event=E2=80=99:
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     156 |     switch (event) {
>         |     ^~~~~~
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add all missing enums
>=20
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-s390x@nongnu.org
> ---
>  hw/char/terminal3270.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 6859c1bcb2..2aab04fd4b 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -166,6 +166,11 @@ static void chr_event(void *opaque, int event)
>          sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
>          css_conditional_io_interrupt(sch);
>          break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
>  }
> =20

It indeed seems sane to ignore all of these.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>



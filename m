Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE0C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BD12075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BD12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG51P-00048T-QM
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 13:03:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG50X-0003pQ-1f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG50W-0003x3-2h
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hG50V-0003v4-Qb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4630430832F4;
	Mon, 15 Apr 2019 17:02:57 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
	[10.18.17.132])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EBEC85D9C9;
	Mon, 15 Apr 2019 17:02:52 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<20190415154503.6758-2-berrange@redhat.com>
Date: Mon, 15 Apr 2019 13:02:52 -0400
In-Reply-To: <20190415154503.6758-2-berrange@redhat.com> ("Daniel
	P. \=\?utf-8\?Q\?Berrang\=C3\=A9\=22's\?\= message of "Mon,
	15 Apr 2019 16:45:01 +0100")
Message-ID: <jpgbm17p5fn.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 15 Apr 2019 17:02:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] usb-mtp: fix string length for
 filename when writing metadata
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415170252.wwMks0TgRMAvc80CgozVRtZDo_-6tQPkKBLjX3m6y3M@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ObjectInfo 'length' field provides the length of the
> wide character string filename. This is then converted to
> a multi-byte character string. This may have a different
> byte count to the wide character string. We should use the
> C string length of the multi-byte string instead.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index ebf210fbf8..838cd74da6 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1714,7 +1714,7 @@ static void usb_mtp_write_metadata(MTPState *s, uin=
t64_t dlen)
>          return;
>      }
>=20=20
> -    o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
> +    o =3D usb_mtp_object_lookup_name(p, filename, -1);

Nit: Might as well just remove the "-1" argument and unconditionally use
strlen in usb_mtp_object_lookup_name

Bandan

>      if (o !=3D NULL) {
>          next_handle =3D o->handle;
>      }


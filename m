Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB9C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D6320665
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQbOFJn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D6320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGekh-0004YP-CR
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGekA-00048t-JZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:49:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGek9-0003Mu-2x
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599814156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jS8XQLp7h9JQXVvB3S63foCbiUhcGGDVLw77BV+QCxw=;
 b=GQbOFJn4+qcItxWyUfywXJWr0gS534D2nvZiAeq+xQPLM5uK65DfdjLFc5uPnn0PHdhrqo
 Hkt4pnZ9PvZECMEEaY6lgQJQIxtun68T+oJnoA74+EqICG0EcYgtLjjOgexJypodb0KMv1
 jBzt4s1XXu0KKy6BliFnbJxdkb7mJpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-8qcfpvAhMue3TopjdnVs5Q-1; Fri, 11 Sep 2020 04:49:14 -0400
X-MC-Unique: 8qcfpvAhMue3TopjdnVs5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE36A10BBEDE;
 Fri, 11 Sep 2020 08:49:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D2D75127;
 Fri, 11 Sep 2020 08:49:08 +0000 (UTC)
Date: Fri, 11 Sep 2020 10:49:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PULL 02/10] usb-host: restrict workaround to new libusb versions
Message-ID: <20200911104907.604673ce@redhat.com>
In-Reply-To: <20200910131504.11341-3-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
 <20200910131504.11341-3-alex.bennee@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 14:14:56 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Fixes build failures with old kernels (USBDEVFS_GET_SPEED missing),
> on the assumtion that distros with old kernels also have old libusb.
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200902081445.3291-1-kraxel@redhat.com>
> Message-Id: <20200909112742.25730-3-alex.bennee@linaro.org>

Can we get this merged to fix travis-ci builds, please.

>=20
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 08604f787fd..c5d38cb09c0 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_dev=
ice *dev, int hostfd)
>      usb_host_ep_update(s);
> =20
>      libusb_speed =3D libusb_get_device_speed(dev);
> -#ifdef CONFIG_LINUX
> +#if LIBUSB_API_VERSION >=3D 0x01000107 && defined(CONFIG_LINUX)
>      if (hostfd && libusb_speed =3D=3D 0) {
>          /*
>           * Workaround libusb bug: libusb_get_device_speed() does not



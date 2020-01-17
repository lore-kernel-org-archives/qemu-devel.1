Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE3C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ED12072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fysnet.net header.i=@fysnet.net header.b="kGmZHtnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED12072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fysnet.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isYMT-0002xS-6L
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 15:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <SRS0=Bsuh7h=3G=fysnet.net=fys@eigbox.net>)
 id 1isYLe-0002Xa-NC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 15:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <SRS0=Bsuh7h=3G=fysnet.net=fys@eigbox.net>)
 id 1isYLb-000321-6z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 15:36:06 -0500
Received: from bosmailout02.eigbox.net ([66.96.187.2]:46695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <SRS0=Bsuh7h=3G=fysnet.net=fys@eigbox.net>)
 id 1isYLa-00030z-Te
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 15:36:03 -0500
Received: from bosmailscan05.eigbox.net ([10.20.15.5])
 by bosmailout02.eigbox.net with esmtp (Exim) id 1isXsT-0007aS-Sb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 15:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fysnet.net; 
 s=dkim;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Subject:In-Reply-To:References:To:From:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/vXGc+tsEitNlI/oCYzV27PfekICVxRuex8waw1STz8=; b=kGmZHtntm5mVsYTtguQGaSPrq7
 rkT3PbJg+x0K7T7dSWpqIPkJdE6ukdbjFQwkBQwm3FthvT+IR+oNey9NKZTdonEmbMsTblAWygSlY
 uu8crBHEolUjpFF6cZmzJantub8ENqBPqCzE0cHqxt297UguY5/QWRhKKX2tYArHemahvPJYhZZko
 igMwDr5ZjSR4LeAM/U27b3OuSvKF1CFti4ep5AwY7GfH5yAEgEIDWRmuDkG1LnsrA7r0vKlNpHQNC
 aIiQkpcJh70JzITuqaitYGugf2EDTt2u/mnFxtNmzSL2DNn2vyg7re/Vctvud7txNcdlCJzVXlcf2
 vSBYchqQ==;
Received: from [10.115.3.32] (helo=bosimpout12)
 by bosmailscan05.eigbox.net with esmtp (Exim) id 1isXsT-00075l-Q8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 15:05:57 -0500
Received: from bosauthsmtp13.yourhostingaccount.com ([10.20.18.13])
 by bosimpout12 with 
 id rY5u2100D0GvDVm01Y5xNb; Fri, 17 Jan 2020 15:05:57 -0500
X-Authority-Analysis: v=2.2 cv=KNQqNBNo c=1 sm=1 tr=0
 a=UH8/iCWBfdUmbm4Ft4Vi3Q==:117 a=wQpGw2XyfUITcO7/aAUuvg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10
 a=SM4o0Mu9yyYA:10 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=03UIiu-VAAAA:8
 a=dcsqdaBT8OkvHXK3sqQA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=TDsaGBozw4ymKzHYph0x:22
Received: from 72-24-195-225.cpe.sparklight.net ([72.24.195.225]:58795
 helo=DESKTOPJA91MNU) by bosauthsmtp13.eigbox.net with esmtpa (Exim)
 id 1isXsQ-0004Y9-99; Fri, 17 Jan 2020 15:05:54 -0500
From: <fys@fysnet.net>
To: "'Gerd Hoffmann'" <kraxel@redhat.com>,
	<qemu-devel@nongnu.org>
References: <20200117073716.31335-1-kraxel@redhat.com>
In-Reply-To: <20200117073716.31335-1-kraxel@redhat.com>
Subject: RE: [PATCH v2] uas: fix super speed bMaxPacketSize0
Date: Fri, 17 Jan 2020 13:05:52 -0700
Message-ID: <000001d5cd71$86eec090$94cc41b0$@fysnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF9zN17bNeCucrr7FHGOpobEVUJCaifSRaA
Content-Language: en-us
X-EN-UserInfo: 1f5b907dc19810306d73f25093731c51:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: fys@fysnet.net
X-EN-OrigIP: 72.24.195.225
X-EN-OrigHost: 72-24-195-225.cpe.sparklight.net
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 66.96.187.2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am okay with this patch.  Thank you.

Ben

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Friday, January 17, 2020 12:37 AM
> To: qemu-devel@nongnu.org
> Cc: fys@fysnet.net; Gerd Hoffmann <kraxel@redhat.com>
> Subject: [PATCH v2] uas: fix super speed bMaxPacketSize0
>=20
> For usb2 bMaxPacketSize0 is "n", for usb3 it is "1 << n", so it must =
be 9 not 64
> ...
>=20
> rom "Universal Serial Bus 3.1 Specification":
>=20
>    If the device is operating at Gen X speed, the bMaxPacketSize0
>    field shall be set to 09H indicating a 512-byte maximum packet.
>    An Enhanced SuperSpeed device shall not support any other maximum
>    packet sizes for the default control pipe (endpoint 0) control
>    endpoint.
>=20
> We now announce a 512-byte maximum packet.
>=20
> Fixes: 89a453d4a5c ("uas-uas: usb3 streams")
> Reported-by: Benjamin David Lunt <fys@fysnet.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/dev-uas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c index
> 6d6d1073b907..1bc4dd4fafb8 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -303,7 +303,7 @@ static const USBDescDevice desc_device_high =3D {
>=20
>  static const USBDescDevice desc_device_super =3D {
>      .bcdUSB                        =3D 0x0300,
> -    .bMaxPacketSize0               =3D 64,
> +    .bMaxPacketSize0               =3D 9,
>      .bNumConfigurations            =3D 1,
>      .confs =3D (USBDescConfig[]) {
>          {
> --
> 2.18.1



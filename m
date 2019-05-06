Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9EC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3D82053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNf1y-0005PL-Q5
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:55:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNf0z-0004Pg-Kn
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNf0y-0002nB-DI
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hNf0v-0002lM-P5; Mon, 06 May 2019 10:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11FC7C01EE87;
	Mon,  6 May 2019 14:54:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-124-221.rdu2.redhat.com
	[10.10.124.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9C014AB;
	Mon,  6 May 2019 14:54:32 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ebc00991-8a3c-8aa0-f761-06c57692cff1@redhat.com>
Date: Mon, 6 May 2019 16:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505200602.12412-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 06 May 2019 14:54:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/19 22:06, Philippe Mathieu-Daud=C3=A9 wrote:
> The pflash device is a child of TYPE_DEVICE, so it can implement
> the DeviceReset handler. Actually it has to implement it, else
> on machine reset it might stay in an incoherent state, as it has
> been reported in the buglink listed below.
>=20
> Add the DeviceReset handler and remove its call from the realize()
> function.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 073cd14978f..639b05bc4d5 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -762,7 +762,6 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
> =20
> -    pflash_reset(pfl);
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
> @@ -850,6 +849,11 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>      pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
>  }
> =20
> +static void pflash_cfi01_reset(DeviceState *dev)
> +{
> +    pflash_reset(PFLASH_CFI01(dev));
> +}
> +
>  static Property pflash_cfi01_properties[] =3D {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>      /* num-blocks is the number of blocks actually visible to the gues=
t,
> @@ -894,6 +898,7 @@ static void pflash_cfi01_class_init(ObjectClass *kl=
ass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->reset =3D pflash_cfi01_reset;
>      dc->realize =3D pflash_cfi01_realize;
>      dc->props =3D pflash_cfi01_properties;
>      dc->vmsd =3D &vmstate_pflash;
>=20

(Hopefully I'm not missing anything obvious, while writing the below:)

Sometimes the object model is really nice.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


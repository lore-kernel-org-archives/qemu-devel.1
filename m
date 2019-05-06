Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64834C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377162053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377162053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfOe-0006Ks-HA
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:19:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNfNb-0005ug-9J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNfNZ-0001Cx-CU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hNfNP-00010r-IG; Mon, 06 May 2019 11:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E870030833BF;
	Mon,  6 May 2019 15:17:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-124-221.rdu2.redhat.com
	[10.10.124.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC789100194A;
	Mon,  6 May 2019 15:17:36 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <25a7725c-3ac4-43cb-cd0a-cfc4007b244c@redhat.com>
Date: Mon, 6 May 2019 17:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505200602.12412-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 06 May 2019 15:17:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/5] hw/block/pflash_cfi02: Add the
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

- IMO, the above two tags should be dropped from the commit message, as
they are specific to CFI01.

- Additionally, the commit message references the realize() function
(correctly), but the patch doesn't change that function. That is, the
patch doesn't remove the pflash_reset() call from pflash_cfi02_realize()
that was introduced in the last patch.

Thanks
Laszlo

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f321b74433c..5af367d1563 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -674,6 +674,11 @@ static void pflash_cfi02_realize(DeviceState *dev,=
 Error **errp)
>      pfl->cfi_table[0x3c] =3D 0x00;
>  }
> =20
> +static void pflash_cfi02_reset(DeviceState *dev)
> +{
> +    pflash_reset(PFLASH_CFI02(dev));
> +}
> +
>  static Property pflash_cfi02_properties[] =3D {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
>      DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
> @@ -701,6 +706,7 @@ static void pflash_cfi02_class_init(ObjectClass *kl=
ass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->reset =3D pflash_cfi02_reset;
>      dc->realize =3D pflash_cfi02_realize;
>      dc->unrealize =3D pflash_cfi02_unrealize;
>      dc->props =3D pflash_cfi02_properties;
>=20



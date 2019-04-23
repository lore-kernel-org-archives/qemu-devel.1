Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51EBC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DE321773
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DE321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58389 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0pd-0001bf-I6
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:11:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0ne-0000FQ-8L
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0l5-0004CQ-L1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hJ0l5-0004B0-Dp; Tue, 23 Apr 2019 15:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CDC630ADBDC;
	Tue, 23 Apr 2019 19:07:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E41060143;
	Tue, 23 Apr 2019 19:07:00 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-8-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <499877a9-e657-d071-c7b7-5db5e8e82017@redhat.com>
Date: Tue, 23 Apr 2019 21:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-8-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 23 Apr 2019 19:07:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/7] hw/sparc64: Implement
 fw_cfg_arch_key_name()
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423190658.wIFuEPFjuvGg1IeXENSQpPTEBMQbKk2J-Gii20wCBKw@z>

On 04/22/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> sparc64-specific key.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sparc64/sun4u.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 399f2d73c81..4230b17b873 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -91,6 +91,25 @@ typedef struct EbusState {
>  #define TYPE_EBUS "ebus"
>  #define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
> =20
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] =3D {
> +        {FW_CFG_SPARC64_WIDTH, "width"},
> +        {FW_CFG_SPARC64_HEIGHT, "height"},
> +        {FW_CFG_SPARC64_DEPTH, "depth"},
> +    };
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i=
++) {
> +        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                              Error **errp)
>  {
>=20

Same questions. From my POV:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


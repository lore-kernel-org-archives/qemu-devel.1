Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5388C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5AF22B4B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+4mida5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5AF22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJJf-0004SQ-N2
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJIq-0003FM-Fl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:55:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJIo-0008He-S8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D9/R73BWfZi/CtyR7Oh57gnhCqX3f5GCX1vEIwtpzCU=;
 b=Y+4mida59/cdkaikpAQlj0hXv6dLRxTthYkvhHZb7/kPHIepRC4Rl/rPeYpUsQ6eaF+6tC
 T92qRKMJAlA0s3ymEfsniOr2MIECEzU7BcLcy4ZbVGjZUluXxTmaQtwY1/FXKPJ979uHb4
 ET77FdRTHABdO3gkpPeHnZJVsbI9YIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-dU9JR7UBPR6qlyZk_btHbQ-1; Thu, 27 Aug 2020 10:54:53 -0400
X-MC-Unique: dU9JR7UBPR6qlyZk_btHbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 369928010C7;
 Thu, 27 Aug 2020 14:54:52 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4B2519936;
 Thu, 27 Aug 2020 14:54:45 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:54:45 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 16/20] microvm: wire up hotplug
Message-ID: <20200827145445.w7asyudbbpeoqugv@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-17-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-17-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mu2vaf7vpmh5oc4y"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mu2vaf7vpmh5oc4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:50PM +0200, Gerd Hoffmann wrote:
> The cpu hotplug code handles the initialization of coldplugged cpus
> too, so it is needed even in case cpu hotplug is not supported.
>=20
> Wire cpu hotplug up for microvm.
> Without this we get a broken MADT table.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/microvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 9df15354ce0f..8de8ca864963 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -320,6 +320,39 @@ static void microvm_fix_kernel_cmdline(MachineState =
*machine)
>      g_free(cmdline);
>  }
> =20
> +static void microvm_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                       DeviceState *dev, Error **errp)
> +{
> +    x86_cpu_pre_plug(hotplug_dev, dev, errp);
> +}
> +
> +static void microvm_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
> +{
> +    x86_cpu_plug(hotplug_dev, dev, errp);
> +}
> +
> +static void microvm_device_unplug_request_cb(HotplugHandler *hotplug_dev=
,
> +                                             DeviceState *dev, Error **e=
rrp)
> +{
> +    error_setg(errp, "unplug not supported by microvm");
> +}
> +
> +static void microvm_device_unplug_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    error_setg(errp, "unplug not supported by microvm");
> +}
> +
> +static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine=
,
> +                                                   DeviceState *dev)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        return HOTPLUG_HANDLER(machine);
> +    }
> +    return NULL;
> +}
> +
>  static void microvm_machine_state_init(MachineState *machine)
>  {
>      MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
> @@ -503,6 +536,7 @@ static void microvm_machine_initfn(Object *obj)
>  static void microvm_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> =20
>      mc->init =3D microvm_machine_state_init;
> =20
> @@ -524,6 +558,13 @@ static void microvm_class_init(ObjectClass *oc, void=
 *data)
>      /* Machine class handlers */
>      mc->reset =3D microvm_machine_reset;
> =20
> +    /* hotplug (for cpu coldplug) */
> +    mc->get_hotplug_handler =3D microvm_get_hotplug_handler;
> +    hc->pre_plug =3D microvm_device_pre_plug_cb;
> +    hc->plug =3D microvm_device_plug_cb;
> +    hc->unplug_request =3D microvm_device_unplug_request_cb;
> +    hc->unplug =3D microvm_device_unplug_cb;
> +
>      object_class_property_add(oc, MICROVM_MACHINE_PIC, "OnOffAuto",
>                                microvm_machine_get_pic,
>                                microvm_machine_set_pic,
> @@ -573,6 +614,7 @@ static const TypeInfo microvm_machine_info =3D {
>      .class_size    =3D sizeof(MicrovmMachineClass),
>      .class_init    =3D microvm_class_init,
>      .interfaces =3D (InterfaceInfo[]) {
> +         { TYPE_HOTPLUG_HANDLER },
>           { }
>      },
>  };
> --=20
> 2.27.0
>=20

--mu2vaf7vpmh5oc4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HyTQACgkQ9GknjS8M
AjVVXBAApARyub6ewNJhebabpb9BF2MJjdiqmXg/b0VJE+34821IyA1qfqcxuh04
H1BeD0+0z0IYOMgC8FImffQHqNdvMuJJh695gK+GcnPzUndWMZq9gI1jhuNUiP7n
lKRHpUZja5U7DyQuQU0C7OnXlYSne4FdF7yLlGYSlrT7t8SwmJRyMiqZTRlMojRA
QIjwjS2LRR14mDHfHl5DTQUg2Vb8+T/wziCocWyFb+qQAqvepbr2+Q6ycFrqXYsL
3N16mnhejAn/0/eMClYqwuSx3MPWN0x4JVHyxLokY5P1KGIguCbfsTlbF2xYq8Fr
ryixOJSSHhsyESfRYwN5OIbealOlcieOEMiq4sB4ntUWqvP4vnEtEcRvZmj+u5X4
uoD64LqIl3+ahBp62Zv3fq8nhdu5ajAPb3JzoTlFiH9CRZH9qD7V+WEzJHNKOIBM
js2I4xR/UBDYnUbAop4yMOay/sbhM+BB+BCFp8A2IIW76LDdGpeI7AqAis8zoNO8
Yr9kn50wEyb6P1hc4PDg5x/1xZ2nUiTd6thXSsZkrGT7BE1JzjUYUIza4w3fW8HK
fPsrAXgKyVaz6eL9VoQU4q/pMFBs+z3+cUgXzlgfclVHEv1NqpaBr8RzQa/LnZGs
NeFaAW6OZPCuHV0khq2Jf9QUbcdIPRpMI3Z6VHuAUymOw5BOLXM=
=FhXu
-----END PGP SIGNATURE-----

--mu2vaf7vpmh5oc4y--



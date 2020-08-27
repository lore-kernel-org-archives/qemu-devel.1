Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E665C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFDD20738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0HA9GVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFDD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDFx-0000cb-5K
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBDFF-00085k-ME
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:26:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBDFE-0004j0-7j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598516811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xeh2/hVP2VgcI3vgKBeANnUuhh1sdg2a9myA7Aq1mpw=;
 b=J0HA9GVkR4wp6/NSzMk2RXhFmtBUehyTbjPS3RXzz3VYRerylAkuY3c/nFaLI4f55qHPjg
 4TWp4n6pLErNwoD+ypVjdEG3nFnuvnEILgRMoyFUUmOrdbz1LNQyIMwlguwk5B9uhGcbCi
 1xnStz3AAXpaeWyl7Q2fSY1r89LIqvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-7T8LL7X0PB2_ewSju-sYwA-1; Thu, 27 Aug 2020 04:26:47 -0400
X-MC-Unique: 7T8LL7X0PB2_ewSju-sYwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF1B2800050;
 Thu, 27 Aug 2020 08:26:45 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794D67A40C;
 Thu, 27 Aug 2020 08:26:39 +0000 (UTC)
Date: Thu, 27 Aug 2020 10:26:38 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 12/20] microvm/acpi: disable virtio-mmio cmdline hack
Message-ID: <20200827082638.jl2ygnk3devjulsi@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-13-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-13-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4okk6qkbwxpuwlg4"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
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

--4okk6qkbwxpuwlg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:46PM +0200, Gerd Hoffmann wrote:
> ... in case we are using ACPI.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/microvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 54510a03f754..04209eb38fbe 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -343,7 +343,8 @@ static void microvm_machine_reset(MachineState *machi=
ne)
>      CPUState *cs;
>      X86CPU *cpu;
> =20
> -    if (machine->kernel_filename !=3D NULL &&
> +    if (!x86_machine_is_acpi_enabled(X86_MACHINE(machine)) &&
> +        machine->kernel_filename !=3D NULL &&
>          mms->auto_kernel_cmdline && !mms->kernel_cmdline_fixed) {
>          microvm_fix_kernel_cmdline(machine);
>          mms->kernel_cmdline_fixed =3D true;
> --=20
> 2.27.0
>=20

--4okk6qkbwxpuwlg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9Hbj0ACgkQ9GknjS8M
AjWU2xAAuAzE6H8prRzONn4rfTmfyoLsrOTZkSZYD5knA7LC9xirg7k8z+Tit4wO
YWwtww+BrkAgKBYfwp1rMb1fXa6ge3uVesK/MMCzQ+UjNc1P0vNgWbJgqXthr1Tx
0mbDHfpg2nxaPFS3Y677tcTPS9/8BTwUjSfyiCDJ4bibUcXdypXRnslthfCPv7G+
9OPZpDHMRqwz1p7WleTlvfovZZ/EdS5XnX78ZJhDHX/BBPxEcM+2oH6a4HOkBuAs
7n+4c6f6929a3DdFOiJKndw2/pNdHRht4L9fYnSAk4Z38XVUAR9fj/FlgHNgYBsJ
f6a3Ge6pezlyLFm/p9gx250uRp53j5JfniE7QcNjvE0JvJdJY0BC3Dmkgkw44QVd
UC+DkxxpUT+yA+U4QFmmXx+v9towVxj6pAgFvk6OIYpAgZj8+uFPBY6foj65z8rg
+4p/PxWxZ6BsCgZaJfZDfVYQiL37/+Dog0QBt02MLJdfaRSwXU3vG03ShRAK5UsT
klPnpyhdMgIH7frJ2nfm4pJquM5GdZEkXQWPxTqHxLac9jGyiFi9fd+M+h2vT86z
TuI/TgoMlsOT2XUO5qFeOX0D4vaHSOy/R/QBpKWsEIDuGQG0tv+HXo2EvU37oR8+
5Hxfz6GM3gZUF/1B1pcSQhVduVMq0wVFZaBxjeQ0kkPL4/NO8tc=
=rrC8
-----END PGP SIGNATURE-----

--4okk6qkbwxpuwlg4--



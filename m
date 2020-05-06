Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FAC206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbWWQJ4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FAC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWEUx-0001wK-0q
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWEUC-00014H-Vi
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:28:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41496
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWEUC-00018U-9I
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588750135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7zUsKhHn004BEZcfmUJBENy677WQJkQ3AC/+lB5dlQ=;
 b=VbWWQJ4sJN24W8ZXmTdllfmMbZ/WMA9ArEioJ6WW70c97ddyJl8eOnZwG+ED93TwAybPz+
 Rz6keBGp5JWiTEHhbnFJz5dKcITrPsPHIA5xwEDJPjDs7dR9RjZkE74NMVvvxwScoX8aHW
 6xaKltX1Zx0+5p38QS/3cBm9kNIngkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-QJDLgnQwN4mGCQU4WWj2zQ-1; Wed, 06 May 2020 03:28:53 -0400
X-MC-Unique: QJDLgnQwN4mGCQU4WWj2zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E30F107ACCD;
 Wed,  6 May 2020 07:28:52 +0000 (UTC)
Received: from localhost (ovpn-113-195.rdu2.redhat.com [10.10.113.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67B495C1BD;
 Wed,  6 May 2020 07:28:46 +0000 (UTC)
Date: Wed, 6 May 2020 09:28:45 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 13/13] microvm/acpi: use GSI 16-23 for virtio
Message-ID: <20200506072845.ch4tf5x2iecds5lp@dritchie>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-14-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-14-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gjnioq4jjhsitiyt"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gjnioq4jjhsitiyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 03:43:05PM +0200, Gerd Hoffmann wrote:
> With ACPI enabled and IO-APIC being properly declared in the ACPI tables
> we can use interrupt lines 16-23 for virtio and avoid shared interrupts.
>=20
> With acpi disabled we continue to use lines 8-15.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/microvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 2aa2804e4ca0..08ed2a17f2ca 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -124,7 +124,7 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
> =20
>      kvmclock_create();
> =20
> -    mms->virtio_irq_base =3D 8;
> +    mms->virtio_irq_base =3D x86_machine_is_acpi_enabled(x86ms) ? 16 : 8=
;
>      for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
>                               VIRTIO_MMIO_BASE + i * 512,
> --=20
> 2.18.4
>=20

--gjnioq4jjhsitiyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl6yZywACgkQ9GknjS8M
AjW4RA//UMrGYX9f7u9Kgs435Pp7b1p/MEqrk3WXhTB6RocG3DETswePcjtUyaCj
ebyjzsbfThmZsyIqECPzbIchE9hBBsxVcUIFIhw9UJKqGFLsiG3DMCbFNGTv+VS/
sQhM6BfY4tseyJzwoRuO2TGfd6dM0vLh2BeWKTauIUu28qhcpRanndYKs53jA6H+
FGs3TrvZ9mw+A9ngbbFbvu0Ek6AAAXWTzJqtpQ5g+6j3dq6FYNTUvmvnbt6Ev8z0
/gCyQDxsKsgptVRgnJAGEjEcUlS/W9rq8G514wyh/q/vqt+ZKReWd42GvU16UUdo
L3hbj8uL6AgFLPUBK/+M1AjbYKzms1oCWoQeyuqrOSvIKCm5Tvzr5uQkQamw+9EP
ZUKaiWxt6kdA1ZN+L3IHXFuYa1L3YMSLWiHbKA6TMCuGf7BQVLECiVSrkowYMLbn
fGsSW0PRt4Frne19IlK9MDAiEJgEQVQM3Jafqd5/9uLUxpQ810dBtp/O6VkLEUKq
2StKRYSoLakBU6PIT/zHXzj1ZIgi7Exft4t4/4by8ezNpoZDNBgaY2NOGi6RrhaR
MEYVBhjPwKCh9+49jIFn7AdxbJhTZELpB42cRk7t3hC1VdtdAqikt9Qw84ZllT7C
1Ebg77mLY8ovd1/NEHMhcXev8owO9HnRqVVDXWlK5GbCpEAuc7I=
=/kDr
-----END PGP SIGNATURE-----

--gjnioq4jjhsitiyt--



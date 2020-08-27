Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E16C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C592054F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT2au4S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C592054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJLS-0006lY-VR
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJJr-00053Z-C8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJJp-00008I-Oy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RnrfKeRZ8e9U01Le3p/kSMvC5YfufnAiq567iqPDCA8=;
 b=QT2au4S71amx7V0MTMTvyTTznaKIO5IZ465MvQVcaTSXKTOvWAmdgk0t+pdOgEEraRIDC+
 fIMfUd8l1aYfW+ihr97qw01ZT2+qZ8vkwLusrtDe0L8iD7+9AZ105WnCK/X5qrexRjXH1u
 tKhYV3S2hHhH/4HFx7PIxHhDPFzXJVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-OE9fojpVNbaR0LzqJMNqMg-1; Thu, 27 Aug 2020 10:55:59 -0400
X-MC-Unique: OE9fojpVNbaR0LzqJMNqMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7622DF6C03;
 Thu, 27 Aug 2020 14:55:57 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E6C1055A60;
 Thu, 27 Aug 2020 14:55:50 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:55:49 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 18/20] tests/acpi: allow override blkdev
Message-ID: <20200827145549.yxevoxlcj44aqxlj@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-19-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-19-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g3hkxlwvgijsjsfz"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--g3hkxlwvgijsjsfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:52PM +0200, Gerd Hoffmann wrote:
> microvm needs virtio-blk instead of ide.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index d25ff354921f..058ba3886659 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -72,6 +72,7 @@ typedef struct {
>      const char *variant;
>      const char *uefi_fl1;
>      const char *uefi_fl2;
> +    const char *blkdev;
>      const char *cd;
>      const uint64_t ram_start;
>      const uint64_t scan_len;
> @@ -635,9 +636,10 @@ static void test_acpi_one(const char *params, test_d=
ata *data)
>          args =3D g_strdup_printf("-machine %s,kernel-irqchip=3Doff %s -a=
ccel tcg "
>              "-net none -display none %s "
>              "-drive id=3Dhd0,if=3Dnone,file=3D%s,format=3Draw "
> -            "-device ide-hd,drive=3Dhd0 ",
> +            "-device %s,drive=3Dhd0 ",
>               data->machine, data->tcg_only ? "" : "-accel kvm",
> -             params ? params : "", disk);
> +             params ? params : "", disk,
> +             data->blkdev ?: "ide-hd");
>      }
> =20
>      data->qts =3D qtest_init(args);
> --=20
> 2.27.0
>=20

--g3hkxlwvgijsjsfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HyXQACgkQ9GknjS8M
AjVddw/9HDhRHAT3Xld+mKjH5KyYmNM1IQpnF0y0BFxcPc2YmQIcPbtgnl3Sm8+a
QWp5jlvcR3AkX2oRyiOowqvcDD0GbuBUABmUeu2C/4yzU59GFiaDwAg/8IYfYOjm
lw46Kq5JVE5g0NGyoERBYeTo9tV6W4E7e4Zr29RRzD3FcdxM8oAVh3z/AMClu/mr
HxEjr6INIT4x+8u2e/5RalxHRv+zOdz3QPbAiwWEzX6UhDW0WY0eh20T9Ob62a4r
vMqXQWYfE9O4nfPcRxxVZLAwo9BPkBkb3Sa+yHZ3QFvKbHaMnqyKPhj1CaKLyJAr
ZJv6+zTjgK5aWQQmcG/ZAQ9mXCKpVBJ2ET17JNnTmKymJPlW3BvcTDqJREzZTL96
3hh9cMegu81wIFwkmv3TrPIZQkvHu5Lra7S7e9HnMvFXVCoteD/XBSLN9An26t4B
AB8b9jtSSt2EYvte1IsWNy2xjcMildAi9mMCX9aSf8DBtMBLSrPtIhFUPLOY+u8P
SdzKxrAd/EokGIJyFUDbxFsZnU4H+dgUCPkDi7kFgwANaN+ohNJv+MDNrvcqwOh6
ln+t2JyEhcEdoRiUM5V+9ziYA9ztyN4cZsPxGwSRI9qaK41f2VvHMWMoN8Z/lFdx
xJ2Df4GNdcWJvBbL1uSHTVSzycXp9ZFUYzTdWDxSoOhMyNucLXE=
=wZOk
-----END PGP SIGNATURE-----

--g3hkxlwvgijsjsfz--



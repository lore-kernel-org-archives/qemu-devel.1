Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B97C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697AC2073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwVGq7Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697AC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFvo-0001FD-K2
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieFv8-0000i2-V1
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieFv7-0003SO-Un
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:05:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieFv7-0003S5-R9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gcXxnFZqmipUTp4SLY/i9ILSaABJyhP3QgU/n54mC1A=;
 b=fwVGq7RrJS1p7B7k8FE7OMX71ZBf5WwwwQ98wgrLnC/u0I8bGQDvw27e7eH++NtH6fZaWG
 CmXzmLZdAd5FPJRItS+W+O51pRC5XrniuygxgzUPZ5FPDfvsplKHnPZJ+5uKgkx1+qnzbG
 CwN8y8H/eLMiFp2W6e71g5VryUg7NB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-h0eJ5ZtWNDC-3obL730LkA-1; Mon, 09 Dec 2019 05:05:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AEDE107AFFB;
 Mon,  9 Dec 2019 10:05:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7B95D6C5;
 Mon,  9 Dec 2019 10:05:22 +0000 (UTC)
Subject: Re: [PATCH-for-5.0 v3 3/6] hw/pci-host/i440fx: Use size_t to iterate
 over ARRAY_SIZE()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a4745134-47dc-ab8a-6009-69fcc9dfbb02@redhat.com>
Date: Mon, 9 Dec 2019 11:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209095002.32194-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: h0eJ5ZtWNDC-3obL730LkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/2019 10.49, Philippe Mathieu-Daud=C3=A9 wrote:
> We don't enforce the -Wsign-conversion CPPFLAG, but it doesn't hurt
> to avoid this warning:
>=20
>   warning: implicit conversion changes signedness: 'int' to 'size_t' (aka=
 'unsigned long') [-Wsign-conversion]
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/pci-host/i440fx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index fbdc563599..0cc80b276d 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -419,12 +419,11 @@ out:
>  static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      uint32_t val =3D 0;
> -    int i, num;
> +    size_t i;
>      int pos, len;
>      Error *local_err =3D NULL;
> =20
> -    num =3D ARRAY_SIZE(igd_host_bridge_infos);
> -    for (i =3D 0; i < num; i++) {
> +    for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
>          pos =3D igd_host_bridge_infos[i].offset;
>          len =3D igd_host_bridge_infos[i].len;
>          host_pci_config_read(pos, len, &val, &local_err);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>



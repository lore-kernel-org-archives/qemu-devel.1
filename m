Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44673C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9DC2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsP7X0bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9DC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFyT-0002ET-7B
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieFxt-0001pj-6b
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieFxs-0005zf-7k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:08:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieFxs-0005zG-4R
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575886107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kgf8J08dv830lwyKwrxJuLOd2qCaBurqJZMFFAjrIZk=;
 b=gsP7X0bx+RmO/TxLkPBVcZ1kX2xKIFrRMiA8ZtKMEAxByM1oqPmu0ThK70zcfcZnpFaM97
 R2gsAp0QHHsJOs88FYhChE0NDBJ8SPjbYBw8P7+d3D65wI7YZLpLgUMv1FTeoCx7XxorBu
 oc/A5Bp08/EV++ifTP6cpYieODbRTNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-XRGtWUwIN8miFcYIjwTopA-1; Mon, 09 Dec 2019 05:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF21107ACC7;
 Mon,  9 Dec 2019 10:08:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60A165D6C5;
 Mon,  9 Dec 2019 10:08:15 +0000 (UTC)
Subject: Re: [PATCH-for-5.0 v3 4/6] hw/pci-host/i440fx: Use definitions
 instead of magic values
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-5-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8869b47a-8fa9-8d36-bdb8-80b4cad9ae33@redhat.com>
Date: Mon, 9 Dec 2019 11:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209095002.32194-5-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: XRGtWUwIN8miFcYIjwTopA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/2019 10.50, Philippe Mathieu-Daud=C3=A9 wrote:
> Use definitions from "hw/pci/pci_regs.h".
> This also helps when using git-grep.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/pci-host/i440fx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 0cc80b276d..414138595b 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -376,13 +376,13 @@ typedef struct {
> =20
>  /* Here we just expose minimal host bridge offset subset. */
>  static const IGDHostInfo igd_host_bridge_infos[] =3D {
> -    {0x08, 2},  /* revision id */
> -    {0x2c, 2},  /* sybsystem vendor id */
> -    {0x2e, 2},  /* sybsystem id */
> -    {0x50, 2},  /* SNB: processor graphics control register */
> -    {0x52, 2},  /* processor graphics control register */
> -    {0xa4, 4},  /* SNB: graphics base of stolen memory */
> -    {0xa8, 4},  /* SNB: base of GTT stolen memory */
> +    {PCI_REVISION_ID,         2},
> +    {PCI_SUBSYSTEM_VENDOR_ID, 2},
> +    {PCI_SUBSYSTEM_ID,        2},
> +    {0x50,                    2}, /* SNB: processor graphics control reg=
ister */
> +    {0x52,                    2}, /* processor graphics control register=
 */
> +    {0xa4,                    4}, /* SNB: graphics base of stolen memory=
 */
> +    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
>  };
> =20
>  static void host_pci_config_read(int pos, int len, uint32_t *val, Error =
**errp)
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>



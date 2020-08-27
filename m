Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF20C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBB02054F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwx2j+It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBB02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJLV-0006pm-CR
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJKZ-0005my-Se
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:56:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJKX-0000Hp-CA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wsuZpKXQI/kSu1Qx0/XtWkBt+ZOTYP/BuvKbIRJ0s8c=;
 b=Nwx2j+ItstD8ZzPzCMkPFL30gmAENhSh562IgxxeJ4zsQ57h91bTwJBA4BfPuA7bOvovbm
 kgiumcRGDbUPK1xmgKwYOiXQAx5E0XdK2GCtjyHBL+BzvhecCzKWRR9KGG8ZBbgd2fEnxa
 wl7AqykHAjVBHbu1gWWcOzTMvZsxy60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-iineSp69Mta0uaMYcSrzrA-1; Thu, 27 Aug 2020 10:56:41 -0400
X-MC-Unique: iineSp69Mta0uaMYcSrzrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D4F10ABDA1;
 Thu, 27 Aug 2020 14:56:39 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB2B27A4D2;
 Thu, 27 Aug 2020 14:56:33 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:56:32 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 13/20] x86: constify x86_machine_is_*_enabled
Message-ID: <20200827145632.bitfuhk72rfkpjvv@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-14-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-14-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="753vxnsxshtrvxbw"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

--753vxnsxshtrvxbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:47PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/x86.h | 4 ++--
>  hw/i386/x86.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index b79f24e28545..a350ea3609f5 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -110,8 +110,8 @@ void x86_load_linux(X86MachineState *x86ms,
>                      bool pvh_enabled,
>                      bool linuxboot_dma_enabled);
> =20
> -bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
> -bool x86_machine_is_acpi_enabled(X86MachineState *x86ms);
> +bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
> +bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
> =20
>  /* Global System Interrupts */
> =20
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index cf384b974318..31a82885d735 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -845,7 +845,7 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool=
 isapc_ram_fw)
>                                  bios);
>  }
> =20
> -bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
> +bool x86_machine_is_smm_enabled(const X86MachineState *x86ms)
>  {
>      bool smm_available =3D false;
> =20
> @@ -887,7 +887,7 @@ static void x86_machine_set_smm(Object *obj, Visitor =
*v, const char *name,
>      visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
>  }
> =20
> -bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
> +bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
>  {
>      if (x86ms->acpi =3D=3D ON_OFF_AUTO_OFF) {
>          return false;
> --=20
> 2.27.0
>=20

--753vxnsxshtrvxbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HyZ8ACgkQ9GknjS8M
AjWcYBAArqdaF/J6ySxkRoQT2NMqtfI3CTHkQ7/H3Yo+dgvBSzJWxy9Br6WcBZEr
l5KXNsenUaTA2MUX2yQ4n6Lf4SSOhBQeCC6zoPC1mWp6UH6zeljDsL/Np13esMAL
yxTqZPjZXqaJfB0xgoGmNbsBL99XBnOYWKeoo+ZcV5p4UWm/F1glQOJd4Ocd51p4
6pFM4uz7laY8+G+9lhOBOjEx9K2S04W7cWGeKxIjN49aJp7TOLD3jbj4sguGBrHJ
xzhS4njeNAFvPe1ttZp+SDUEjbNyqRchEjbByjpavoSIJkRP5qgJiN0hMU+JGC38
LsNfNU1VPSdqFzVMkTc/DPMon0OR00Ns2Qaozp+DgksGSft7ZDqGnwGGYkSTMpZh
ggXIJ9oNDoGy5Cufr/lGJCKTl14imz/ktyT7+9j4AL6AH+aeCe8kKbLE4QD0kwf7
LendbGwcDwopBywNJ27ddsEJMN7L/50C387aO0W8kagZetYun0tc+kSi4Tdl0DmZ
wKA/NKaVk/ytm2OYYvd6nVPP2aTlMvtL7hE3U70psMLMekNDwTvlj9E6HCzzQxie
f5LnpQiOZXBLfIEaVnc6bx2UVUijfZwBz8vONlg3Kv0BXMoE849VKA3zjU77UX5w
Z/vgjmtzkDQU5mLLcjPlBLHR2rG8R3aK6bj/8JoG1jgREGokTRw=
=2VtS
-----END PGP SIGNATURE-----

--753vxnsxshtrvxbw--



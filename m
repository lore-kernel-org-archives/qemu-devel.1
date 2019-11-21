Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE08C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3A120721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx/G0HzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3A120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkLd-0000bc-Q5
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXkKF-00081k-Pm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXkKE-0002TP-Ll
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26035
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXkKE-0002Sh-IO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574334518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHL0UO7MAK8copWACF50qrbewMiXFvk5XnmjfwV6jmk=;
 b=Jx/G0HzIDrLqzgB8jsqre3bCCdIzqI82aHZQXaNksxiUklaP53NpqAO/Si5pCkiHFrosDN
 1+Y+JpEMV9KqDF7L1a9zkiT/xnPZBMqUjZdqVuu3hNoc8wXoo4SCwnSN5FPylexO7QUNOb
 nd6Ohb8BFD/jFEFJSMi5UM58TnHJkfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0TC8HXwfPYm0vJ1YK0vWPw-1; Thu, 21 Nov 2019 06:08:30 -0500
Received: by mail-wm1-f69.google.com with SMTP id y133so1373906wmd.8
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c4/qmxm5dqKJV3NK8SjSOV5dRQJhUqjY8Y5afRnTv2w=;
 b=tx+yVWN59Hko/7/VO3HUA91EHBficVt4hjBOmCYBOBTAjKlhCLA4UbQ3tiKwjRlgci
 /a1oyHLh+GtkxEZBlD1BQ+v4o2fCB8a7kK21u9N8+qrJQO5MTs7BTlANTDCVXdztvKYL
 PbJuN31kd7xCd87o9afcprmsIv4nvTXyi4K0FX9XIs4PKpdQ75FNHa7PliiDE0fXDczm
 nlryXps+JN6GesoURa4h7xB5nfCYKHkZ0jOEX3ZI246j7zeZbHSuhM7XUrwtZp9HGkh7
 W5uCGJrt0IVcvvsXiib+wrwjd+7NwkePMvh2xTsGE5NHWtVd0EaobjCMa60XOjGV+p+x
 1n+w==
X-Gm-Message-State: APjAAAXXhaqeCFxQ9JbKzttbmH1c3hU20vsmqXxS7T6OXbQu6YIO9u9F
 gMEQYEUicbtCKqgwvGd/G6y6v+arie+jkgokK91rIsboFmZiMfelKja5J2+lnE6EhvxOGx8Ajp+
 GIx5ImA6Z9uARIEQ=
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr10185419wrm.359.1574334509330; 
 Thu, 21 Nov 2019 03:08:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwh9qdL2hfxd3B/faG2J2QLv8g8iD3a8H48SqJm5vKfiIpt/i5Kz3TagaWBUlfbtlbML4+PRQ==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr10185382wrm.359.1574334509028; 
 Thu, 21 Nov 2019 03:08:29 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id m13sm2523687wmc.41.2019.11.21.03.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 03:08:28 -0800 (PST)
Subject: Re: [PATCH v2] exynos4210_gic: Suppress gcc9 format-truncation
 warnings
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
References: <20191121013859.287372-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80635d08-4546-9f14-b664-f8f79cf5ec19@redhat.com>
Date: Thu, 21 Nov 2019 12:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121013859.287372-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-MC-Unique: 0TC8HXwfPYm0vJ1YK0vWPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 2:38 AM, David Gibson wrote:
> exynos4210_gic_realize() prints the number of cpus into some temporary
> buffers, but it only allows 3 bytes space for it.  That's plenty:
> existing machines will only ever set this value to EXYNOS4210_NCPUS
> (2).  But the compiler can't always figure that out, so some[*] gcc9
> versions emit -Wformat-truncation warnings.
>=20
> We can fix that by hinting the constraint to the compiler with a
> suitably placed assert().
>=20
> [*] The bizarre thing here, is that I've long gotten these warnings
>      compiling in a 32-bit x86 container as host - Fedora 30 with
>      gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal
>      x86_64 host - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
 >

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

--- <- here goes the separator I suppose

> Changes since v1:
>   * Used an assert to hint the compiler, instead of increasing the
>     buffer size.
>=20
> ---
>   hw/intc/exynos4210_gic.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index a1b699b6ba..ed4d8482e3 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -314,6 +314,14 @@ static void exynos4210_gic_realize(DeviceState *dev,=
 Error **errp)
>               EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
>  =20
>       for (i =3D 0; i < s->num_cpu; i++) {
> +        /*
> +         * This clues in gcc that our on-stack buffers do, in fact
> +         * have enough room for the cpu numbers.  gcc 9.2.1 on 32-bit
> +         * x86 doesn't figure this out, otherwise and gives spurious
> +         * warnings.
> +         */
> +        assert(i <=3D EXYNOS4210_NCPUS);
> +
>           /* Map CPU interface per SMP Core */
>           sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
>           memory_region_init_alias(&s->cpu_alias[i], obj,
>=20



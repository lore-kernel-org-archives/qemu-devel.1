Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC2C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E71217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo075gQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E71217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izq0N-00045Y-VK
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izpzI-0003O8-6x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izpzG-0003BQ-8d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:51:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izpzG-0003AD-59
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581029465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icv33eBiR2I+mYSDzaq6QSN263N2WB1MBrPZaycniYY=;
 b=Oo075gQm+YUdeZ6G0CPu81UiyisbwQdZk0WC5Lqjk/7Pu07QRVVcp9Sckr2SdXbMWlOenH
 sZYed3yXy6pysILhbykpY3UV+GzMCUlb+QeotySlNpZ6vsyOksEZ/wfTSPXoeAryjVdP4h
 EFMQYg+ag+IFRaLNcC7eYNKBwAmK22Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-sBCosjNfPZepG1b-2SGu9Q-1; Thu, 06 Feb 2020 17:51:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id d15so217928wru.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 14:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6zonQwthUIyO3uDNOl9B69G6xjJlqM2rgpgfOa2CcHw=;
 b=J3+ivz75m+P7rdg0osHYg6u/vpXbbVV+X2zENp1nGzglcVY2roJ9m3IAyp/0EkJZgs
 xRaODAfP3FIzu+5DTCHM72z1CTSzXgBOUGIgiI8FLS++ZmZIDlIbBi3KjqLkEC6Ybkf7
 XWvg8d3NajsGK0begBduzgf6NiA0KUZa7SeJ+PIalHZ1aElpOGad50rumv/OaTEgBbcd
 cl+mPzTWDaZuDgVKmMbjU4xWTV9U0+gnxsoNaq3YZnSvC7y2V8wPXHLVRyXcb+GKUJv4
 ML9ncOfGABizIW7bfRNH7VaMz0drBsPUDCcGubdYQXZP5mdk9I8PO7+wuQyksf6oqm2u
 e7bA==
X-Gm-Message-State: APjAAAXZklHO/3p7v6ftEuWyRGe74az8XotNsTM0/Au31/PPC8tEQ1Dw
 ugHqq0rkhHn+4yyob4xwI1tLrXtS2TaI+b7pNNe+pVJzKP6V++Ka0lZvYRkxFhLeAJeowugD7hJ
 7tGmUoDrA1zslcsM=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr65066wmd.127.1581029460387;
 Thu, 06 Feb 2020 14:51:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxdSbC5vabCytVlx5A/MrdIFVsarN6xI1JGhN4tUxlG0+6LS+sCypTiBv/oAbWECrnInTX6Q==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr65051wmd.127.1581029460189;
 Thu, 06 Feb 2020 14:51:00 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l29sm853996wrb.64.2020.02.06.14.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 14:50:59 -0800 (PST)
Subject: Re: [PATCH] docs/arm-cpu-features: Make kvm-no-adjvtime comment
 clearer
To: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>
References: <20200206224858.23184-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f8ed42e-15be-1f80-107b-fa4d4254da2b@redhat.com>
Date: Thu, 6 Feb 2020 23:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206224858.23184-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: sBCosjNfPZepG1b-2SGu9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 11:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The bold text sounds like 'knock knock'. Only bolding the
> second 'not' makes it easier to read.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   docs/arm-cpu-features.rst | 2 +-
>   target/arm/kvm.c          | 5 +----
>   2 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index dbf3b7cf42..fc1623aeca 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -185,7 +185,7 @@ the list of KVM VCPU features and their descriptions.
>  =20
>     kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  Thi=
s
>                              means that by default the virtual time
> -                           adjustment is enabled (vtime is *not not*
> +                           adjustment is enabled (vtime is not *not*
>                              adjusted).
>  =20
>                              When virtual time adjustment is enabled each
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 85860e6f95..bcca8c8029 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -194,10 +194,7 @@ static void kvm_no_adjvtime_set(Object *obj, bool va=
lue, Error **errp)
>   /* KVM VCPU properties should be prefixed with "kvm-". */
>   void kvm_arm_add_vcpu_properties(Object *obj)
>   {
> -    if (!kvm_enabled()) {
> -        return;
> -    }
> -
> +    assert(kvm_enabled());

Oops, this was not supposed to be committed.

>       ARM_CPU(obj)->kvm_adjvtime =3D true;
>       object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_ge=
t,
>                                kvm_no_adjvtime_set, &error_abort);
>=20



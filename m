Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7741C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC25924681
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY8eaFaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC25924681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ige5o-0005Tn-Ua
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ige4y-0004rf-3W
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ige4x-0006Ab-64
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:17:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ige4x-000675-1u
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576455458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWhUBUeBgK04x4i3sIhcg+DM1+J6iHEFt5qdOjm9s60=;
 b=aY8eaFaSVfU3QWlTi91gxUXu0MKDDMjCOy+w1ddOvVm3ceDwnaGooOSVSMJrmFYKX2JPvc
 TYG/U21xz+kiFvyK86QKvR3Oq9gmbrAK9omNSd59emIgXBUwHm7u/9+dxztpaWNfpCBfWe
 o/eqJMuJQ3U9MFX/52J30UYOpIyPMCU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-tzER5Wl6M0uC09yRGQWsHQ-1; Sun, 15 Dec 2019 19:17:35 -0500
Received: by mail-wr1-f71.google.com with SMTP id b13so1410168wrx.22
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 16:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1e9AidJmNHbOJw5LwOfFSsNm7euHiS3mPs7opbkr410=;
 b=XTlYJxkmaG4szqWGs5GOcGK/l720ooPx5uk9B0CXoF/MzYjea9BZbP/vbBjpD4NmhH
 a9rpeOndlmB0MYC7iNXbVs5q3lUpD7rLFdnrelOPeu+zCnn7+mAReOIfIuj1tFmqoYCf
 +6pn7ORPcKIlRVEBOCfeD94d47qQXqLHdaY6I9YIvbaFKa36+SuevrDjWPVKNY+6N/qH
 z+4gckDUhrI+GK/xedFpGlq0MyNPFquKXvNvoHNZM3vYjM7MyAzZuoShK9vKhTCQu81+
 MC/m6tzAemhNim53Nvc2cPcVhD7UJmw/RxO3YdSuw7T7OMnYHa3MAzXjvW4n6dvUfI3v
 6PJg==
X-Gm-Message-State: APjAAAVniXIYPGiLrBJQm5P2GyKSZ4h4N5Gg7hgN5U3e9YKOn61JAcUu
 9gPKM3Q9Qi2DRV3ED57Ho5QxhaMsv4xxrHYEw7JJawIpN4rgU0FR7RdEWE9MiYk1gEaYLsrgh84
 Iv7f42iHOaLjCR1U=
X-Received: by 2002:a1c:5419:: with SMTP id i25mr27618581wmb.150.1576455454124; 
 Sun, 15 Dec 2019 16:17:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEKMARgSZ5F+idl3VgD1Ws8GpB/pbIkJWkdSQDoYttIe8Z8GatRLXSwZxxkCph/00XkhZ+uw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr27618559wmb.150.1576455453818; 
 Sun, 15 Dec 2019 16:17:33 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e12sm19457469wrn.56.2019.12.15.16.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2019 16:17:33 -0800 (PST)
Subject: Re: [PATCH 05/10] arm: allwinner-h3: add System Control module
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-6-nieklinnenbank@gmail.com>
 <949aec5f-fd92-9fb2-25f4-803cd1bbf601@redhat.com>
 <CAPan3WpC2AiSGJsMmbQgJkucEDRg_os418rY_B6B8b8D2WM31A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <25c838e3-af9a-d742-6946-056c431a8805@redhat.com>
Date: Mon, 16 Dec 2019 01:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WpC2AiSGJsMmbQgJkucEDRg_os418rY_B6B8b8D2WM31A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: tzER5Wl6M0uC09yRGQWsHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 12:27 AM, Niek Linnenbank wrote:
> On Fri, Dec 13, 2019 at 1:09 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 12/2/19 10:09 PM, Niek Linnenbank wrote:
[...]
>      > +static const MemoryRegionOps allwinner_h3_syscon_ops =3D {
>      > +=C2=A0 =C2=A0 .read =3D allwinner_h3_syscon_read,
>      > +=C2=A0 =C2=A0 .write =3D allwinner_h3_syscon_write,
>      > +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>      > +=C2=A0 =C2=A0 .valid =3D {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,
>=20
>     Can you point me to the datasheet page that says this region is
>     restricted to 32-bit accesses? Maybe you want .valid -> .impl instead=
?
>=20
> Hehe well here I can only give the same answer as for the SD/MMC driver:=
=20
> the datasheet
> only provides the base address and register offsets, but nothing=20
> explicitely mentioned about alignment.
> I do see that also for this device the registers are 32-bit aligned.
>=20
> Does that mean I should change MemoryRegionOps to . impl instead?

No, keep them, but add ".impl.min_access_size =3D 4" (see answer to SD/MMC=
=20
model patch).



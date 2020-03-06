Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD73C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F342073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIiLMBgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F342073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8VA-0007M7-Ii
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jA8U7-00060v-M7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jA8U6-0001cE-M1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:37:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jA8U6-0001ao-Iu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583483850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIof3AkU2IkHeVGssOqdyQ3MR20tHE1wfvz1T0B4jlM=;
 b=FIiLMBgvL/WKAEJPhrRglRFwhBp7gwJkfULlycqGXPFeWdH6PuLY3K1NfZl6rg1gEMM9KD
 Pc7bMVSF6cPPpxy5wJJpbpX3GqguE0e31ivU6CTSWMm3hEhCOCcAi/Ez3yvnHLHxL7E4h/
 ttBhA4nTh2qZMnuyRstNgw1AW18WaZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-95YUK-fePiqjrmrawZwwiA-1; Fri, 06 Mar 2020 03:37:26 -0500
X-MC-Unique: 95YUK-fePiqjrmrawZwwiA-1
Received: by mail-wr1-f69.google.com with SMTP id w11so687549wrp.20
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 00:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+JwmFIV4EQ/1jb/bmSBxX8EMZV2M3M7i3jxLfkhMM28=;
 b=iL1P0PAZjjIvjyO7LfjV+Jo+yYkmrA9P48x6TrjedkcE70ZmsahGwUnebUvJb392hO
 aaxU1mZq+SLKnGTh09FHveXBDFamZd43NQv7KmFWcPIFhfHDZ+FFfUq6YWy0zAVN2uBQ
 hBOFqKpqjf9AdgiivX3Kd7PfnYUwJSpjjm8R4LfBhA8OvCteuZv9GmC9t28DdJEB6vX/
 LcnuqLxn9F7cKhbgF6Gr8418ZOcEE3XRFtv0R6mquXyXjhpqhc3PIig9DoTdW85NlrqE
 T3rbZ0o8hqhbm0aWq/IOBZyR/vFmgSvKcpD+tF1h/iy6jYY4uRXAjt2uNcn/RFJRw5oL
 KCyg==
X-Gm-Message-State: ANhLgQ2hfVsHUxEPYkb3THQtedDguoWwkUkEzITyrqPlH/aIaBNxDrm3
 WBIhzSMP219kaBY0tcD8rbczXrrOiskkTsykAPmXS1uMsCaVuTsG8++gGkwHxA1t96m0+IxY0gH
 e+klgqMDDQCo9gbY=
X-Received: by 2002:a5d:638a:: with SMTP id p10mr2813328wru.42.1583483845347; 
 Fri, 06 Mar 2020 00:37:25 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs094a93xJZE37lNGq8QmKGZGGJVP+4CTS0vQ8M0PfbTHkQcFpqYlln6DBtECOSdaaa410EHw==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr2813302wru.42.1583483845114; 
 Fri, 06 Mar 2020 00:37:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e?
 ([2001:b07:6468:f312:b99a:4374:773d:f32e])
 by smtp.gmail.com with ESMTPSA id z12sm20447811wrs.43.2020.03.06.00.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 00:37:24 -0800 (PST)
Subject: Re: [PATCH 1/6] hw/net/e1000e_core: Let e1000e_can_receive() return a
 boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dc2c940-551c-020d-bbed-98dcb194f59d@redhat.com>
Date: Fri, 6 Mar 2020 09:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305175651.4563-2-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 18:56, Philippe Mathieu-Daud=C3=A9 wrote:
> The e1000e_can_receive() function simply returns a boolean value.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/net/e1000e_core.h | 2 +-
>  hw/net/e1000e_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index 49abb136dd..aee32f7e48 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -143,7 +143,7 @@ e1000e_core_set_link_status(E1000ECore *core);
>  void
>  e1000e_core_pci_uninit(E1000ECore *core);
> =20
> -int
> +bool
>  e1000e_can_receive(E1000ECore *core);
> =20
>  ssize_t
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 94ea34dca5..e0bafe975b 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -967,7 +967,7 @@ e1000e_start_recv(E1000ECore *core)
>      }
>  }
> =20
> -int
> +bool
>  e1000e_can_receive(E1000ECore *core)
>  {
>      int i;
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>



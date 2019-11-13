Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C87C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A15222D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6E8Yowr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A15222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu8P-0004d2-R7
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUu7g-00046C-No
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUu7f-0005uw-Nh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUu7f-0005td-Jw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573657195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Qw6/Y6nacXUxGs6BYNw2PKOW+ZOr5mHu7KC2FfY9Kfk=;
 b=h6E8YowrEzt1ioo4+p+NZw6UeucFwP82va0sAwbHYEf9ZljFF5/hwZnYSpGdVBCF342AxO
 +jHu6l8bq3UH3E2BlUOyPGtcSYUYz1sZS4L+G0RlEY6uKjktNWwgxEkNeJQTyK6I11VMpS
 mKr6QYrLFF+doF9pJaoovn7Kir2qBa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Tj3Wbcf0MiybMe8TbIl50g-1; Wed, 13 Nov 2019 09:59:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id l3so1736066wrx.21
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WP+aEA5DGudkrsGvf3+tE1nJrpL33iHp1/3qYgtuQ40=;
 b=jOb22gvUzz1lZgBpARpu5QTi1sWFc3Ujo8hA0C1ZzCHeIJLPlSVwEDiDb19QBwXPJX
 p1rGquSswice8T4wdDs7NqCMq6tEerNiypjWlmoyqCuCFnEKSAhtkJ3BAjzECM1i3Nrp
 31KWamGhrWcX0SBdf4EOb4TZOc3WMfhijoanCDGwNwtNN7uiszr6tVSBRErb6ha1XLSX
 i7xL0C9edeTY5CDxcbWxGLHy4KYFZ16n/GELekUdmoV1LTXPePSnNjeoJMMe7ouXNjGs
 OOWPxuo2QUsDrEhg5deHNvvYPOS0gnz+L4IpBQnK1XTH2dLQCGmZBURl9iPeNIApfAu4
 kmwA==
X-Gm-Message-State: APjAAAVnnWXHR6QN93C9hz7k0g+g7QWyLFIVT74izjj7Glyoe3o//GMJ
 5mmKsWEXV9b18RmRh5bYVFTFIxxZQn7fABzzCdhmYC+QimjzjbNLUht7aQpRvomOhn68f0/Xooh
 Yya36QFWHXSL4jlo=
X-Received: by 2002:a5d:570f:: with SMTP id a15mr3144877wrv.316.1573657192755; 
 Wed, 13 Nov 2019 06:59:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqywAUQvD1txGtD0yIhIo7jDdFCEEIojaU8ZMwM29CxitXixCfe6aIPkSyoAECuk1eOWfcoKZQ==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr3144860wrv.316.1573657192466; 
 Wed, 13 Nov 2019 06:59:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:64a1:540d:6391:74a9?
 ([2001:b07:6468:f312:64a1:540d:6391:74a9])
 by smtp.gmail.com with ESMTPSA id y78sm2817359wmd.32.2019.11.13.06.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:59:51 -0800 (PST)
Subject: Re: [PATCH] WHPX: refactor load library
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4d20ec63-7eae-7c7f-167b-f87709adcd78@redhat.com>
Date: Wed, 13 Nov 2019 15:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: Tj3Wbcf0MiybMe8TbIl50g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Justin Terry \(VM\)" <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/19 21:31, Sunil Muthuswamy wrote:
>=20
> +typedef enum WHPFunctionList {
> +    WINHV_PLATFORM_FNS_DEFAULT,
> +    WINHV_EMULATION_FNS_DEFAULT,
> +} WHPFunctionList;
> =20

What does "default" stand for?  I assume you have more changes to this
function in the future.

> + * Load the functions from the given library, using the given handle. If=
 a
> + * handle is provided, it is used, otherwise the library is opened. The
> + * handle will be updated on return with the opened one.
> + */
> +static bool load_whp_dipatch_fns(HMODULE *handle, WHPFunctionList functi=
on_list)
> +{

Typo, "dipatch" instead of "dispatch".
>=20
> +    if (hLib) {
> +        FreeLibrary(hWinHvEmulation);
> +    }

The argument to FreeLibrary should be hLib.

Paolo



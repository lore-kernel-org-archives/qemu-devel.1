Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6113DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308F52073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH22U9/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308F52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iejZw-00037k-7A
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iejZ4-0002bb-TK
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iejZ2-0002mI-QX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:44:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iejZ2-0002li-Ms
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575999887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dFNy2ufcLZZVwOl22pvq6jcog3rf3tPjjOm8HTU3zA=;
 b=aH22U9/P4Sl8SjFP0dyYorYtTT+dMInjy0sIox5824w0v/rAKusdgcPW4MzuZeynopP5gR
 Kp49uCBXPCeWCjMLVpmZb2OX4DgGfvtc/PzAqe05lTy4vvbjIH//IcJPypPy+xonY98y8F
 +C+3fYYySWYbdeGJzFhImQf3y9KQ4ww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-nAlY2uPcOOGpTlyyOWMnsA-1; Tue, 10 Dec 2019 12:44:46 -0500
Received: by mail-wm1-f70.google.com with SMTP id q21so1275940wmc.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 09:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rdb3htqVxF/97hBOyXD18SU5vkFYnRj8kFnYmJCpbTY=;
 b=Z7uqHKfDwz08ZbCzHEr1jNjyHvJ37NSwoRkY2jQq1/vG7gePueUUbczMi6tv3nCA2b
 apzzt7jMMX6r+5+IXwPjyHsFMqOL3AjFuhS4OkFwa6fg3Z8MZyF4NE40kUOo2DQrMHTP
 FxQMCDzqXm4MnXEd2XqNsaykEhhW9snojkyEDvt8mg9gQkx9hYna4KDwvzV0NKz2wGMz
 IaOUXhSaU281PZtcxtmPdnqe2ebP9W/gUIQv6iZwyPehKQS1QipPl2+2AmoNE0xAgmxu
 hF9vDKXBL7Us1Bka0QUZ4ccLKItpGWhjqEKsOThjBJlRRTW0QFJBNcccLeal+gNKhcub
 awVQ==
X-Gm-Message-State: APjAAAWOuzpV1LxF5E5fgBQOUFBgDuoSN/1d0Ge8BW2LStVLsdqTSiO3
 FssWKLr6xNG6JVctmxDalV0ZmMNf4D+1GU5Bc6Q5/GNGerZ8udIIbMMEHflvkHxJKoO6GPkX0b2
 /encZdw3oR9r1uZ0=
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr6219956wml.120.1575999885159; 
 Tue, 10 Dec 2019 09:44:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+A+XMGJNyo2H8g38oj1rCr9YinOJwgtvaXcdBLMPgALQ1l6+PQPL2h+ZgdEWy8BUMFNqgTA==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr6219937wml.120.1575999884939; 
 Tue, 10 Dec 2019 09:44:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id b185sm4149291wme.36.2019.12.10.09.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 09:44:44 -0800 (PST)
Subject: Re: [PATCH v2 15/18] xen: convert "-machine igd-passthru" to an
 accelerator property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-16-git-send-email-pbonzini@redhat.com>
 <CAJ+F1C+hZhubMWE47URc38R=2d6GEg=TK8=dKpE_1XNs4txQfA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a62c25d9-059a-6709-250e-498ecfc443b1@redhat.com>
Date: Tue, 10 Dec 2019 18:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+hZhubMWE47URc38R=2d6GEg=TK8=dKpE_1XNs4txQfA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: nAlY2uPcOOGpTlyyOWMnsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/19 13:56, Marc-Andr=C3=A9 Lureau wrote:
>> +    if (g_str_equal(qom_name, "igd-passthru")) {
>> +        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, v=
alue);
>=20
> shouldn't it warn about deprecation?

The old version is not deprecated (I'm only deprecating -tb-size because
it's a toplevel option, but not the -machine versions; they have been
there forever and probably have too many users).

Paolo



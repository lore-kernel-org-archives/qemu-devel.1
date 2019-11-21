Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F78C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830C82068D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os/ewWWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXq79-0003cp-JA
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXq5h-0002cI-Ul
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXq5g-0005e0-MO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:18:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXq5g-0005dS-It
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574356679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmL1qLEwwuk3EbgLv2eOIRVmfULeKuzq21+pkHcyatQ=;
 b=Os/ewWWAQy0Sx/ANSOkcCfan70NJNUrdjqv7Z8y7Bh/KwOheQKE9cDDd06N5EkaoIp+IEW
 BPni+ba/wcep3qEprSj8dfJqPEqv1aKxz1gsjP4OvsachuTu1ai9ZEqRppRnN1f4wPUGOA
 +Ycl53XkMNgxUGu+SMa0RtT+ePhlxw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-L4r9dL72MfqJdtpWD8sgZQ-1; Thu, 21 Nov 2019 12:17:58 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so2460942wrb.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tcAXb1FTW0sbD9KROTNmNw2or/14ZHfWOCuP3Hndpsw=;
 b=kglY4idCbtYHhClvSXzS7/uW6nPFJrWY/tO90O05eUn/kugMwjgZ/RD8CThCjZbmG9
 JEXzU5Rh+pzUhQEKgGHPG7u8ptkl6mijBVpHyyftFEYDd92jvAPTqg1gqPVAuSfyZwdE
 rZlNtpuAGiG0VAtwq/AOP+lVgQbN+01V4o3wsdwypyVUa/CVwhCTpxqwAcN64J35AEz9
 6zOs9ATJdJSl6NQiVjWkhiEONdCIiwx6dJrRIw1nfWZUZ8cFtCgbZT1RNw8j7YwpX3Vr
 aMinJihU7WPWxGsnTFO/Km3LGTG3+lk75Dx6xjBT8vvI8GqlRPAOzwuYiSIW0tzX9qtq
 jTqw==
X-Gm-Message-State: APjAAAU0CokwYmlSTDSnq4G+zGsipvhRxASaHRzzmwfD4JnKGJdhL6N4
 gMdrqzKead7qehCwcaWkQtaDt4512i3xdWN2c50jE9UMwEZHE1hXn5TNh4I71Rh5P5xOqTUtrbB
 xT8abS31rE+GHTFw=
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr11549826wmg.45.1574356676882; 
 Thu, 21 Nov 2019 09:17:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbjpdaf2XT9bsKdYDbrHtXU+H8zuRZ3IZna+qPRkUfBsgpArkuYPCiN36RCim+HxKnW49Wiw==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr11549797wmg.45.1574356676647; 
 Thu, 21 Nov 2019 09:17:56 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id d7sm4178553wrx.11.2019.11.21.09.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 09:17:55 -0800 (PST)
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
 <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
 <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <32d6aa36-3240-7a80-89c1-5cba13bbc022@redhat.com>
Date: Thu, 21 Nov 2019 18:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: L4r9dL72MfqJdtpWD8sgZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 6:00 PM, Aleksandar Markovic wrote:
> On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 11/21/19 9:19 AM, Helge Deller wrote:
>=20
>         On 20.11.19 23:20, Aleksandar Markovic wrote:
>=20
>             On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
>             <aleksandar.m.mail@gmail.com
>             <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>                 On Wed, Nov 20, 2019 at 3:58 PM Helge Deller
>                 <deller@gmx.de <mailto:deller@gmx.de>> wrote:
>=20
>=20
>                     Improve strace output of various syscalls which
>                     either have none
>                     or only int-type parameters.
>=20
>=20
>                 It would be nice if you included a history of the patch
>                 (after the line
>                 "---", as it is customary for single patch submission).
>                 You changed
>                 only ioctl() in v2, right?
>=20
>=20
>         Yes. Will add history in next round.
>=20
>                 I missed your v2, but responded with several hints to v1.
>=20
>=20
>         Yes, I saw all your mails.
>         Thanks for your feedback!
>=20
>             userfaultfd(), membarrier(), mlock2()... - all could be
>             included into
>             your patch.
>=20
>=20
>         I think there are quite some more which I didn't included.
>         That's why I wrote "*various*" and not "*all*" in my changelog.
>         I'm debugging other code, and the ones I fixed are the ones I
>         actually tested with my code.
>=20
>=20
>     If you don't have handy way to test the other syscalls, I'll rather
>     restrict your patch to the one you tested, at least you are certain
>     you didn't introduced regressions. Unless their implementation is
>     trivial, of course.
>=20
>=20
> What can be handier than writing a program that contains a single system=
=20
> call?

Ahah very easy indeed :) Not noticing it shows how busy I am with=20
firmware world than I forgot linux-user can be a simpler/powerful way to=20
easily test stuff, as the Hexagon recent port also demonstrated.



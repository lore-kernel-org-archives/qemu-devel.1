Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147DC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7962070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXa6rRgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7962070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionIy-0003HC-16
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomBo-0006tI-7K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomBn-0005N4-2U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:34:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomBm-0005Li-V6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578393258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VWrm5t3dJ+OkI+JMxHMGI0ClvGjVadJrvF8sQm1D3U=;
 b=eXa6rRgSvvAaL3iY0FGWObD1yES0rDWBWT2IF3osAiITQi1xnRfNLNK8xgTdnqx4GSE2+9
 glErvaOA4UisTWFo1ZqXEUL7q6jSBcYi4VdL9aWfeK3pWdqWIGjapCGyrdMo9CjdKLiXYu
 tjVN7yWwlFw04ifTyKod0IARxzn1f9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-YdwUTYmINdG-reOkt7Ez1g-1; Tue, 07 Jan 2020 05:34:15 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so19087360wrm.18
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PxNvrIz6y3kihbk3x31P4PsqYCMZdduiFFlcYioHv8Q=;
 b=THXZ5oHCVllcbu8T7s/kSmE1I0Bzl2BJorM3UbEoZd1/i4y1kIgo69hiHs+v1xzdoG
 s57TeaWT2uZ0pg3q77GVgmfKyh+G2chmqZqYPzrYv6e2QFbWE60MYwYJ5dJkpTxQQvVO
 ABDRsnOAAwQBCb+o2sS2/iC+Psf+xUATYQn3guNhy1JT0yoC1JUmg9cjbpVLe2Yov4wf
 gUIJXC03ZkvsWEJGYwMQy94FlLMyfNibBoo3O9WhDnMVOTysjaRAbRaGthy9rQ4vF54C
 SbleY2L9gMSYKe9pReeOskY3bPlNlxSBtZafrvDywkd3PlzhWqCCi2J8KJ4s1TuM00ld
 wN6w==
X-Gm-Message-State: APjAAAXnxvv1OoXNhE4GhJ1V2M7JczE8Syde+G2V4dQ7gedHAdnK/Cs9
 +zCadEJ/A6vcY0bWTqBRjuhtM5pD56dQ9WwBiJqFX3IMGO31FbUfxWnzxqLYm1uvDSjccleUul3
 +ktahT7KQFnGetZE=
X-Received: by 2002:a1c:4008:: with SMTP id n8mr37360129wma.121.1578393254544; 
 Tue, 07 Jan 2020 02:34:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0DXd9qqgRr1u4KR2W6t/RZ+mvLeirV8egLa4hDPKQdADzns0jt2yhCjXYnBxobDVZXLkPuQ==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr37360106wma.121.1578393254333; 
 Tue, 07 Jan 2020 02:34:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id y139sm27653841wmd.24.2020.01.07.02.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:34:13 -0800 (PST)
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191231184916.10235-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e61692a-b670-153c-d348-5ab292d30a87@redhat.com>
Date: Tue, 7 Jan 2020 11:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191231184916.10235-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: YdwUTYmINdG-reOkt7Ez1g-1
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/19 19:49, Philippe Mathieu-Daud=C3=A9 wrote:
> When configured with --without-default-devices and setting
> MC146818RTC=3Dn, the build fails:
>=20
>     LINK    x86_64-softmmu/qemu-system-x86_64
>   /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_marshal=
_rtc_reset_reinjection':
>   qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_rtc_re=
set_reinjection'
>   /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined reference t=
o `qmp_rtc_reset_reinjection'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>   make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>=20
> This patch tries to fix this, but this is incorrect because QAPI
> scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
> get:
>=20
>   hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=80=98q=
mp_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
>     113 | void qmp_rtc_reset_reinjection(Error **errp)
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1
>=20
> Any idea? :)

Adding a stub seems like a good alternative.  Is the purpose of this to
change MicroVM's select directive to imply?

Paolo



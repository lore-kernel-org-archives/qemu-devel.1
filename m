Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C179CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B74520678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EloAyU3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B74520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOfC-00033r-Mm
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOYH-0006v3-2h
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOYG-00045i-4i
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:36:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jONO9-0007mr-0T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586877732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T47jjTmFB0dQt0VOFFjvgXGa6qL01FfKTD0QVvKLKDk=;
 b=EloAyU3gCjHfiIhdcaDbmqviP/qjoK3kQQErxyuu12b3CAiggJ3n/q2VloWopzWOcfnql2
 oWXoPmcKEj3St2/YiHflM1vpLD6GjvHBYXkyzg6gCKOhI3JFkxcCFM33MKuUGYn7i8IrH3
 9CXmpbIbbSgxqUmLxBa9SBiUPSNIi3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-SiX25Pl4Pky3jqsSxT7Hxw-1; Tue, 14 Apr 2020 11:22:10 -0400
X-MC-Unique: SiX25Pl4Pky3jqsSxT7Hxw-1
Received: by mail-wr1-f70.google.com with SMTP id 11so2554411wrc.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FeCCTWaNSRLxufx6+oivoFLifDhnwtozvnd5P831NGo=;
 b=mEnOSVFvmkgDKxMSeF7nfLY261VE93V8jjP+wIOpHzn0Ktl0GxuHF4k3gOpMtV9pT7
 4LbyFBn8MCYhO1HUfFdMoBioTSfwUHdp3+6YgSKkWVqZIyMXrNqLIqcXkUbuLpEdT7Ga
 wxTCDFvWixcJf9XZM6LaPbqScUJvh2PiyQlc51tMO1N0+HttAoiz8d5kHrrUoiWKB7P6
 TJ4vOT9rr1Sdh9WSsF2mQn1C5zT/uGGH16MH9crfeavP+yJlEB9e3JU8GOev2YjtTUqG
 tOL25kstn6/SjeLjx75LUzZWapbJ7iV1+k5WzZ/zGE5gz+VamNhQlF64KRm9Kzebm2bH
 61gA==
X-Gm-Message-State: AGi0PuZfb1XeoiBwYYT/bFFPozIaBogZJe2wOqpYoXyINzQTqDsy1fXY
 4PMs6wJo9T0epV8BaAEUokhYLsXYFGFdG9OWAbWmznBCa8uLxdGN0Q+B6qUgju3biSaiPzI8iQy
 0fgv7nMPS4snF5Kg=
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr366102wmm.15.1586877729724; 
 Tue, 14 Apr 2020 08:22:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKqBtokZm6PGFOndpaYlgdnGpPWMzF8doxKJgcMmcWvmSOJLGaeTCejjY8hNIZPRYvoHP8EPg==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr366024wmm.15.1586877728564; 
 Tue, 14 Apr 2020 08:22:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm18748022wma.47.2020.04.14.08.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 08:22:08 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] gdbstub: Introduce gdb_get_freg32() to get
 float32 registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200414111846.27495-1-philmd@redhat.com>
 <420ba3eb-996a-6bab-7764-ebf91ab22917@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9805276a-79d5-e913-5817-b894d2aabf72@redhat.com>
Date: Tue, 14 Apr 2020 17:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <420ba3eb-996a-6bab-7764-ebf91ab22917@linaro.org>
Content-Language: en-US
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 5:19 PM, Richard Henderson wrote:
> On 4/14/20 4:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> +static inline int gdb_get_freg32(GByteArray *array, float32 val)
>> +{
>> +    uint8_t buf[4];
>> +
>> +    QEMU_BUILD_BUG_ON(sizeof(CPU_FloatU) !=3D sizeof(buf));
>=20
> Why bother withe the BUG_ON when you could just put the sizeof(CPU_FloatU=
) into
> the array bounds above?

Ah good idea, thanks :)

>=20
>=20
> r~
>=20



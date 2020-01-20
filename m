Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC6C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDB22073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV1VEGaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSL3-0007gr-Cz
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSKB-00079K-3g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSK5-00043z-KK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:22:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSK5-00043H-Dn
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579508532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQzF28PH1WRMqdTrdg37DO0bT3HsuUHP0mh+IQbQcpM=;
 b=ZV1VEGaIVd2vTc9NAXVoIR1sLQiLGRb6Rj8ThhYDWSaJ+Xijk/hEBpoERYxR225nz6gr+S
 JYhRQHvlUyFOoFaJ7jg1NCPS47gxJRe33MoKvBcl2mLSATsd88deiz9jabw93T5bA5kfa5
 XRGWjJl2XEHwAy12LcU3mMku2yXUfQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-uzLDQpi7NU-itfyL7qjJQQ-1; Mon, 20 Jan 2020 03:22:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so13756914wrn.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MBlKV7a1E6OPePgNnFfOOX2L6Nm9mTCYTzlUDjDk7uE=;
 b=bbkfbuvM+K8lv6Ybcqvn2EBZeauhsUlsfP5Yo4j5SVndEA6bRRIZB6gLxOhUPO3I/S
 umlLsYfbw2cKvRpZPMzF0fQZ27xne0gKOw4qfFZipt/YphNSPWGo+9GSKzuy7CZ67BJJ
 jUnaQUyyvy1eBRcfQVjTXa1hU2EzcVzCg68WjYHGvBXv5lMM3TOq5scMLkwH5zmIurut
 nlUdj+ufX+e+2B0zg6moMgNxJ+nc/hciNzAP4GXB2lqizuvCVkeJtaKurtk5pAC6wS5A
 Ibwvmt40fc/zIIUXodhYxPkXIk9ldWIeK3w3MS6AUHp6Y2v3OXrUVN0TBW/pbQh8CXWM
 gNkQ==
X-Gm-Message-State: APjAAAXz4f9g31VcnV+6vK28DgvtDC1Tk5kMKLIt5RaH4kh+uZg3APfE
 19zrDgaI5XUsbb0ByfY10WV9bZXzx1hghMou/JMimq7OZ3Jv1uIr2sPdfewOPy6WZKNg3ZFSKVn
 iPDt4GOX58ndwVbA=
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr16714988wru.411.1579508529835; 
 Mon, 20 Jan 2020 00:22:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyACaUpyAR9FiJj5Rhg6euXbtMktitQ2XdaGDrDNLim8snnYmj9BIluQAE7MjiL6ape9H3sw==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr16714964wru.411.1579508529519; 
 Mon, 20 Jan 2020 00:22:09 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n187sm22534405wme.28.2020.01.20.00.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:22:09 -0800 (PST)
Subject: Re: [PATCH] python: Treat None-return of greeting cmd
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
References: <20200120071202.30646-1-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <664ea3a9-6053-4df8-5a3b-75c11aabc736@redhat.com>
Date: Mon, 20 Jan 2020 09:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120071202.30646-1-ldoktor@redhat.com>
Content-Language: en-US
X-MC-Unique: uzLDQpi7NU-itfyL7qjJQQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/20/20 8:12 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> In case qemu process dies the "monitor.cmd" returns None which gets
> passed to the "__negotiate_capabilities" and leads to unhandled
> exception. Let's only check the resp in case it has a value.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>   python/qemu/qmp.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 5c8cf6a056..a3e5de718a 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -73,7 +73,7 @@ class QEMUMonitorProtocol(object):
>               raise QMPConnectError
>           # Greeting seems ok, negotiate capabilities
>           resp =3D self.cmd('qmp_capabilities')
> -        if "return" in resp:
> +        if resp and "return" in resp:
>               return greeting
>           raise QMPCapabilitiesError
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B26C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EE92053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctgcbWo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EE92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFHg-0004tO-G3
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZFFw-0002mk-3V
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZFBj-0007Yv-16
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:18:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZFBi-0007Wi-UF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574691482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaFD3f7HMP8cL1ToH5R+SqgA9eUolEzEIxWblD1mqnE=;
 b=ctgcbWo6Txa8vwSljiywONQqEtDN57gZbtIM+J2IlDz9c6NDVJ0idYkUvnku0bz1l40Cyt
 NnX59/yL7757wLftJcotjFUE2Xx0hN+lOxCICF/5kEcbntwFQSSob+zLkqbPeQQnp9otzV
 /o7CkW1onaevfjGM1AdRvv0rkiO6DE0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-aQ2h8Gn7NQWURoP5FfiESA-1; Mon, 25 Nov 2019 09:17:58 -0500
Received: by mail-wm1-f71.google.com with SMTP id o135so3816569wme.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0BrC9KBfOfeOJ+nX3vNAcQ+cDBIyTuwtkb+cj2hz++g=;
 b=hIY685Sw+z8LmuMlXAFLNxKmTFBXKZBw1SHZQ1O2YWNv82daqHV+cAlzDnwQMY9Ugm
 PN8E9QkE7LCQibOHU33J1YyOXB8por6HEayGbb/QAF8Nm0RkF3V6dUGsuuKsK7QKUnUd
 L/R/ZFdGAaGTG+Nmz/lMPKIyYTOhifdnenfJh/ts3YqxZJBhk6pzT696PAMfRE+fZAhj
 ttT1A/x9TNuty9MEIvUTf7PmnFv8ZhY5Wm0Pi3ntiN4uIFEJUy1tnYsLAQAQyiU9l7fx
 c0OsjrHj934SY3hCPN/g8a/9gUzBbgiyKuCzk/4tM7sMAmUbzbwA9zGEnwrg08UcI2oL
 JR9g==
X-Gm-Message-State: APjAAAW6tCNS62P9uAmqhr2SumYs+kluSSzrcMpbOQxhogZADaWr9J9f
 pSpbVbVDl+4AbhC9AZ4I1ctFz2NXmvvkT/MdeGl0zGTS6fZv6BPfEpMcfbAS2axB4uPXmFy/7Dm
 +gC1YyDFlT1nUHnY=
X-Received: by 2002:a5d:4146:: with SMTP id c6mr30815822wrq.250.1574691477729; 
 Mon, 25 Nov 2019 06:17:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiP3ZwDpMMLYsnSgWBe5uSRK1CKp4DycKmevreQiuskUlBfVMSlQV/8M6nPh0fyAGREyu9MA==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr30815782wrq.250.1574691477356; 
 Mon, 25 Nov 2019 06:17:57 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id 65sm11322158wrs.9.2019.11.25.06.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 06:17:56 -0800 (PST)
Subject: Re: [PATCH 1/2] util/cutils: Turn FIXME comment into
 QEMU_BUILD_BUG_ON()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191125133846.27790-1-armbru@redhat.com>
 <20191125133846.27790-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c195ba59-6cb8-526f-5450-914051ef5f6f@redhat.com>
Date: Mon, 25 Nov 2019 15:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125133846.27790-2-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: aQ2h8Gn7NQWURoP5FfiESA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 2:38 PM, Markus Armbruster wrote:
> qemu_strtoi64() assumes int64_t is long long.  This is marked FIXME.
> Replace by a QEMU_BUILD_BUG_ON() to avoid surprises.
>=20
> Same for qemu_strtou64().
>=20
> Fix a typo in qemu_strtoul()'s contract while there.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/cutils.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..b372dd3e68 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -502,7 +502,7 @@ int qemu_strtoul(const char *nptr, const char **endpt=
r, int base,
>    * Convert string @nptr to an int64_t.
>    *
>    * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
> - * and INT_MIN on underflow.
> + * and INT64_MIN on underflow.
>    */
>   int qemu_strtoi64(const char *nptr, const char **endptr, int base,
>                    int64_t *result)
> @@ -517,8 +517,9 @@ int qemu_strtoi64(const char *nptr, const char **endp=
tr, int base,
>           return -EINVAL;
>       }
>  =20
> +    /* This assumes int64_t is long long TODO relax */
> +    QEMU_BUILD_BUG_ON(sizeof(int64_t) !=3D sizeof(long long));

Ready for 128-bit!
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       errno =3D 0;
> -    /* FIXME This assumes int64_t is long long */
>       *result =3D strtoll(nptr, &ep, base);
>       return check_strtox_error(nptr, ep, endptr, errno);
>   }
> @@ -541,8 +542,9 @@ int qemu_strtou64(const char *nptr, const char **endp=
tr, int base,
>           return -EINVAL;
>       }
>  =20
> +    /* This assumes uint64_t is unsigned long long TODO relax */
> +    QEMU_BUILD_BUG_ON(sizeof(uint64_t) !=3D sizeof(unsigned long long));
>       errno =3D 0;
> -    /* FIXME This assumes uint64_t is unsigned long long */
>       *result =3D strtoull(nptr, &ep, base);
>       /* Windows returns 1 for negative out-of-range values.  */
>       if (errno =3D=3D ERANGE) {
>=20



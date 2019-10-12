Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C16C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C157920650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C157920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAXa-0004fW-0Q
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAWQ-0003VA-Pl
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAWO-0005fj-4O
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAWN-0005fS-Su
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:04:56 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AE1436961
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:04:54 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id p6so3050488wmc.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wgY6f831nPfq8AMAHrsqYSPsJ40+LhCt9P4m0y5Q67E=;
 b=mrlWXTJjJNd5U84H3NnOQ6JzIfTYKoLSLXFG/3SAHFklgIkp1yD25UaIj2LN4xlA/S
 xQ5ey7aeI/EsuOralmH/dWpq70vS6LkFCjZdOw74pYWG7zwc2WpmIOj+sNvZdDLnOEtS
 crgwSuLGVSXhiI7bWYB7MZ7GOxOBci6tXhYhV/9n10VAtrECa2eLICWln8zW7CB/KGuY
 xXn0Qc+VKii2DMfNPp7W0Ppl0JmUhfbG0H61ieZ55aAT/vMMCaWU6uyn4QjLhAxy07sx
 LYSHwGBJ2f4U10UtpIdHtwz0D5vlj6wmr4mdmYMz1NGtpqC6GH+2hlxxSn3eysHHpwQY
 ycHQ==
X-Gm-Message-State: APjAAAUYUEA3G5Iu26UtGJ1mkIOhIsZ838kHKNaF8jJ26ePED+RfgX6N
 OMpZ4L2Ig4eaitZ+e99O4SHyFwEsc+kMWMsmL+3lDKNpkIVaIX/88+6zvGf7DKpt/BSll3iSQlc
 CU4hd++5ObsJYMaw=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr6298752wml.43.1570860293118; 
 Fri, 11 Oct 2019 23:04:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbm2ySHolr1trQDsTtEftpUZ4JEDmVOofzwyHMu8t/8yneVMT6E+X7kQ9SNCL7qhKWuZo7tA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr6298736wml.43.1570860292905; 
 Fri, 11 Oct 2019 23:04:52 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id i11sm13122152wrw.57.2019.10.11.23.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:04:52 -0700 (PDT)
Subject: Re: [RFC v5 002/126] net/net: Clean up variable shadowing in
 net_client_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-3-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6808e719-7ed2-15bc-525b-322b14fd3236@redhat.com>
Date: Sat, 12 Oct 2019 08:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Jason Wang <jasowang@redhat.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> Variable int err in inner scope shadows Error *err in outer scope.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   net/net.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/net.c b/net/net.c
> index 84aa6d8d00..9e93c3f8a1 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1126,16 +1126,13 @@ static int net_client_init(QemuOpts *opts, bool=
 is_netdev, Error **errp)
>  =20
>               prefix_addr =3D substrings[0];
>  =20
> -            if (substrings[1]) {
> -                /* User-specified prefix length.  */
> -                int err;
> -
> -                err =3D qemu_strtoul(substrings[1], NULL, 10, &prefix_=
len);
> -                if (err) {
> -                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                               "ipv6-prefixlen", "a number");
> -                    goto out;
> -                }
> +            /* Handle user-specified prefix length. */
> +            if (substrings[1] &&
> +                qemu_strtoul(substrings[1], NULL, 10, &prefix_len))
> +            {
> +                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                           "ipv6-prefixlen", "a number");
> +                goto out;
>               }
>  =20
>               qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abo=
rt);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


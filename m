Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743EC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A9220650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A9220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAZU-0005n4-5H
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAYs-0005N8-1A
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAYq-0006nZ-VO
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:07:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAYq-0006nR-Nh
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:07:28 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C27DAC06513B
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:07:27 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id x11so3800887wro.15
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z6c4/T+Wmi+EKJAGWVgKFs4BshBiK+WuDhQn4K3OwO8=;
 b=UiSgpDQYkJuVozx4h7vjVy1ZqRUITYDUy/XpvpgLZjp5NPniZAgS/vF2KAd/lScItB
 cCREj6yRbDYCM1pXAfZEYGO9PY0+uBZRIVOUu0kliO9L0a4ml35rlPoDO8j12f/Z5C2W
 0rRbqIhEylD5xQPKZBckSEfa4mB7dZls6SaYr/gZ4FbcMXt4GpUqtL4nvJShm9kEnBEa
 d7uXKuuQ9EvPegxdJG1PMwc9OmU6kfnD84NQwDYC9X86tkb1Yx7Bl1k33b+UZ9BLcjda
 f+/JsDPuRYgYiBJig5AhI0Y5uOJHkUog9C4RxNtcdoiGh4RDK7Qla3vWoMucXhk7hLhj
 8+qQ==
X-Gm-Message-State: APjAAAVkgCGKL62jquteaLw1kEW2ES5m9TEs9t+VG4wmD++2C+iMyh+y
 RNsLVi+1avzj4DdohS/9/hJ7oreeBG7HQofmltMewjGP89hmwdE8ipt6I15Mp9TgPAxWhdopiXy
 1iCzruDq8FhcnyVw=
X-Received: by 2002:adf:fe12:: with SMTP id n18mr4563532wrr.114.1570860446493; 
 Fri, 11 Oct 2019 23:07:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSBqaBYHWPcVnSwnSwFKE5jN064RKseCgHkLlEkf2yCHwBwre9nv4Hc6vqMvt8r/f4Fc1URg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr4563516wrr.114.1570860446328; 
 Fri, 11 Oct 2019 23:07:26 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f83sm17411902wmf.43.2019.10.11.23.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:07:25 -0700 (PDT)
Subject: Re: [RFC v5 020/126] include/qom/object.h: rename Error ** parameter
 to more common errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-21-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29245503-5a09-73f0-fba5-afb05a6b08c9@redhat.com>
Date: Sat, 12 Oct 2019 08:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-21-vsementsov@virtuozzo.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/qom/object.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77f..716f6f655d 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1635,9 +1635,9 @@ void object_class_property_add_uint32_ptr(ObjectC=
lass *klass, const char *name,
>    * property of type 'uint64'.
>    */
>   void object_property_add_uint64_ptr(Object *obj, const char *name,
> -                                    const uint64_t *v, Error **Errp);
> +                                    const uint64_t *v, Error **errp);
>   void object_class_property_add_uint64_ptr(ObjectClass *klass, const c=
har *name,
> -                                          const uint64_t *v, Error **E=
rrp);
> +                                          const uint64_t *v, Error **e=
rrp);

Oddly the implementation already use lowercase.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   /**
>    * object_property_add_alias:
>=20


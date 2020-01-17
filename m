Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C74C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2562064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffcysyme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2562064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSFu-0002yt-Gx
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isSDv-00018g-Co
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isSDs-0007O0-3P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isSDr-0007Nn-V1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+13yfHX/vSMaISQr3NlQ0cc0cRhMGu20Iw3NPzh8Dc=;
 b=Ffcysyme0x4ZLxxifxiOyL3gIdwMSbl0RhoNVgfxz+S07EnziUHO8yh+Qv4MMaBQjc/kzG
 LBU8AEQc40Xz1LyreS3aTL+yDvTYPz+uJ7b5u24oU6p20FPNcXTfPi9epY3v3Am7bWmZhn
 DLnYKpNR76PQxdCR/3VfjAl/FbFzZvQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-4ULBwElHMQuZsKhCYuE_WQ-1; Fri, 17 Jan 2020 09:03:36 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2304215wma.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wszs3S6K8qf3jXB08PkYwU1IXYFyYbkfYQpNohXJSuQ=;
 b=E/hgrjYaa6n/PnvUfwEPbyDUXuJF+GcX7hqKj0M2jQXuvJ+ke7JMs0i4E0L4vlbbWo
 oOrzS/Opp48q9InyJAVIHsBrlrMAzI6xKUIdS7eWvQJWFHKfaWlwGCvvLxkRLKb2Hh8y
 69wwPisP+jl+EDANNYKSFjcyGeuKI4605FF0sRCNFn3xlZmUw0pjlNFERolNoDCgg/zS
 30XmKAdKUStVTTICmQm3NCKSaxeNMIErBdPBCpwNvlndThspACOK5DHAlgBxrJwXDg3U
 v9hL7k6sIAHhZXcMsSJU+tXVRWpN/Xgz/WGdF7/MQTOQFaRiraa+wAdCPMabggDNL8A8
 Kqzg==
X-Gm-Message-State: APjAAAUsVJdrBcBI/9FLSID6/OTOIxj1kYo6xQAQSfADeOeFpeVp8pRr
 eaJk5CRcXnabmr3JLOFHxpDar8m9NKLfltgQOke8EdcBir5fPflcEG3DqHn7W91sG00nHpbDbYp
 5EQ0JcfP5eOyBD2o=
X-Received: by 2002:a1c:988e:: with SMTP id a136mr4798430wme.181.1579269815056; 
 Fri, 17 Jan 2020 06:03:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmKJG8GVgvzeDXnIQWbIx1pglpYibGJuhzz1JBr+ynzx/JU3fvY1MDV/ocfqICkgCgXstKlQ==
X-Received: by 2002:a1c:988e:: with SMTP id a136mr4798409wme.181.1579269814871; 
 Fri, 17 Jan 2020 06:03:34 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 16sm9351741wmi.0.2020.01.17.06.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 06:03:33 -0800 (PST)
Subject: Re: [PATCH] multifd: Be consistente about using uint64_t
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200117135639.14602-1-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af372ea0-d081-8c16-54bb-5c3e2e58a147@redhat.com>
Date: Fri, 17 Jan 2020 15:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117135639.14602-1-quintela@redhat.com>
Content-Language: en-US
X-MC-Unique: 4ULBwElHMQuZsKhCYuE_WQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 2:56 PM, Juan Quintela wrote:
> We transmit ram_addr_t always as uint64_t.  Be consistent in its
> use (on 64bit system, it is always uint64_t problem is 32bits).
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/ram.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 96feb4062c..f7482b1b35 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -803,7 +803,10 @@ static void multifd_send_fill_packet(MultiFDSendPara=
ms *p)
>       }
>  =20
>       for (i =3D 0; i < p->pages->used; i++) {
> -        packet->offset[i] =3D cpu_to_be64(p->pages->offset[i]);
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp =3D p->pages->offset[i];

Using a temp variable is clearer than a cast, good.

> +
> +        packet->offset[i] =3D cpu_to_be64(temp);
>       }
>   }
>  =20
> @@ -877,10 +880,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>       }
>  =20
>       for (i =3D 0; i < p->pages->used; i++) {
> -        ram_addr_t offset =3D be64_to_cpu(packet->offset[i]);
> +        uint64_t offset =3D be64_to_cpu(packet->offset[i]);
>  =20
>           if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
> -            error_setg(errp, "multifd: offset too long " RAM_ADDR_FMT
> +            error_setg(errp, "multifd: offset too long %" PRId64

Nitpick: PRIu64 for uint64_t.

Using PRIu64:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>                          " (max " RAM_ADDR_FMT ")",
>                          offset, block->max_length);
>               return -1;
> @@ -1236,7 +1239,7 @@ int multifd_save_setup(void)
>           p->id =3D i;
>           p->pages =3D multifd_pages_init(page_count);
>           p->packet_len =3D sizeof(MultiFDPacket_t)
> -                      + sizeof(ram_addr_t) * page_count;
> +                      + sizeof(uint64_t) * page_count;
>           p->packet =3D g_malloc0(p->packet_len);
>           p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
>           p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
> @@ -1447,7 +1450,7 @@ int multifd_load_setup(void)
>           p->id =3D i;
>           p->pages =3D multifd_pages_init(page_count);
>           p->packet_len =3D sizeof(MultiFDPacket_t)
> -                      + sizeof(ram_addr_t) * page_count;
> +                      + sizeof(uint64_t) * page_count;
>           p->packet =3D g_malloc0(p->packet_len);
>           p->name =3D g_strdup_printf("multifdrecv_%d", i);
>       }
>=20



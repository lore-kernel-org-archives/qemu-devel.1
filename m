Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8162070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0SgqAeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8162070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWuG-0000CR-1x
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQWoo-0004K7-5X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:50:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQWom-0006jb-DI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:50:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20549
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQWol-0006hb-Ti
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587390634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vI1E091/krB5NzrW6+Oudgm9AtIRHkUYUYoJ1W2jgGg=;
 b=G0SgqAeI31AV5kcBhe9YKkPgBpnSl8M88SxS2lZ2dg+hSL5nK8Bl7J7wFRtIlOVa9Evmde
 qhlD/cIX+gKcebY4gkew0fNoSf/tVzE/LP0KlhwCrYpd0JSulmin3Q7hTL44rJFfliKn2f
 n71OWZ/5fJWJyxXf3k8KT9Zb9D2spI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-V-ZYrjO8OxyQMlPSZrcsmQ-1; Mon, 20 Apr 2020 09:50:29 -0400
X-MC-Unique: V-ZYrjO8OxyQMlPSZrcsmQ-1
Received: by mail-wr1-f70.google.com with SMTP id r11so5720303wrx.21
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=puHWFtzMl9G4btqhF6Wpn2mzi44uYI6CndKqqtWnjrk=;
 b=IMyTAQgdqIRwM8s3Rpcp/KzlrntvHmheOY7J3t+Cy5Nf7LoUpuGZnAI11LCamBAbdj
 l7g3nDuk+reuhzGppYHKcEeethRUy6tYE2hl82u5ry2h+SZ7EL1/5xYNjDON4qkqgUTm
 T02qd/6lfuR0hPDIU6zFAttfc/F+RqKn5DAw9ddW2pZO/B763/NgXKLiZgBVvW7YF4iQ
 EDLvZxKJhD5amzYw0lAIzQavMF2OlJasssMTb2NQJchQawoBfsGYpAwmD/6bg8ZTV1gB
 CiZ4uZECa5RPpK2sfwZ8zM2fRHcH/rOsdFJhdpgWEMhapYPtU4IQyQ8SsGRT+GSDPFVm
 JIhQ==
X-Gm-Message-State: AGi0PubHUNs5fMhYcgZpMRdXFNQpXuRxpguySxSV9Od17arhdPzQ7IW1
 m8AQzfN3n3rSV9B1yxTwnWKeznqNkRCyJvv6JbSGA1y5NCEDOIVbQTKUuEQYKwfwTJJaVwtRjof
 FynwWSsmRyDCiagI=
X-Received: by 2002:a5d:6145:: with SMTP id y5mr18519507wrt.126.1587390627899; 
 Mon, 20 Apr 2020 06:50:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTQ9lpJe+jlA/mQBZ7GHNH3KEXFbaK69UKXoxifoKReHWPbi99W5FMjRh27HxZpn3Vq1ZdoQ==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr18519489wrt.126.1587390627639; 
 Mon, 20 Apr 2020 06:50:27 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l16sm1205941wrp.91.2020.04.20.06.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 06:50:27 -0700 (PDT)
Subject: Re: [PATCH 3/4] bamboo, sam460ex: Tidy up error message for
 unsupported RAM size
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e02072ff-6d53-f835-8e90-92d94aeb2017@redhat.com>
Date: Mon, 20 Apr 2020 15:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420132826.8879-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/20/20 3:28 PM, Markus Armbruster wrote:
> Improve
>=20
>      $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
>      qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB=
 DIMM/bank supported
>      qemu-system-ppc: Possible valid RAM size: 2048
>=20
> to
>=20
>      qemu-system-ppc: Max 1 banks of 2048, 1024, 512, 256, 128, 64, 32 MB=
 DIMM/bank supported
>      Possible valid RAM size: 2048
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/ppc/ppc4xx_devs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 3376c43ff5..dea39546ad 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -716,11 +716,11 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_b=
anks,
>           for (i =3D 0; sdram_bank_sizes[i]; i++) {
>               g_string_append_printf(s, "%" PRIi64 "%s",
>                                      sdram_bank_sizes[i] / MiB,
> -                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +                                   sdram_bank_sizes[i + 1] ? ", " : "");
>           }
>           error_report("Max %d banks of %s MB DIMM/bank supported",
>               nr_banks, s->str);
> -        error_report("Possible valid RAM size: %" PRIi64,
> +        error_printf("Possible valid RAM size: %" PRIi64 "\n",

Maybe nicer:

            error_printf("Possible valid RAM size: %" PRIi64 " MB\n",

Regardless
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>               used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB=
);
>  =20
>           g_string_free(s, true);
>=20



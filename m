Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E010EC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F43206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFO36bsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F43206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLQ7I-0005Ss-RO
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 07:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLQ6O-0004ru-O6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLQ6N-0006FS-RG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLQ6N-0006F0-OL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586173179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdcK2IS3+8LMTvQUMccuriqkWW8YQN/3+sdcnL6/WjE=;
 b=CFO36bsw21tXEOJJqTzX0hA4hSNAparjtMEgLt3fH6OHMbvG6X3nEf1v0PoiV/feAkP2U1
 hG1nOPIPcGGnQ6EThs8e2nUkBKLNnZ3whhESedw73MmsIily3FEPweQqNdPgOBV1M0/EGv
 UHrQqOixepZ5gIm7ZhmZVJ+W185+8Ig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-DWmFfqDtOXKPbxAt1wcX5g-1; Mon, 06 Apr 2020 07:39:34 -0400
X-MC-Unique: DWmFfqDtOXKPbxAt1wcX5g-1
Received: by mail-wr1-f71.google.com with SMTP id y6so2076058wrq.21
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 04:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LdcK2IS3+8LMTvQUMccuriqkWW8YQN/3+sdcnL6/WjE=;
 b=psNwWOMzp9Zxs5xZ22C2qBqUhe2BGZZExBELlwOOpYoXBLqGcImkSWViGQ/fIO6SHd
 AOD0u2n1BVNMr4KH5bK8T76BbJ9pUUCsvzwDQwefzCA9V3z9oDC6kDKcH06vnzkE+1ZE
 sxyR1rptwdG3BezLQZd/AW/1kiP+7JkezI8tBuOZm0KOli/3//ODAfQKQuc+SddfKdTr
 vxCV5YM+cXdDKIhV2uLWvMvF0Q+ubtGT9ONsEHufIliiiyR+ee+bIqOS2NIQjXJbH5p1
 /o0IV4csnXNSTNBu+6KWb72enlCG23EVXQO0ySQIgPCar7D76tVqFRlDonsNMGrwF0uO
 ZCDw==
X-Gm-Message-State: AGi0Pub5AEj9myjf0vNQCDJZVCjln66z38qNEn7QUa2qqp2m5Rhvwss6
 LjSh5XKl/ISCGgfUcETUqrRX0nWOBdR436+8k3V5HtkD3zTHJkx3tqlSu3qbedpaZCMZld7Kv95
 +QFu0IhocLV9dq+c=
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr23021463wmc.53.1586173173139; 
 Mon, 06 Apr 2020 04:39:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypItVXYLZgoKsGpjkMSbWMhJdqXx360iNLdn1/j3JAl7Q5oh+B/mZvN3AMOQknqBdby9rR4EXg==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr23021443wmc.53.1586173172890; 
 Mon, 06 Apr 2020 04:39:32 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id t124sm399746wmf.19.2020.04.06.04.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 04:39:32 -0700 (PDT)
Subject: Re: [PATCH v2 09/12] acpi: move aml builder code for parallel device
To: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-10-kraxel@redhat.com>
 <20200403121210.30a010cb@redhat.com> <20200403121601.35099bf5@redhat.com>
 <20200406102652.lf2yq4wkm2lylgzf@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca686405-226e-b906-02b8-eeb2aeb18b30@redhat.com>
Date: Mon, 6 Apr 2020 13:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406102652.lf2yq4wkm2lylgzf@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/04/20 12:26, Gerd Hoffmann wrote:
> -    if (isa->iobase != 0x0378) {
> +    for (i = 0; i < ARRAY_SIZE(isa_parallel_io); i++) {
> +        if (isa->iobase == isa_parallel_io[i]) {
> +            uid = i + 1;
> +        }
> +    }
> +    if (!uid) {
>          return;
>      }
>  
> @@ -583,8 +589,9 @@ static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
>      aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));

FWIW this should be replaced with iso->iobase if you want to support
multiple parallel ports (we probably should since the patch has been
written already :)).

Paolo

>      aml_append(crs, aml_irq_no_flags(7));
>  
> -    dev = aml_device("LPT");
> +    dev = aml_device("LPT%d", uid);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>      aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  



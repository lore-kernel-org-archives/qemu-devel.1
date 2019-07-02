Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD08C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FA22089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FA22089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEgl-00022R-9r
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiEeo-0001X6-7A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiEei-00042t-FZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:00:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiEeZ-0003uQ-Ta
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:00:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so16829977wrr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SPA4TH7tte4ECbV/Nas9+EtL4terS/+HiDuW/MO4Jmw=;
 b=Chd9/fvmO7YjEkFFN13wQkGkIuMR4pNxoVb6LzicU0rZrBAKyX5gsPXx7E/6uqPwrb
 Cs96TgMGJL6zcRkTJlu3eKgUkcPQA41plBmauuC9+vyeY+lvCc1Cg2Yl6OeF0lB3HtdQ
 H0vMkJZDIbLqOADeAQI6bs7U6FSYNKqkEi2cdF/iIcthhrSyLqBgla6mBjmGE8vhgHPj
 kjoVXajvwVkyCp/7aKbN5JuyFxzwTgpCsFCASt5EwbM9WhNPNDoFuO+0+5U0Z0COCeSY
 cQ+P17Aw0wC7XhTyHlpxnLaoIR3LFxr2epc/G4UqOQunChtnxXiLk+Y/SyEVh8DgM+0x
 ts4Q==
X-Gm-Message-State: APjAAAUUKD+1Bwdwc6YPMRTv3V625sE+D3qb9Zy3Ov9ce0TourW+IhDH
 L3Q0M0EnYXpLleDUyVML8lkjqQ==
X-Google-Smtp-Source: APXvYqyW6Hp6DjZIlJBYSBpXRopZPHegVXHl5xOHUb1EdXaaGgQmi8WNEf/XIbSjEO3pX3DY7M5Gog==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr21672863wrx.300.1562058039482; 
 Tue, 02 Jul 2019 02:00:39 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id q10sm13739768wrf.32.2019.07.02.02.00.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 02:00:38 -0700 (PDT)
To: minyard@acm.org, QEMU Developers <qemu-devel@nongnu.org>
References: <20190701183100.7849-1-minyard@acm.org>
 <20190701183100.7849-2-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1314c0c8-304b-b8b3-ae7a-84384b9dc282@redhat.com>
Date: Tue, 2 Jul 2019 11:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701183100.7849-2-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qdev: Add a no default uuid property
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus & Eric.

On 7/1/19 8:30 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This is for IPMI, which will behave differently if the UUID is
> not set.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-properties.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 1eae5ab056..7fd887af84 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -237,6 +237,13 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>          .set_default = true,                                       \
>          }
>  
> +#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
> +        .name      = (_name),                                      \
> +        .info      = &qdev_prop_uuid,                              \
> +        .offset    = offsetof(_state, _field)                      \
> +            + type_check(QemuUUID, typeof_field(_state, _field)),  \
> +        }
> +
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
>  
> 


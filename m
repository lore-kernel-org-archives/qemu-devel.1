Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C0C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6C620780
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9n0khIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6C620780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM9Dl-0002Fy-0u
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jM9D6-0001pC-3L
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jM9D5-0005d5-4g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:49:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jM9D5-0005cp-1N
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586346574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBApviWNBP9Hspt+1RXFKHuPerWDJtTeCdaJyQKxHA4=;
 b=a9n0khILKGqq+Oz68m/RzL8CTFqecFkPr1NtPugCerV9mgx+NUsXA2JHFKdCGK3DJ7c1jo
 Y6NZV3BLZZHhBcwEu1tU4PEdBH4h+P4SmFQX+a5Cx91Mp/jiRfAoWr7wYfZqIqEy5tsx3h
 0zb1GWC3RNQR5Jxh5dYqQ2IqoKpjM+M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73--C-BjIMBPBGIDiZUMrjmAA-1; Wed, 08 Apr 2020 07:49:32 -0400
X-MC-Unique: -C-BjIMBPBGIDiZUMrjmAA-1
Received: by mail-ed1-f69.google.com with SMTP id w6so6530467edq.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 04:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cdHBVygdJ4S5WAkxD/uXkZlSqsq1bpoZPDICmTF73F0=;
 b=EceMBtlST5xvhiL4+89z0mxOzuFN3gb+HY/iN+RkjpXVzhoVrWGmXJDUJmxdEaXQ0L
 EPmH+hN47Q8lGZ8BnXx17faUvPZz60+wr5XIY2HJrVJhvNPXOmcwNBssuvesnISnzP3L
 k5kXwxO0mO+Hy/slp/WJ0bHRnGbuG+iz6lirohioZgI8ycu7hKKY7vRsOpxcMlnG3YHB
 YLIhf0p8Xw8K0QTywDrV6t56vpUT96xcEg+IopnML8EMCqnTpWlQom4GYFwBQXi71fFj
 NyjMPgMIAVTkQR7/XOnormnpJQySh4be2K6XGY4ss2Uln0v0X35nZhqPIF4Ua3q30dCg
 9UEg==
X-Gm-Message-State: AGi0PuYUS7yaIeNxGMIBEDFjACLFtXtELXjyL3ifYN2/ETNDry/4GDMO
 RuWJjCqq5BC0gn+4j/S/12jBIzmVhUllMAa8T3LKQN3lnMHQbyi7aInEGhNWg2o+S4oWCAzeBiT
 Jb8vrZqklqE8vthw=
X-Received: by 2002:a05:6402:2c8:: with SMTP id
 b8mr5782511edx.242.1586346571173; 
 Wed, 08 Apr 2020 04:49:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3qJ+TQk1563GptqGMAN3FZhTJjUKl843dA75EFr50UM6N4wCsbVeFcf4mlm7MZfvuea/wWQ==
X-Received: by 2002:a05:6402:2c8:: with SMTP id
 b8mr5782495edx.242.1586346571013; 
 Wed, 08 Apr 2020 04:49:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j9sm2887108edl.67.2020.04.08.04.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 04:49:30 -0700 (PDT)
Subject: Re: [PATCH] configure: Add nios2-softmmu to the libfdt-required list
To: Stephanos Ioannidis <root@stephanos.io>,
 Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
References: <20200408081607.96114-1-root@stephanos.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2cc3540c-69f2-d5b5-0ab5-1534a55fb07b@redhat.com>
Date: Wed, 8 Apr 2020 13:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408081607.96114-1-root@stephanos.io>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/20 10:16 AM, Stephanos Ioannidis wrote:
> The nios2-softmmu target requires libfdt to function properly (see
> hw/nios2/boot.c).
>=20
> Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 233c671aaa..029adcf795 100755
> --- a/configure
> +++ b/configure
> @@ -4236,7 +4236,7 @@ fi
>   fdt_required=3Dno
>   for target in $target_list; do
>     case $target in
> -    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips6=
4el-softmmu|riscv*-softmmu|rx-softmmu)
> +    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips6=
4el-softmmu|nios2-softmmu|riscv*-softmmu|rx-softmmu)
>         fdt_required=3Dyes
>       ;;
>     esac
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>



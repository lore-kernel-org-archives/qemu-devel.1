Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA10C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC11221920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC11221920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Fzf-0004Z9-0Y
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7Fyc-0003xS-6p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7Fyb-00018o-5q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7Fyb-000176-0l
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:28:49 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 863142DA980
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 09:28:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so7091556wrw.14
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 02:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=by2bjIZg4qdRn5dszm+izjxfpHO99UyDhjIS2GVdlmU=;
 b=VGcHbS3sSBX3IKpY2j458kQia6tAPfSS5iHugyYQhjTcc0N18XKDUYXgPT8JtSlGFN
 IcLB3yurZIhANB7paDlnNetZAyeSlzHdjGBo+exJ72GUmikCqVdINTflK+rdqrgpLKUS
 GWY2ukfPTnIkLIgaJPr9VoRpRdxGv72jBOEBo6VQY+tza5f6dvRAqQJNfkMme8Jt6CsP
 o36LKU4WgxZ88SqrblGJ9wzaEVbqDPYEYON7c8CvxGc67jWX86lcSC+NldByMm9xtz2U
 OgLe1F2JKrSGF4uuAvdmkqEYngSU4BDrkm0F5hjipw3HVS+h8zPb5I7taPIs03sbOL9g
 1vxg==
X-Gm-Message-State: APjAAAWztkxYzFttn5sN2HyKGCZasnVkBm8TjE9PGLgjQRoKNkYRV5ak
 sFFubcH3MDKpQ4AH7v2fAd4mGeRv9vUVpEzivTz64NyP95d5aNrMYgExFMllyggbBPIIBT0vCb0
 UXtECJLsXCpAsuI8=
X-Received: by 2002:a1c:c00e:: with SMTP id q14mr18856419wmf.14.1568021326360; 
 Mon, 09 Sep 2019 02:28:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/S+BQMo4r6AGTW/C4eHi2YzYZObNvz8aHUKfQXATXJI/VFSVqe5a5mGmnv3icF4OqSYrBMw==
X-Received: by 2002:a1c:c00e:: with SMTP id q14mr18856413wmf.14.1568021326223; 
 Mon, 09 Sep 2019 02:28:46 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o19sm18845335wro.50.2019.09.09.02.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 02:28:45 -0700 (PDT)
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org,
 qemu-trival@nongnu.org
References: <20190909031446.1331810-1-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <74c5363a-b5fb-9e14-14be-49297a063dba@redhat.com>
Date: Mon, 9 Sep 2019 11:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909031446.1331810-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pci_bridge: fix a typo in comment
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 5:14 AM, Mao Zhongyi wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  hw/pci/pci_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 715b9a4fe6..97967d12eb 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -311,7 +311,7 @@ void pci_bridge_reset(DeviceState *qdev)
> =20
>      /*
>       * the default values for base/limit registers aren't specified
> -     * in the PCI-to-PCI-bridge spec. So we don't thouch them here.
> +     * in the PCI-to-PCI-bridge spec. So we don't touch them here.
>       * Each implementation can override it.
>       * typical implementation does
>       * zero base/limit registers or
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


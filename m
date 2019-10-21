Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D8ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4C720873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4C720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbUe-0006aF-2H
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMbSX-0004tR-Cs
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMbSW-0004ob-EX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMbSW-0004oO-80
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:08 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62A222A09AA
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:27:07 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s17so2021625wrp.17
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgVur9m2ao3zzaMS3WbY6SSOuq1tgZelB8sgg0rG82k=;
 b=PRdoLIyg970Whyh3CkAMav0ASjb8Ps9XyfNUZkFADozt86y3xSKztM6wEHj6aEqCUk
 CE00R1bVXlt9NcSshHxyoQCEnOsT9JIf/Q2ZkVvhCtxJVCsrBHC0Ndwf/J/VoJFh7GhA
 8mMb2HLdAsJQv3G7X4+ICaKMkKrWH6sKnk7mB0pYhFvYZAHP9GLg8c3X+PahIpj9ZrFv
 OBHYxytm2SZkWygzHduJbHKAOirWb2vFJm1LDrMhq41kddODmyVFuG7bUV0II08uLYui
 cXCRy7z4M1eMaS+TG+HBpbijKA/EYJA2lNKE6ZoKsKzSsadSyKuXkgPp/Zr5UrgyfE+/
 aqAg==
X-Gm-Message-State: APjAAAWNU4BhzyqWNeigWjj01xKZGfXBh9Z+AhtFWjyYPlcHoQPmOtT4
 izVOzELVF7yKvhd2TRx9tbS0vTyEuLcWwZD0eQAia3JzFu9V93SThbd0QklBaprCOuGhE2pISa/
 2eW30w9rySyPxEpY=
X-Received: by 2002:a1c:6144:: with SMTP id v65mr4934439wmb.53.1571678826005; 
 Mon, 21 Oct 2019 10:27:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6jysGRvCLHDvvi/XHZEcdhGXmwT0jzMG/fbHmc1n/JuPLujod4UT6+BAHPPAXbwNTPO6TOQ==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr4934416wmb.53.1571678825834; 
 Mon, 21 Oct 2019 10:27:05 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n3sm16462682wrr.50.2019.10.21.10.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:27:05 -0700 (PDT)
Subject: Re: [PATCH] memory-device: simplify Makefile.objs conditions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191021171120.17947-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb457d5d-5e79-4ddc-c5f2-7b376b0cdf77@redhat.com>
Date: Mon, 21 Oct 2019 19:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021171120.17947-1-pbonzini@redhat.com>
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 7:11 PM, Paolo Bonzini wrote:
> hw/mem/ is only included if CONFIG_MEM_DEVICE is true, so we need not
> specify the condition again in hw/mem/Makefile.objs.

Yes, cleaner.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mem/Makefile.objs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
> index 3e2f7c5ca2..56345befd0 100644
> --- a/hw/mem/Makefile.objs
> +++ b/hw/mem/Makefile.objs
> @@ -1,3 +1,3 @@
>   common-obj-$(CONFIG_DIMM) +=3D pc-dimm.o
> -common-obj-$(CONFIG_MEM_DEVICE) +=3D memory-device.o
> +common-obj-y +=3D memory-device.o
>   common-obj-$(CONFIG_NVDIMM) +=3D nvdimm.o
>=20


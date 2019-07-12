Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74EEC742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF0B2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF0B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlz3v-0001H8-Tc
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlz3k-0000sg-Fc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlz3j-0005U3-Gi
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:10:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlz3j-0005RN-AS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:10:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so10735669wrm.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OCGCCZocBcY2ZFoKWX4/JllPMG5vgLhCR/ga0MpDnyI=;
 b=MrlJzW+2fEgCREmzkiOndMSoWiC2yNHU6OdcYUmU4lGDD4Qw6qRuuSn5Js5HqDtPzf
 QoTqgZgSwXNK/yn/bhs1EbBPKyfE7YsWtefjHGAuAfNkK41vJfUxDWtyiPOK+CDRpYh9
 tkan1gOKQLXWGRATu2+TB3rbiD6yqkLfSian18kUK1/32st+e+VJo0KXmz4F4pdHdjLC
 OYXy7qcyLNo5s2+V6BllAkHJxJt/A1H0RxZuqJcKt2i9F/GGeiyuagJWmqNis4YeuYO5
 9aXeW+lDQh/KZ70LzLFPtPGFWoiAsfk2gpCtxVXvPikuhTm+ctD+m/qrMyhF+82P7VyB
 VZxA==
X-Gm-Message-State: APjAAAXCTUbcJSPJXxhKbNBBAa0Dsn3+4wSJpPs6lYsb5POa0ur4NDe9
 YkNdaCQOAdFDTyb0bmChwWv2Aw==
X-Google-Smtp-Source: APXvYqzkljEHhgVlGiXNDdGA7suTV5WpQu8ly1LSpfeXW9svEKhrSz4qtHQlHE1/bmtXfvu2yhQQ+w==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr11953156wrp.176.1562951409723; 
 Fri, 12 Jul 2019 10:10:09 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id r12sm12151260wrt.95.2019.07.12.10.10.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:10:09 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190711192512.31936-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6c600af7-6590-cdc0-20f3-677b37393693@redhat.com>
Date: Fri, 12 Jul 2019 19:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711192512.31936-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] xio3130_downstream: typo fix
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 9:25 PM, Michael S. Tsirkin wrote:
> slt ctl/status are passed in incorrect order.
> Fix this up.
> 

Fixes: Coverity (CID 1403007)

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/pci-bridge/xio3130_downstream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 899b0fd6c9..182e164f74 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -43,7 +43,7 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>  {
>      uint16_t slt_ctl, slt_sta;
>  
> -    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);
> +    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>      pci_bridge_write_config(d, address, val, len);
>      pcie_cap_flr_write_config(d, address, val, len);
>      pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
> 


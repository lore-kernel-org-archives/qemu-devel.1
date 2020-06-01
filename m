Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6842073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFWJNcIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6842073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfu0l-0003Oy-PR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftyO-0000ut-DS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:36:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftyM-0004vb-RM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:36:03 -0400
Received: by mail-pf1-x442.google.com with SMTP id x207so2278728pfc.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hGrlH3PqgBr3ZkLXs0ICSwS5m6e98ZxaoB6gTALk4to=;
 b=GFWJNcIJwd07F0D6M4IVLW6PM8NwXWcTh05r+2LsqCuNKmw3KcaiHOLhKJcdunMpKy
 k8C7roaMyHD4kAFgeLh1abx6yLpKVPoLQr+e1sZVtY3Aw9W8WkhIiKz6w76YB+JqcH4P
 MxkAomMSNK8vmd+4Jxt+xrrsCTPQEsE8onWo67228m4xttiom20ukivbUAHX8Q8JUeWg
 0S/zSvXhSxLPN+S8RUH60vBO3/IgfMPExKMPz0QsEnIpgApVtllcayn9Qb0l9VfAtI6h
 +YQXQOC2rlmxeKBLJRIZWtdy0au/+c1OsjwAQZ0kpGZpn/9flGgboP2H4IxvkCRz+1fm
 FVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hGrlH3PqgBr3ZkLXs0ICSwS5m6e98ZxaoB6gTALk4to=;
 b=FDKIIUUmWmyfmoc8WV/J6ZFqK+XlX6MU5+oXOT+W+q/MOJYay84Iuwk2+wcsVhYPBn
 n1Sx/wgax24dIZAscqJocVviZfnzLTCKmUVBJ1xbp7KQjEnCYr96REx5aXwPeT5cnOpC
 bh7zHGkvPPf64QS3ixfF9Py7v2L9f2u2v/vWEpvSgksWoPEpasmt2hMqBQb+j+FMVDMu
 vcz28O1FLWKuQwH6CNSD39VYTMjdJI02x45W7y8WDWKf5tO3LAhz0sDUVm36b3v48KT+
 qY/1C28KCyFrBEvJmwLow7+Bh5/PQxC6xjUCycgMQeH13ATRLiN25+ZMES78ugxT5t7r
 lEqA==
X-Gm-Message-State: AOAM532A/GY42Y3D+Jd2Q1EspjUKs88cBtB5CIZbjGb+6Jh40jBMKuDI
 V+i9FCckpLQZBvFjFBORQ9QKJg==
X-Google-Smtp-Source: ABdhPJzQLtQYfpPCKrXikLqS/8usRLci/JPY1d5rfCIMc2sTmw/wqAqfi33AqaxVZO9QQc4TtjWvNw==
X-Received: by 2002:a62:ee07:: with SMTP id e7mr22044574pfi.42.1591054561486; 
 Mon, 01 Jun 2020 16:36:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m14sm445894pgn.83.2020.06.01.16.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:36:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] hw/pci/pci_bridge: Correct pci_bridge_io memory
 region size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35f77178-dc79-3b4a-7562-9bc37fad9d9b@linaro.org>
Date: Mon, 1 Jun 2020 16:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:29 AM, Philippe Mathieu-Daudé wrote:
> memory_region_set_size() handle the 16 Exabytes limit by
> special-casing the UINT64_MAX value. This is not a problem
> for the 32-bit maximum, 4 GiB.
> By using the UINT32_MAX value, the pci_bridge_io MemoryRegion
> ends up missing 1 byte:
> 
>   (qemu) info mtree
>   memory-region: pci_bridge_io
>     0000000000000000-00000000fffffffe (prio 0, i/o): pci_bridge_io
>       0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>       0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>       00000000000001ce-00000000000001d1 (prio 0, i/o): vbe
>       0000000000000378-000000000000037f (prio 0, i/o): parallel
>       00000000000003b4-00000000000003b5 (prio 0, i/o): vga
>       ...
> 
> Fix by using the correct value. We now have:
> 
>   memory-region: pci_bridge_io
>     0000000000000000-00000000ffffffff (prio 0, i/o): pci_bridge_io
>       0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>       0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>       ...
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/pci/pci_bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



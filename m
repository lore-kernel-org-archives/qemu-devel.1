Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D88C73C7F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BBD20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BBD20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7xw-0007pU-GY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl7x3-0007A0-LC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl7x1-000222-QV
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl7x1-0001yZ-G0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so1419616wru.10
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 01:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5SSNbmovsrwDVC2d0KAr9xCw5iZseUjXmFO4F2JkajU=;
 b=MAuzLGsjzAiWs9fK2Ty5pg1F5aufG4gDJjDRb3zsZYr1nSeTZubT/muH8m1o1tMLDP
 wClD03vRWW1BdLEGiKtO8n9lGsv2i/nQUUMhWYytgb/FYPa86zvj8eBJxtDK3BUNFJrG
 6bsoWrSeMOZUj1iAA/qP0wFyF8+6+KCTvCG0eBFU/TATqIwLaB2HqzLtlNy5a+SD4XTs
 +KLGrUj9WjWqayXN7ohBLZCwBkIZg830M6q/4T0nsSY03hpon3twRinSmF7mAizZUOmi
 7r5r/7DN59OObyLRx5VD0i3xosOMdgwgBVmDejnXkeYYaYYr7yN6s995LyqNBrt0HV6E
 CN1w==
X-Gm-Message-State: APjAAAVmTcJs+Nqa9kTz1bhNmdvSj8OipYi5Kr8nBTGTnCa2LwnpY3so
 gsPp5uW98AVtCsFc/FyMY/PXuw==
X-Google-Smtp-Source: APXvYqzLjvhiKMnLdlcGwXHvYK8nxJlf53rJxbNc0I1Mhdeoxqasay+a8pLlGDQL82IiBVylvLfcEw==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr28635678wrs.14.1562747261118; 
 Wed, 10 Jul 2019 01:27:41 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m7sm1214497wrx.65.2019.07.10.01.27.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 01:27:40 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
Date: Wed, 10 Jul 2019 10:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709194330.837-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Debarshi Ray <rishi@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/19 21:43, Marc-André Lureau wrote:
> With current podman, we have to use a uidmap trick in order to be able
> to rw-share the ccache directory with the container user.
> 
> With a user 1000, the default mapping is:
> 1000 (host) -> 0 (container).

Why not do this in docker.py (either as part of patch 1 or separately)?
 Also, can you document in a comment why this is not needed with docker?

Thanks,

Paolo

